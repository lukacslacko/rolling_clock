"""Analytic tire toolpaths for the supplied P1S / PLA / textured PEI profile.

No printer communication. Produces a raw G-code job and a sliced 3MF container.
All circles are G2/G3 quarter arcs; infill intersections are solved analytically.
The machine-specific start/end templates were extracted from the builder's job.
"""
import math, json, re, hashlib, zipfile, io, datetime
from pathlib import Path
import numpy as np
from split_tire import OUT, OUTER_R, INNER_R, TIRE_H, CENTERS, HOLE_R

PROFILE=json.loads((OUT/'printer/profile.json').read_text())
C=np.array(PROFILE['gcode_center_mm'],dtype=float)
H=.2
FLOW=PROFILE['filament_flow_ratio']
FA=math.pi*(PROFILE['filament_diameter_mm']/2)**2
K=1-math.pi/4
NAME='01_tire_248x4_P1S_PLA'


def area(width):return H*(width-H*K)
def polar(r,a):return np.array([r*math.cos(a),r*math.sin(a)])


def subtract(intervals,cut):
    lo,hi=cut;out=[]
    for a,b in intervals:
        if hi<=a or lo>=b:out.append((a,b));continue
        if lo>a:out.append((a,min(b,lo)))
        if hi<b:out.append((max(a,hi),b))
    return out


def material_line(a,b,rout,rin,holes,clearance):
    """Check an extruding connector's whole segment against all boundaries."""
    if max(np.linalg.norm(a),np.linalg.norm(b))>rout-clearance+1e-8:return False
    v=b-a;vv=float(v@v)
    def dist(q):
        t=float(np.clip(((q-a)@v)/vv,0,1)) if vv else 0
        return float(np.linalg.norm(a+t*v-q))
    return dist(np.zeros(2))>=rin+clearance and all(dist(q)>=r+clearance for q,r in holes)


def make_layer(layer):
    comp=[.15,.075,0][min(layer-1,2)]
    ro,ri,rh=OUTER_R-comp,INNER_R+comp,HOLE_R+comp
    ow=.5 if layer==1 else .42
    iw=.5 if layer==1 else .45
    spacing=iw-H*K
    outer_radii=[ro-ow/2]
    outer_radii.append(outer_radii[-1]-(ow+iw)/2+H*K)
    outer_radii.append(outer_radii[-1]-spacing)
    inner_radius=ri+ow/2
    hole_radius=rh+ow/2
    # Infill overlaps wall footprints by 0.25 mm. Boundary circles themselves
    # remain analytically exact and are never polygonized or arc-fitted.
    overlap=.25
    fill_ro=outer_radii[-1]-iw/2-iw/2+overlap
    fill_ri=inner_radius+ow/2+iw/2-overlap
    fill_rh=hole_radius+ow/2+iw/2-overlap
    angle=math.radians(45 if layer%2 else 135)
    u=np.array([math.cos(angle),math.sin(angle)]);v=np.array([-u[1],u[0]])
    holes=[(np.array(q),rh) for q in CENTERS]
    scan_holes=[(float(q@u),float(q@v),fill_rh) for q in CENTERS]
    # Alternate the scanline phase as well as direction.
    phase=.25 if layer%2 else .75
    lanes=[[],[]]
    for j in range(-math.ceil(fill_ro/spacing),math.ceil(fill_ro/spacing)+1):
        y=(j+phase)*spacing
        if abs(y)>=fill_ro:continue
        x=math.sqrt(fill_ro*fill_ro-y*y);segments=[(-x,x)]
        if abs(y)<fill_ri:
            t=math.sqrt(fill_ri*fill_ri-y*y);segments=subtract(segments,(-t,t))
        for hx,hy,hr in scan_holes:
            if abs(y-hy)<hr:
                t=math.sqrt(hr*hr-(y-hy)**2);segments=subtract(segments,(hx-t,hx+t))
        for a,b in segments:
            for side,(lo,hi) in enumerate([(a,min(b,0)),(max(a,0),b)]):
                if hi-lo>.12:
                    lanes[side].append((y,lo*u+y*v,hi*u+y*v))
    paths=[]
    # Work around each half of the annulus instead of jumping over its central
    # opening on every scanline. Connect nearby lines only through material.
    for side,segments in enumerate(lanes):
        if side:segments.reverse()
        active=[]
        for _,a,b in segments:
            if active:
                if np.linalg.norm(active[-1]-b)<np.linalg.norm(active[-1]-a):a,b=b,a
                if (np.linalg.norm(active[-1]-a)<2 and
                        material_line(active[-1],a,ro,ri,holes,iw/2)):
                    active.extend([a,b]);continue
                paths.append(active)
            active=[a,b]
        if active:paths.append(active)
    return {'layer':layer,'z':round(layer*H,3),'compensation_mm':comp,
            'ro':ro,'ri':ri,'rh':rh,'outer_width':ow,'fill_width':iw,
            'outer_radii':outer_radii,'inner_radius':inner_radius,
            'hole_radius':hole_radius,'paths':paths,
            'seam_angle':math.radians((17+(layer-1)*137.507764)%360)}


