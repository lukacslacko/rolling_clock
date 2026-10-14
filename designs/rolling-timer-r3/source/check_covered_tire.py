"""Validate covered-tire commands, solid skins, roof spans and hardware."""
import os
os.environ.setdefault('MPLCONFIGDIR','/tmp/rolling-clock-mpl')
import math,json,hashlib,zipfile
import numpy as np
from shapely.geometry import LineString,Point
from shapely.ops import unary_union
import trimesh
import manifold3d as mf
from primitives import extr,cyl,mesh
from covered_tire import OUT,NAME,BASE,SKIN_LAYERS,CENTERS
from ribbed_tire import outline,nominal_shape,layer_data
from check_split_tire import parse


def cad_checks():
    full=outline(0);core=nominal_shape()
    # Subtract enclosed cells from one solid envelope. A closed hollow part
    # has one positive outer shell plus separate negative cavity surfaces;
    # surface-component count alone is not a solid-connectivity test.
    void=full-core
    cavities=[g for g in getattr(void,'geoms',[void]) if g.area>.0001]
    tire=extr(full,0,4)
    for cavity in cavities:tire-=extr(cavity,.6,2.8)
    tm=mesh(tire);shells=tm.split(only_watertight=False)
    assert tm.is_watertight and all(s.is_watertight for s in shells)
    assert sum(s.volume>1e-5 for s in shells)==1
    assert sum(s.volume< -1e-5 for s in shells)==len(cavities)==114
    p=BASE/'STL/01_case_spider_for_4mm_tire.stl'
    spider_tm=trimesh.load(p);spider_tm.apply_translation((-121.1,-121.1,0))
    spider=mf.Manifold(mf.Mesh64(np.asarray(spider_tm.vertices,dtype=np.float64,order='C'),np.asarray(spider_tm.faces,dtype=np.uint64,order='C')))
    assert float((spider^tire).volume())<1e-5
    for q in CENTERS:
        bearing=cyl(2.95,.01,3.98,q)-cyl(1.71,0,4,q)
        assert float((bearing-tire).volume())<1e-5
        bolt=cyl(1.5,0,16,q)+cyl(3.25,-3.2,3.2,q)
        assert float((bolt^(tire+spider)).volume())<1e-5
    assert p.read_bytes()==(OUT/'STL'/p.name).read_bytes()
    return {'tire_watertight_connected':True,'no_collision_with_existing_spider':True,
            'six_solid_screw_seats':True,'same_M3x16_screws_and_7mm_stack':True,
            'spider_sha256':hashlib.sha256(p.read_bytes()).hexdigest(),
            'bottom_skin_mm':.6,'core_height_mm':2.8,'top_skin_mm':.6,'enclosed_core_cells':len(cavities),
            'outer_diameter_mm':248,'inner_diameter_mm':222,'axial_thickness_mm':4}


def draw(moves):
    import matplotlib
    matplotlib.use('Agg')
    import matplotlib.pyplot as plt
    from matplotlib.collections import LineCollection
    from matplotlib.patches import Rectangle
    fig=plt.figure(figsize=(14,6.5),facecolor='#f7f9fb')
    ax=fig.add_axes([.055,.12,.35,.73])
    detail=fig.add_axes([.48,.47,.49,.36])
    section=fig.add_axes([.48,.10,.49,.25])
    for target,n in [(ax,20),(detail,17)]:
        selected=[m for m in moves if m['layer']==n]
        if n==20:
            # Filled silhouette avoids aliasing between dozens of close paths
            # when this overview is downscaled. The detail shows actual paths.
            shape=outline(0);x,y=shape.exterior.xy;target.fill(x,y,color='#d5a239')
            for hole in shape.interiors:
                x,y=hole.xy;target.fill(x,y,color='white')
        else:
            target.add_collection(LineCollection([m['points'] for m in selected if not m['rolling']],colors='#4c9c83',linewidths=.9))
        target.add_collection(LineCollection([m['points'] for m in selected if m['rolling']],colors='#087a96',linewidths=1.7))
        target.set_aspect('equal');target.grid(alpha=.15)
    ax.set_xlabel('mm')
    ax.set(xlim=(-129,129),ylim=(-129,129),title='Closed top face · concentric solid layers')
    detail.set(xlim=(-23,23),ylim=(107,126),title='Zigzag core beneath the skins')
    section.add_patch(Rectangle((0,0),13,.6,facecolor='#d5a239'))
    section.add_patch(Rectangle((0,3.4),13,.6,facecolor='#d5a239'))
    section.add_patch(Rectangle((0,.6),.86,2.8,facecolor='#087a96'))
    section.add_patch(Rectangle((11.77,.6),1.23,2.8,facecolor='#087a96'))
    section.text(6.5,2,'2.8 mm zigzag core',ha='center',va='center',fontsize=12,color='#397d68')
    section.text(13.4,.3,'0.6 mm · 3 bottom layers',va='center',fontsize=10)
    section.text(13.4,3.7,'0.6 mm · 3 top layers',va='center',fontsize=10)
    section.set(xlim=(-.3,20),ylim=(-.4,4.5),title='Radial section · 4 mm total thickness')
    section.axis('off')
    fig.suptitle('Covered zigzag tire · Ø248 / Ø222 × 4 mm',fontsize=21,fontweight='bold')
    fig.text(.5,.02,'Exact circular rolling surface · six clear screw holes · original spoke frame and hardware',ha='center',fontsize=11)
    fig.savefig(OUT/'toolpath-preview.png',dpi=160);plt.close(fig)


