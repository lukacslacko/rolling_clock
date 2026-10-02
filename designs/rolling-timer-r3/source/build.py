"""R3 bolted rolling clock, mm. Generates all three complete configurations.
Run from any directory; only this revision's generated assets are overwritten.
CAD checks do not predict running friction, print fit, or structural strength.
"""
from pathlib import Path
import json, math, argparse
from primitives import *
from shapely import affinity
ROOT=Path(__file__).resolve().parents[1]
MODEL=json.loads((ROOT/'escapement-reference.json').read_text())
NUT_WIDTH=5.25 # User's calibrated trap width; validate with coupon before printing.
NUT_DEPTH=2.8
W=180.; REAR=72.; FRONT=126.; PEND_Z=145.
A=np.array([0.,0.]); Bslow=np.array([-56.25,0.]); C=np.array([30.,-45.])
F=np.array(MODEL['pivot']); TILT=-10.0; P=C+rotate2([F],TILT*D)[0]

def intersections(a,r,b,s):
    d=np.linalg.norm(b-a);u=(b-a)/d;x=(r*r-s*s+d*d)/(2*d)
    h=math.sqrt(r*r-x*x);v=np.array([-u[1],u[0]])
    return a+x*u+h*v,a+x*u-h*v
Bfast=intersections(A,56.25,C,56.25)[0]
E64=intersections(Bslow,56.25,C,56.25)[1]
E32=E64.copy()
AXES={'A':A,'B16':Bfast,'Bslow':Bslow,'D':E64,'C':C,'P':P}
FRAME_POSTS=[(-81,51),(72,-60),(65,68)]
BRIDGE_POSTS=[P+[-26,24],P+[26,24]]
BOWL_BOLTS=[(-36,52),(36,52)];BOWL_RESTS=[(-36,78),(36,78)]
parts={}; assemblies={}; layouts={}; current=[]

def register(name,m,qty=1,rot=(0,0,0),note='',color='frame',folder='common'):
    path=ROOT/'STL'/folder;path.mkdir(parents=True,exist_ok=True)
    pr=m.rotate(rot);bb=pr.bounding_box();pr=pr.translate((-bb[0],-bb[1],-bb[2]));tm=mesh(pr)
    assert tm.is_watertight and tm.volume>0 and len(tm.split())==1,(name,tm.is_watertight,tm.volume,len(tm.split()))
    assert max(tm.extents)<=250.01,(name,tm.extents)
    tm.export(path/(name+'.stl'))
    parts[(folder,name)]={'m':m,'qty':qty,'file':f'STL/{folder}/{name}.stl','color':color,
        'dimensions_mm':tm.extents.round(3).tolist(),'volume_cm3':round(tm.volume/1000,3),'print_note':note}
    return m

def place(name,xyz=(0,0,0),rot=(0,0,0),folder='common',group='fixed',label=None):
    p=parts[folder,name];m=p['m'].rotate(rot).translate(xyz)
    current.append({'part':name,'folder':folder,'name':label or name,'m':m,'color':p['color'],'group':group})
    return m

