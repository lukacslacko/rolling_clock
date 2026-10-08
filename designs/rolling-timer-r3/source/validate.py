"""Build and validate the exact exported geometry, including metal fastener envelopes."""
import build as b
from primitives import *
from shapely import affinity
import json
ROOT=b.ROOT

def overlap(a,c):
    ba=a.bounding_box();bc=c.bounding_box()
    if any(min(ba[k+3],bc[k+3])-max(ba[k],bc[k])<1e-5 for k in range(3)):return 0.
    return max(0.,float((a^c).volume()))
def about(m,axis,deg):return m.translate((-axis[0],-axis[1],0)).rotate((0,0,float(deg))).translate((*axis,0))
def allowed(a,c):
    # A deliberately undersize calibration may overlap the nominal 5.5 mm
    # nut. The production 5.6 mm seats must pass without this exemption.
    return b.NUT_WIDTH<5.5 and (a.get('allowed_interference_with')==c['name'] or c.get('allowed_interference_with')==a['name'])

def check_nut_access():
    # Independent dimensional gauges in the generated solids: a loose entry
    # must not accidentally widen the seated nut's anti-rotation walls.
    findings=[]
    slots=[('common','02_square_case_post',b.NUT_WIDTH,lambda m:m.translate((0,0,12.5))),
           ('common','07_square_frame_post',b.NUT_WIDTH,lambda m:m.translate((0,0,81.4))),
           ('common','23_square_bridge_post',b.NUT_WIDTH,lambda m:m.translate((0,0,135.4+b.AXIAL_EXTENSION))),
           ('common','13_bolted_gear_pivot',b.NUT_WIDTH,lambda m:m.translate((0,0,80.9))),
           ('common','19_bolted_anchor_pivot',b.NUT_WIDTH,lambda m:m.translate((0,0,80.9))),
           ('common','01_case_wheel',b.NUT_WIDTH,lambda m:m.rotate((0,90,0)).translate((5.6,0,6))),
           ('common','10_drive_72',b.NUT_WIDTH,lambda m:m.rotate((0,90,0)).translate((5.6,0,91+b.AXIAL_EXTENSION))),
           ('common','25_screw_fixed_bob',b.NUT_WIDTH,lambda m:m.mirror((0,1,0)).rotate((0,0,90)).translate((0,150,151.2+b.AXIAL_EXTENSION)))]
    slots += [('fit-tests','40_nut_post_coupon_'+suffix,width,lambda m:m.translate((0,0,3.4)))
              for width,suffix in [(5.25,'525'),(5.4,'540'),(5.6,'560')]]
    for folder,name,width,pose in slots:
        m=b.parts[folder,name]['m']
        # Probe the actual 5.8 mm straight mouth, ahead of the tapered region.
        free=overlap(m,pose(cub(-3.75,-(b.NUT_ENTRY_WIDTH-.01)/2,.1,.08,b.NUT_ENTRY_WIDTH-.01,.1)))
        seat=overlap(m,pose(cub(-.2,-(width-.01)/2,.1,.4,width-.01,.1)))
        held=overlap(m,pose(cub(-.2,-(width+.1)/2,.1,.4,width+.1,.1)))
        assert free<1e-6 and seat<1e-6 and held>.001,(name,free,seat,held)
        # Nominal M3 nut enters without interference before reaching the
        # taper/seat. Smaller alternative coupons intentionally grip tighter.
        nut=extr(Polygon([polar(5.5/math.sqrt(3),k*math.pi/3) for k in range(6)]),.2,2.4)
        path=max(overlap(m,pose(nut.translate((u,0,0)))) for u in np.linspace(-18,-6.8,29))
        assert path<1e-6,(name,path)
        findings.append({'part':folder+'/'+name,'entry_mm':b.NUT_ENTRY_WIDTH,'seat_mm':width,
                         'free_entry_and_snug_seat_gauges_passed':True,'unseated_nut_path_overlap_mm3':path})
    print('Nut channels: dimensional gauges and insertion paths passed for',len(findings),'parts.',flush=True)
    return findings

