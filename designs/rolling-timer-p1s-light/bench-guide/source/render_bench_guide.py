"""Render the exact lightweight bench kit; no changes to printable geometry."""
import bpy, json, math, sys
from pathlib import Path
from mathutils import Vector, Matrix
from bpy_extras.object_utils import world_to_camera_view

ROOT=Path(__file__).resolve().parents[2]
OUT=ROOT/'bench-guide'
RAW=OUT/'renders'; RAW.mkdir(parents=True,exist_ok=True)
PILOT='--pilot' in sys.argv
ONLY=None
if '--only' in sys.argv: ONLY=set(sys.argv[sys.argv.index('--only')+1].split(','))
bpy.ops.object.select_all(action='SELECT');bpy.ops.object.delete(use_global=False)
colors={'frame':'C2CAD0','pins':'53677B','shaft':'2868AF','input':'EA7830','compound':'169C89','escape':'E5B52C','regulator':'D44859','steel':'909AA5'}
materials={}
for key,hx in colors.items():
    linear=lambda c:c/12.92 if c<=.04045 else ((c+.055)/1.055)**2.4
    rgba=tuple(linear(int(hx[i:i+2],16)/255) for i in (0,2,4))+(1,)
    m=bpy.data.materials.new(key);m.diffuse_color=rgba;m.use_nodes=True
    p=m.node_tree.nodes.get('Principled BSDF');p.inputs['Base Color'].default_value=rgba
    p.inputs['Roughness'].default_value=.48;p.inputs['Metallic'].default_value=.65 if key=='steel' else 0
    materials[key]=m
def group(p):
    n=int(p[:2])
    return {3:'shaft',10:'input',11:'compound',12:'escape',18:'regulator',24:'regulator',25:'regulator'}.get(n,'frame' if n in (5,6,7,22,23) else 'pins')
C=Matrix(((1,0,0,0),(0,0,1,0),(0,-1,0,0),(0,0,0,1)))
manifest=json.loads((ROOT/'source/assembly/assembly.json').read_text())
objects={}
allowed={3,4,5,6,7,10,11,12,13,15,16,17,18,19,20,21,22,23,24,25,26,34,35,36,37}
for i,item in enumerate(manifest):
    if item.get('hardware') or int(item['part'][:2]) not in allowed or (item['part'].startswith('04_') and i!=10):continue
    bpy.ops.wm.stl_import(filepath=str(ROOT/'source/assembly'/item['file']))
    ob=bpy.context.object;ob.name=f'{i:02d} | {item["part"]}'
    ob.data.materials.append(materials[group(item['part'])]);ob.matrix_world=C
    objects[i]=ob
assert len(objects)==28

# Illustrated M3 clamp hardware, unthreaded envelopes; not supplied print parts.
P=(-25,-94.8539784553595)
ang=math.radians(-5)
def clamp_world(x,y,z):
    return Vector((P[0]+x*math.cos(ang)-y*math.sin(ang),z,-(P[1]+x*math.sin(ang)+y*math.cos(ang))))
def hardware_cyl(name,radius,length,cy,vertices=48):
    bpy.ops.mesh.primitive_cylinder_add(vertices=vertices,radius=radius,depth=length,location=clamp_world(12.5,cy,124))
    ob=bpy.context.object;ob.name=name
    axis=(clamp_world(12.5,cy+1,124)-clamp_world(12.5,cy,124)).normalized()
    ob.rotation_euler=axis.to_track_quat('Z','Y').to_euler();ob.data.materials.append(materials['steel'])
    return ob
