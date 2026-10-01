"""Read back exported STL files. No CAD regeneration or rendering side effects."""
from pathlib import Path
import json, math, hashlib
import numpy as np
import trimesh
from shapely.geometry import Polygon
from shapely import affinity

ROOT=Path(__file__).resolve().parents[1]
OLD=ROOT.parent/'rolling-timer-p1s'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
files=sorted((ROOT/'STL').glob('*.stl'))+sorted((ROOT/'upgrade-32x/STL').glob('*.stl'))
checks=[]
for p in files:
    m=trimesh.load_mesh(p,process=True)
    row={'file':str(p.relative_to(ROOT)),'watertight':bool(m.is_watertight),
         'bodies':len(m.split()),'volume_mm3':float(m.volume),
         'dimensions_mm':m.extents.tolist(),'bed_z_mm':float(m.bounds[0,2])}
    assert row['watertight'] and row['bodies']==1 and row['volume_mm3']>0,row
    assert max(row['dimensions_mm'])<=250.01 and abs(row['bed_z_mm'])<.0001,row
    checks.append(row)

def section(m,z):
    curve=m.section(plane_origin=(0,0,z),plane_normal=(0,0,1))
    result=Polygon()
    for ring in curve.discrete:
        # Even/odd nesting restores holes, even if path winding is arbitrary.
        poly=Polygon(np.array(ring)[:,:2])
        result=result.symmetric_difference(poly)
    return result
support=[]
for name,upper in [('11_compound_18_72',7.1),('12_escape_compound',5.1)]:
    m=trimesh.load_mesh(ROOT/'STL'/(name+'.stl'),process=True)
    bed=section(m,.10);pinion=section(m,upper)
    unsupported=pinion.difference(bed.buffer(.00005)).area
    assert unsupported<.001,(name,unsupported)
    support.append({'part':name,'bed_section_z_mm':.1,'pinion_section_z_mm':upper,
                    'pinion_area_outside_bed_footprint_mm2':unsupported})

profile=Polygon([(4,2.6),(2.6,4),(-2.6,4),(-4,2.6),(-4,-2.6),(-2.6,-4),(2.6,-4),(4,-2.6)])
socket=profile.buffer(.15,join_style=2)
max_corner_radius=max(math.hypot(x,y) for x,y in socket.exterior.coords)
lo,hi=0,10
for _ in range(50):
    a=(lo+hi)/2
    if socket.covers(affinity.rotate(profile,a,origin=(0,0))):lo=a
    else:hi=a
pin_shift=11*math.tan(math.radians(hi))
assert 6-max_corner_radius>1.0
assert pin_shift<1.2
unchanged={}
for name in ['05_rear_carrier','06_front_carrier']:
    p=ROOT/'STL'/(name+'.stl');old=OLD/'STL'/(name+'.stl')
    unchanged[name]={'sha256':sha(p),'identical_to_revision_1':sha(p)==sha(old) if old.exists() else None}
    if old.exists():assert unchanged[name]['identical_to_revision_1']
asm=json.loads((ROOT/'assembly-checks.json').read_text())
motion=json.loads((ROOT/'motion-checks.json').read_text())
upgrade=json.loads((ROOT/'upgrade-32x/layout-and-checks.json').read_text())
assert not asm['unintended_intersections']
assert not motion['unintended_intersections']
assert not upgrade['unintended_nominal_intersections']
report={'revision':2,'exported_meshes':checks,'through_pinion_print_support':support,
        'carrier_plates':unchanged,'minimum_journal_wall_mm':6-max_corner_radius,
        'nominal_key_rotational_clearance_each_side_deg':hi,
        'max_retainer_centerline_shift_at_key_engagement_mm':pin_shift,
        'hub_retainer_tangential_relief_each_side_mm':1.2,
        'all_required_geometric_checks_passed':True,
        'limits':'Geometric checks only. Does not validate extrusion, bridging, material strength, actual fit, wear, friction, or sustained operation.'}
(ROOT/'revision-checks.json').write_text(json.dumps(report,indent=2))
print(json.dumps({k:v for k,v in report.items() if k!='exported_meshes'},indent=2))
print(f'{len(checks)} exported meshes checked.')
