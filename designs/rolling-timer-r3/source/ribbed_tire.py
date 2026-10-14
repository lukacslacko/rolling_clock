"""Original 13 mm tire envelope, with open zigzag web and solid screw seats.

Three outside and two inside circular passes; no axial skins or bridging.
All layers repeat the same web, with first-layer edge compensation retained.
"""
import math,json,shutil
from functools import lru_cache
import numpy as np
from shapely.geometry import Point,LineString
from shapely.ops import unary_union
from shapely import affinity
from narrow_tire import sector
from split_tire import OUT as BASE,CENTERS
from split_tire_gcode import Writer,write_job,polar,H,K,C

OUT=BASE/'wide-zigzag'
NAME='01_tire_248x4_wide_zigzag_P1S_PLA'
RIB_WIDTH=.5


def layer_data(n):
    comp=[.15,.075,0][min(n-1,2)]
    ow=.5 if n==1 else .42;pw=.5 if n==1 else .45
    outer=[124-comp-ow/2]
    outer.append(outer[-1]-(ow+pw)/2+H*K)
    outer.append(outer[-1]-(pw-H*K))
    inner=[111+comp+pw/2,111+comp+pw/2+pw-H*K]
    # The web and solid pads overlap the adjacent circular walls by 0.24 mm.
    gap_in=inner[-1]+pw/2;gap_out=outer[-1]-pw/2
    return dict(comp=comp,ow=ow,pw=pw,outer=outer,inner=inner,
                gap_in=gap_in,gap_out=gap_out,z=n*H)


def outline(comp):
    p=Point(0,0).buffer(124-comp,quad_segs=4096)-Point(0,0).buffer(111+comp,quad_segs=4096)
    for q in CENTERS:p-=Point(q).buffer(1.7+comp,quad_segs=256)
    return p


def pads(comp):
    p=unary_union([sector(124-comp,111+comp,comp,math.radians(30+60*k)) for k in range(6)])
    for q in CENTERS:p-=Point(q).buffer(1.7+comp,quad_segs=256)
    return p


@lru_cache(maxsize=4)
def paths_for(n):
    d=layer_data(n);c,pw=d['comp'],d['pw'];overlap=.24
    # One continuous triangular wave around the annulus, interrupted only by
    # solid mounting pads. 3-degree vertex spacing, 6-degree full repeat.
    rlo=d['gap_in']+RIB_WIDTH/2-overlap
    rhi=d['gap_out']-RIB_WIDTH/2+overlap
    zig=LineString([polar(rhi if k%2==0 else rlo,math.radians(k*3)) for k in range(121)])
    pad_regions=pads(c)
    clipped=zig.difference(pad_regions.buffer(-overlap))
    ribs=[np.asarray(g.coords) for g in getattr(clipped,'geoms',[clipped]) if g.length>.05]
    # Local solid pads: two side walls, bore circle, plus dense zigzag fill.
    # Inner/outer circular walls already close the radial ends of each pad.
    fill=sector(d['gap_out']-pw/2+overlap,d['gap_in']+pw/2-overlap,c+1.5*pw-overlap)
    fill-=Point(114,0).buffer(1.7+c+1.5*pw-overlap,quad_segs=256)
    rot=45 if n%2 else -45
    rotated=affinity.rotate(fill,-rot,origin=(0,0));minx,miny,maxx,maxy=rotated.bounds
    spacing=pw-H*K;raw=[]
    for j in range(math.floor(miny/spacing),math.ceil(maxy/spacing)+1):
        y=(j+.5)*spacing
        clipped=rotated.intersection(LineString([(minx-1,y),(maxx+1,y)]))
        for line in getattr(clipped,'geoms',[clipped]):
            if line.geom_type!='LineString' or line.length<.06:continue
            if j%2:line=LineString(list(line.coords)[::-1])
            raw.append(np.asarray(affinity.rotate(line,rot,origin=(0,0)).coords))
    allowed=sector(124-c,111+c,c)-Point(114,0).buffer(1.7+c,quad_segs=256)
    paths=[];active=[]
    for line in raw:
        a,b=line[0],line[-1]
        if active:
            if np.linalg.norm(active[-1]-b)<np.linalg.norm(active[-1]-a):a,b=b,a
            if np.linalg.norm(active[-1]-a)<1.5 and LineString([active[-1],a]).buffer(pw/2,quad_segs=12).difference(allowed.buffer(.00001)).area<1e-8:
                active.extend([a,b]);continue
            paths.append(np.asarray(active))
        active=[a,b]
    if active:paths.append(np.asarray(active))
    sides=[]
    for sign in [-1,1]:
        pts=[]
        for r in [d['gap_in']+pw/2-overlap,d['gap_out']-pw/2+overlap]:
            pts.append(polar(r,sign*(math.radians(3)-math.asin((c+pw/2)/r))))
        sides.append(np.asarray(pts))
    return ribs,paths,sides