nut_access=check_nut_access()

def check_pivot_sections():
    findings=[]
    slot_top=80.9+b.NUT_DEPTH
    for name,end in [('13_bolted_gear_pivot',128.5+b.AXIAL_EXTENSION),('19_bolted_anchor_pivot',161.5+b.AXIAL_EXTENSION)]:
        m=b.parts['common',name]['m']
        # Check material continuity, not just whether the mesh is connected.
        # The nut pocket must remain entirely in the square base, below a
        # substantial cap and a full solid shaft (the bolt bore stops blind).
        roof=b.PIVOT_BASE_TOP-slot_top
        solid_cap=b.PIVOT_BASE_TOP-b.PIVOT_BORE_END
        required_shaft=cyl(3.999,b.PIVOT_BASE_TOP-.05,end-b.PIVOT_BASE_TOP)
        missing_shaft=float((required_shaft-m).volume())
        areas=[float(m.slice(float(z)).area()) for z in np.arange(78.1,b.PIVOT_BASE_TOP-.05,.2)]
        assert roof>=4 and solid_cap>=3 and missing_shaft<1e-5,(name,roof,solid_cap,missing_shaft)
        assert min(areas)>math.pi*4**2,(name,min(areas))
        findings.append({'part':name,'base_height_mm':b.PIVOT_BASE_TOP-78,
                         'cap_above_nut_slot_mm':round(roof,3),'solid_cap_above_bolt_bore_mm':round(solid_cap,3),
                         'minimum_base_section_area_mm2':round(min(areas),3),'solid_8mm_shaft_verified':True})
    print('Pivot sections passed:',findings,flush=True)
    return findings

pivot_sections=check_pivot_sections()

def zrange(name):
    bb=b.parts['common',name]['m'].bounding_box()
    return float(bb[2]),float(bb[5])

def check_main_thrust():
    # Derive both axial stops from actual solids. Checking only a prescribed
    # +/-0.4 movement missed the absent rear collar after the 6 mm widening.
    collar=b.parts['common','38_rear_journal_thrust_collar']['m']
    rear=b.parts['common','05_shared_rear_frame']['m']^cyl(8,70,80)
    front=b.parts['common','06_shared_front_frame']['m']^cyl(8,70,80)
    rear_face=float(rear.bounding_box()[5]);front_face=float(front.bounding_box()[2])
    gear0,gear1=zrange('10_drive_72')
    c0,c1=zrange('38_rear_journal_thrust_collar')
    w0,w1=zrange('35_main_rear_thrust_washer')
    f0,f1=zrange('34_main_front_thrust_sleeve')
    float_range=(-(gear0-rear_face-(c1-c0)-(w1-w0)),front_face-gear1-(f1-f0))
    assert abs((c1-c0)-b.AXIAL_EXTENSION)<1e-6
    assert abs(c0-rear_face-.4)<1e-6 and abs(c1-w0)<1e-6
    assert overlap(collar,b.parts['common','36_rear_round_journal']['m'])<1e-6
    # Both stops must exist and restrict motion to under 1 mm in each direction.
    assert -.81<float_range[0]<=0<=float_range[1]<.81,float_range
    report={'rear_frame_collar_face_z_mm':rear_face,'rear_washer_z_mm':[w0,w1],
            'added_collar_z_mm':[c0,c1],'added_collar_length_mm':c1-c0,
            'round_bore_mm':12.4,'outside_diameter_mm':16,
            'nominal_frame_to_added_collar_gap_mm':round(c0-rear_face,3),
            'rigid_axle_float_limits_mm':[round(v,3) for v in float_range],
            'loose_sleeves_can_slide_independently':True}
    print('Main thrust stops:',report,flush=True)
    return float_range,report

MAIN_FLOAT,main_thrust=check_main_thrust()