def screw(name,point,axis,length):
    """Worst-case 6.5 x 3.2 mm head and nominal 5.5 AF x 2.4 mm nut.
    Nuts may intentionally overlap the user's 5.25 mm calibrated trap walls.
    """
    group='case' if name.startswith('case_') else 'rotor' if name.startswith('axle_') else 'pendulum' if name in ('pendulum_clamp','bob_bolt') else 'fixed'
    if name.startswith('case_'):offset=12.5;owner='case_post_'+name.rsplit('_',1)[1]
    elif name.startswith('frame_'):offset=7.2;owner='frame_post_'+str(int(name.rsplit('_',1)[1])+1)
    elif name.startswith('bridge_'):offset=7.2;owner='bridge_post_'+name.rsplit('_',1)[1]
    elif name.startswith('axle_'):
        offset=11.2;owner={'6':'rear_case_wheel','91':'10_drive_72','174':'front_case_wheel'}[name.rsplit('_',1)[1]]
    elif name.startswith('bowl_'):offset=6.4;owner='08_open_ballast_bowl'
    elif name=='pendulum_clamp':offset=10.2;owner='24_offset_pendulum'
    elif name=='bob_bolt':offset=9.8;owner='25_screw_fixed_bob'
    elif name=='anchor_pivot_bolt':offset=6.7;owner='19_bolted_anchor_pivot'
    else:offset=6.7;owner=name[0]+'_pivot'
    v=np.array(axis,dtype=float);v/=np.linalg.norm(v)
    def pose(m):
        if np.allclose(v,[0,0,-1]):m=m.rotate((180,0,0))
        elif np.allclose(v,[1,0,0]):m=m.rotate((0,90,0))
        elif np.allclose(v,[0,1,0]):m=m.rotate((-90,0,0))
        else:assert np.allclose(v,[0,0,1]),v
        return m.translate(tuple(point))
    m=pose(cyl(1.5,0,length)+cyl(3.25,-3.2,3.2))
    current.append({'part':name,'folder':'hardware','name':name,'m':m,'color':'steel','group':group,'hardware':True,'type':'screw','length':length,'nut_grip_mm':offset,'tip_beyond_nut_mm':length-offset-2.4,'axis':v.tolist(),'point':list(point)})
    phase=math.pi/6 if name in ('pendulum_clamp','bob_bolt') else 0
    nutpoly=Polygon([polar(5.5/math.sqrt(3),k*math.pi/3+phase) for k in range(6)])
    nut=pose(extr(nutpoly,offset,2.4)-cyl(1.6,offset-1,4.4))
    current.append({'part':name+'_nut','folder':'hardware','name':name+'_nut','m':nut,'color':'steel','group':group,'hardware':True,'type':'nut','allowed_interference_with':owner})

def nut_slot(m,z,side=12,width=NUT_WIDTH):
    # Axial bolt is Z. Nut enters from -X; two parallel Y walls resist rotation.
    return m-cub(-side/2-.1,-width/2,z,side/2+3.6,width,NUT_DEPTH)

def socket_lip(xy,z,size=12,h=1.5):
    outer=box(-size/2-1.7,-size/2-1.7,size/2+1.7,size/2+1.7)
    inner=box(-size/2-.2,-size/2-.2,size/2+.2,size/2+.2)
    return extr(outer-inner,z,h).translate((*xy,0))

def square_post(size,z,length,depth):
    m=cub(-size/2,-size/2,z,size,size,length)
    for zz in (z+depth,z+length-depth-NUT_DEPTH):
        m=nut_slot(m,zz,size)
    m-=cyl(1.7,z-1,min(14,length/2+1))
    m-=cyl(1.7,z+length-min(13,length/2),min(14,length/2+1))
    return m

def cross_hub(m,z):
    # M3x16, head underside x=-5.6; nut bearing face x=5.6.
    m-=hx(1.7,-12,0,z,24)
    m-=hx(3.6,-12,0,z,6.4)
    m-=cub(5.6,-NUT_WIDTH/2,z-3.25,NUT_DEPTH,NUT_WIDTH,13)
    return m

# Deeper rolling rim; post screws have clearance and apply axial clamping only.
ring=circle(124)-circle(111)
for k in range(6):
    angle=k*60+30;q=polar(114,angle*D)
    ring|=bar(A,q,7)
    ring|=affinity.translate(affinity.rotate(box(-6.9,-6.9,6.9,6.9),angle,origin=(0,0)),*q)
ring|=circle(11)
wheel=extr(ring,0,7)+cyl(10.8,0,12)
wheel=cross_hub(key_hole(wheel,-1,15),6)
for k in range(6):
    q=polar(114,(k*60+30)*D)
    wheel-=cyl(1.7,-1,10,q)
    wheel+=socket_lip((0,0),7,10).rotate((0,0,k*60+30)).translate((*q,0))
