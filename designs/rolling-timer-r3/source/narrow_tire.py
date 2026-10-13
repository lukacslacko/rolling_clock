"""Five-pass, 2 mm radial tire with six local mounting pads; same R3 spider.

The 4 mm axial thickness and all mounting holes stay unchanged. Only pads
have small solid-fill regions. The five rolling-ring circles are true G3 arcs.
"""
import math,json,shutil
import numpy as np
from shapely.geometry import Point,Polygon,LineString
from shapely.ops import unary_union
from shapely import affinity
from split_tire import OUT as BASE,CENTERS
from split_tire_gcode import Writer,write_job,polar,H,K,C
OUT=BASE/'narrow-five-pass'
NAME='01_tire_248x4_2mm_ring_P1S_PLA'
HALF_ANGLE=math.radians(3)


def sector(ro,ri,offset=0,angle=0):
    """Annular tab, with the two radial sides shifted inward by offset."""
    lo=-HALF_ANGLE+math.asin(offset/ro)
    hi=HALF_ANGLE-math.asin(offset/ro)
    ilo=-HALF_ANGLE+math.asin(offset/ri)
    ihi=HALF_ANGLE-math.asin(offset/ri)
    pts=[polar(ro,a+angle) for a in np.linspace(lo,hi,97)]
    pts += [polar(ri,a+angle) for a in np.linspace(ihi,ilo,97)]
    return Polygon(pts)


def shape(comp=0):
    ring=Point(0,0).buffer(124-comp,quad_segs=4096)-Point(0,0).buffer(122+comp,quad_segs=4096)
    for i,q in enumerate(CENTERS):
        ring |= sector(124-comp,111+comp,comp,math.radians(30+60*i))
    for q in CENTERS:ring -= Point(q).buffer(1.7+comp,quad_segs=256)
    return ring


class NarrowWriter(Writer):
    def arc_to(self,center,end,width,speed,ccw=True):
        center=np.asarray(center)+C;end=np.asarray(end)+C
        old=self.pos.copy();r=np.linalg.norm(old-center)
        aa=math.atan2(*(old-center)[::-1]);bb=math.atan2(*(end-center)[::-1])
        sweep=((bb-aa) if ccw else (aa-bb))%(2*math.pi)
        ij=center-old;e=self.extrusion(r*sweep,width,speed)
        self.add(f'G{3 if ccw else 2} X{end[0]:.5f} Y{end[1]:.5f} I{ij[0]:.5f} J{ij[1]:.5f} E{e:.6f}')
        self.pos=end
    def line_to(self,p,width,speed):
        p=np.asarray(p)+C;e=self.extrusion(np.linalg.norm(p-self.pos),width,speed)
        self.add(f'G1 X{p[0]:.5f} Y{p[1]:.5f} E{e:.6f}');self.pos=p


def layer_data(n):
    comp=[.15,.075,0][min(n-1,2)];ro,ri=124-comp,122+comp
    # Five stadium-shaped beads exactly span the 2 mm ring after shrinkage.
    # Their natural overlap is h*(1-pi/4), just as for ordinary solid walls.
    width=(ro-ri+4*H*K)/5
    radii=[ro-width/2-j*(width-H*K) for j in range(5)]
    assert abs(radii[-1]-width/2-ri)<1e-8
    return comp,width,radii


def pad_paths(n,comp,width):
    """Small raster only inside the six tabs, with exact circular hole walls.

Clipping offsets keep the bead footprint inside the tab. Raster extends
0.24 mm into the innermost ring bead for a fused joint. It does not enter
the four outer ring passes, so the rolling wall is not overfilled.
"""
    pad_w=.42 if n==1 else .45
    spacing=pad_w-H*K
    overlap=.24
    boundary_offset=comp+1.5*pad_w-overlap
    # The local infill overlaps the U contour on each side and the inner arc.
    end_r=122+comp+overlap-pad_w/2
    base=sector(end_r,111+boundary_offset,boundary_offset)
    hole=Point(114,0).buffer(1.7+comp+pad_w*1.5-overlap,quad_segs=256)
    base-=hole
    rot=45 if n%2 else -45
    raster=affinity.rotate(base,-rot,origin=(0,0))
    minx,miny,maxx,maxy=raster.bounds
    paths=[]
    for k in range(math.floor(miny/spacing),math.ceil(maxy/spacing)+1):
        y=(k+.5)*spacing
        clipped=raster.intersection(LineString([(minx-1,y),(maxx+1,y)]))
        for line in getattr(clipped,'geoms',[clipped]):
            if line.geom_type!='LineString' or line.length<.06:continue
            if k%2:line=LineString(list(line.coords)[::-1])
            line=affinity.rotate(line,rot,origin=(0,0))
            paths.append(np.array(line.coords))
    # Join neighboring raster lanes through solid material, so each tiny pad
    # does not pay a retract/Z-hop for every line. Never bridge a screw bore.
    allowed=sector(124-comp,111+comp,comp)-Point(114,0).buffer(1.7+comp,quad_segs=256)
    joined=[];active=[]
    for path in paths:
        a,b=path[0],path[-1]
        if active:
            if np.linalg.norm(active[-1]-b)<np.linalg.norm(active[-1]-a):a,b=b,a
            if np.linalg.norm(active[-1]-a)<1.5:
                footprint=LineString([active[-1],a]).buffer(pad_w/2,quad_segs=12)
                if footprint.difference(allowed.buffer(.00001)).area<1e-8:
                    active.extend([a,b]);continue
            joined.append(np.array(active))
        active=[a,b]
    if active:joined.append(np.array(active))
    return pad_w,joined


