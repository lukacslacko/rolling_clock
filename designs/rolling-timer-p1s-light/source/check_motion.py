"""Geometric checks; this is not a force/friction or structural simulation."""
import build as b
import numpy as np, math, json
from shapely.geometry import Polygon
from shapely import affinity

def overlap(a,c):
    ba=a.bounding_box();bc=c.bounding_box()
    if any(min(ba[k+3],bc[k+3])-max(ba[k],bc[k])<1e-5 for k in range(3)):return 0
    return (a^c).volume()
input_names=['03_main_shaft','04_main_crosspin','10_drive_72','34_main_front_thrust_sleeve','35_main_rear_thrust_washer','36_rear_round_journal','37_front_round_journal']
moving=input_names+['11_compound_18_72','12_escape_compound','18_pallet_anchor','24_pendulum','25_open_pendulum_bob','26_bob_pin']
fixed=[a for a in b.assembly if a['part'] not in moving and a['part'] not in ['01_case_wheel','02_case_post','03_main_shaft','04_main_crosspin']]
issues=[]; max_contact=0
# Both spur pairs, over a complete input tooth pitch, using the real profiles.
gear_areas=[]
for deg in np.linspace(0,5,121):
    a=affinity.rotate(b.spur(72),deg,origin=(0,0))
    bp=affinity.translate(affinity.rotate(b.spur(18,-10*b.D),-4*deg,origin=(0,0)),*b.B)
    bw=affinity.translate(affinity.rotate(b.spur(72),-4*deg,origin=(0,0)),*b.B)
    cp=affinity.translate(affinity.rotate(b.spur(18,b.cphase),16*deg,origin=(0,0)),*b.C)
    gear_areas.append(max(a.intersection(bp).area,bw.intersection(cp).area))
# Complete anchor including arms, sampled through its two impulse events.
anchor_outline=b.en|b.ex|b.arms|b.circle(6.5)
assert abs(np.linalg.norm(b.mesh(b.CG).vertices[:,:2],axis=1).max()-b.R)<.001, 'Escape tip radius changed in CAD'
anchor_areas=[]
for k in range(0,b.MODEL['N']+1,10):
    phase=k/b.MODEL['N'];q=b.MODEL['wheel_angles'][k]
    alpha=b.MODEL['alpha_center']-b.MODEL['amplitude']*math.cos(2*math.pi*phase)
    an=affinity.rotate(anchor_outline,alpha/b.D,origin=(0,0));an=affinity.translate(an,*b.F)
    ew=affinity.rotate(b.escape,q/b.D,origin=(0,0))
    anchor_areas.append(an.intersection(ew).area)
# Actual three-dimensional pieces against fixed frame and thrust spacers.
for k in range(0,b.MODEL['N']+1,60):
    phase=k/b.MODEL['N'];q=b.MODEL['wheel_angles'][k]/b.D
    alpha=3-5*math.cos(2*math.pi*phase)
    moving_meshes=[
      ('10_drive_72',b.parts['10_drive_72']['m'].rotate((0,0,q/16))),
      ('11_compound_18_72',b.parts['11_compound_18_72']['m'].rotate((0,0,-q/4)).translate((*b.B,0))),
      ('12_escape_compound',b.parts['12_escape_compound']['m'].rotate((0,0,q)).translate((*b.C,0))),
      ('18_pallet_anchor',b.parts['18_pallet_anchor']['m'].rotate((0,0,alpha)).translate((*b.P,0)))]
    for name,m in moving_meshes:
        for f in fixed:
            v=overlap(m,f['model'])
            if v>.02:issues.append([name,f['name'],k,round(v,5)])
# Pendulum beat can be trimmed; test -25 to +15 degrees to include swing and trim.
max_radius=0
for a in np.linspace(-25,15,41):
    for name in ['24_pendulum','25_open_pendulum_bob']:
        m=b.parts[name]['m'].rotate((0,0,float(a))).translate((*b.P,0))
        vs=b.mesh(m).vertices
        max_radius=max(max_radius,float(np.linalg.norm(vs[:,:2],axis=1).max()))
        for f in fixed:
            v=overlap(m,f['model'])
            if v>.02:issues.append([name,f['name'],float(a),round(v,5)])
static_radius=max(float(np.linalg.norm(b.mesh(a['model']).vertices[:,:2],axis=1).max()) for a in fixed)
# New keyed rotor: check a complete turn against the stationary carrier.
rotor=[a for a in b.assembly if a['part'] in input_names]
for deg in np.linspace(0,360,73):
    for a in rotor:
        m=a['model'].rotate((0,0,float(deg)))
        for f in fixed:
            v=overlap(m,f['model'])
            if v>.02:issues.append([a['name'],f['name'],'rotor '+str(float(deg)),round(v,5)])
report={'spur_profile_samples':121,'max_spur_overlap_mm2':max(gear_areas),
        'anchor_profile_samples':241,'max_anchor_overlap_mm2':max(anchor_areas),
        'mechanism_3d_poses':41,'pendulum_poses':41,'pendulum_angle_range_deg':[-25,15],
        'pendulum_max_radius_mm':max_radius,'fixed_carrier_max_radius_mm':static_radius,
        'rotating_case_posts_inner_radius_mm':111.25,'keyed_rotor_full_turn_samples':73,'unintended_intersections':issues,
        'limitations':'Rigid CAD geometry only. No extrusion error, elastic deflection, friction, wear, carrier rocking, or operating reliability simulation.'}
(b.ROOT/'motion-checks.json').write_text(json.dumps(report,indent=2));print(json.dumps(report,indent=2))
assert max(gear_areas)<.001
assert max(anchor_areas)<.005
assert max(max_radius,static_radius)<110.9
assert not issues