register('01_case_wheel',wheel,2,note='Flat outer face on bed, hub and locating lips up. No outer brim; diameter 248 mm.',color='case')
register('02_square_case_post',square_post(10,7,166,5.5),6,rot=(0,90,0),note='Long flat side on bed; both nut-slot mouths upward. Preload two M3 nuts. End bolts M3x16.',color='case')
shaft=extr(key_profile,0,W)
for z in (6,91,174):shaft-=hx(1.7,-6,0,z,12)
register('03_square_main_axle',shaft,rot=(90,0,0),note='Long flat on bed; solid. Cross-holes at 6, 91 and 174 mm from the rear end.',color='case')

# Shared open frames carry all specified axes, not an unrestricted mounting grid.
core=unary_union([bar(FRAME_POSTS[i],FRAME_POSTS[(i+1)%3],9) for i in range(3)])
core|=circle(11)
for q in list(AXES.values())[1:]:
    half=6.9 if np.linalg.norm(q-P)<.01 else 7.9
    core|=circle(9,q)|bar(q,A,9)|affinity.translate(box(-half,-half,half,half),*q)
    near=min(FRAME_POSTS,key=lambda p:np.linalg.norm(np.array(p)-q));core|=bar(q,near,8)
core|=bar(C,P,10)
for q in FRAME_POSTS:core|=circle(9,q)|affinity.translate(box(-7.9,-7.9,7.9,7.9),*q)
rearshape=core
for top,low in zip(BOWL_BOLTS,BOWL_RESTS):
    rearshape|=bar(A,top,10)|bar(top,low,10)|circle(7,low)
rearshape|=bar(BOWL_BOLTS[0],BOWL_BOLTS[1],9)
frontshape=core
for q in BRIDGE_POSTS:frontshape|=bar(P,q,9)|circle(9,q)
rear=extr(rearshape,72,6)+cyl(10,78,4)
front=extr(frontshape,126,6)+cyl(10,122,4)
rear=hole(rear,A,6.2,71,13);front=hole(front,A,6.2,121,13)
for q in list(AXES.values())[1:]:
    rear=hole(rear,q,1.7,71,10)
    rear=hole(rear,q,3.6,71,3.2) # Head underside 74.2 -> 3.8 mm remaining frame.
    rear+=socket_lip(q,78,size=10 if np.linalg.norm(q-P)<.01 else 12)
    if np.linalg.norm(q-P)<.01:front=hole(front,q,6.2,121,13)
    else:front=hole(front,q,4.2,125,4) # Blind 3 mm seat, not press fit.
for q in FRAME_POSTS:
    rear=hole(rear,q,1.7,71,10);rear=hole(rear,q,3.6,71,3.2);rear+=socket_lip(q,78)
    front=hole(front,q,1.7,125,10);front=hole(front,q,3.6,129.8,3.2)
    front+=socket_lip(q,124.5)
for q in BRIDGE_POSTS:
    front=hole(front,q,1.7,125,10);front=hole(front,q,3.6,125,3.2)
for q in BOWL_BOLTS:
    rear=hole(rear,q,1.7,71,10);rear=hole(rear,q,3.6,74,5)
register('05_shared_rear_frame',rear,note='Flat outside face on bed; lips and main collar up. Universal 16/32/64 frame.')
register('06_shared_front_frame',front,rot=(180,0,0),note='Outside face on bed; all locating lips point up. Bridge posts locate in the bridge at their other ends.')
register('07_square_frame_post',square_post(12,78,48,3.4),3,rot=(0,90,0),note='Long flat side on bed, nut slots up. Flat ends set the 48 mm frame gap; M3x10 at both ends.')

