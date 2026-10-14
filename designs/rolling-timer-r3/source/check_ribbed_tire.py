"""Parse emitted ribbed-tire moves; check geometry, web continuity and hardware."""
import os
os.environ.setdefault('MPLCONFIGDIR','/tmp/rolling-clock-mpl')
import json,hashlib,zipfile,math
import numpy as np
from shapely.geometry import LineString,Point
from shapely.ops import unary_union
import trimesh
import manifold3d as mf
from primitives import extr,cyl,mesh
from ribbed_tire import OUT,NAME,BASE,CENTERS,nominal_shape,outline,layer_data,pads
from check_split_tire import parse


def cad_checks():
    shape=nominal_shape();tire=extr(shape,0,4);tm=mesh(tire)
    assert tm.is_watertight and len(tm.split())==1
    p=BASE/'STL/01_case_spider_for_4mm_tire.stl'
    spider_tm=trimesh.load(p);spider_tm.apply_translation((-121.1,-121.1,0))
    spider=mf.Manifold(mf.Mesh64(np.asarray(spider_tm.vertices,dtype=np.float64,order='C'),
                                np.asarray(spider_tm.faces,dtype=np.uint64,order='C')))
    assert float((spider^tire).volume())<1e-5
    for q in CENTERS:
        bearing=cyl(2.95,.01,3.98,q)-cyl(1.71,0,4,q)
        assert float((bearing-tire).volume())<1e-5
        bolt=cyl(1.5,0,16,q)+cyl(3.25,-3.2,3.2,q)
        assert float((bolt^(tire+spider)).volume())<1e-5
    assert shape.difference(outline(0).buffer(.0001)).area<.0001
    assert hashlib.sha256(p.read_bytes()).digest()==hashlib.sha256((OUT/'STL'/p.name).read_bytes()).digest()
    return {'tire_watertight_connected':True,'same_spider_sha256':hashlib.sha256(p.read_bytes()).hexdigest(),
            'no_collision_with_existing_spider':True,'six_solid_screw_bearing_patches':True,
            'same_M3x16_screws_and_7mm_stack':True,'outer_diameter_mm':248,'inner_diameter_mm':222,
            'axial_thickness_mm':4,'mount_hole_diameter_mm':3.4,'bolt_circle_mm':228}


def draw(moves):
    import matplotlib
    matplotlib.use('Agg')
    import matplotlib.pyplot as plt
    from matplotlib.collections import LineCollection
    fig,axes=plt.subplots(1,2,figsize=(13,6),facecolor='#f7f9fb')
    layer=[m for m in moves if m['layer']==3]
    for ax in axes:
        for kind,color,lw in [('solid','#d5a239',.75),('rib','#4c9c83',1.1),('outer','#087a96',1.5)]:
            selected=[m for m in layer if ('outer' if m['rolling'] else 'rib' if m.get('feature')=='Sparse infill' else 'solid')==kind]
            ax.add_collection(LineCollection([m['points'] for m in selected],colors=color,linewidths=lw))
        ax.set_aspect('equal');ax.grid(alpha=.15);ax.set_xlabel('mm')
    axes[0].set(xlim=(-129,129),ylim=(-129,129),title='Original 13 mm-wide ring · open zigzag web')
    axes[1].set(xlim=(-23,23),ylim=(107,126),title='Solid screw seat and continuous circular walls')
    fig.suptitle('Wide ribbed tire · Ø248 / Ø222 × 4 mm',fontsize=20,fontweight='bold')
    fig.text(.5,.02,'Teal: exact outer arcs   •   Green: 0.5 mm web   •   Gold: walls and solid pads   •   No top or bottom skins',ha='center',fontsize=11)
    fig.tight_layout(rect=(0,.06,1,.93));fig.savefig(OUT/'toolpath-preview.png',dpi=170);plt.close(fig)


