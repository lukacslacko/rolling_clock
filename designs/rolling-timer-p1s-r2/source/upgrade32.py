"""Optional 32:1 development set. Reuses the 16:1 plates, drum and pendulum.
Generated and checked geometry, NOT a print-tested upgrade. Build 16:1 first.
"""
import build as b
import numpy as np, math, json
from shapely import affinity

UP=b.ROOT/'upgrade-32x';UP.mkdir(exist_ok=True)
b.STL=UP/'STL';b.STL.mkdir(exist_ok=True)
for stale in b.STL.glob('*.stl'):stale.unlink()
original=set(b.parts)
# Intersect a 56.25 mm B-D mesh circle and a 33.75 mm C-D mesh circle.
u=(b.C-b.B)/56.25;along=46.125
height=math.sqrt(56.25**2-along**2)
E=b.B+along*u-height*np.array([-u[1],u[0]])
DM=[(-80,-60),(-60,-40),(-40,-60)]
mounts=list(dict.fromkeys(b.B_MOUNTS+DM))
module=b.pivot_module_shape(b.B,b.B_MOUNTS)|b.pivot_module_shape(E,DM)
rear=b.extr(module,73,4)+b.cyl(3,77,32,b.B)+b.cyl(4,77,22.4,E)
for xy in mounts:rear=b.hole(rear,xy,2.05,72,6)
b.register('U01_BD_rear_module',rear,note='Replaces 31. Integral Ø6 B pivot and Ø8 cantilever D pivot.',color='frame')
Bgear=b.extr(b.spoked(b.spur(72),38,9),86,6)+b.extr(b.spur(18,-10*b.D),78,14)
Bgear=b.hole(Bgear,(0,0),3.175,77,16)
b.register('U02_B_compound',Bgear,rot=(180,0,0),note='Replaces 11. Large wheel on bed; pinion above.',color='train')
beta2=math.atan2(*(E-b.B)[::-1]);dphase=5*beta2+math.pi-math.pi/18
Dgear=b.extr(b.spoked(b.spur(36),16.5,8,5,4),94,6)+b.extr(b.spur(18,dphase),86,14)
Dgear=b.hole(Dgear,(0,0),4.175,85,16)-b.cyl(6.5,97.6,3.4)
b.register('U03_D_18_36_compound',Dgear,rot=(180,0,0),note='Wheel on bed. Recess in its front hub accepts the flush retaining collar.',color='train')
beta3=math.atan2(*(b.C-E)[::-1]);cphase=3*beta3+math.pi-math.pi/18
mirror_escape=affinity.scale(b.escape,xfact=-1,yfact=1,origin=(0,0))
Cgear=b.extr(b.spur(18,cphase),94,11)+b.extr(b.spoked(mirror_escape,21.5,7,5,4),101,4)
Cgear=b.hole(Cgear,(0,0),3.175,93,13)
b.register('U04_reversed_escape_compound',Cgear,rot=(180,0,0),note='Replaces 12. Escape wheel face on bed. This wheel runs clockwise viewed from the pendulum/front side.',color='escape')
anchor=b.parts['18_pallet_anchor']['m'].mirror((1,0,0))
b.register('U05_reversed_anchor',anchor,note='Replaces 18. Sleeve up. Mirrored pallets match the third external mesh.',color='regulator')
def sp(name,z,h,xy,r=5,bore=3.2):
    m=b.cyl(r,z,h)-b.cyl(bore,z-1,h+2)
    b.register(name,m,note='Replacement thrust spacer; flat on bed.',color='pins')
    return m.translate((*xy,0))
new=[('U01_BD_rear_module',rear),('U02_B_compound',Bgear.translate((*b.B,0))),('U03_D_18_36_compound',Dgear.translate((*E,0))),('U04_reversed_escape_compound',Cgear.translate((*b.C,0))),('U05_reversed_anchor',anchor.rotate((0,0,2)).translate((*b.P,0)))]
for name,z,h,xy,r,bore in [('U06_B_front_spacer',92.6,13.4,b.B,5,3.2),('U07_C_rear_spacer',73,20.8,b.C,5,3.2),('U08_C_front_spacer',105.2,4.8,b.C,5,3.2),('U10_D_rear_spacer',77,8.8,E,5.5,4.2)]:
    new.append((name,sp(name,z,h,xy,r,bore)))