def main():
    path=OUT/'GCODE'/f'{NAME}.gcode';moves,profile=parse(path,allow_partial_arcs=True)
    lines=path.read_text().splitlines();feature=None;byline={m['line']:m for m in moves}
    for number,line in enumerate(lines,1):
        if line.startswith('; FEATURE: '):feature=line.split(': ',1)[1]
        if number in byline:byline[number]['feature']=feature
    reports=[];covered={}
    for n in range(1,21):
        group=[m for m in moves if m['layer']==n];skin=n in SKIN_LAYERS;d=layer_data(n)
        web=[m for m in group if m['feature']=='Sparse infill']
        assert (len(web)==0 if skin else len(web)>=100),(n,'incorrect solid/core layer')
        if skin:assert all(m['cmd'] in ('G2','G3') for m in group),(n,'skins must be concentric')
        if n in (1,2,3,4,17,18,19,20):
            material=unary_union([LineString(m['points']).buffer(m['width']/2,quad_segs=12) for m in group])
            target=outline(d['comp']) if skin else nominal_shape(n)
            missing=target-material;percent=100*(1-missing.area/target.area)
            assert material.buffer(.002).geom_type=='Polygon',(n,'disconnected material')
            assert percent>99.5 and missing.buffer(-.13).is_empty,(n,percent,missing.buffer(-.13).area)
            covered[n]=material
            reports.append({'layer':n,'solid_skin':skin,'coverage_percent':percent,'connected_material':True})
            print('Coverage',reports[-1],flush=True)
    # First roof bridges only the triangular core cells, starting each fill arc
    # on solid pads or bore walls. Measure unsupported distance along the arc.
    support=covered[17].buffer(.025);maximum=0.;spans=0
    roof=[m for m in moves if m['layer']==18 and m['feature']=='Internal solid infill']
    for m in roof:
        gaps=LineString(m['points']).difference(support)
        for g in getattr(gaps,'geoms',[gaps]):
            if not g.is_empty:maximum=max(maximum,g.length);spans+=1
        assert m['speed']==25
    # Parse starts of uninterrupted roof paths, independent of quarter splits.
    for i,m in enumerate(roof):
        if i==0 or m['line']>roof[i-1]['line']+1:
            assert support.covers(Point(m['points'][0])),('roof starts without support',m['line'])
    assert maximum<14,('roof span too large',maximum)
    for n,previous in [(2,1),(3,2),(4,3),(19,18),(20,19)]:
        support=covered[previous].buffer(.25)
        for m in [m for m in moves if m['layer']==n]:
            assert LineString(m['points']).difference(support).is_empty,(n,'unsupported non-bridge path')
    summary=json.loads((OUT/'toolpath-summary.json').read_text())
    assert abs(sum(m['E'] for m in moves)-summary['body_filament_mm'])<.02
    with zipfile.ZipFile(path.with_suffix('.gcode.3mf')) as z:
        assert z.testzip() is None and z.read('Metadata/plate_1.gcode')==path.read_bytes()
        assert z.read('Metadata/plate_1.gcode.md5').decode()==hashlib.md5(path.read_bytes()).hexdigest()
    report=cad_checks();report.update({'raw_gcode_sha256':hashlib.sha256(path.read_bytes()).hexdigest(),
        'solid_skin_layers':list(SKIN_LAYERS),'solid_skins_are_concentric':True,
        'first_roof_max_unsupported_arc_mm':maximum,'first_roof_unsupported_spans':spans,
        'first_roof_fill_starts_supported':True,'first_roof_speed_mm_s':25,
        'body_bounds_and_bed_exclusion_passed':True,'all_six_bores_clear':True,
        'max_deposition_mm3_s':max(m['flow'] for m in moves),'coverage':reports,
        'limits':'Geometric/command checks only. Bridging quality, torsional stiffness, adhesion and loaded roundness require a physical trial.'})
    (OUT/'checks.json').write_text(json.dumps(report,indent=2)+'\n');draw(moves)
    print('Covered tire checks passed; maximum first-roof span',maximum,flush=True)


if __name__=='__main__':main()