def generate():
    OUT.mkdir(parents=True,exist_ok=True)
    (OUT/'STL').mkdir(exist_ok=True)
    shutil.copyfile(BASE/'STL/01_case_spider_for_4mm_tire.stl',
                    OUT/'STL/01_case_spider_for_4mm_tire.stl')
    w=NarrowWriter();w.add('; HANDCRAFTED_TIRE_BODY_START')
    for s in ['G90','G21','G17','M83','G92 E0']:w.add(s)
    stats=[]
    for n in range(1,21):
        comp,width,radii=layer_data(n);pw,local_paths=pad_paths(n,comp,width)
        z=n*.2;t0=w.seconds;e0=w.print_e;start=math.radians((17+(n-1)*137.507764)%360)
        w.add('; CHANGE_LAYER');w.add(f'; Z_HEIGHT: {z:.3f}');w.add('; LAYER_HEIGHT: 0.2')
        w.add(f'; layer num/total_layer_count: {n}/20');w.add(f'M73 L{n}');w.add(f'M991 S0 P{n-1}')
        w.add(f'M106 P1 S{0 if n==1 else 255}');w.add('M106 P2 S0');w.add('; OBJECT_ID: 1')
        pad_speed=25 if n==1 else 40;fill_speed=30 if n==1 else 60
        for i,q in enumerate(CENTERS):
            theta=math.radians(30+60*i)
            def point(r,sign):
                a=theta+sign*(HALF_ANGLE-math.asin((comp+pw/2)/r))
                return polar(r,a)
            inner=111+comp+pw/2;end=122+comp+.22
            w.add('; LOCAL_MOUNTING_PAD_START')
            w.circle(q,1.7+comp+pw/2,z,pw,pad_speed,start,cw=True)
            w.travel(point(end,-1),z);w.style('Outer wall',pw,pad_speed,500)
            w.line_to(point(inner,-1),pw,pad_speed)
            w.arc_to((0,0),point(inner,1),pw,pad_speed)
            w.line_to(point(end,1),pw,pad_speed)
            for path in local_paths:
                c,s=math.cos(theta),math.sin(theta)
                rotated=path@np.array([[c,s],[-s,c]])
                w.polyline(rotated,z,pw,fill_speed)
            w.add('; LOCAL_MOUNTING_PAD_END')
        for j in reversed(range(5)):
            w.add(f'; CONCENTRIC_RING_PASS: {j+1}/5')
            speed=25 if n==1 else (40 if j==0 else 60)
            w.circle((0,0),radii[j],z,width,speed,start,outer=(j==0))
        stats.append({'layer':n,'height_mm':z,'edge_compensation_mm':comp,
                      'outer_centerline_radius_mm':radii[0],'rolling_wall_width_mm':width,
                      'concentric_passes':5,'concentric_radii_mm':radii,
                      'outer_commands':4,'local_pad_fill_paths':len(local_paths)*6,
                      'nominal_motion_seconds':float(w.seconds-t0),'filament_mm':float(w.print_e-e0)})
    outline=shape()
    result=write_job(w,stats,out=OUT,name=NAME,outline=outline,wall_loops=5,
              description='248 mm OD, 2 mm radial ring, 4 mm axial thickness, six inward mounting pads; five concentric ring passes per layer.')
    result.update({'radial_ring_width_mm':2,'axial_thickness_mm':4,'passes_per_ring_layer':5,
                   'mounting_pad_count':6,'same_spider_stl':True,'ring_has_no_raster_infill':True})
    (OUT/'toolpath-summary.json').write_text(json.dumps(result,indent=2)+'\n')
    return result


if __name__=='__main__':generate()