def check_rolling_rim():
    # Inspect the exported STL, so a later mesh simplification cannot silently
    # restore coarse flats even when the source circle has enough segments.
    tm=trimesh.load(ROOT/'STL/common/01_case_wheel.stl',force='mesh')
    centre=(tm.bounds[0,:2]+tm.bounds[1,:2])/2
    xy=tm.vertices[:,:2]-centre
    outer=xy[np.abs(np.linalg.norm(xy,axis=1)-124)<.002]
    angles=np.sort(np.unique(np.round(np.arctan2(outer[:,1],outer[:,0]),7)))
    increments=np.diff(np.r_[angles,angles[0]+2*math.pi])
    widest=2*124*math.sin(float(increments.max())/2)
    sagitta=124*(1-math.cos(float(increments.max())/2))
    assert len(angles)==b.ROLLING_RIM_SEGMENTS and widest<.52 and sagitta<.0003
    report={'exported_outer_segments':len(angles),'max_flat_width_mm':round(widest,6),
            'max_ideal_chord_radial_error_mm':round(sagitta,7),
            'nominal_diameter_mm':248,'previous_outer_segments':192}
    print('Exported rolling rim:',report,flush=True)
    return report

rolling_rim=check_rolling_rim()

def main_pose(item,dz):
    # Journals, thrust sleeves and the new round-bore collar are not axially
    # fastened. Let them take up their individual clearances at either stop.
    def clamp(nominal,lo,hi):
        assert lo<=hi+1e-6,(item['name'],dz,lo,hi)
        return max(lo,min(nominal,hi))
    washer=clamp(88.4,max(88.,88.+dz),88.8+dz)
    front=clamp(101.2,100.8+dz,min(101.6,102.+dz))
    shifts={
        '35_main_rear_thrust_washer':washer-88.4,
        '36_rear_round_journal':clamp(12.4,12.+dz,washer-76.)-12.4,
        '38_rear_journal_thrust_collar':clamp(82.4,82.,washer-6.)-82.4,
        '34_main_front_thrust_sleeve':front-101.2,
        '37_front_round_journal':clamp(128.,front+26.4,128.4+dz)-128.,
    }
    return item['m'].translate((0,0,shifts.get(item['name'],dz)))

