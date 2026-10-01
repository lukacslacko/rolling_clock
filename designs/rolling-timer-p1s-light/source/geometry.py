import math, json
from pathlib import Path
import numpy as np

D=math.pi/180
R=34.0
PITCH=2*math.pi/30
F=np.array([0.,-R/math.cos(45*D)])
LOCK=1.5*D
LIFT=4.5*D
DROP=2*D
AMP=5*D
CENTER=(LOCK+LIFT)/2

def polar(r,a): return np.array([r*math.cos(a),r*math.sin(a)])
def rot(points,a,origin=F):
    p=np.array(points)-origin
    return p@np.array([[math.cos(a),math.sin(a)],[-math.sin(a),math.cos(a)]])+origin
def arc(r,a,b,n=None):
    n=n or max(3,int(abs(b-a)/(0.12*D))+1)
    return [F+polar(r,t) for t in np.linspace(a,b,n)]

# Equal-impulse-radius deadbeat construction; see Roman Andronov's construction.
width=PITCH/2-DROP
Ln=polar(R,-math.pi/2-math.pi/4-width/2)
Hn=polar(R,-math.pi/2-math.pi/4+width/2)
ro=float(np.linalg.norm(Ln-F)); ri=float(np.linalg.norm(Hn-F))
an=math.atan2(*(Ln-F)[::-1]); ax=math.pi-an
cn=an-LOCK; dn=cn-LIFT; dx=ax; cx=dx-LIFT
entry=np.array(arc(ro,an+18*D,cn)+arc(ri,dn,an+18*D))
exitp=np.array(arc(ri,ax-22*D,cx)+arc(ro,dx,ax-22*D))

def inside(p,poly):
    x,y=p; a=poly; b=np.roll(poly,-1,axis=0)
    cond=((a[:,1]>y)!=(b[:,1]>y)) & (x<(b[:,0]-a[:,0])*(y-a[:,1])/(b[:,1]-a[:,1]+1e-30)+a[:,0])
    return bool(np.count_nonzero(cond)%2)

def boundaries(poly):
    a=poly;b=np.roll(poly,-1,axis=0);v=b-a
    aa=np.sum(v*v,axis=1);bb=2*np.sum(a*v,axis=1);cc=np.sum(a*a,axis=1)-R*R
    disc=bb*bb-4*aa*cc
    valid=disc>=0
    roots=[]
    for sign in [-1,1]:
        tt=(-bb+sign*np.sqrt(np.maximum(0,disc)))/(2*aa)
        for k in np.where(valid & (tt>=-1e-10)&(tt<=1+1e-10))[0]:
            p=a[k]+tt[k]*v[k];angle=math.atan2(p[1],p[0])
            if inside(polar(R,angle+1e-6),poly) and not inside(polar(R,angle-1e-6),poly):
                roots.append(angle)
    return roots

N=2400
qs=[]; alphas=[]; states=[]
q=None
for k in range(N+1):
    phase=k/N
    alpha=CENTER-AMP*math.cos(2*math.pi*phase)
    roots=[]
    for side,p in enumerate([entry,exitp]):
        for angle in boundaries(rot(p,alpha)):
            residue=angle%PITCH
            if q is None: delta=residue
            else:
                delta=(residue-q)%PITCH
                if delta>PITCH-2e-6: delta=0
            roots.append((delta,residue,side,angle))
    if not roots: raise RuntimeError('No pallet stops wheel')
    delta,residue,side,angle=min(roots)
    q=residue if q is None else q+delta
    qs.append(q);alphas.append(alpha);states.append(side)

