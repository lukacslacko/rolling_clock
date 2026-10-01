"""Rolling timer prototype, millimetres. Run from any directory.
pip install manifold3d==3.5.4 trimesh==5.1.0 shapely==2.1.2 numpy
The physical front-view coordinate system is X right, Y down, Z toward front.
Every STL is individually placed on its intended printing face at Z=0.
Assembly meshes are development/preview assets, NOT print plates.
"""
from pathlib import Path
import math, json, sys
import numpy as np
import manifold3d as mf
import trimesh
from shapely.geometry import Point, LineString, Polygon, box
from shapely.ops import unary_union
from shapely.geometry.polygon import orient

ROOT=Path(__file__).resolve().parents[1]
STL=ROOT/'STL'; STL.mkdir(exist_ok=True)
ASM=ROOT/'source'/'assembly'; ASM.mkdir(exist_ok=True)
for stale in ASM.glob('*.stl'): stale.unlink()
MODEL=json.loads((ROOT/'geometry.json').read_text())
D=math.pi/180
MOD=1.25; TOOTH_THINNING=.18
P=np.array(MODEL['centres']['P']); B=np.array([-56.25,0]); C=np.array(MODEL['centres']['C'])
F=np.array(MODEL['pivot']); R=34
FRAME_POSTS=[(65,-35),(40,-85),(45,65),(-60,65)]
BUCKET_PEGS=[(-40,55),(40,55),(-40,80),(40,80)]
BRIDGE_POSTS=[tuple(P+[-21,16]),tuple(P+[21,16])]
B_MOUNTS=[(-80,0),(-60,-40),(-40,-20)]
parts={}; assembly=[]

def circle(r,c=(0,0)): return Point(c).buffer(r,quad_segs=48)
def bar(a,b,w): return LineString([a,b]).buffer(w/2,cap_style=1)
def section(g):
    if g.geom_type=='Polygon': gs=[g]
    else: gs=list(g.geoms)
    contours=[]
    for poly in gs:
        if poly.area<1e-8: continue
        po=orient(poly,sign=1)
        contours.append(np.asarray(po.exterior.coords)[:-1])
        contours.extend(np.asarray(i.coords)[:-1] for i in po.interiors)
    return mf.CrossSection(contours)
def extr(g,z,h): return section(g).extrude(h).translate((0,0,z))
def cyl(r,z,h,xy=(0,0),n=96): return mf.Manifold.cylinder(h,r,circular_segments=n).translate((*xy,z))
def cub(x,y,z,dx,dy,dz): return mf.Manifold.cube((dx,dy,dz)).translate((x,y,z))
def hx(r,x,y,z,length):return mf.Manifold.cylinder(length,r,circular_segments=64).rotate((0,90,0)).translate((x,y,z))
def hy(r,x,y,z,length):return mf.Manifold.cylinder(length,r,circular_segments=64).rotate((-90,0,0)).translate((x,y,z))
def mesh(m):
    raw=m.simplify(0.0001).to_mesh64()
    return trimesh.Trimesh(np.asarray(raw.vert_properties)[:,:3],np.asarray(raw.tri_verts),process=True)
def polar(r,a):return np.array([r*math.cos(a),r*math.sin(a)])
KEY_WIDTH=8.0
KEY_CHAMFER=1.4
KEY_CLEARANCE=.15 # offset of each face; socket is 8.30 across flats
key_half=KEY_WIDTH/2;key_flat_end=key_half-KEY_CHAMFER
key_profile=Polygon([(key_half,key_flat_end),(key_flat_end,key_half),(-key_flat_end,key_half),(-key_half,key_flat_end),(-key_half,-key_flat_end),(-key_flat_end,-key_half),(key_flat_end,-key_half),(key_half,-key_flat_end)])
key_socket=key_profile.buffer(KEY_CLEARANCE,join_style=2)
def key_hole(m,z,h):return m-extr(key_socket,z,h)
def retainer_slot(m,z):
    # Tangential relief lets the square faces carry torque before the pin bears.
    cut=hx(1.95,-12,-1.2,z,24)+hx(1.95,-12,1.2,z,24)+cub(-12,-1.2,z-1.95,24,2.4,3.9)
    return m-cut