class Writer:
    def __init__(self):
        self.lines=[];self.pos=np.array([18.,1.5]);self.z=.2
        self.retracted=False;self.e_positive=0.;self.print_e=0.;self.seconds=0.
        self.last_width=None;self.feature=None
    def add(self,line):self.lines.append(line)
    def travel(self,p,z):
        p=np.asarray(p)+C
        if not self.retracted:
            self.add('G1 E-0.8 F1800');self.seconds+=.8/30;self.retracted=True
        hop=max(self.z,z)+.4
        self.add(f'G1 Z{hop:.3f} F1200');self.seconds+=abs(hop-self.z)/20
        self.add(f'G1 X{p[0]:.5f} Y{p[1]:.5f} F12000');self.seconds+=np.linalg.norm(p-self.pos)/200
        self.add(f'G1 Z{z:.3f} F1200');self.seconds+=(hop-z)/20
        self.add('G1 E0.8 F1800');self.seconds+=.8/30
        self.pos=p;self.z=z;self.retracted=False
    def style(self,feature,width,speed,accel):
        if feature!=self.feature:self.add('; FEATURE: '+feature);self.feature=feature
        if width!=self.last_width:self.add(f'; LINE_WIDTH: {width:.5f}');self.last_width=width
        self.add(f'M204 S{accel}');self.add(f'G1 F{speed*60:.0f}')
    def extrusion(self,length,width,speed):
        e=length*area(width)/FA*FLOW
        self.print_e+=e;self.seconds+=length/speed
        return e
    def circle(self,center,r,z,width,speed,start,cw=False,outer=False):
        center=np.asarray(center);sign=-1 if cw else 1
        self.travel(center+polar(r,start),z)
        self.style('Outer wall' if outer else 'Inner wall',width,speed,500 if outer else 1000)
        if outer:self.add('; ANALYTIC_ROLLING_SURFACE_START')
        length=math.pi*r/2
        for k in range(4):
            old=center+polar(r,start+sign*k*math.pi/2)+C
            end=center+polar(r,start+sign*(k+1)*math.pi/2)+C
            ij=center+C-old;e=self.extrusion(length,width,speed)
            self.add(f'G{2 if cw else 3} X{end[0]:.5f} Y{end[1]:.5f} I{ij[0]:.5f} J{ij[1]:.5f} E{e:.6f}')
            self.pos=end
        if outer:self.add('; ANALYTIC_ROLLING_SURFACE_END')
    def polyline(self,path,z,width,speed):
        self.travel(path[0],z);self.style('Internal solid infill',width,speed,1000)
        for p in path[1:]:
            p=np.asarray(p)+C;length=np.linalg.norm(p-self.pos)
            if length<1e-7:continue
            e=self.extrusion(length,width,speed)
            self.add(f'G1 X{p[0]:.5f} Y{p[1]:.5f} E{e:.6f}');self.pos=p