print('pivot distance',-F[1],'pallet radii',ro,ri)
print('advance deg', (qs[-1]-qs[0])/D, 'expected',360/30)
print('start/end',qs[0]/D,qs[-1]/D,'range',min(qs)/D,max(qs)/D)
for k in range(0,N+1,N//16):print(k,round(alphas[k]/D,3),round(qs[k]/D,5),states[k])
assert abs(qs[-1]-qs[0]-PITCH)<1e-5

# Leading tooth tip at angle 0; a 1.4-degree, approximately 0.88 mm tip edge.
# Back-swept tooth root edges give clearance to both pallets.
rootR=R*.78
tip_width=1.4*D
tooth=[polar(rootR,-8.5*D),polar(R-.3,-tip_width),polar(R,0),polar(rootR,-2.0*D)]

def poly_path(points):
    return 'M'+'L'.join(f'{p[0]:.5f},{p[1]:.5f}' for p in points)+'Z'

def spur(n,module=1.25,backlash=.18):
    rp=module*n/2; rb=rp*math.cos(20*D);ra=rp+module;rf=rp-1.25*module
    inv=lambda r: math.sqrt(max(0,(r/rb)**2-1))-math.acos(min(1,rb/r))
    half=math.pi/(2*n)-backlash/(2*rp)
    invp=inv(rp)
    points=[]
    for i in range(n):
        mid=i*2*math.pi/n
        start=mid-half-invp
        points.append(polar(rf,start))
        for r in np.linspace(max(rf,rb),ra,10): points.append(polar(r,mid-half-invp+inv(r)))
        atop=half+invp-inv(ra)
        for a in np.linspace(mid-atop,mid+atop,4)[1:]:points.append(polar(ra,a))
        for r in np.linspace(ra,max(rf,rb),10)[1:]:points.append(polar(r,mid+half+invp-inv(r)))
        points.append(polar(rf,mid+half+invp))
        end=(i+1)*2*math.pi/n-half-invp
        for a in np.linspace(mid+half+invp,end,4)[1:]:points.append(polar(rf,a))
    return np.array(points)

period=2*math.pi*math.sqrt(.140/9.81)
runtime=1000/(120*2*math.pi)*(16*30*period)
data={
    'period':period,'runtime':runtime,'N':N,
    'alpha_center':CENTER,'amplitude':AMP,'q0':qs[0],
    'wheel_angles':[round(q-qs[0],9) for q in qs],
    'sides':states,
    'entry':entry.round(6).tolist(),'exit':exitp.round(6).tolist(),
    'pivot':F.tolist(),'entryPath':poly_path(entry),'exitPath':poly_path(exitp),
    'tooth':np.array(tooth).round(6).tolist(),
    'spur72':poly_path(spur(72)), 'spur18':poly_path(spur(18)),
    'outerR':R,'rootR':rootR,'ro':ro,'ri':ri,
    'centres':{'A':[0,0],'B':[-56.25,0],'C':[-25,-math.sqrt(2187.5)],'P':[-25,-math.sqrt(2187.5)+F[1]]},
    'ratios':[4,4], 'gear_module':1.25,'pressure_angle':20,
    'drum_diameter':240,'pendulum_effective_length':140,
    'ramp_length':1000,'ramp_angle':6,'escape_teeth':30,
    'pallet_lock':1.5,'pallet_lift':4.5,'pallet_drop':2,
}
(Path(__file__).resolve().parents[1]/'geometry.json').write_text(json.dumps(data,separators=(',',':')))
print('T',period,'runtime',runtime,'advance/tick',math.pi*240/(16*60))

def interior_distance(point,poly):
    if not inside(point,poly): return 0.
    va=np.roll(poly,-1,axis=0)-poly
    t=np.clip(np.sum((point-poly)*va,axis=1)/np.sum(va*va,axis=1),0,1)
    return float(np.min(np.linalg.norm(point-(poly+t[:,None]*va),axis=1)))

worst=0; worst_frame=None
for k in range(0,N+1,12):
    polys=[rot(entry,alphas[k]),rot(exitp,alphas[k])]
    for j in range(30):
        tp=rot(tooth,qs[k]+j*PITCH,origin=np.array([0.,0.]))
        if max(tp[:,1])>R or min(tp[:,1])>-15:continue
        samples=np.concatenate([tp+(np.roll(tp,-1,axis=0)-tp)*u for u in np.linspace(0,1,11)])
        for pp in polys:
            for p in samples:
                d=interior_distance(p,pp)
                if d>worst:worst=d;worst_frame=(k,j)
print('Max sampled tooth/pallet penetration mm',worst,'at',worst_frame)
assert worst<.025, 'Tooth flanks interfere with pallet'

# Involute pair: verify both tooth phasing and clearance across one repeat.
ga=spur(72);gb=spur(18);zero=np.array([0.,0.])
penetration=0
for a in np.linspace(0,2*math.pi/72,50):
    ap=rot(ga,a,zero)
    bp=rot(gb,-4*a-10*D,zero)+np.array([-56.25,0.])
    for p in ap[(ap[:,0]<-38)&(np.abs(ap[:,1])<18)]:
        penetration=max(penetration,interior_distance(p,bp))
    for p in bp[(bp[:,0]>-50)&(np.abs(bp[:,1])<18)]:
        penetration=max(penetration,interior_distance(p,ap))
print('Max sampled spur penetration mm',penetration)
assert penetration<.001, 'Spur teeth interfere'

notes={
    'pendulum_period_s':period,'beat_s':period/2,'nominal_run_s':runtime,
    'drum_rotation_s':period*30*16,'mm_per_beat':math.pi*240/(16*60),
    'five_minute_distance_mm':1000*300/runtime,
    'escapement_tip_penetration_mm':worst,'spur_penetration_mm':penetration,
    'escape_cycle_advance_degrees':(qs[-1]-qs[0])/D,
    'gear_centre_distance_mm':56.25,
    'torque_example_assumed_mass_kg':.9,
    'torque_example_assumed_slope_deg':6,
    'nominal_input_torque_Nm':.9*9.81*.12*math.sin(6*D),
    'ideal_escape_torque_Nm':.9*9.81*.12*math.sin(6*D)/16,
    'ballast_offset_uphill_mm':.9/.6*120*math.sin(6*D),
}
(Path(__file__).resolve().parents[1]/'kinematic-checks.json').write_text(json.dumps(notes,indent=2))