def rotate2(p,a):return np.asarray(p)@np.array([[math.cos(a),math.sin(a)],[-math.sin(a),math.cos(a)]])
def spur(n,phase=0):
    rp=MOD*n/2; rb=rp*math.cos(20*D); ra=rp+MOD; rf=rp-1.25*MOD
    inv=lambda r: math.sqrt(max(0,(r/rb)**2-1))-math.acos(min(1,rb/r))
    half=math.pi/(2*n)-TOOTH_THINNING/(2*rp); invp=inv(rp); pts=[]
    for i in range(n):
        mid=i*2*math.pi/n+phase
        pts.append(polar(rf,mid-half-invp))
        for r in np.linspace(max(rf,rb),ra,14):pts.append(polar(r,mid-half-invp+inv(r)))
        atop=half+invp-inv(ra)
        for a in np.linspace(mid-atop,mid+atop,5)[1:]:pts.append(polar(ra,a))
        for r in np.linspace(ra,max(rf,rb),14)[1:]:pts.append(polar(r,mid+half+invp-inv(r)))
        pts.append(polar(rf,mid+half+invp))
        end=(i+1)*2*math.pi/n+phase-half-invp
        for a in np.linspace(mid+half+invp,end,5)[1:]:pts.append(polar(rf,a))
    return Polygon(pts)
def spoked(poly,outer,inner,spokes=6,width=5,offset=30):
    material=circle(inner) | (circle(150)-circle(outer))
    for k in range(spokes):material|=bar((0,0),polar(outer+1,(k*360/spokes+offset)*D),width)
    return poly.intersection(material)
def hole(m,xy,r,z=0,h=160):return m-cyl(r,z,h,xy)
def register(name,m,qty=1,rot=(0,0,0),note='',color='frame'):
    pr=m.rotate(rot); bb=pr.bounding_box(); pr=pr.translate((-bb[0],-bb[1],-bb[2]))
    tm=mesh(pr); bounds=tm.extents
    assert tm.is_watertight and tm.volume>0,(name,'invalid mesh',m.status(),tm.volume)
    assert max(bounds)<=250.01,(name,bounds)
    assert len(tm.split())==1,(name,'disconnected solids')
    tm.export(STL/(name+'.stl'))
    parts[name]={'m':m,'qty':qty,'print_dimensions_mm':np.round(bounds,3).tolist(),
                 'solid_volume_cm3':round(tm.volume/1000,3),'print_note':note,'color':color,
                 'triangles':len(tm.faces),'watertight':bool(tm.is_watertight)}
    return m
def place(name,m=None,xyz=(0,0,0),rot=(0,0,0),label=None):
    model=(m if m is not None else parts[name]['m']).rotate(rot).translate(xyz)
    num=len(assembly); filename=f'{num:02d}_{name}.stl'; mesh(model).export(ASM/filename)
    assembly.append({'name':label or name,'part':name,'file':filename,'color':parts[name]['color'],'model':model})
    return model
def pin(name,r,length,head=3,qty=1):
    m=cyl(head,0,1.6)+cyl(r,1.6,length)
    return register(name,m,qty,note='Print upright on its head; brim. Do not force a tight pin.',color='pins')

# Case wheels: square keyed drive; crosspins only retain parts axially.
ring=circle(120)-circle(111)
for k in range(6):ring|=bar((0,0),polar(115.5,(k*60+30)*D),6)
ring|=circle(11)
for k in range(6):ring-=circle(3.05,polar(115.5,(k*60+30)*D))
wheel=extr(ring,0,6)+cyl(10.8,0,10)
wheel=retainer_slot(key_hole(wheel,-1,12),5)
register('01_case_wheel',wheel,2,note='Flat spokes on bed; 240 mm circle. No brim outside the rim.',color='case')
place('01_case_wheel');place('01_case_wheel',rot=(180,0,0),xyz=(0,0,140),label='front_case_wheel')
post=cyl(4.25,6,128)+cyl(2.95,1,5)+cyl(2.95,134,5)
register('02_case_post',post,6,note='Upright with brim. The two case wheels capture the shoulders.',color='case')
for k in range(6):place('02_case_post',xyz=(*polar(115.5,(k*60+30)*D),0))
main=extr(key_profile,0,140)
for z in [5,81,135]:main-=hx(1.95,-7,0,z,14)
register('03_main_shaft',main,rot=(90,0,0),note='Lie on a long flat as exported; solid, 4-6 walls. 8 mm square with 1.4 mm corner chamfers. Clear retention holes.',color='pins');place('03_main_shaft')
pin('04_main_crosspin',1.875,24,3,3)
for z in [5,81,135]:place('04_main_crosspin',rot=(0,90,0),xyz=(-13.6,0,z))

