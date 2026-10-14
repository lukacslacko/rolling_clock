"""Independent parser/checks of the generated tire G-code, plus print coverage.

Validates the emitted commands, rather than trusting the generator's path list.
Machine homing/wiping is a separate, retained P1S startup template. No printing.
"""
import os
os.environ.setdefault('MPLCONFIGDIR','/tmp/rolling-clock-mpl')
from pathlib import Path
import math,re,json,hashlib,zipfile
import numpy as np
from shapely.geometry import Point,LineString,box
from shapely.ops import unary_union
from split_tire import OUT,CENTERS


def parse(path,outline_for_comp=None,allow_partial_arcs=False):
    lines=path.read_text().splitlines()
    start=lines.index('; HANDCRAFTED_TIRE_BODY_START')
    stop=lines.index('; HANDCRAFTED_TIRE_BODY_END')
    profile=json.loads((OUT/'printer/profile.json').read_text());center=np.array(profile['gcode_center_mm'])
    pos=np.array([18.,1.5,.2]);width=None;feed=None;layer=0;rolling=False;result=[];relative_e=False
    max_accel=0;previous_print_z=0
    outlines={c:outline_for_comp(c).buffer(.002) for c in [0,.075,.15]} if outline_for_comp else {}
    for number in range(start+1,stop):
        line=lines[number]
        if line=='; CHANGE_LAYER':layer+=1
        if line.startswith('; LINE_WIDTH:'):width=float(line.split(':')[1])
        if line=='; ANALYTIC_ROLLING_SURFACE_START':rolling=True
        if line=='; ANALYTIC_ROLLING_SURFACE_END':rolling=False
        text=line.split(';')[0].strip()
        if not text:continue
        cmd=text.split()[0]
        args={k:float(v) for k,v in re.findall(r'([XYZIJEFSP])([-+]?\d*\.?\d+)',text[len(cmd):])}
        assert cmd in ['G90','G21','G17','M83','G92','G1','G2','G3','M73','M991','M106','M204'],(number,cmd)
        if cmd=='M83':relative_e=True
        if cmd=='M204':max_accel=max(max_accel,args['S']);assert args['S']<=1000
        if cmd not in ['G1','G2','G3']:continue
        old=pos.copy()
        for i,k in enumerate('XYZ'):
            if k in args:pos[i]=args[k]
        if 'F' in args:feed=args['F']
        assert 0<=pos[0]<=256 and 0<=pos[1]<=256 and .199<=pos[2]<=4.401,(number,pos)
        xy_move=not np.allclose(pos[:2],old[:2],atol=1e-9) or cmd in ['G2','G3']
        if args.get('E',0)<=0 or not xy_move:continue
        assert relative_e and abs(pos[2]-old[2])<1e-8
        assert abs(pos[2]-.2*layer)<1e-6 and pos[2]>=previous_print_z
        previous_print_z=pos[2]
        comp=[.15,.075,0][min(layer-1,2)];ro=124-comp;ri=111+comp;rh=1.7+comp
        arc=None
        if cmd in ['G2','G3']:
            c=old[:2]+[args['I'],args['J']];r=float(np.linalg.norm(old[:2]-c))
            rend=float(np.linalg.norm(pos[:2]-c));assert abs(r-rend)<.00003,(number,r,rend)
            a=math.atan2(*(old[:2]-c)[::-1]);b=math.atan2(*(pos[:2]-c)[::-1]);sign=1 if cmd=='G3' else -1
            sweep=(sign*(b-a))%(2*math.pi)
            if (outline_for_comp is None and not allow_partial_arcs) or rolling:
                assert abs(sweep-math.pi/2)<.00003,(number,sweep)
            ts=a+sign*np.linspace(0,sweep,max(8,int(r*sweep/.15)+1))
            points=c+r*np.column_stack([np.cos(ts),np.sin(ts)])
            length=r*sweep;arc={'center':c.tolist(),'radius':r,'sweep':sweep}
        else:
            length=float(np.linalg.norm(pos[:2]-old[:2]))
            points=np.linspace(old[:2],pos[:2],max(2,int(length/.15)+1))
        pp=points-center;radial=np.linalg.norm(pp,axis=1)
        assert radial.max()+width/2<=ro+.00003,(number,'outside OD',radial.max(),width)
        assert radial.min()-width/2>=ri-.00004,(number,'inside ID',radial.min(),width)
        for q in CENTERS:
            assert np.linalg.norm(pp-q,axis=1).min()-width/2>=rh-.00005,(number,'screw hole')
        if outline_for_comp is not None:
            allowed=outlines[comp]
            footprint_local=LineString(pp).buffer(width/2,quad_segs=12)
            excess=footprint_local.difference(allowed).area
            assert excess<.0002,(number,'outside narrow tire',excess)
        # Material footprint avoids the P1S excluded lower-left rectangle.
        footprint=LineString(points+np.array(profile['extruder_offset_mm'])).buffer(width/2,quad_segs=4)
        assert footprint.intersection(box(0,0,18,28)).area<1e-6
        flow=args['E']*(math.pi*1.75**2/4)/(length/(feed/60))
        assert flow<6,(number,flow)
        if rolling:
            assert cmd=='G3' and np.linalg.norm(np.array(arc['center'])-center)<.00002
            assert abs(arc['radius']-(ro-width/2))<.00002
            assert feed/60==(25 if layer==1 else 40)
        result.append({'line':number+1,'layer':layer,'z':pos[2],'width':width,'rolling':rolling,
                       'cmd':cmd,'arc':arc,'E':args['E'],'length':length,'flow':flow,
                       'speed':feed/60,'points':pp})
    assert layer==20 and len(set(m['layer'] for m in result))==20
    for n in range(1,21):assert sum(m['rolling'] and m['layer']==n for m in result)==4
    return result,profile