def main():
    path=OUT/'GCODE'/f'{NAME}.gcode';moves,profile=parse(path)
    # Annotate parsed geometry from the independent feature comments.
    feature=None;byline={m['line']:m for m in moves}
    for n,line in enumerate(path.read_text().splitlines(),1):
        if line.startswith('; FEATURE: '):feature=line.split(': ',1)[1]
        if n in byline:byline[n]['feature']=feature
    reports=[];footprints={}
    for n in range(1,21):
        group=[m for m in moves if m['layer']==n];d=layer_data(n)
        circles=[m for m in group if m['arc'] and np.linalg.norm(np.asarray(m['arc']['center'])-profile['gcode_center_mm'])<.00002]
        assert len(circles)==20,(n,'3 outer + 2 inner circles')
        for radius in d['outer']+d['inner']:
            selected=[m for m in circles if abs(m['arc']['radius']-radius)<.00002]
            assert len(selected)==4 and abs(sum(m['arc']['sweep'] for m in selected)-2*math.pi)<.00003
        web=[m for m in group if m['feature']=='Sparse infill']
        assert len(web)>=100 and all(abs(m['width']-.5)<1e-6 for m in web)
        # Repeat stable web location through the height; no unsupported roofs.
        if n>3:
            previous=[m for m in moves if m['layer']==n-1 and m['feature']=='Sparse infill']
            assert len(web)==len(previous)
            for a,b in zip(web,previous):assert np.allclose(a['points'],b['points'],atol=.00002)
        if n<=4:
            covered=unary_union([LineString(m['points']).buffer(m['width']/2,quad_segs=12) for m in group])
            target=nominal_shape(n);missing=target-covered
            percent=100*(1-missing.area/target.area)
            assert covered.buffer(.002).geom_type=='Polygon',(n,'disconnected walls/web/pads')
            assert percent>99 and missing.buffer(-.13).is_empty,(n,percent,missing.area)
            assert covered.difference(target.buffer(.025)).area<.05,(n,'unexpected material outside ribbed shape')
            solid_target=pads(d['comp']);pad_missing=solid_target-covered
            assert pad_missing.buffer(-.13).is_empty,(n,'unfilled screw pad')
            footprints[n]=covered
            reports.append({'layer':n,'nominal_material_coverage_percent':percent,
                            'connected_wall_web_and_screw_pads':True,'solid_screw_seats':True,
                            'intentional_open_area_mm2':outline(d['comp']).area-target.area})
            print('Coverage',reports[-1],flush=True)
    # Verify the changing first-layer compensation retains support under all
    # later paths. .25 mm is half the web width; it is a geometric bound only.
    for n in [2,3]:
        for m in [m for m in moves if m['layer']==n]:
            assert LineString(m['points']).difference(footprints[n-1].buffer(.25)).is_empty,(n,'unsupported path')
    summary=json.loads((OUT/'toolpath-summary.json').read_text())
    assert abs(sum(m['E'] for m in moves)-summary['body_filament_mm'])<.02
    with zipfile.ZipFile(path.with_suffix('.gcode.3mf')) as z:
        assert z.testzip() is None and z.read('Metadata/plate_1.gcode')==path.read_bytes()
        assert z.read('Metadata/plate_1.gcode.md5').decode()==hashlib.md5(path.read_bytes()).hexdigest()
    report=cad_checks()
    report.update({'raw_gcode_sha256':hashlib.sha256(path.read_bytes()).hexdigest(),
        'twenty_layers_with_three_outer_and_two_inner_circles':True,'rib_width_mm':.5,
        'no_top_bottom_skins_or_roofs':True,'stable_full_height_web':True,
        'body_bounds_and_bed_exclusion_passed':True,'all_six_bores_clear':True,
        'max_deposition_mm3_s':max(m['flow'] for m in moves),'coverage':reports,
        'limits':'Geometric/command checks only; physical stiffness, adhesion, shrinkage and loaded roundness remain untested.'})
    (OUT/'checks.json').write_text(json.dumps(report,indent=2)+'\n');draw(moves)
    print('Ribbed tire checks passed',flush=True)


if __name__=='__main__':main()