# Reusable carrier plates. A 20 mm mounting lattice on 40 mm rails leaves
# wide inspection windows. New blind-seat pivot modules sit on the plates'
# INNER faces, so a future shaft never needs a new through-hole in a rail.
nodes=[(0,0),tuple(B),tuple(C),tuple(P)]+FRAME_POSTS+BUCKET_PEGS
links=[((0,0),tuple(B)),(tuple(B),tuple(C)),(tuple(C),tuple(P)),
       ((0,0),FRAME_POSTS[0]),(tuple(B),FRAME_POSTS[1]),
       ((0,0),FRAME_POSTS[2]),(tuple(B),FRAME_POSTS[3]),
       (FRAME_POSTS[2],FRAME_POSTS[3]),(FRAME_POSTS[0],tuple(P)),
       (FRAME_POSTS[1],tuple(P))]
grid=circle(108)-circle(102)
for t in [-80,-40,0,40,80]:
    grid|=bar((t,-108),(t,108),6)|bar((-108,t),(108,t),6)
grid=grid.intersection(circle(108))
GRID=[]
exclusions=[((0,0),15),(tuple(C),8),(tuple(P),8)]+[(p,8) for p in FRAME_POSTS+BUCKET_PEGS+BRIDGE_POSTS]
for x in range(-100,101,20):
    for y in range(-100,101,20):
        if x*x+y*y>100**2 or (x%40 and y%40):continue
        if any(np.linalg.norm(np.array((x,y))-c)<r for c,r in exclusions):continue
        GRID.append((x,y));grid|=circle(5.5,(x,y))
shape=grid|circle(11)
for xy in [tuple(C),tuple(P)]+FRAME_POSTS+BUCKET_PEGS:
    nearest=min([(x,y) for x in [-80,-40,0,40,80] for y in range(-100,101,20) if x*x+y*y<102**2]+[(x,y) for y in [-80,-40,0,40,80] for x in range(-100,101,20) if x*x+y*y<102**2],key=lambda q:np.linalg.norm(np.array(q)-xy))
    shape|=circle(6,xy)|bar(xy,nearest,7)
rear=extr(shape,68,5)+cyl(10,73,4)
frontshape=shape
for p in BRIDGE_POSTS:frontshape|=bar(tuple(P),p,8)|circle(5,p)
front=extr(frontshape,110,5)+cyl(10,106,4)
for name,m,z,isfront in [('05_rear_carrier',rear,68,False),('06_front_carrier',front,106,True)]:
    m=hole(m,(0,0),6.2,z-1,12)
    for xy in [C]:m=hole(m,xy,3.1,z-1,12)
    m=hole(m,P,5.3 if isfront else 3.1,z-1,12)
    for xy in FRAME_POSTS:m=hole(m,xy,2.05,z-1,12)
    for xy in (BRIDGE_POSTS if isfront else BUCKET_PEGS):m=hole(m,xy,2.05,z-1,12)
    for xy in GRID:m=hole(m,xy,2.05,z-1,12)
    register(name,m,rot=(180,0,0) if isfront else (0,0,0),note='Reusable mounting grid. Flat plate on bed, bearing collar upward.',color='frame');place(name)
framepost=cyl(5,73,37)+cyl(2,68,5)+cyl(2,110,5)
register('07_carrier_post',framepost,4,note='Upright. Select static press fit using coupon.',color='frame')
for p in FRAME_POSTS:place('07_carrier_post',xyz=(*p,0))

# Open ballast vessel. The mouth points UP in the stationary carrier.
bucket=cub(-62,42,8,110,46,58)-cub(-59.6,40,10.4,105.2,45.6,53.2)
for xy in BUCKET_PEGS:
    bucket+=cyl(5,66,2,xy)
    bucket=hole(bucket,xy,2.05,61,8)