def representative_layer(n):return n if n<=2 else (3 if n%2 else 4)


def nominal_shape(n=4):
    d=layer_data(n);ribs,_,_=paths_for(representative_layer(n))
    p=Point(0,0).buffer(124-d['comp'],quad_segs=4096)-Point(0,0).buffer(d['gap_out'],quad_segs=4096)
    p|=Point(0,0).buffer(d['gap_in'],quad_segs=4096)-Point(0,0).buffer(111+d['comp'],quad_segs=4096)
    return unary_union([p,pads(d['comp'])]+[LineString(r).buffer(RIB_WIDTH/2,quad_segs=12) for r in ribs])


class RibWriter(Writer):
    def web(self,path,z,speed):
        self.travel(path[0],z);self.style('Sparse infill',RIB_WIDTH,speed,1000)
        for p in path[1:]:
            p=np.asarray(p)+C;e=self.extrusion(np.linalg.norm(p-self.pos),RIB_WIDTH,speed)
            self.add(f'G1 X{p[0]:.5f} Y{p[1]:.5f} E{e:.6f}');self.pos=p


def generate():
    (OUT/'STL').mkdir(parents=True,exist_ok=True)
    shutil.copyfile(BASE/'STL/01_case_spider_for_4mm_tire.stl',OUT/'STL/01_case_spider_for_4mm_tire.stl')
    w=RibWriter();w.add('; HANDCRAFTED_TIRE_BODY_START')
    for s in ['G90','G21','G17','M83','G92 E0']:w.add(s)
    stats=[]
    for n in range(1,21):
        d=layer_data(n);ribs,fill,sides=paths_for(representative_layer(n))
        t0=w.seconds;e0=w.print_e;z=d['z'];c=d['comp'];pw=d['pw'];ow=d['ow']
        start=math.radians((17+(n-1)*137.507764)%360)
        w.add('; CHANGE_LAYER');w.add(f'; Z_HEIGHT: {z:.3f}');w.add('; LAYER_HEIGHT: 0.2')
        w.add(f'; layer num/total_layer_count: {n}/20');w.add(f'M73 L{n}');w.add(f'M991 S0 P{n-1}')
        w.add(f'M106 P1 S{0 if n==1 else 255}');w.add('M106 P2 S0');w.add('; OBJECT_ID: 1')
        wall_speed=25 if n==1 else 60;fill_speed=30 if n==1 else 60
        for r in reversed(d['inner']):w.circle((0,0),r,z,pw,wall_speed,start,cw=True)
        for r in reversed(d['outer'][1:]):w.circle((0,0),r,z,pw,wall_speed,start)
        for i,q in enumerate(CENTERS):
            theta=math.radians(30+60*i);co,si=math.cos(theta),math.sin(theta)
            w.circle(q,1.7+c+pw/2,z,pw,25 if n==1 else 40,start,cw=True)
            for path in sides+fill:w.polyline(path@np.array([[co,si],[-si,co]]),z,pw,fill_speed)
        for path in ribs:w.web(path,z,25 if n==1 else 50)
        w.circle((0,0),d['outer'][0],z,ow,25 if n==1 else 40,start,outer=True)
        stats.append({'layer':n,'height_mm':z,'edge_compensation_mm':c,
                      'outer_centerline_radius_mm':d['outer'][0],'rolling_wall_width_mm':ow,
                      'outer_commands':4,'inner_wall_passes':2,'outer_wall_passes':3,
                      'rib_paths':len(ribs),'nominal_motion_seconds':float(w.seconds-t0),
                      'filament_mm':float(w.print_e-e0)})
    result=write_job(w,stats,out=OUT,name=NAME,outline=nominal_shape(),
        description='248 mm OD / 222 mm ID / 4 mm axial thickness; open zigzag web and six solid screw seats.',
        fill_description='open axial faces, repeated 0.5 mm zigzag web, six solid screw seats',
        config_extra={'sparse_infill_density':'10%','top_shell_layers':'0','bottom_shell_layers':'0'})
    result.update({'radial_envelope_width_mm':13,'axial_thickness_mm':4,'rib_width_mm':RIB_WIDTH,
                   'rib_vertex_spacing_deg':3,'axial_skins':0,'same_spider_stl':True,
                   'nominal_material_area_mm2':nominal_shape().area,
                   'nominal_envelope_area_mm2':outline(0).area})
    (OUT/'toolpath-summary.json').write_text(json.dumps(result,indent=2)+'\n')
    return result


if __name__=='__main__':generate()