def coverage(moves):
    reports=[]
    for layer in [1,2,3,4]:
        comp=[.15,.075,0][min(layer-1,2)]
        target=Point(0,0).buffer(124-comp,quad_segs=2048)-Point(0,0).buffer(111+comp,quad_segs=2048)
        for q in CENTERS:target-=Point(q).buffer(1.7+comp,quad_segs=128)
        footprints=[LineString(m['points']).buffer(m['width']/2,quad_segs=8) for m in moves if m['layer']==layer]
        covered=unary_union(footprints);missing=target-covered
        percent=100*(1-missing.area/target.area)
        # No intentional sparse regions: residual sub-bead scallops are a
        # geometric footprint diagnostic, not a material porosity simulation.
        big_void=missing.buffer(-.12)
        assert percent>99.5 and big_void.is_empty,(layer,percent,big_void.area)
        reports.append({'layer':layer,'nominal_bead_footprint_coverage_percent':percent,
                        'uncovered_area_mm2':missing.area,'no_uncovered_region_with_0_12mm_inradius':True})
        print('Coverage',reports[-1],flush=True)
    return reports


def draw(moves,source):
    import matplotlib
    matplotlib.use('Agg')
    import matplotlib.pyplot as plt
    from matplotlib.collections import LineCollection
    fig,axes=plt.subplots(1,2,figsize=(13,6),facecolor='#f7f9fb')
    layer=[m for m in moves if m['layer']==3]
    axes[0].add_collection(LineCollection([m['points'] for m in layer if not m['rolling']],colors='#e6bc56',linewidths=.45))
    axes[0].add_collection(LineCollection([m['points'] for m in layer if m['rolling']],colors='#087a96',linewidths=1.5))
    axes[0].set(xlim=(-129,129),ylim=(-129,129),aspect='equal',title='Generated tire: full layer at Z = 0.6 mm')
    axes[0].set_xlabel('mm');axes[0].set_ylabel('mm');axes[0].grid(alpha=.15)
    # Detail around the top screw hole, showing dense infill and intact bore.
    axes[1].add_collection(LineCollection([m['points'] for m in layer if not m['rolling']],colors='#d29425',linewidths=1))
    axes[1].add_collection(LineCollection([m['points'] for m in layer if m['rolling']],colors='#087a96',linewidths=2))
    axes[1].set(xlim=(-7,7),ylim=(109,126),aspect='equal',title='Screw hole and rolling surface detail')
    axes[1].set_xlabel('mm');axes[1].grid(alpha=.15)
    fig.suptitle('Handcrafted circular tire toolpaths',fontsize=19,fontweight='bold')
    fig.text(.5,.015,'Teal: four tangent G3 quarter-arcs per outer circle • Gold: walls and fully filled interior • Shown from emitted G-code',ha='center',fontsize=10)
    fig.tight_layout(rect=(0,.05,1,.94));fig.savefig(OUT/'toolpath-preview.png',dpi=160);plt.close(fig)


def main():
    path=OUT/'GCODE/01_tire_248x4_P1S_PLA.gcode'
    moves,profile=parse(path);covers=coverage(moves)
    summary=json.loads((OUT/'toolpath-summary.json').read_text())
    actual_e=sum(m['E'] for m in moves)
    assert abs(actual_e-summary['body_filament_mm'])<.02
    container=path.with_suffix('.gcode.3mf')
    with zipfile.ZipFile(container) as z:
        assert z.testzip() is None and z.read('Metadata/plate_1.gcode')==path.read_bytes()
        assert z.read('Metadata/plate_1.gcode.md5').decode()==hashlib.md5(path.read_bytes()).hexdigest()
        assert b'DesignerUserId' not in z.read('3D/3dmodel.model')
    draw(moves,None)
    report={'raw_gcode_sha256':hashlib.sha256(path.read_bytes()).hexdigest(),'layer_count':20,
            'outer_circle_commands_each_layer':4,'outer_wall_arcs_share_one_center':True,
            'max_arc_center_rounding_error_allowed_mm':.00002,
            'max_body_deposition_volumetric_rate_mm3_s':max(m['flow'] for m in moves),
            'deposition_filament_mm':actual_e,'nominal_coverage':covers,
            'body_bounds_and_bed_exclusion_passed':True,'all_six_holes_clear':True,
            'relative_extrusion_and_monotonic_print_heights':True,'gcode_3mf_md5_and_contents_verified':True,
            'limits':'Geometric/command checks and nominal bead coverage only. No firmware/thermal/extrusion/printed-roundness simulation. Startup is retained from the supplied P1S job.'}
    (OUT/'gcode-checks.json').write_text(json.dumps(report,indent=2)+'\n')
    print('All G-code checks passed.',flush=True)


if __name__=='__main__':main()