register('08_open_ballast_bucket',bucket,rot=(-90,0,0),note='Open mouth upward in print and use. No lid. 2.4 mm walls.',color='ballast');place('08_open_ballast_bucket')
pin('09_bucket_pin',2,9.4,3.6,4)
for xy in BUCKET_PEGS:place('09_bucket_pin',xyz=(*xy,62))

# Two-stage 72:18 speed-increasing train, printed as positive-phase compounds.
A=extr(spoked(spur(72),38,12),78,6)+cyl(11,78,8)
A=retainer_slot(key_hole(A,77,11),81)
register('10_drive_72',A,note='Wheel face flat on bed, hub upward.',color='case');place('10_drive_72')
BG=extr(spoked(spur(72),38,9),88,6)+extr(spur(18,-10*D),78,16)
BG=hole(BG,(0,0),3.175,77,18)
register('11_compound_18_72',BG,rot=(180,0,0),note='Large wheel on bed; pinion teeth run through all 16 mm so they start on the bed. Phase is built in.',color='train');place('11_compound_18_72',xyz=(*B,0))
pts=[]
for k in range(30):
    pts.extend(rotate2(MODEL['tooth'],k*12*D))
    pts.extend(polar(MODEL['rootR'],a) for a in np.linspace((k*12-2)*D,((k+1)*12-8.5)*D,6)[1:])
escape=Polygon(rotate2(pts,MODEL['q0']))
beta=math.atan2(C[1]-B[1],C[0]-B[0]); cphase=5*beta+math.pi-math.pi/18
CG=extr(spur(18,cphase),88,17)+extr(spoked(escape,21.5,7,5,4,0),101,4)
CG=hole(CG,(0,0),3.175,87,20)
register('12_escape_compound',CG,rot=(180,0,0),note='Escape wheel on bed; pinion teeth run through all 17 mm. Preserve escape tooth tips.',color='escape');place('12_escape_compound',xyz=(*C,0))
shaft=cyl(5,66,2)+cyl(3,68,47)
register('13_gear_pivot',shaft,1,note='Escape shaft only. Upright on flange, brim; solid. Both ends supported.',color='pins')
place('13_gear_pivot',xyz=(*C,0))
def pivot_module_shape(axis,mounts):
    assert all(tuple(p) in GRID for p in mounts),'Select existing grid holes'
    return unary_union([circle(6.5,axis)]+[bar(axis,p,9)|circle(5.5,p) for p in mounts])
bm=pivot_module_shape(B,B_MOUNTS)
bback=extr(bm,73,4)+cyl(3,77,32,B)
bfront=extr(bm,106,4)-cyl(3.175,105,4.4,B)
for xy in B_MOUNTS:
    bback=hole(bback,xy,2.05,72,6);bfront=hole(bfront,xy,2.05,105,6)
register('31_B_rear_pivot_module',bback,note='Flat module on bed, integral pivot upward. Mounts to three grid holes.',color='frame');place('31_B_rear_pivot_module')
register('32_B_front_pivot_module',bfront,rot=(180,0,0),note='Closed face on bed, blind bearing seat upward. Matching three grid holes.',color='frame');place('32_B_front_pivot_module')
pin('33_module_pin',2,9,3.6,6)
for xy in B_MOUNTS:
    place('33_module_pin',xyz=(*xy,66.4))
    place('33_module_pin',rot=(180,0,0),xyz=(*xy,116.6))
def spacer(name,z,height,qty=1,r=5,bore=3.2):
    m=cyl(r,z,height)-cyl(bore,z-1,height+2)
    register(name,m,qty,note='Flat annular face on bed. Keep thrust faces smooth.',color='pins');return m
for name,z,h,xy in [('15_B_front_spacer',94.6,11.4,B),('16_C_rear_spacer',73,14.4,C),('17_C_front_spacer',105.6,4.4,C)]:
    spacer(name,z,h);place(name,xyz=(*xy,0))
for name,z,h,r in [('34_main_front_thrust_sleeve',86.4,19.2,8.8),('35_main_rear_thrust_washer',77,.6,9.8)]:
    register(name,key_hole(cyl(r,z,h),z-1,h+2),note='Flat face on bed. Chamfered square bore keys this thrust part to the main shaft.',color='pins');place(name)

