"""Project actual assembled meshes into a true-scale axle identification drawing.

This reads existing CAD exports without regenerating or changing any print mesh.
Run after validate.py if the axle geometry changes, then run make_guide.py.
"""
from pathlib import Path
import json
import numpy as np
import trimesh
from shapely.geometry import Polygon
from shapely.ops import unary_union

ROOT = Path(__file__).resolve().parents[1]
NAMES = ('03_square_main_axle', '36_rear_round_journal',
         '38_rear_journal_thrust_collar',
         '35_main_rear_thrust_washer', '10_drive_72',
         '34_main_front_thrust_sleeve', '37_front_round_journal')


def main():
    layouts = json.loads((ROOT / 'layouts.json').read_text())
    result = {'view': 'Along X; horizontal = CAD Z from rear end; vertical = CAD Y',
              'units': 'mm', 'hole_centres_mm': layouts['32']['main_axle_cross_holes_mm'],
              'parts': {}}
    assemblies = {ratio: json.loads((ROOT / f'assembly/{ratio}x/assembly.json').read_text())
                  for ratio in ('16', '32', '64')}
    for name in NAMES:
        item = next(i for i in assemblies['32'] if i['name'] == name)
        mesh = trimesh.load(ROOT / 'assembly/32x' / item['file'], force='mesh')
        # All ratios must use the very same positioned part, not just its envelope.
        for ratio in ('16', '64'):
            other = next(i for i in assemblies[ratio] if i['name'] == name)
            assert (ROOT / f'assembly/{ratio}x' / other['file']).read_bytes() == (ROOT / 'assembly/32x' / item['file']).read_bytes(), (ratio, name)
        projected = mesh.triangles[:, :, [2, 1]]
        polys = [Polygon(t) for t in projected if abs(np.linalg.det(np.stack((t[1]-t[0], t[2]-t[0])))) > 1e-9]
        outline = unary_union(polys).simplify(0.00001, preserve_topology=True)
        assert outline.is_valid and outline.geom_type == 'Polygon', name
        result['parts'][name] = {
            'source': 'assembly/32x/' + item['file'],
            'bounds_mm': mesh.bounds.tolist(),
            'outline': list(outline.exterior.coords),
            'holes': [list(h.coords) for h in outline.interiors],
        }
    assert result['hole_centres_mm'] == [6, 97, 180]
    assert result['parts'][NAMES[0]]['bounds_mm'] == [[-4.0, -4.0, 0.0], [4.0, 4.0, 186.0]]
    (ROOT / 'axle-reference.json').write_text(json.dumps(result, indent=2) + '\n')
    print('Projected',len(NAMES),'actual assembled meshes; identical core axle in all three ratios.')


if __name__ == '__main__':
    main()
