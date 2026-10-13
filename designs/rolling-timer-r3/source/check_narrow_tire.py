"""Verify the generated narrow tire and compatibility with the existing spider."""
import os
os.environ.setdefault('MPLCONFIGDIR','/tmp/rolling-clock-mpl')
import math,json,hashlib,zipfile
from functools import lru_cache
from pathlib import Path
import numpy as np
from shapely.geometry import LineString,Point
from shapely.ops import unary_union
import trimesh
import manifold3d as mf
from primitives import extr,cyl,mesh
from narrow_tire import OUT,NAME,BASE,shape,CENTERS,layer_data
from check_split_tire import parse


def cad_checks():
    tire=extr(shape(),0,4);tm=mesh(tire)
    assert tm.is_watertight and len(tm.split())==1
    spider_path=BASE/'STL/01_case_spider_for_4mm_tire.stl'
    spider_tm=trimesh.load(spider_path);spider_tm.apply_translation((-121.1,-121.1,0))
    spider=mf.Manifold(mf.Mesh64(np.asarray(spider_tm.vertices,dtype=np.float64,order='C'),
                                np.asarray(spider_tm.faces,dtype=np.uint64,order='C')))
    assert float((spider^tire).volume())<1e-5
    old=extr(Point(0,0).buffer(124,quad_segs=4096)-Point(0,0).buffer(111,quad_segs=4096),0,4)
    for q in CENTERS:
        old-=cyl(1.7,0,4,q,n=1024)
        # A 6 mm diameter bearing patch under each pad is retained, except bore.
        bearing=cyl(2.95,.01,3.98,q)-cyl(1.71,0,4,q)
        assert float((bearing-tire).volume())<1e-5
        bolt=cyl(1.5,0,16,q)+cyl(3.25,-3.2,3.2,q)
        assert float((bolt^(tire+spider)).volume())<1e-5
    assert float((tire-old).volume())<.05
    return {'tire_watertight_connected':True,'no_collision_with_existing_spider':True,
            'six_screw_bearing_patches_retained':True,'M3x16_stack_still_7mm':True,
            'same_spider_sha256':hashlib.sha256(spider_path.read_bytes()).hexdigest(),
            'outer_diameter_mm':248,'radial_ring_width_mm':2,'axial_thickness_mm':4,
            'mount_hole_diameter_mm':3.4,'mount_bolt_circle_mm':228,
            'mount_inner_pilot_radius_mm':111,'mount_angle_width_deg':6}


def main():
    gcode=OUT/'GCODE'/f'{NAME}.gcode'
    moves,profile=parse(gcode,outline_for_comp=lru_cache(maxsize=3)(shape))
    coverage=[]
    for n in range(1,21):
        comp,width,radii=layer_data(n)
        circles=[m for m in moves if m['layer']==n and m['arc'] and
                 np.linalg.norm(np.array(m['arc']['center'])-profile['gcode_center_mm'])<.00002 and m['arc']['radius']>121]
        assert len(circles)==20,(n,'five complete circles')
        for r in radii:
            group=[m for m in circles if abs(m['arc']['radius']-r)<.00002]
            assert len(group)==4 and abs(sum(m['arc']['sweep'] for m in group)-2*math.pi)<.00003
        # Every positive-extrusion G1 belongs to a mounting pad; none in open arcs.
        for m in [m for m in moves if m['layer']==n and m['cmd']=='G1']:
            pts=m['points'];assert np.linalg.norm(pts,axis=1).max()<122+comp+.25
        if n<=4:
            covered=unary_union([LineString(m['points']).buffer(m['width']/2,quad_segs=12) for m in moves if m['layer']==n])
            target=shape(comp);missing=target-covered
            percent=100*(1-missing.area/target.area)
            assert percent>99 and missing.buffer(-.13).is_empty,(n,percent,missing.buffer(-.13).area)
            # All six pads fused to the ring in the footprint of each checked layer.
            assert covered.buffer(.002).geom_type=='Polygon',(n,'unconnected bead footprints')
            coverage.append({'layer':n,'nominal_coverage_percent':percent,'no_void_with_0_13mm_inradius':True})
            print('Coverage',coverage[-1],flush=True)
    summary=json.loads((OUT/'toolpath-summary.json').read_text())
    assert abs(sum(m['E'] for m in moves)-summary['body_filament_mm'])<.02
    with zipfile.ZipFile(gcode.with_suffix('.gcode.3mf')) as z:
        assert z.testzip() is None and z.read('Metadata/plate_1.gcode')==gcode.read_bytes()
        assert z.read('Metadata/plate_1.gcode.md5').decode()==hashlib.md5(gcode.read_bytes()).hexdigest()
    report=cad_checks()
    report.update({'raw_gcode_sha256':hashlib.sha256(gcode.read_bytes()).hexdigest(),
                   'twenty_layers_with_five_complete_concentric_circles_each':True,
                   'rolling_ring_has_no_raster_infill':True,'all_six_bores_clear':True,
                   'body_bounds_and_bed_exclusion_passed':True,
                   'max_deposition_mm3_s':max(m['flow'] for m in moves),'nominal_coverage':coverage,
                   'limits':'Command and CAD geometry checks only; flexibility, shrinkage and printed roundness remain untested.'})
    (OUT/'checks.json').write_text(json.dumps(report,indent=2)+'\n')
    draw(moves)
    print('Narrow tire checks passed',flush=True)


def draw(moves):
    import matplotlib
    matplotlib.use('Agg')
    import matplotlib.pyplot as plt
    from matplotlib.collections import LineCollection
    fig,axes=plt.subplots(1,2,figsize=(12,6),facecolor='#f7f9fb')
    layer=[m for m in moves if m['layer']==3]
    for ax in axes:
        for rolling,color,lw in [(False,'#d6a339',.9),(True,'#087a96',1.5)]:
            ax.add_collection(LineCollection([m['points'] for m in layer if m['rolling']==rolling],colors=color,linewidths=lw))
        ax.set_aspect('equal');ax.grid(alpha=.15);ax.set_xlabel('mm')
    axes[0].set(xlim=(-129,129),ylim=(-129,129),title='2 mm ring + six inward mounting pads')
    axes[1].set(xlim=(-8,8),ylim=(109,126),title='Five circular passes; local fill at each screw')
    fig.suptitle('Narrow tire · same 248 mm diameter and 4 mm axial thickness',fontsize=17,fontweight='bold')
    fig.text(.5,.02,'Parsed from the emitted G-code · existing spoke frame and M3×16 screws fit unchanged',ha='center',fontsize=11)
    fig.tight_layout(rect=(0,.05,1,.93));fig.savefig(OUT/'toolpath-preview.png',dpi=170);plt.close(fig)


if __name__=='__main__':main()