# Pallet anchor, integral sleeve, and separate adjustable pendulum clamp.
en=Polygon(np.array(MODEL['entry'])-F); ex=Polygon(np.array(MODEL['exit'])-F)
arms=LineString([np.array(MODEL['entry'][0])-F,(-17,4),(0,0),(17,4),np.array(MODEL['exit'][0])-F]).buffer(2.5)
anchor=extr(en|ex|arms|circle(6.5),101,4)+cyl(5,105,22)
anchor=hole(anchor,(0,0),3.175,100,29)
register('18_pallet_anchor',anchor,note='Pallet faces flat on bed, sleeve upward. No supports on contact edges.',color='regulator');place('18_pallet_anchor',xyz=(*P,0),rot=(0,0,-2))
pshaft=cyl(5,66,2)+cyl(3,68,65)
register('19_anchor_pivot',pshaft,note='Upright on flange; brim, solid. Supported at rear plate and front bridge.',color='pins');place('19_anchor_pivot',xyz=(*P,0))
spacer('20_anchor_rear_spacer',73,27.4,r=4.5);place('20_anchor_rear_spacer',xyz=(*P,0))
spacer('21_anchor_front_washer',127.6,1.4,r=4.5);place('21_anchor_front_washer',xyz=(*P,0))
bridgeshape=bar(BRIDGE_POSTS[0],BRIDGE_POSTS[1],8)|circle(6,tuple(P))
bridgeshape|=bar(BRIDGE_POSTS[0],tuple(P),8)|bar(tuple(P),BRIDGE_POSTS[1],8)
bridge=extr(bridgeshape,129,4)
bridge=hole(bridge,P,3.1,128,6)
for xy in BRIDGE_POSTS:bridge=hole(bridge,xy,2.05,128,6)
register('22_anchor_bridge',bridge,note='Flat on bed.',color='frame');place('22_anchor_bridge')
bpost=cyl(4.5,115,14)+cyl(2,110,5)+cyl(2,129,4)
register('23_bridge_post',bpost,2,note='Upright.',color='frame')
for xy in BRIDGE_POSTS:place('23_bridge_post',xyz=(*xy,0))
head=(circle(10)|box(7,-6,16,6))-circle(5.1)-box(0,-.4,17,.4)
pend=extr(head,121,6)+extr(box(-3.5,8,3.5,166),121,6)
pend-=hy(1.6,12.5,-8,124,16)
# Captive M3 nut pocket on positive-Y ear; screw is inserted from negative-Y.
hex2=Polygon([polar(3.35,k*math.pi/3+math.pi/6) for k in range(6)])
nut=extr(hex2,0,3).rotate((-90,0,0)).translate((12.5,3,124))
pend-=nut
for yy in [135,140,145,150,155]:pend=hole(pend,(0,yy),1.5,120,8)
register('24_pendulum',pend,rot=(180,0,0),note='Rod and clamp on bed; One M3×16 plus nut clamps the beat.',color='regulator');place('24_pendulum',xyz=(*P,0),rot=(0,0,-5))
# Open, movable iron-filled bob, with a through-slot over the rod and indexed pin.
bob=cub(-17,133,117,34,24,16)-cub(-14.6,130,119.4,29.2,24.6,11.2)
bob+=cub(-5,133,117,10,24,16)
bob-=cub(-3.7,132,120.7,7.4,26,6.6)
bob=hole(bob,(0,145),1.55,116,18)
bob=bob.translate((0,5,0))
register('25_open_pendulum_bob',bob,rot=(-90,0,0),note='Open mouth up. Slide over rod; set centre initially to the 150 mm hole.',color='regulator');place('25_open_pendulum_bob',xyz=(*P,0),rot=(0,0,-5))
pin('26_bob_pin',1.45,16,2.7)
pinpos=rotate2([(0,150)],-5*D)[0]+P
place('26_bob_pin',xyz=(*pinpos,115.4))

