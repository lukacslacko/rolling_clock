"""Clearance replacement for parts 25 and 26 of the lightweight rolling timer.

Only writes this bob-1mm folder. Original working print set is preserved.
Dependencies: manifold3d, numpy, trimesh, shapely (as in ../../source/requirements.txt).
"""
from pathlib import Path
import json, math
import numpy as np
import manifold3d as mf
import trimesh
from shapely.geometry import MultiPoint, Point

OUT=Path(__file__).resolve().parents[1]
ROOT=OUT.parent
OUT.mkdir(parents=True,exist_ok=True)
(OUT/'assembly').mkdir(exist_ok=True)
model=json.loads((ROOT/'geometry.json').read_text())
P=np.array(model['centres']['P'])

def cube(x,y,z,dx,dy,dz):return mf.Manifold.cube((dx,dy,dz)).translate((x,y,z))
def cylinder(r,z,h,xy=(0,0)):
    return mf.Manifold.cylinder(h,r,circular_segments=96).translate((*xy,z))
def mesh(m):
    a=m.simplify(.0001).to_mesh64()
    return trimesh.Trimesh(np.asarray(a.vert_properties)[:,:3],np.asarray(a.tri_verts),process=True)
def manifold(path):
    t=trimesh.load_mesh(path,process=True)
    return mf.Manifold(mf.Mesh64(np.asarray(t.vertices,dtype=np.float64),np.asarray(t.faces,dtype=np.uint64)))
def bob(thin):
    # The two iron pockets remain unchanged, including their 2.4 mm floor.
    x,z,w,d=(-15.6,118.4,31.2,13.2) if thin else (-17,117,34,16)
    m=cube(x,133,z,w,24,d)-cube(-14.6,130,119.4,29.2,24.6,11.2)
    # Retain the central structural web, rod slot, and pin fit.
    m+=cube(-5,133,z,10,24,d)
    m-=cube(-3.7,132,120.7,7.4,26,6.6)
    m-=cylinder(1.55,116,18,(0,145))
    return m.translate((0,5,0))

new_bob=bob(True);old_bob=bob(False)
pin=cylinder(2.7,0,1.6)+cylinder(1.45,1.6,13.2)
old_pin=cylinder(2.7,0,1.6)+cylinder(1.45,1.6,16)
def bob_pose(m,angle):return m.rotate((0,0,float(angle))).translate((*P,0))
def pin_pose(m,angle,z):return m.translate((0,150,z)).rotate((0,0,float(angle))).translate((*P,0))

parts={}
for name,m,rotation in [('25_open_pendulum_bob_1mm',new_bob,(-90,0,0)),('26_bob_pin_short',pin,(0,0,0))]:
    p=m.rotate(rotation);bb=p.bounding_box();p=p.translate(tuple(-bb[k] for k in range(3)))
    t=mesh(p);t.export(OUT/(name+'.stl'))
    saved=trimesh.load_mesh(OUT/(name+'.stl'),process=True)
    assert saved.is_watertight and len(saved.split())==1 and saved.volume>0
    assert max(saved.extents)<256 and abs(saved.bounds[0,2])<1e-5
    parts[name]={'dimensions_mm':np.round(saved.extents,4).tolist(),'volume_cm3':round(saved.volume/1000,5),'watertight':True,'single_body':True}
mesh(bob_pose(new_bob,-5)).export(OUT/'assembly/25_bob_assembled.stl')
mesh(pin_pose(pin,-5,116.8)).export(OUT/'assembly/26_pin_assembled.stl')

# Every nonstructural vertical outer cup wall is 1.00 mm. The floor and central
# spine still carry the iron, rod and retaining pin; they are not thinned to 1 mm.
wall_checks={
 'left':(-14.6)-(-15.6),'right':15.6-14.6,
 'rear':119.4-118.4,'front':131.6-130.6,
 'floor':162-159.6}
assert all(abs(wall_checks[k]-1)<1e-6 for k in ['left','right','rear','front'])
assert abs(wall_checks['floor']-2.4)<1e-6

# Compare actual original mesh to recreated source geometry before checking fit.
items=json.loads((ROOT/'source/assembly/assembly.json').read_text())
objects={i:manifold(ROOT/'source/assembly'/a['file']) for i,a in enumerate(items)}
original_match=(objects[35]-bob_pose(old_bob,-5)).volume()+(bob_pose(old_bob,-5)-objects[35]).volume()
assert original_match<.02,original_match
assert (new_bob-old_bob).volume()<1e-6