cap=b.cyl(6,97.8,1.6)-b.cyl(3.95,97,4)
b.register('U11_D_recessed_collar',cap,note='Press onto the fixed Ø8 pivot within the gear counterbore. Top flush with pivot tip at Z99.4; preserve endplay and try fit first.',color='pins')
new.append(('U11_D_recessed_collar',cap.translate((*E,0))))
replaced=['11_compound_18_72','12_escape_compound','18_pallet_anchor','15_B_front_spacer','16_C_rear_spacer','17_C_front_spacer','31_B_rear_pivot_module']
items=[(a['name'],a['model']) for a in b.assembly if a['part'] not in replaced]+new
for xy in [p for p in mounts if p not in b.B_MOUNTS]:
    items.append(('extra_module_pin',b.parts['33_module_pin']['m'].translate((*xy,66.4))))
collisions=[]
for i,(name,a) in enumerate(items):
    for name2,c in items[i+1:]:
        if {name,name2}=={'U01_BD_rear_module','U11_D_recessed_collar'}:continue # intentional press fit
        ba=a.bounding_box();bc=c.bounding_box()
        if any(min(ba[k+3],bc[k+3])-max(ba[k],bc[k])<.0001 for k in range(3)):continue
        v=(a^c).volume()
        if v>.02:collisions.append([name,name2,round(v,5)])
maxmesh=0
for deg in np.linspace(0,5,121):
    gb=affinity.translate(affinity.rotate(b.spur(72),-4*deg,origin=(0,0)),*b.B)
    dp=affinity.translate(affinity.rotate(b.spur(18,dphase),16*deg,origin=(0,0)),*E)
    dw=affinity.translate(affinity.rotate(b.spur(36),16*deg,origin=(0,0)),*E)
    cp=affinity.translate(affinity.rotate(b.spur(18,cphase),-32*deg,origin=(0,0)),*b.C)
    maxmesh=max(maxmesh,gb.intersection(dp).area,dw.intersection(cp).area)
rmax=float(np.linalg.norm(b.mesh(rear).vertices[:,:2],axis=1).max())
report={'ratio':32,'pairs':[[72,18],[72,18],[36,18]],'D_axis_xy_mm':E.tolist(),
        'D_pivot_diameter_mm':8,'rear_module_mounts_xy_mm':mounts,'extra_part_33_pins':2,
        'input_to_escape_direction':'opposite; replace both escapement wheel and anchor with supplied mirrored versions',
        'replaced_base_parts':replaced,'kept':'Both reusable plates, drum wheels and posts, main shaft, C/P shafts, front B module, pendulum and ballast bucket.',
        'max_added_module_radius_mm':rmax,'spur_samples':121,'max_spur_overlap_mm2':maxmesh,
        'C_D_total_axial_endplay_mm_each':0.4,'minimum_D_gear_to_escape_wheel_axial_gap_mm_including_endplay':0.6,
        'unintended_nominal_intersections':collisions,'intentional_interference':'0.1 mm diametral interference at D shaft collar; calibrate the fit.',
        'nominal_5_min_travel_mm':math.pi*240/(32*30*b.MODEL['period'])*300,
        'status':'Development geometry; static pose and spur meshes checked. Reversed pallet geometry is the reflection of the checked 16:1 construction. Requires printing and running trials.'}
(UP/'layout-and-checks.json').write_text(json.dumps(report,indent=2))
(UP/'parts.json').write_text(json.dumps({n:{k:v for k,v in b.parts[n].items() if k!='m'} for n in b.parts if n not in original},indent=2))
print(json.dumps(report,indent=2))
assert maxmesh<.001 and not collisions and rmax<110