# A small, numbered-by-position coupon. Test the actual materials before big prints.
coupon=cub(0,0,0,112,42,5)
for i,dia in enumerate([6.2,6.3,6.4,6.5]):coupon=hole(coupon,(11+i*17,12),dia/2,-1,8)
for i,dia in enumerate([12.2,12.3,12.4]):coupon=hole(coupon,(14+i*23,30),dia/2,-1,8)
for i,dia in enumerate([4.0,4.1,4.2]):coupon=hole(coupon,(91+i*7,11),dia/2,-1,8)
# Asymmetric corner makes the diagram's orientation unambiguous.
coupon-=cyl(5,-1,8,(0,0))
register('27_fit_coupon',coupon,note='Not an assembly part. Notched corner is lower-left in the fit diagram.',color='frame')
register('28_fit_test_6mm',cyl(5,0,2)+cyl(3,2,18),note='Coupon test shaft; upright.',color='pins')
register('29_fit_test_12mm',cyl(8,0,2)+cyl(6,2,18),note='Coupon test shaft; upright.',color='pins')
register('30_fit_test_4mm',cyl(3,0,2)+cyl(2,2,14),note='Coupon test pin; upright.',color='pins')

# Slip-on round journals rotate with the square shaft inside the unchanged plates.
# Their extended ends locate against the wheel hubs and existing thrust stack.
for name,z,h in [('36_rear_round_journal',10.4,66.6),('37_front_round_journal',106,23.6)]:
    journal=key_hole(cyl(6,z,h),z-1,h+2)
    register(name,journal,note='Upright on flat end; brim. OD 12 mm runs in existing 12.4 mm carrier bore. Square socket slides on shaft.',color='pins');place(name)
key_coupon=cub(0,0,0,54,20,5)
for x,allow in [(10,.1),(27,.15),(44,.2)]:
    key_coupon-=extr(key_profile.buffer(allow,join_style=2),-1,7).translate((x,10,0))
key_coupon-=cyl(3,-1,7,(0,0))
register('38_square_fit_coupon',key_coupon,note='Not an assembly part. Notch at lower-left: 8.20, 8.30, 8.40 mm across flats, left to right.',color='frame')
register('39_square_fit_key',extr(key_profile,0,20),rot=(90,0,0),note='Not an assembly part. Same profile and lying-flat orientation as main shaft.',color='pins')

report={n:{k:v for k,v in p.items() if k!='m'} for n,p in parts.items()}
(ROOT/'mounting-grid.json').write_text(json.dumps({'pitch_mm':20,'rail_spacing_mm':40,'hole_diameter_mm':4.1,'holes_xy_mm':GRID,'B_module_mounts_xy_mm':B_MOUNTS,'rear_plate_z_mm':[68,73],'rear_module_z_mm':[73,77],'front_module_z_mm':[106,110],'front_plate_z_mm':[110,115],'fixed_axes_xy_mm':{'A':[0,0],'C':C.tolist(),'P':P.tolist()},'note':'All other pivots may be placed in blind-seat or integral-shaft modules, in front of the rear plate, without drilling the plate. New modules must avoid existing moving envelopes.'},indent=2))
(ROOT/'parts.json').write_text(json.dumps(report,indent=2))
(ASM/'assembly.json').write_text(json.dumps([{k:v for k,v in a.items() if k!='model'} for a in assembly],indent=2))
total=sum(p['solid_volume_cm3']*p['qty'] for p in parts.values())
print(f'{len(parts)} printable part types; {len(assembly)} assembly instances; {total:.1f} cm³ CAD plastic volume')

# Check the assembled nominal pose for unintended geometric intersections.
collisions=[]
for i,a in enumerate(assembly):
    for b in assembly[i+1:]:
        ba=a['model'].bounding_box();bb=b['model'].bounding_box()
        if any(min(ba[k+3],bb[k+3])-max(ba[k],bb[k])<=.0001 for k in range(3)):continue
        v=(a['model']^b['model']).volume()
        if v>.02:collisions.append({'a':a['name'],'b':b['name'],'intersection_mm3':round(v,5)})
(ROOT/'assembly-checks.json').write_text(json.dumps({'unintended_intersections':collisions,'nominal_pose_checked':True,'max_print_dimension_mm':240,'all_meshes_watertight':True,'assembly_instances':len(assembly)},indent=2))
print('Intersections',json.dumps(collisions,indent=2))