hardware=[hardware_cyl('M3 x16 shaft envelope',1.5,16,2),hardware_cyl('M3 cap head envelope',2.75,3,-7.5),hardware_cyl('Plain M3 nut envelope',5.5/math.sqrt(3),2.4,4.7,6)]
scene=bpy.context.scene;scene.render.engine='CYCLES';scene.cycles.samples=12 if PILOT else 24
scene.cycles.use_denoising=True;scene.render.image_settings.file_format='PNG';scene.render.image_settings.color_mode='RGBA'
scene.render.film_transparent=True;scene.render.resolution_percentage=100
scene.view_settings.view_transform='AgX';scene.view_settings.look='AgX - Medium High Contrast'
scene.world.use_nodes=True;scene.world.node_tree.nodes['Background'].inputs[0].default_value=(.83,.89,1,1)
scene.world.node_tree.nodes['Background'].inputs[1].default_value=.4
def light(name,loc,energy,size):
    bpy.ops.object.light_add(type='AREA',location=loc);ob=bpy.context.object;ob.name=name
    ob.data.energy=energy;ob.data.shape='DISK';ob.data.size=size
    ob.rotation_euler=(Vector((-15,90,30))-ob.location).to_track_quat('-Z','Y').to_euler()
light('Soft key',(-220,340,360),1500000,240)
light('Fill',(260,180,70),900000,220)
light('Rear light',(40,-180,240),1200000,200)
bpy.ops.object.camera_add();cam=bpy.context.object;scene.camera=cam
cam.data.type='PERSP';cam.data.lens=58;cam.data.clip_end=10000
def cad(p):return C@Vector(p)
def set_view(ids,offsets=None,hw=False,focus=None,direction=(.28,1,.23)):
    offsets=offsets or {}
    for i,ob in objects.items():
        ob.hide_render=i not in ids;ob.hide_set(i not in ids)
        ob.matrix_world=Matrix.Translation(cad(offsets.get(i,(0,0,0))))@C
    for ob in hardware:ob.hide_render=not hw;ob.hide_set(not hw)
    bpy.context.view_layer.update()
    pts=[ob.matrix_world@Vector(p) for i,ob in objects.items() if i in (focus or ids) for p in ob.bound_box]
    lo=Vector(tuple(min(p[k] for p in pts) for k in range(3)));hi=Vector(tuple(max(p[k] for p in pts) for k in range(3)))
    target=(lo+hi)/2;v=Vector(direction).normalized();distance=max((hi-lo).length,100)
    for j in range(100):
        cam.location=target+v*distance;cam.rotation_euler=(target-cam.location).to_track_quat('-Z','Y').to_euler()
        bpy.context.view_layer.update()
        ps=[world_to_camera_view(scene,cam,p) for p in pts]
        if all(.11<p.x<.89 and .055<p.y<.945 and p.z>0 for p in ps):break
        distance*=1.055
    return offsets
meta={}
def shot(name,ids,offsets=None,hw=False,focus=None,direction=(.28,1,.23),points=None,w=1400,h=1150):
    if ONLY and name not in ONLY:return
    if PILOT:w=850;h=700
    scene.render.resolution_x=w;scene.render.resolution_y=h
    off=set_view(ids,offsets,hw,focus,direction)
    labels={}
    for label,(idx,pt) in (points or {}).items():
        p=cad(Vector(pt)+Vector(off.get(idx,(0,0,0))))
        ndc=world_to_camera_view(scene,cam,p);labels[label]=[ndc.x,ndc.y]
    meta[name]={'labels':labels,'visible_indices':sorted(ids),'offsets_cad_mm':off,'hardware_shown':hw}
    scene.render.filepath=str(RAW/(name+'.png'));bpy.ops.render.render(write_still=True)
    print('FINISHED '+name,flush=True)