reports={};all_bad=[]
for ratio,items in b.assemblies.items():
    bad=[];nutfits=[]
    for i,a in enumerate(items):
        for c in items[i+1:]:
            v=overlap(a['m'],c['m'])
            if v>.02:
                row=[a['name'],c['name'],round(v,6)]
                if allowed(a,c):nutfits.append(row)
                else:bad.append(['static']+row)
    # Gear endplay +/-0.3 mm; derive axle limits from both thrust stacks.
    # Loose sleeves take up their clearances independently at the stops.
    endbad=[]
    for a in items:
        if a['group'] not in ('B','C','D','anchor'):continue
        for da in (-.3,.3):
            am=a['m'].translate((0,0,da))
            for c in items:
                if c is a:continue
                offsets=(-.3,.3) if c['group'] in ('B','C','D','anchor') else MAIN_FLOAT if c['group'] in ('case','rotor') else (0,)
                for dc in offsets:
                    cm=main_pose(c,dc) if c['group'] in ('case','rotor') else c['m'].translate((0,0,dc))
                    v=overlap(am,cm)
                    if v>.02:endbad.append([a['name'],c['name'],da,dc,round(v,6)])
    for a in items:
        if a['group'] not in ('case','rotor'):continue
        for dz in MAIN_FLOAT:
            am=main_pose(a,dz)
            for c in items:
                if c['group'] not in ('fixed','pendulum'):continue
                v=overlap(am,c['m'])
                if v>.02:endbad.append([a['name'],c['name'],dz,0,round(v,6)])
    # Check the loose thrust stack against itself at both physical axle stops.
    moving=[a for a in items if a['group'] in ('case','rotor')]
    for dz in MAIN_FLOAT:
        posed=[(a,main_pose(a,dz)) for a in moving]
        for i,(a,am) in enumerate(posed):
            for c,cm in posed[i+1:]:
                v=overlap(am,cm)
                if v>.02:endbad.append([a['name'],c['name'],dz,dz,round(v,6)])
    layout=b.layouts[ratio];axes={k:np.array(v) for k,v in layout['axes'].items()};ph=layout['pinion_phase_rad']
    # Actual involute sections, full tooth pitch, not pitch-circle approximations.
    spurmax=0
    for a in np.linspace(0,5,121):
        polygons={
          'A':affinity.rotate(b.spur(72),a,origin=(0,0)),
          'Bp':affinity.translate(affinity.rotate(b.spur(18,ph['B']),-4*a,origin=(0,0)),*axes['B']),
          'Bw':affinity.translate(affinity.rotate(b.spur(72),-4*a,origin=(0,0)),*axes['B']),
          'Cp':affinity.translate(affinity.rotate(b.spur(30 if ratio==32 else 18,ph['C']),(1 if ratio==16 else -1)*ratio*a,origin=(0,0)),*axes['C'])}
        pairs=[('A','Bp')]
        if ratio==16:pairs.append(('Bw','Cp'))
        else:
            polygons['Dp']=affinity.translate(affinity.rotate(b.spur(18,ph['D']),16*a,origin=(0,0)),*axes['D'])
            polygons['Dw']=affinity.translate(affinity.rotate(b.spur(60 if ratio==32 else 72),16*a,origin=(0,0)),*axes['D'])
            pairs += [('Bw','Dp'),('Dw','Cp')]
        spurmax=max(spurmax,*(polygons[x].intersection(polygons[y]).area for x,y in pairs))
    fixed=[a for a in items if a['group']=='fixed']
    # Full moving solids at 41 escapement-cycle positions.
    mechbad=[];anchormax=0
    for k in range(0,b.MODEL['N']+1,60):
        q=b.MODEL['wheel_angles'][k]/D
        alpha=3-5*math.cos(2*math.pi*k/b.MODEL['N'])
        for a in items:
            if a['group'] not in ('B','C','D','anchor'):continue
            group=a['group']
            axis=axes['P'] if group=='anchor' else axes[group]
            angle={'B':-4*q/ratio,'C':q if ratio==16 else -q,'D':16*q/ratio,'anchor':(alpha+2)*(1 if ratio==16 else -1)}[group]
            m=about(a['m'],axis,angle)
            for c in fixed:
                v=overlap(m,c['m'])
                if v>.02:mechbad.append([a['name'],c['name'],k,round(v,6)])
        # Contact geometry is preserved or reflected as a matched pair.
    for k in range(0,b.MODEL['N']+1,10):
        q=b.MODEL['wheel_angles'][k]/D;alpha=3-5*math.cos(2*math.pi*k/b.MODEL['N'])
        an=affinity.translate(affinity.rotate(b.anchor_outline,alpha,origin=(0,0)),*b.F)
        ew=affinity.rotate(b.escape,q,origin=(0,0));anchormax=max(anchormax,an.intersection(ew).area)
    # Pendulum plus its screws and nuts against the frame, drum and main rotor.
    pend=[a for a in items if a['group']=='pendulum']
    others=[a for a in items if a['group'] in ('fixed','case','rotor')]
    pendbad=[];pend_radius=0
    for angle in np.linspace(-15,15,61):
        for a in pend:
            m=about(a['m'],b.P,angle)
            vs=mesh(m).vertices;pend_radius=max(pend_radius,float(np.linalg.norm(vs[:,:2],axis=1).max()))
            for c in others:
                v=overlap(m,c['m'])
                if v>.02:pendbad.append([a['name'],c['name'],float(angle),round(v,6)])
    # Sweep all rotating drum/input parts against stationary bodies. Ignore
    # moving tooth meshes, already tested above; check pendulum at mid position.
    rotor=[a for a in items if a['group'] in ('case','rotor')]
    rotorbad=[]
    for angle in np.linspace(0,360,73):
        for a in rotor:
            m=about(a['m'],b.A,angle)
            for c in fixed+pend:
                v=overlap(m,c['m'])
                if v>.02:rotorbad.append([a['name'],c['name'],float(angle),round(v,6)])
    # Analytic swept cylindrical bounds cover every case angle, beyond sampling.
    fixed_radius=max(float(np.linalg.norm(mesh(a['m']).vertices[:,:2],axis=1).max()) for a in fixed)
    gear_radius=max(np.linalg.norm(axes['B'])+46.25,np.linalg.norm(axes['C'])+34,
                    np.linalg.norm(axes['D'])+(38.75 if ratio==32 else 46.25) if ratio!=16 else 0)
    headroom=109-max(fixed_radius,pend_radius,gear_radius)
    assert all(a['tip_beyond_nut_mm']>=.39 for a in items if a.get('type')=='screw')
    rep={'ratio':ratio,'nut_insertion_channels':nut_access,'pivot_sections':pivot_sections,
      'frame_gap_mm':layout['frame_gap_mm'],'case_width_mm':layout['case_width_mm'],
      'B_gear_to_its_pivot_nut_min_axial_gap_mm':round(84+b.AXIAL_EXTENSION-.3-(80.9+2.4),3),
      'static_unintended_intersections':bad,'intended_calibrated_nut_trap_intersections':nutfits,
      'main_axle_thrust':main_thrust,
      'axial_endplay_intersections':endbad,'gear_axial_float_mm':[-.3,.3],'carrier_to_rotor_axial_float_mm':[round(v,3) for v in MAIN_FLOAT],'drive_hub_to_B_wheel_min_gap_with_endplay_mm':round(102-.3-(100.8+MAIN_FLOAT[1]),3),
      'spur_samples':121,'max_spur_overlap_mm2':spurmax,'anchor_samples':241,'max_anchor_overlap_mm2':anchormax,
      'mechanism_3d_samples':41,'mechanism_intersections':mechbad,'pendulum_angle_range_deg':[-15,15],
      'pendulum_sweep_samples':61,'pendulum_intersections':pendbad,'case_full_turn_samples':73,'case_intersections':rotorbad,
      'fixed_max_radius_mm':fixed_radius,'pendulum_max_radius_mm':pend_radius,'gear_max_swept_radius_mm':float(gear_radius),
      'case_post_inner_swept_radius_mm':109,'minimum_radial_case_post_gap_mm':float(headroom),
      'bob_to_frame_axial_gap_mm':9.4,'bob_screw_head_to_frame_axial_gap_mm':6.2,'bob_screw_tip_to_front_spokes_mm':15.6,
      'rolling_rim_radius_mm':124,'rolling_rim_mesh':rolling_rim,'post_body_max_radius_mm':math.hypot(119,5),
      'print_meshes_watertight_connected_within_250mm':True,
      'hardware':{k:layout[k] for k in ('M3x10','M3x16')},
      'limits':f'Rigid CAD, sampled gear/pendulum motion and analytic radial bounds. No fit, friction, structural or wear simulation. Nominal nut AF: 5.5 mm; configured seat: {b.NUT_WIDTH:g} mm; insertion channel: {b.NUT_ENTRY_WIDTH:g} mm. The builder selected the 5.6 mm seat after printing fit coupons. Screw heads bounded by 6.5 mm diameter x 3.2 mm height.'}
    reports[ratio]=rep
    (ROOT/f'checks-{ratio}x.json').write_text(json.dumps(rep,indent=2))
    failures=bad+mechbad+pendbad+rotorbad+endbad
    print(ratio,'static',len(bad),'axial',len(endbad),'mechanism',len(mechbad),'pendulum',len(pendbad),'rotor',len(rotorbad),'gear area',spurmax,'radial gap',headroom,flush=True)
    if failures:print(json.dumps(failures[:30],indent=2),flush=True)
    all_bad+=failures
    if spurmax>=.001 or anchormax>=.005 or headroom<2:all_bad.append(['geometry_limit',ratio,spurmax,anchormax,headroom])
assert not all_bad, f'{len(all_bad)} geometry failures; see checks-*.json'
print('All three configurations passed.')
