"""Read back the delivered meshes and compare against the revision-2 print set."""
from pathlib import Path
import json, hashlib
import trimesh
ROOT=Path(__file__).resolve().parents[1]
OLD=ROOT.parent/'rolling-timer-p1s-r2'
changed=[];unchanged=[];meshes=[]
for path in sorted((ROOT/'STL').glob('*.stl')):
    m=trimesh.load_mesh(path,process=True)
    row={'file':path.name,'watertight':bool(m.is_watertight),'bodies':len(m.split()),
         'dimensions_mm':m.extents.tolist(),'volume_cm3':float(m.volume/1000),'bed_z_mm':float(m.bounds[0,2])}
    assert row['watertight'] and row['bodies']==1 and m.volume>0
    assert max(m.extents)<=250.01 and abs(row['bed_z_mm'])<.0001
    meshes.append(row)
    old=OLD/'STL'/path.name
    if old.exists():
        (unchanged if hashlib.sha256(path.read_bytes()).digest()==hashlib.sha256(old.read_bytes()).digest() else changed).append(path.name)
if OLD.exists():
    assert changed==['05_rear_carrier.stl','06_front_carrier.stl','08_open_ballast_bucket.stl'],changed
parts=json.loads((ROOT/'parts.json').read_text())
oldparts=json.loads((OLD/'parts.json').read_text()) if (OLD/'parts.json').exists() else None
new_vol=sum(parts[n]['solid_volume_cm3'] for n in ['05_rear_carrier','06_front_carrier'])
old_vol=sum(oldparts[n]['solid_volume_cm3'] for n in ['05_rear_carrier','06_front_carrier']) if oldparts else 145.201
assembly=json.loads((ROOT/'assembly-checks.json').read_text())
motion=json.loads((ROOT/'motion-checks.json').read_text())
layout=json.loads((ROOT/'light-layout.json').read_text())
assert not assembly['unintended_intersections'] and not motion['unintended_intersections']
grip=layout['head_seat_z_mm']-layout['nut_bearing_face_z_mm']
tip=10-grip-layout['plain_nut_thickness_mm']
assert abs(grip-6.9)<1e-6 and tip>.65
report={'variant':'lightweight 16:1','meshes':meshes,'changed_from_R2':changed,'byte_identical_to_R2':unchanged,
        'carrier_pair_CAD_volume_cm3':new_vol,'R2_grid_pair_CAD_volume_cm3':old_vol,
        'carrier_pair_CAD_volume_reduction_percent':100*(1-new_vol/old_vol),
        'bolt_grip_mm':grip,'M3x10_tip_beyond_plain_2p4mm_nut_mm':tip,
        'printed_instances':assembly['printed_instances'],'hardware_instances':4,
        'minimum_case_post_clearance_from_checked_fixed_envelope_mm':motion['rotating_case_posts_inner_radius_mm']-motion['fixed_carrier_max_radius_mm'],
        'all_geometric_checks_passed':True,
        'limits':'CAD volume is not slicer time or actual filament use. No physical printing, deflection, joint strength, friction, or sustained running tests. Screw/nut meshes are threadless envelopes.'}
(ROOT/'light-checks.json').write_text(json.dumps(report,indent=2))
print(json.dumps({k:v for k,v in report.items() if k not in ['meshes','byte_identical_to_R2']},indent=2))