stages=[
 ('01-rear',[12,14,15,16,21,28],{'05':(12,(0,0,75)),'07 x3':(14,(-76,-52,92)),'13':(21,(-25,-46.77,112)),'19':(28,(-25,-94.854,131)),'B':(12,(-56.25,0,103))}),
 ('02-shaft',[8,37],{'03':(8,(0,0,138)),'36':(37,(5,0,38))}),
 ('03-input',[26,18,10,25],{'35':(26,(8,0,77.3)),'10':(18,(28,8,81)),'04':(10,(-12,0,81)),'34':(25,(7,0,99))}),
 ('04-compound',[19,22],{'11':(19,(-97,0,91)),'15':(22,(-53,0,101))}),
 ('05-escape',[23,20,24],{'16':(23,(-21,-46.77,79)),'12':(20,(-44,-60,103)),'17':(24,(-21,-46.77,108))}),
 ('06-anchor',[29,27],{'20':(29,(-22,-94.854,86)),'18':(27,(-48,-77,103))}),
 ('07-front',[13,38],{'06':(13,(0,0,112)),'37':(38,(5,0,119))}),
 ('08-pendulum',[34],{'24':(34,(-17,-5,124))}),
 ('09-bob',[35,36],{'25':(35,(-11,55,126)),'26':(36,(-12,54.6,116))}),
 ('10-bridge',[30,32,33,31],{'21':(30,(-21,-94.854,128)),'23 x2':(32,(-46,-78.854,121)),'22':(31,(-25,-86,132))}),
]
cumulative=set()
for name,added,pts in stages:
    cumulative.update(added)
    offset={13:(0,0,45),38:(0,0,55)} if name=='07-front' else None
    shot(name,set(cumulative),offsets=offset,hw=name in ('08-pendulum','09-bob','10-bridge'),points=pts)
    if PILOT and name=='03-input':break
if not PILOT:
    shot('complete',set(objects),hw=True,points={'A':(18,(22,0,81)),'B':(19,(-77,0,91)),'C':(20,(-45,-49,103)),'P':(31,(-25,-94.854,133))})
    shot('input-exploded',{8,37,26,18,10,25},offsets={26:(0,0,16),18:(0,0,55),10:(-18,0,55),25:(0,0,95)},direction=(-1.1,1,.6),points={'36':(37,(-4,0,40)),'35':(26,(-7,0,77.6)),'10':(18,(-42,0,81)),'04':(10,(-13,0,81)),'34':(25,(-6,0,99))},w=1500,h=950)
    shot('gear-stacks',{19,22,21,23,20,24},offsets={19:(-20,0,0),22:(-20,0,23),23:(30,0,-12),20:(30,0,15),24:(30,0,34),21:(30,0,0)},direction=(.9,1,.5),points={'11':(19,(-72,20,91)),'15':(22,(-53,0,101)),'16':(23,(-21,-46.77,80)),'12':(20,(-39,-60,103)),'17':(24,(-22,-46.77,108))})
    shot('anchor-detail',{20,21,24,27,28,29},direction=(.05,1,.15),points={'18':(27,(-50,-78,103)),'20':(29,(-22,-94.854,88)),'19':(28,(-25,-94.854,132)),'12':(20,(-25,-21,103))})
    shot('clamp-detail',{27,28,29,34},hw=True,direction=(.85,1,.35),focus={27},points={'sleeve':(27,(-25,-94.85,118)),'clamp':(34,(-14,-94,124))},w=1200,h=900)
    shot('bridge-exploded',{13,27,28,30,31,32,33,34},offsets={30:(0,0,12),31:(0,0,35),32:(0,0,12),33:(0,0,12)},hw=True,focus={27,28,30,31,32,33},direction=(.65,1,.35),points={'21':(30,(-21,-94.85,128)),'22':(31,(-25,-94.85,131)),'23 x2':(32,(-46,-78.85,120))},w=1300,h=1050)
    shot('bob-detail',{34,35,36},offsets={36:(0,0,-10)},focus={35,36},direction=(.5,-1,.45),points={'25':(35,(-12,54,118)),'26':(36,(-12,54.6,116))},w=1200,h=900)
    shot('test-front',set(objects),hw=True,direction=(0,1,.01),points={'A':(18,(0,0,83)),'B':(19,(-56.25,0,91)),'C':(20,(-25,-46.77,103)),'P':(31,(-25,-94.854,133)),'bob':(35,(-12,54.6,125))})
path=OUT/'render-metadata.json'
old=json.loads(path.read_text()) if path.exists() else {};old.update(meta);path.write_text(json.dumps(old,indent=2))
print('BENCH GUIDE RENDERS COMPLETE',flush=True)