# Main iron bowl, narrower corners for clearance of square drum posts.
bucket=cub(-52,42,10,104,46,60)-cub(-49.6,40,12.4,99.2,45.6,55.2)
for q in BOWL_BOLTS+BOWL_RESTS:bucket+=cyl(5.5,70,2,q)
hexnut=Polygon([polar(NUT_WIDTH/math.sqrt(3),k*math.pi/3) for k in range(6)])
for q in BOWL_BOLTS:
    bucket+=cyl(5.8,64.8,3.2,q)
    bucket-=extr(hexnut,64.7,2.9).translate((*q,0));bucket=hole(bucket,q,1.7,64,10)
register('08_open_ballast_bowl',bucket,rot=(-90,0,0),note='Mouth up. Two M3x10 screws and two nuts; lower pads rest on the frame.',color='ballast')

inputgear=extr(spoked(spur(72),38,12),84,6)+cyl(11,84,10.8)
inputgear=cross_hub(key_hole(inputgear,83,17),91)
register('10_drive_72',inputgear,note='Broad wheel on bed, hub up. M3x16 retains the square axle.',color='input')
# Gear pivots: square foot bolts to rear frame; front tip slips into a blind seat.
def pivot(end,size=12):
    m=cub(-size/2,-size/2,78,size,size,4.5)+cyl(4,82.5,end-82.5)
    m=nut_slot(m,80.9,size) # 3.8 mm frame + 2.9 mm nut seat + 2.4 = 9.1 mm.
    m-=cyl(1.7,77,12)
    return m
register('13_bolted_gear_pivot',pivot(128.5),2,note='Square foot on bed; 8 mm journal up. One M3x10 at rear; tip has 0.5 mm clearance in the front blind seat.',color='pins')
register('19_bolted_anchor_pivot',pivot(161.5,10),note='Square foot on bed. M3x10 at rear; bridge supports the long tip.',color='pins')

en=Polygon(np.array(MODEL['entry'])-F);ex=Polygon(np.array(MODEL['exit'])-F)
arms=LineString([np.array(MODEL['entry'][0])-F,(-17,4),(0,0),(17,4),np.array(MODEL['exit'][0])-F]).buffer(2.5)
anchor_outline=en|ex|arms|circle(7.5)
anchor=extr(anchor_outline,117,4)+cyl(6,121,30)
anchor=hole(anchor,A,4.175,116,37)
register('18_anchor_forward',anchor,folder='16x',note='Pallet faces on bed, sleeve up. Used only with 16x escape wheel.',color='regulator')
register('18_anchor_reversed',anchor.mirror((1,0,0)),folder='slow-common',note='Pallet faces on bed, sleeve up. Used with 32x or 64x reversed escape wheels.',color='regulator')

def spacer(name,z,h,bore=4.2,r=6,folder='common',qty=1):
    return register(name,cyl(r,z,h)-cyl(bore,z-1,h+2),qty,folder=folder,note=f'Flat annular face on bed; {h:g} mm long.',color='pins')
spacer('20_anchor_rear_spacer',82.5,34.2)
spacer('21_anchor_front_spacer',151.3,7.7)
bridgeshape=bar(BRIDGE_POSTS[0],BRIDGE_POSTS[1],10)|bar(BRIDGE_POSTS[0],P,10)|bar(P,BRIDGE_POSTS[1],10)|circle(7,P)
for q in BRIDGE_POSTS:bridgeshape|=circle(9,q)|affinity.translate(box(-7.9,-7.9,7.9,7.9),*q)
bridge=extr(bridgeshape,159,6);bridge=hole(bridge,P,4.2,158,4)
for q in BRIDGE_POSTS:
    bridge=hole(bridge,q,1.7,158,10);bridge=hole(bridge,q,3.6,162.8,3.2);bridge+=socket_lip(q,157.5)