# No new part volume extends beyond the old exterior envelope at matching poses.
# Fill the original bore's 0.1 mm radial running clearance: the relocated pin head
# legitimately occupies some of that internal clearance, which is not exterior.
old_envelope=bob_pose(old_bob,-5)+pin_pose(old_pin,-5,115.4)+bob_pose(cylinder(1.55,115.4,17.6,(0,150)),-5)
new_envelope=bob_pose(new_bob,-5)+pin_pose(pin,-5,116.8)
added_envelope=(new_envelope-old_envelope).volume()
assert added_envelope<.001,added_envelope

# Pocket dimensions and capacity are exactly preserved (central spine excluded).
capacity_cm3=2*(14.6-5)*11.2*21.6/1000
rod_local=objects[34].translate((-P[0],-P[1],0)).rotate((0,0,5))
fixed={i:m for i,m in objects.items() if i not in [0,1,2,3,4,5,6,7,8,9,10,11,18,19,20,27,34,35,36]}
issues=[];max_r=0;min_r=1000;overlap_max=0
def overlap(a,b):
    aa=a.bounding_box();bb=b.bounding_box()
    if any(min(aa[k+3],bb[k+3])-max(aa[k],bb[k])<=1e-6 for k in range(3)):return 0.
    return (a^b).volume()
for angle in np.linspace(-25,15,81):
    b=bob_pose(new_bob,angle);p=pin_pose(pin,angle,116.8)
    rod=bob_pose(rod_local,angle)
    for label,m in [('bob',b),('pin',p)]:
        points=mesh(m).vertices[:,:2]
        max_r=max(max_r,float(np.linalg.norm(points,axis=1).max()))
        min_r=min(min_r,float(MultiPoint(points).convex_hull.distance(Point(0,0))))
        for i,ob in fixed.items():
            v=overlap(m,ob);overlap_max=max(overlap_max,v)
            if v>.005:issues.append([float(angle),label,items[i]['name'],float(v)])
        v=overlap(m,rod);overlap_max=max(overlap_max,v)
        if v>.005:issues.append([float(angle),label,'pendulum rod',float(v)])
    v=overlap(b,p);overlap_max=max(overlap_max,v)
    assert v<.005,v

# Plane/radius bounds cover every drum rotation, not just sampled spoke angles.
# Front spokes start at Z134; the thicker wheel hub is confined within R11.
# Case posts reach inward to R111.25 and span the entire axial compartment.
clearances={'bob_to_front_frame_mm':118.4-115,
            'rear_pin_head_to_front_frame_mm':116.8-115,
            'bob_and_pin_to_front_case_spokes_mm':134-131.6,
            'case_post_radial_clearance_mm':111.25-max_r,
            'radial_separation_from_case_hub_mm':min_r-11}
assert not issues,issues
assert all(v>0 for v in clearances.values()),clearances
report={'revision':'1 mm outer walls / 2026-10-01','parts':parts,
 'wall_thickness_mm':wall_checks,'rod_slot_mm':[7.4,6.6],
 'pin_hole_diameter_mm':3.1,'pin_shank_diameter_mm':2.9,
 'pin_shank_length_mm':13.2,'pin_overall_length_mm':14.8,
 'iron_pocket_capacity_cm3_old_and_new':round(capacity_cm3,6),
 'pin_location_from_pendulum_pivot_mm':150,
 'original_source_reconstruction_difference_mm3':original_match,
 'new_volume_outside_old_exterior_envelope_mm3':added_envelope,
 'pendulum_sweep_deg':[-25,15],'pendulum_sweep_samples':81,
 'nominal_clearances_mm':clearances,'max_intersection_mm3':overlap_max,
 'intersections':issues,
 'drum_clearance_check':'Axial separation from spokes and radial separation from hubs/posts cover all drum angles within the checked pendulum sweep.',
 'limits':'Ideal CAD dimensions. Existing prototype runs according to user; replacement not physically printed or tested. Does not model print error, flex, axial play or screw/assembly tolerances.'}
(OUT/'checks.json').write_text(json.dumps(report,indent=2))
print(json.dumps(report,indent=2))