def generate():
    w=Writer();w.add('; HANDCRAFTED_TIRE_BODY_START')
    w.add('G90');w.add('G21');w.add('G17');w.add('M83');w.add('G92 E0')
    stats=[]
    for n in range(1,21):
        d=make_layer(n);t0=w.seconds;e0=w.print_e
        z,ow,iw=d['z'],d['outer_width'],d['fill_width']
        w.add('; CHANGE_LAYER');w.add(f'; Z_HEIGHT: {z:.3f}');w.add('; LAYER_HEIGHT: 0.2')
        w.add(f'; layer num/total_layer_count: {n}/20');w.add(f'M73 L{n}');w.add(f'M991 S0 P{n-1}')
        w.add(f'M106 P1 S{0 if n==1 else 255}');w.add('M106 P2 S0')
        w.add('; OBJECT_ID: 1')
        # Build the internal structure first; finish each layer with the
        # uninterrupted outside circle at a constant conservative speed.
        wall_speed=25 if n==1 else 40;fill_speed=30 if n==1 else 60
        for q in CENTERS:w.circle(q,d['hole_radius'],z,ow,wall_speed,d['seam_angle'],cw=True)
        w.circle((0,0),d['inner_radius'],z,ow,wall_speed,d['seam_angle'],cw=True)
        for r in reversed(d['outer_radii'][1:]):w.circle((0,0),r,z,iw,wall_speed,d['seam_angle'])
        for path in d['paths']:w.polyline(path,z,iw,fill_speed)
        w.circle((0,0),d['outer_radii'][0],z,ow,wall_speed,d['seam_angle'],outer=True)
        stats.append({'layer':n,'height_mm':z,'edge_compensation_mm':d['compensation_mm'],
                      'outer_centerline_radius_mm':d['outer_radii'][0],'rolling_wall_width_mm':ow,
                      'outer_commands':4,'infill_paths':len(d['paths']),
                      'nominal_motion_seconds':float(w.seconds-t0),'filament_mm':float(w.print_e-e0)})
    return write_job(w,stats)


def write_job(w,stats,out=OUT,name=NAME,outline=None,wall_loops=3,
              description='Analytic circle, 248 mm OD / 222 mm ID / 4 mm thick, six 3.4 mm holes.'):
    w.add('; HANDCRAFTED_TIRE_BODY_END');w.add('M1003 S0');w.add('M106 S0');w.add('M106 P2 S0');w.add('M981 S0 P20000')
    start=(OUT/'printer/p1s-start.gcode.in').read_text()
    end=(OUT/'printer/p1s-end.gcode.in').read_text().format(end_lift_z=f'{TIRE_H+.5:.1f}')
    # Motion-only estimate plus the startup overhead in the supplied slice.
    estimated_seconds=int(math.ceil(w.seconds*1.12+431))
    weight=w.print_e*FA*PROFILE['filament_density_g_cm3']/1000
    config=json.loads((OUT/'printer/project-settings.json').read_text())
    config.update({'sparse_infill_density':'100%','sparse_infill_pattern':'zig-zag','layer_height':'0.2','wall_loops':str(wall_loops),
                   'outer_wall_speed':['40','40'],'outer_wall_acceleration':['500','500'],
                   'enable_arc_fitting':'1','resolution':'0.001','brim_type':'no_brim',
                   'brim_width':'0','enable_support':'0','seam_position':'random',
                   'upward_compatible_machine':['Bambu Lab P1S 0.4 nozzle']})
    # Explicit subset consumed by the G-code preview. Metadata settings retain
    # the source machine profile; the actual paths below are already generated.
    header=f'''; HEADER_BLOCK_START
; BambuStudio 02.05.00.66
; Custom analytic path generator; version line above selects the Bambu preview dialect.
; model printing time: {int(w.seconds)//3600}h {(int(w.seconds)//60)%60}m {int(w.seconds)%60}s; total estimated time: {estimated_seconds//3600}h {(estimated_seconds//60)%60}m {estimated_seconds%60}s
; total layer number: 20
; total filament length [mm] : {w.print_e:.2f}
; total filament volume [cm^3] : {w.print_e*FA/1000:.3f}
; total filament weight [g] : {weight:.2f}
; filament_density: 1.26
; filament_diameter: 1.75
; max_z_height: 4.00
; filament: 1
; HEADER_BLOCK_END
; CONFIG_BLOCK_START
; printer_model = Bambu Lab P1S
; printer_variant = 0.4
; printer_settings_id = Bambu Lab P1S 0.4 nozzle
; nozzle_diameter = 0.4
; filament_type = PLA
; filament_flow_ratio = 0.98
; filament_settings_id = Bambu PLA Basic @BBL P1S 0.4 nozzle
; curr_bed_type = Textured PEI Plate
; extruder_offset = 0x2
; use_relative_e_distances = 1
; layer_height = 0.2
; initial_layer_print_height = 0.2
; initial_layer_line_width = 0.5
; outer_wall_line_width = 0.42
; inner_wall_line_width = 0.45
; sparse_infill_density = 100%
; sparse_infill_pattern = zig-zag
; enable_arc_fitting = 1
; resolution = 0.001
; nozzle_temperature = 220
; textured_plate_temp = 55
; printable_area = 0x0,256x0,256x256,0x256
; printable_height = 250
; bed_exclude_area = 0x0,18x0,18x28,0x28
; CONFIG_BLOCK_END
; {description}
; First layers: radial compensation 0.15 / 0.075 / 0 mm; full dense fill.
; Requires the same P1S 0.4 / PLA / textured PEI setup as the supplied job.
; Retains source T0 / AMS slot 0 selection. Inspect preview before printing.
'''
    # The Bambu preview loader rejects a config with fewer than 80 keys.
    # Retain the supplied complete serialized config, overriding the small
    # preview subset above. These comments never generate printer motion.
    small=header[header.index('; CONFIG_BLOCK_START'):header.index('; CONFIG_BLOCK_END')]
    overrides=dict(re.findall(r'^; (\w+) = (.*)$',small,re.M))
    overrides.update({'wall_loops':str(wall_loops),'outer_wall_speed':'40,40',
                      'outer_wall_acceleration':'500,500','brim_type':'no_brim',
                      'brim_width':'0','enable_support':'0',
                      'upward_compatible_machine':'"Bambu Lab P1S 0.4 nozzle"'})
    preview_config=(OUT/'printer/gcode-settings.gcode.in').read_text()
    for key,value in overrides.items():
        preview_config=re.sub(r'^; '+key+r' = .*$',lambda m: '; '+key+' = '+value,preview_config,flags=re.M)
    header=re.sub(r'; CONFIG_BLOCK_START.*?; CONFIG_BLOCK_END\n',lambda m:preview_config,header,flags=re.S)
    text=header+f'M73 P0 R{math.ceil(estimated_seconds/60)}\n'+start+'\n'.join(w.lines)+'\n'+end
    (out/'GCODE').mkdir(parents=True,exist_ok=True)
    path=out/'GCODE'/f'{name}.gcode';path.write_text(text)
    summary={'layers':stats,'height_mm':4,'layer_count':20,'body_filament_mm':w.print_e,
             'body_weight_g':weight,'nominal_motion_seconds':float(w.seconds),
             'estimated_total_seconds':estimated_seconds,'estimate_not_firmware_simulation':True,
             'startup_purge_excluded_from_body_totals':True,'profile':PROFILE,'raw_gcode_sha256':hashlib.sha256(path.read_bytes()).hexdigest()}
    (out/'toolpath-summary.json').write_text(json.dumps(summary,indent=2)+'\n')
    package(path,config,summary,name=name,outline=outline)
    print('Generated',path,'weight',round(weight,2),'g; estimated',round(estimated_seconds/60),'min',flush=True)
    return summary


