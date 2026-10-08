"""Read current assembly meshes for illustrated pivot/spacer reference sheets."""
from pathlib import Path
import json
import numpy as np
import trimesh
from shapely.geometry import Polygon
from shapely.ops import unary_union

ROOT = Path(__file__).resolve().parents[1]


def main():
    layouts = json.loads((ROOT/'layouts.json').read_text())
    result = {}
    for ratio in ('16', '32', '64'):
        manifest = json.loads((ROOT/f'assembly/{ratio}x/assembly.json').read_text())
        anchor = '18_anchor_forward' if ratio == '16' else '18_anchor_reversed'
        rows = [('B', 'B_pivot', '15_B_rear_spacer', '11_B_18_72', '16_B_front_spacer')]
        if ratio != '16':
            rows.append(('D', 'D_pivot', '28_D_rear_spacer', f'14_D_18_{60 if ratio == "32" else 72}', '29_D_front_spacer'))
        rows += [('C', 'C_pivot', '17_C_rear_spacer', '12_escape_compound', '27_C_front_spacer'),
                 ('P', '19_bolted_anchor_pivot', '20_anchor_rear_spacer', anchor, '21_anchor_front_spacer')]
        reference = {'axes': layouts[ratio]['axes'], 'rows': []}
        for axis, *names in rows:
            row = {'axis': axis, 'parts': []}
            for name in names:
                item = next(i for i in manifest if i['name'] == name)
                mesh = trimesh.load(ROOT/f'assembly/{ratio}x'/item['file'], force='mesh')
                local = mesh.triangles.copy()
                local[:,:,1] -= layouts[ratio]['axes'][axis][1]
                projected = local[:,:,[2,1]]
                polygons = [Polygon(t) for t in projected if abs(np.linalg.det(np.stack((t[1]-t[0], t[2]-t[0])))) > 1e-9]
                silhouette = unary_union(polygons).simplify(.0001, preserve_topology=True)
                assert silhouette.is_valid and silhouette.geom_type == 'Polygon', (ratio, name)
                row['parts'].append({'name': name, 'file': f"STL/{item['folder']}/{item['part']}.stl",
                    'z': mesh.bounds[:,2].round(4).tolist(), 'length_mm': round(float(mesh.extents[2]), 4),
                    'outline': list(silhouette.exterior.coords), 'holes': [list(h.coords) for h in silhouette.interiors]})
            pivot, rear, wheel, front = row['parts']
            assert abs(rear['z'][0]-88.5)<.001
            assert abs(wheel['z'][0]-rear['z'][1]-.3)<.001
            assert abs(front['z'][0]-wheel['z'][1]-.3)<.001
            assert abs(front['z'][1]-(165 if axis=='P' else 132))<.001
            expected = {'B':(1.2,23.7),'D':(13.2,11.7),'C':(13.2 if ratio=='16' else 25.2,4.7),'P':(34.2,7.7)}[axis]
            assert (rear['length_mm'], front['length_mm']) == expected, (ratio, axis)
            for part in row['parts']: assert (ROOT/part['file']).is_file(), part['file']
            reference['rows'].append(row)
        result[ratio] = reference
    (ROOT/'pivot-reference.json').write_text(json.dumps(result, indent=2)+'\n')
    print('Verified all spacer lengths and stack gaps against actual 16x / 32x / 64x meshes.')


if __name__ == '__main__': main()