register('22_bolted_anchor_bridge',bridge,rot=(180,0,0),note='Outer face on bed; shallow locating lips upward. M3x10 at each end.')
register('23_square_bridge_post',square_post(12,132,27,3.4),2,rot=(0,90,0),note='Flat side on bed, nut mouths up. Two M3x10 per post. Hard shoulders set the bridge position.')
# A shallow dogleg avoids the main axle throughout the checked +/-15 degree swing.
head=(circle(11)|box(-19,-7,-8,7))-circle(6.1)-box(-20,-.4,0,.4)
rod=LineString([(0,8),(0,25),(20,60),(20,95),(0,125),(0,166)]).buffer(3.5,cap_style=2,join_style=1)
pend=extr(head|rod,145,6)
pend-=hy(1.7,-15,-9,148,22)
pend-=hy(3.6,-15,-9,148,3)
nh=Polygon([polar(NUT_WIDTH/math.sqrt(3),k*math.pi/3+math.pi/6) for k in range(6)])
pend-=extr(nh,0,2.8).rotate((-90,0,0)).translate((-15,4.2,148))
for yy in (135,140,145,150,155):pend=hole(pend,(0,yy),1.7,144,9)
register('24_offset_pendulum',pend,rot=(180,0,0),note='Broad face on bed. Dogleg clears the main shaft. M3x16 clamp; 3.4 mm bob holes.',color='regulator')
bob=cub(-15.6,138,141.4,31.2,24,13.2)-cub(-14.6,136,142.4,29.2,23.6,11.2)
bob+=cub(-5,138,141.4,10,24,13.2)
bob-=cub(-3.7,137,144.7,7.4,26,6.6)
bob=hole(bob,(0,150),1.7,140,20)
bob-=cub(-NUT_WIDTH/2,137,151.2,NUT_WIDTH,16.25,2.8)
register('25_screw_fixed_bob',bob,rot=(-90,0,0),note='Open mouth up. 1 mm outer walls; captive nut drops into front central slot. Use one M3x16 through the selected rod hole.',color='regulator')
for name,z,h,r in [('34_main_front_thrust_sleeve',95.2,26.4,7.5),('35_main_rear_thrust_washer',82.4,1.2,8),('36_rear_round_journal',12.4,70,6),('37_front_round_journal',122,45.6,6)]:
    register(name,key_hole(cyl(r,z,h),z-1,h+2),note=f'Flat annular end on bed, {h:g} mm long. Square bore keys to axle.',color='pins')

# Standalone, small post/nut coupons. Print these before committing to the case.
for width,suffix in [(5.25,'525'),(5.4,'540'),(5.6,'560')]:
    # Coupon widths stay literal even after the production NUT_WIDTH changes.
    m=cub(-6,-6,0,12,12,20)
    for zz in (3.4,20-3.4-NUT_DEPTH):m=nut_slot(m,zz,12,width)
    m-=cyl(1.7,-1,22)
    register('40_nut_post_coupon_'+suffix,m,folder='fit-tests',rot=(0,90,0),note=f'Trial nut slot {width:g} mm. Slide nut from open side; use actual M3x10 screw through coupon plate.')
plate=cub(-10,-10,0,20,20,6)+socket_lip(A,6)
plate-=cyl(1.7,-1,10);plate-=cyl(3.6,-1,3.2)
register('41_post_seat_coupon',plate,folder='fit-tests',note='Clamps to coupon with M3x10; 12 mm post slips into 12.4 mm lip opening.')

# Escape polygon retained from the physically successful first build.
pts=[]
for k in range(30):
    pts.extend(rotate2(MODEL['tooth'],k*12*D))
    pts.extend(polar(MODEL['rootR'],a) for a in np.linspace((k*12-2)*D,((k+1)*12-8.5)*D,6)[1:])
escape=Polygon(rotate2(pts,MODEL['q0']))

