"""Wide zigzag tire closed by three concentric solid layers on each face."""
import math,json,shutil
from functools import lru_cache
import numpy as np
from narrow_tire import NarrowWriter
from ribbed_tire import BASE,layer_data,paths_for,representative_layer,outline,nominal_shape,RIB_WIDTH
from split_tire import CENTERS
from split_tire_gcode import write_job,polar,H,K,C,subtract

OUT=BASE/'covered-zigzag'
NAME='01_tire_248x4_covered_zigzag_P1S_PLA'
SKIN_LAYERS=(1,2,3,18,19,20)


@lru_cache(maxsize=3)
def skin_paths(n):
    d=layer_data(n);overlap=.24
    low=d['gap_in']-overlap;high=d['gap_out']+overlap
    count=math.ceil((high-low-H*K)/(d['pw']-H*K))
    width=(high-low+(count-1)*H*K)/count
    radii=[low+width/2+k*(width-H*K) for k in range(count)]
    # Leave room for the bore perimeter, with the same nominal wall overlap.
    excluded=1.7+d['comp']+d['pw']+width/2-overlap
    paths=[]
    for r in radii:
        intervals=[(0,2*math.pi)]
        if abs(r-114)<excluded:
            half=math.acos((r*r+114**2-excluded**2)/(2*r*114))
            for i in range(6):
                angle=math.radians(30+60*i)
                intervals=subtract(intervals,(angle-half,angle+half))
        if len(intervals)==1:
            # At the first roof, start on the solid screw pad at 30 degrees.
            paths.append((r,math.pi/6,math.pi/6+2*math.pi,True))
        else:
            # Join the intervals straddling zero into one continuous arc.
            first,last=intervals[0],intervals[-1]
            intervals=intervals[1:-1]+[(last[0],first[1]+2*math.pi)]
            for lo,hi in intervals:paths.append((r,lo,hi,False))
    return width,paths


class CoveredWriter(NarrowWriter):
    def web(self,path,z,speed):
        self.travel(path[0],z);self.style('Sparse infill',RIB_WIDTH,speed,1000)
        for p in path[1:]:self.line_to(p,RIB_WIDTH,speed)
    def skin_arc(self,r,lo,hi,z,width,speed):
        self.travel(polar(r,lo),z);self.style('Internal solid infill',width,speed,500)
        count=math.ceil((hi-lo)/(math.pi/2)-1e-9)
        for angle in np.linspace(lo,hi,count+1)[1:]:self.arc_to((0,0),polar(r,angle),width,speed)


def generate():
    (OUT/'STL').mkdir(parents=True,exist_ok=True)
    shutil.copyfile(BASE/'STL/01_case_spider_for_4mm_tire.stl',OUT/'STL/01_case_spider_for_4mm_tire.stl')
    w=CoveredWriter();w.add('; HANDCRAFTED_TIRE_BODY_START')
    for s in ['G90','G21','G17','M83','G92 E0']:w.add(s)
    stats=[]
    for n in range(1,21):
        d=layer_data(n);t0=w.seconds;e0=w.print_e;z=d['z'];c=d['comp'];pw=d['pw'];ow=d['ow']
        start=math.radians((17+(n-1)*137.507764)%360);skin=n in SKIN_LAYERS
        w.add('; CHANGE_LAYER');w.add(f'; Z_HEIGHT: {z:.3f}');w.add('; LAYER_HEIGHT: 0.2')
        w.add(f'; layer num/total_layer_count: {n}/20');w.add(f'M73 L{n}');w.add(f'M991 S0 P{n-1}')
        w.add(f'M106 P1 S{0 if n==1 else 255}');w.add('M106 P2 S0');w.add('; OBJECT_ID: 1')
        w.add('; CONCENTRIC_SOLID_SKIN' if skin else '; ZIGZAG_CORE')
        wall_speed=25 if n==1 else 60
        for r in reversed(d['inner']):w.circle((0,0),r,z,pw,wall_speed,start,cw=True)
        for r in reversed(d['outer'][1:]):w.circle((0,0),r,z,pw,wall_speed,start)
        for q in CENTERS:w.circle(q,1.7+c+pw/2,z,pw,25 if n==1 else 40,start,cw=True)
        if skin:
            width,paths=skin_paths(min(n,3))
            speed=25 if n in (1,18) else 60
            for r,lo,hi,_ in paths:w.skin_arc(r,lo,hi,z,width,speed)
        else:
            ribs,fill,sides=paths_for(representative_layer(n))
            for i in range(6):
                theta=math.radians(30+60*i);co,si=math.cos(theta),math.sin(theta)
                for path in sides+fill:w.polyline(path@np.array([[co,si],[-si,co]]),z,pw,60)
            for path in ribs:w.web(path,z,50)
        w.circle((0,0),d['outer'][0],z,ow,25 if n==1 else 40,start,outer=True)
        stats.append({'layer':n,'height_mm':z,'edge_compensation_mm':c,
                      'outer_centerline_radius_mm':d['outer'][0],'rolling_wall_width_mm':ow,
                      'outer_commands':4,'solid_skin':skin,'first_roof':n==18,
                      'nominal_motion_seconds':float(w.seconds-t0),'filament_mm':float(w.print_e-e0)})
    result=write_job(w,stats,out=OUT,name=NAME,outline=outline(0),
        description='248 mm OD / 222 mm ID / 4 mm thick; 0.6 mm bottom and top concentric skins around a 2.8 mm zigzag core.',
        fill_description='three full concentric layers on each face, 0.5 mm zigzag core and solid screw seats',
        config_extra={'sparse_infill_density':'10%','top_shell_layers':'3','bottom_shell_layers':'3',
                      'top_shell_thickness':'0.6','bottom_shell_thickness':'0.6',
                      'top_surface_pattern':'concentric','bottom_surface_pattern':'concentric'})
    result.update({'radial_envelope_width_mm':13,'axial_thickness_mm':4,'rib_width_mm':RIB_WIDTH,
                   'bottom_skin_mm':.6,'top_skin_mm':.6,'core_height_mm':2.8,
                   'solid_skin_layers':list(SKIN_LAYERS),'first_roof_speed_mm_s':25,'same_spider_stl':True})
    (OUT/'toolpath-summary.json').write_text(json.dumps(result,indent=2)+'\n')
    return result


if __name__=='__main__':generate()