def package(gcode,config,summary,name=NAME,outline=None):
    from PIL import Image,ImageDraw
    def thumb(size):
        im=Image.new('RGBA',(size,size),'#f3f6f9');draw=ImageDraw.Draw(im)
        scale=size/274;center=size/2
        def ellipse(q,r,fill):
            x,y=center+q[0]*scale,center-q[1]*scale;t=r*scale
            draw.ellipse((x-t,y-t,x+t,y+t),fill=fill)
        if outline is None:
            ellipse((0,0),124,'#edba43');ellipse((0,0),111,'#f3f6f9')
            for q in CENTERS:ellipse(q,1.7,'#f3f6f9')
        else:
            def project(ring):return [(center+x*scale,center-y*scale) for x,y in ring.coords]
            draw.polygon(project(outline.exterior),fill='#edba43')
            for hole in outline.interiors:draw.polygon(project(hole),fill='#f3f6f9')
        b=io.BytesIO();im.save(b,format='PNG');return b.getvalue()
    model='''<?xml version="1.0" encoding="UTF-8"?>
<model unit="millimeter" xml:lang="en-US" xmlns="http://schemas.microsoft.com/3dmanufacturing/core/2015/02" xmlns:BambuStudio="http://schemas.bambulab.com/package/2021" xmlns:p="http://schemas.microsoft.com/3dmanufacturing/production/2015/06" requiredextensions="p">
<metadata name="Application">BambuStudio-02.05.00.66</metadata><metadata name="BambuStudio:3mfVersion">1</metadata>
<metadata name="Title">Analytic 248 x 4 mm rolling-clock tire</metadata><metadata name="Description">Custom G2/G3 tire paths; P1S / PLA / textured PEI. Not a resliceable project.</metadata><resources/><build/></model>'''
    rels='''<?xml version="1.0" encoding="UTF-8"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Target="/3D/3dmodel.model" Id="rel-1" Type="http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel"/><Relationship Target="/Metadata/plate_1.png" Id="rel-2" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/thumbnail"/></Relationships>'''
    types='''<?xml version="1.0" encoding="UTF-8"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Default Extension="model" ContentType="application/vnd.ms-package.3dmanufacturing-3dmodel+xml"/><Default Extension="png" ContentType="image/png"/><Default Extension="gcode" ContentType="text/x.gcode"/></Types>'''
    modelsettings='''<?xml version="1.0" encoding="UTF-8"?><config><plate><metadata key="plater_id" value="1"/><metadata key="plater_name" value="Analytic tire"/><metadata key="locked" value="false"/><metadata key="filament_map_mode" value="Auto For Flush"/><metadata key="filament_maps" value="1"/><metadata key="filament_volume_maps" value="0"/><metadata key="gcode_file" value="Metadata/plate_1.gcode"/><metadata key="thumbnail_file" value="Metadata/plate_1.png"/><metadata key="thumbnail_no_light_file" value="Metadata/plate_no_light_1.png"/><metadata key="top_file" value="Metadata/top_1.png"/><metadata key="pick_file" value="Metadata/pick_1.png"/><metadata key="pattern_bbox_file" value="Metadata/plate_1.json"/></plate></config>'''
    slicemeta=f'''<?xml version="1.0" encoding="UTF-8"?><config><header><header_item key="X-BBL-Client-Type" value="slicer"/><header_item key="X-BBL-Client-Version" value="02.05.00.66"/></header><plate><metadata key="index" value="1"/><metadata key="extruder_type" value="0"/><metadata key="nozzle_volume_type" value="0"/><metadata key="printer_model_id" value="C12"/><metadata key="nozzle_diameters" value="0.4"/><metadata key="timelapse_type" value="0"/><metadata key="prediction" value="{summary['estimated_total_seconds']}"/><metadata key="weight" value="{summary['body_weight_g']:.2f}"/><metadata key="first_layer_time" value="{summary['layers'][0]['nominal_motion_seconds']:.2f}"/><metadata key="outside" value="false"/><metadata key="support_used" value="false"/><metadata key="label_object_enabled" value="false"/><metadata key="filament_maps" value="1"/><metadata key="limit_filament_maps" value="0"/><object identify_id="1" name="{name}" skipped="false"/><filament id="1" tray_info_idx="GFA00" type="PLA" color="#FEC600" used_m="{summary['body_filament_mm']/1000:.3f}" used_g="{summary['body_weight_g']:.2f}" used_for_object="true" used_for_support="false" group_id="0" nozzle_diameter="0.40" volume_type="Standard"/><layer_filament_lists><layer_filament_list filament_list="0" layer_ranges="0 19"/></layer_filament_lists></plate></config>'''
    bbox={'bbox_all':[4,4,252,252],'bbox_objects':[{'area':outline.area if outline is not None else math.pi*(124**2-111**2)-6*math.pi*1.7**2,'bbox':[4,4,252,252],'id':1,'layer_height':.2,'name':name}], 'bed_type':'textured_plate','filament_colors':['#FEC600'],'filament_ids':[0],'first_extruder':0,'first_layer_time':summary['layers'][0]['nominal_motion_seconds'],'is_seq_print':False,'nozzle_diameter':.4,'version':2}
    files={'[Content_Types].xml':types,'_rels/.rels':rels,'3D/3dmodel.model':model,
           'Metadata/plate_1.gcode':gcode.read_bytes(),'Metadata/plate_1.gcode.md5':hashlib.md5(gcode.read_bytes()).hexdigest(),
           'Metadata/project_settings.config':json.dumps(config),'Metadata/model_settings.config':modelsettings,
           'Metadata/slice_info.config':slicemeta,'Metadata/plate_1.json':json.dumps(bbox),
           'Metadata/filament_sequence.json':'{"plate_1":{"sequence":[1]}}',
           'Metadata/_rels/model_settings.config.rels':'''<?xml version="1.0" encoding="UTF-8"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Target="/Metadata/plate_1.gcode" Id="rel-1" Type="http://schemas.bambulab.com/package/2021/gcode"/></Relationships>'''}
    for thumbnail_name in ['plate_1','plate_no_light_1','top_1','pick_1']:files[f'Metadata/{thumbnail_name}.png']=thumb(512)
    files['Metadata/plate_1_small.png']=thumb(128)
    target=gcode.with_suffix('.gcode.3mf')
    with zipfile.ZipFile(target,'w',zipfile.ZIP_DEFLATED,compresslevel=6) as z:
        for name,value in files.items():z.writestr(name,value)
    with zipfile.ZipFile(target) as z:
        assert z.testzip() is None and z.read('Metadata/plate_1.gcode')==gcode.read_bytes()


if __name__=='__main__':generate()