for ratio in (16,32,64):
    folder=f'{ratio}x'; B=Bfast if ratio==16 else Bslow;E=E32 if ratio==32 else E64
    beta=math.atan2(B[1],B[0]);bp=5*beta+math.pi-math.pi/18
    bg=extr(spoked(spur(72),38,9),96,6)+extr(spur(18,bp),84,18)
    bg=hole(bg,A,4.175,83,21)
    register('11_B_18_72',bg,rot=(180,0,0),folder=folder,note='Large wheel on bed; pinion teeth continue down to the bed. Pinion faces rear in assembly.',color='compound')
    if ratio==16:
        beta=math.atan2(*(C-B)[::-1]);cp=5*beta+math.pi-math.pi/18;cz=96
    else:
        beta=math.atan2(*(E-B)[::-1]);dp=5*beta+math.pi-math.pi/18;n=60 if ratio==32 else 72
        dg=extr(spoked(spur(n),31 if n==60 else 38,9,6,5),108,6)+extr(spur(18,dp),96,18)
        dg=hole(dg,A,4.175,95,22)
        register(f'14_D_18_{n}',dg,rot=(180,0,0),folder=folder,note='Large wheel on bed; pinion faces rear. Both pivot ends supported.',color='extra')
        beta=math.atan2(*(C-E)[::-1]);cn=30 if ratio==32 else 18;cp=(n/cn+1)*beta+math.pi-math.pi/cn;cz=108
    ep=escape if ratio==16 else affinity.scale(escape,xfact=-1,yfact=1,origin=(0,0))
    ep=affinity.rotate(ep,TILT,origin=(0,0))
    cg=extr(spur(30 if ratio==32 else 18,cp),cz,121-cz)+extr(spoked(ep,21.5,8,5,4,0),117,4)
    cg=hole(cg,A,4.175,cz-1,124-cz)
    register('12_escape_compound',cg,rot=(180,0,0),folder=folder,note='Escape face on bed; pinion extends through wheel. Use matching anchor direction.',color='escape')
    spacer('15_B_rear_spacer',82.5,1.2,folder=folder)
    spacer('16_B_front_spacer',102.3,23.7,folder=folder)
    spacer('17_C_rear_spacer',82.5,cz-82.8,folder=folder)
    spacer('27_C_front_spacer',121.3,4.7,folder=folder)
    if ratio!=16:
        spacer('28_D_rear_spacer',82.5,13.2,folder=folder);spacer('29_D_front_spacer',114.3,11.7,folder=folder)
    current=[]
    place('01_case_wheel',group='case',label='rear_case_wheel')
    # Mirror Z without rotating XY: all six square sockets align exactly.
    p=parts['common','01_case_wheel']; current.append({'part':'01_case_wheel','folder':'common','name':'front_case_wheel','m':p['m'].rotate((180,0,0)).translate((0,0,W)),'color':'case','group':'case'})
    for k in range(6):
        angle=k*60+30;q=polar(114,angle*D)
        place('02_square_case_post',xyz=(*q,0),rot=(0,0,angle),group='case',label=f'case_post_{k+1}')
        screw(f'case_rear_{k+1}',(*q,0),(0,0,1),16);screw(f'case_front_{k+1}',(*q,W),(0,0,-1),16)
    place('03_square_main_axle',group='rotor')
    for z in (6,91,174):screw('axle_cross_'+str(z),(-5.6,0,z),(1,0,0),16)
    place('05_shared_rear_frame');place('06_shared_front_frame')
    for i,q in enumerate(FRAME_POSTS):
        place('07_square_frame_post',xyz=(*q,0),label=f'frame_post_{i+1}')
        screw(f'frame_rear_{i}',(*q,74.2),(0,0,1),10);screw(f'frame_front_{i}',(*q,129.8),(0,0,-1),10)
    place('08_open_ballast_bowl')
    for i,q in enumerate(BOWL_BOLTS):screw(f'bowl_{i}',(*q,74),(0,0,-1),10)
    place('10_drive_72',group='rotor')
    for label,axis in [('B',B),('C',C)]+([('D',E)] if ratio!=16 else []):
        place('13_bolted_gear_pivot',xyz=(*axis,0),label=label+'_pivot')
        screw(label+'_pivot_bolt',(*axis,74.2),(0,0,1),10)
    place('19_bolted_anchor_pivot',xyz=(*P,0));screw('anchor_pivot_bolt',(*P,74.2),(0,0,1),10)
    place('11_B_18_72',xyz=(*B,0),folder=folder,group='B')
    place('12_escape_compound',xyz=(*C,0),folder=folder,group='C')
    if ratio!=16:place(f'14_D_18_{60 if ratio==32 else 72}',xyz=(*E,0),folder=folder,group='D')
    for name,axis in [('15_B_rear_spacer',B),('16_B_front_spacer',B),('17_C_rear_spacer',C),('27_C_front_spacer',C)]+([('28_D_rear_spacer',E),('29_D_front_spacer',E)] if ratio!=16 else []):place(name,xyz=(*axis,0),folder=folder)
    an='18_anchor_forward' if ratio==16 else '18_anchor_reversed';af=folder if ratio==16 else 'slow-common'
    place(an,xyz=(*P,0),rot=(0,0,TILT+(-2 if ratio==16 else 2)),folder=af,group='anchor')
    for name in ('20_anchor_rear_spacer','21_anchor_front_spacer'):place(name,xyz=(*P,0))
    place('22_bolted_anchor_bridge')
    for i,q in enumerate(BRIDGE_POSTS):
        place('23_square_bridge_post',xyz=(*q,0),label=f'bridge_post_{i}');screw(f'bridge_rear_{i}',(*q,128.2),(0,0,1),10);screw(f'bridge_front_{i}',(*q,162.8),(0,0,-1),10)
    place('24_offset_pendulum',xyz=(*P,0),group='pendulum');place('25_screw_fixed_bob',xyz=(*P,0),group='pendulum')
    screw('pendulum_clamp',(*(P+[-15,-6]),148),(0,1,0),16)
    screw('bob_bolt',(*(P+[0,150]),141.4),(0,0,1),16)
    for name in ('34_main_front_thrust_sleeve','35_main_rear_thrust_washer','36_rear_round_journal','37_front_round_journal'):place(name,group='rotor')
    assemblies[ratio]=current
    layouts[ratio]={'ratio':ratio,'axes':{k:v.tolist() for k,v in [('A',A),('B',B),('C',C),('P',P)]+([('D',E)] if ratio!=16 else [])},'pinion_phase_rad':{'B':bp,'C':cp,**({'D':dp} if ratio!=16 else {})},'pairs':[[72,18],[72,18]]+([[60,30] if ratio==32 else [72,18]] if ratio!=16 else []),'direction_from_pendulum_side':'input counterclockwise; escape '+('counterclockwise' if ratio==16 else 'clockwise'),'M3x10':sum(x.get('length')==10 for x in current),'M3x16':sum(x.get('length')==16 for x in current),'nominal_seconds_per_metre':1000/(math.pi*248)*ratio*30*MODEL['period']}
    out=ROOT/'assembly'/folder;out.mkdir(parents=True,exist_ok=True)
    for old in out.glob('*.stl'):old.unlink()
    manifest=[]
    for i,item in enumerate(current):
        fn=f'{i:02d}_{item["name"]}.stl';mesh(item['m']).export(out/fn)
        manifest.append({k:v for k,v in item.items() if k!='m'}|{'file':fn})
    (out/'assembly.json').write_text(json.dumps(manifest,indent=2))
    quantities={}
    for item in current:
        if item['folder']=='hardware':continue
        key=item['folder']+'/'+item['part'];quantities[key]=quantities.get(key,0)+1
    layouts[ratio]['print_quantities']=quantities
(ROOT/'parts.json').write_text(json.dumps({f'{folder}/{name}':{k:v for k,v in p.items() if k!='m'} for (folder,name),p in parts.items()},indent=2))
(ROOT/'layouts.json').write_text(json.dumps(layouts,indent=2))
print('Built',len(parts),'part types. Axes:',{k:v.round(4).tolist() for k,v in AXES.items()})
print('Hardware', {r:{k:v for k,v in l.items() if k in ('M3x10','M3x16')} for r,l in layouts.items()})
