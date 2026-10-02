"""Perspective illustrations from the checked R3 assemblies. Blender 5.x."""
from pathlib import Path
import bpy, json, math, sys
from mathutils import Vector, Matrix
from bpy_extras.object_utils import world_to_camera_view
ROOT=Path(__file__).resolve().parents[1];OUT=ROOT/'renders';OUT.mkdir(exist_ok=True)
PILOT='--pilot' in sys.argv
ONLY=set(sys.argv[sys.argv.index('--only')+1].split(',')) if '--only' in sys.argv else None
bpy.ops.object.select_all(action='SELECT');bpy.ops.object.delete(use_global=False)
COLORS={'case':'2868AF','input':'EB8038','compound':'1E9D8A','escape':'E3B431','extra':'9164BA','regulator':'CC435C','pins':'596E83','frame':'D4D9DA','ballast':'D4D9DA','steel':'97A1AA'}
materials={}
for key,hx in COLORS.items():
    lin=lambda c:c/12.92 if c<=.04045 else ((c+.055)/1.055)**2.4
    rgba=tuple(lin(int(hx[i:i+2],16)/255) for i in (0,2,4))+(1,)
    m=bpy.data.materials.new(key);m.diffuse_color=rgba;m.use_nodes=True;p=m.node_tree.nodes.get('Principled BSDF');p.inputs['Base Color'].default_value=rgba;p.inputs['Roughness'].default_value=.45;p.inputs['Metallic'].default_value=.7 if key=='steel' else 0;materials[key]=m
T=Matrix(((1,0,0,0),(0,0,1,0),(0,-1,0,0),(0,0,0,1)))
objects={};manifests={}
for ratio in (16,32,64):
    manifest=json.loads((ROOT/'assembly'/f'{ratio}x'/'assembly.json').read_text());manifests[ratio]=manifest
    for i,a in enumerate(manifest):
        bpy.ops.wm.stl_import(filepath=str(ROOT/'assembly'/f'{ratio}x'/a['file']))
        ob=bpy.context.object;ob.name=f'{ratio}|{i:03d}|{a["name"]}';ob.data.materials.append(materials[a['color']]);ob.matrix_world=T;objects[ratio,i]=ob
scene=bpy.context.scene;scene.render.engine='CYCLES';scene.cycles.samples=12 if PILOT else 32;scene.cycles.use_denoising=True
scene.render.resolution_percentage=100;scene.render.image_settings.file_format='PNG';scene.render.image_settings.color_mode='RGBA';scene.render.film_transparent=True
scene.view_settings.view_transform='AgX';scene.view_settings.look='AgX - Medium High Contrast'
scene.world.use_nodes=True;scene.world.node_tree.nodes['Background'].inputs[0].default_value=(.85,.9,1,1);scene.world.node_tree.nodes['Background'].inputs[1].default_value=.45
for name,loc,energy,size in [('Key',(-230,330,400),1900000,260),('Fill',(350,220,40),1300000,250),('Rim',(30,-160,280),1600000,220)]:
    bpy.ops.object.light_add(type='AREA',location=loc);ob=bpy.context.object;ob.name=name;ob.data.energy=energy;ob.data.shape='DISK';ob.data.size=size;ob.rotation_euler=(Vector((0,85,20))-ob.location).to_track_quat('-Z','Y').to_euler()
bpy.ops.object.camera_add();cam=bpy.context.object;scene.camera=cam;cam.data.type='PERSP';cam.data.lens=58;cam.data.clip_end=10000
meta={}
def render(name,ratio=16,selector=lambda a:True,loc=(330,460,220),target=(0,90,10),res=(1600,1300),offsets=None,labels=None):
    if ONLY and name not in ONLY:return
    offsets=offsets or {}
    for (r,i),ob in objects.items():
        a=manifests[r][i];ob.hide_render=r!=ratio or not selector(a);ob.matrix_world=T
        if r==ratio and a['name'] in offsets:ob.matrix_world=T@Matrix.Translation(Vector(offsets[a['name']]))
    cam.location=loc;cam.rotation_euler=(Vector(target)-cam.location).to_track_quat('-Z','Y').to_euler()
    scene.render.resolution_x=res[0]//(2 if PILOT else 1);scene.render.resolution_y=res[1]//(2 if PILOT else 1)
    scene.render.filepath=str(OUT/(name+'.png'));bpy.ops.render.render(write_still=True)
    points={}
    for key,xyz in (labels or {}).items():
        co=world_to_camera_view(scene,cam,T@Vector(xyz));points[key]=[float(co.x),float(1-co.y)]
    meta[name]={'ratio':ratio,'labels':points}
    print('RENDERED',name,flush=True)
layout=json.loads((ROOT/'layouts.json').read_text());P=layout['16']['axes']['P']
render('assembled-16x',loc=(350,580,260),target=(0,90,0))
for ratio in (16,32,64):
    render(f'mechanism-{ratio}x',ratio,lambda a:a['group']!='case' and not a['name'].startswith('axle_cross_6') and not a['name'].startswith('axle_cross_174'),loc=(220,480,210),target=(0,103,17))
render('frame-and-pivots',selector=lambda a:a['name']=='05_shared_rear_frame' or a['name'].endswith('_pivot') or a['name']=='19_bolted_anchor_pivot' or a['name'].startswith('frame_post_') or 'pivot_bolt' in a['name'] or a['name'].startswith('frame_rear_'),loc=(220,480,210),target=(0,90,5),labels={key:tuple(xy)+ (84,) for key,xy in {'A':layout['16']['axes']['A'],'B16':layout['16']['axes']['B'],'C':layout['16']['axes']['C'],'P':P}.items()})
render('gear-stack',selector=lambda a:a['folder'] not in ('hardware',) and (a['group'] in ('rotor','B','C','anchor') or a['part'] in ('05_shared_rear_frame','13_bolted_gear_pivot','19_bolted_anchor_pivot') or a['part'].startswith(('15_','16_','17_','20_','27_'))),loc=(190,390,200),target=(3,90,22))
render('front-and-pendulum',selector=lambda a:a['group']!='case' and a['part']!='08_open_ballast_bowl' and not a['name'].startswith(('axle_cross_6','axle_cross_174','bowl_')),loc=(190,420,190),target=(0,110,15))
render('close-front-frame',selector=lambda a:a['group'] not in ('case','pendulum') and a['part'] not in ('08_open_ballast_bowl','22_bolted_anchor_bridge','21_anchor_front_spacer') and not a['name'].startswith(('axle_cross_6','axle_cross_174','bowl_')) and not (a['name'].startswith('bridge_front_') and a.get('type')=='screw'),loc=(220,480,210),target=(0,110,5))
render('bowl-rear',selector=lambda a:a['group']!='case' and not a['name'].startswith(('axle_cross_6','axle_cross_174')),loc=(-250,-325,235),target=(0,90,12))
render('bob-detail',selector=lambda a:a['group']=='pendulum',loc=(P[0]-100,-15,-5),target=(P[0],148,-(P[1]+139)),res=(1300,1000),offsets={'bob_bolt':(0,0,-12),'bob_bolt_nut':(0,-14,0)},labels={'25':(P[0]+15,P[1]+150,154),'M3x16':(P[0],P[1]+150,129.4),'nut':(P[0],P[1]+136,152.4)})
render('bob-front-detail',selector=lambda a:a['group']=='pendulum',loc=(P[0]+93,305,-20),target=(P[0],148,-(P[1]+139)),res=(1300,1000),offsets={'bob_bolt':(0,0,-12),'bob_bolt_nut':(0,-14,0)},labels={'nut':(P[0],P[1]+136,152.4)})
render('bridge-detail',selector=lambda a:a['part'] in ('06_shared_front_frame','22_bolted_anchor_bridge','23_square_bridge_post','21_anchor_front_spacer','24_offset_pendulum','19_bolted_anchor_pivot','18_anchor_forward') or a['name'].startswith('bridge_') or a['name'].startswith('pendulum_clamp'),loc=(P[0]+125,335,160),target=(P[0],141,-P[1]-6),res=(1300,1050),offsets={'22_bolted_anchor_bridge':(0,0,14),'bridge_front_0':(0,0,14),'bridge_front_1':(0,0,14)},labels={'22':(P[0],P[1],179),'23':(P[0]+26,P[1]+24,145),'21':(P[0],P[1],155)})
# One square case-post end, wheel, screw and nut, pulled apart for access.
render('case-post-detail',selector=lambda a:a['name'] in ('rear_case_wheel','case_post_1','case_rear_1','case_rear_1_nut'),loc=(220,-145,65),target=(98.7,10,-57),res=(1300,1050),offsets={'case_rear_1':(0,0,-16)},labels={'M3x16':(98.7,57,-16),'nut slot':(98.7,57,13.7),'flat shoulder':(98.7,57,7)})
render('post-nut-detail',selector=lambda a:a['name'] in ('frame_post_1','frame_rear_0','frame_rear_0_nut'),loc=(-225,17,25),target=(-81,92,-51),res=(1300,1050),offsets={'frame_rear_0':(0,0,-12),'frame_rear_0_nut':(-13,0,0)},labels={'07':(-81,51,104),'nut':(-94,51,82.6),'M3x10':(-81,51,62.2)})
# Axle/hub close-up from rear, before journal sleeve installation.
render('axle-detail',selector=lambda a:a['part'] in ('03_square_main_axle','10_drive_72') or a['name'] in ('axle_cross_91','axle_cross_91_nut'),loc=(-95,235,100),target=(0,90,0),res=(1300,1000),offsets={'axle_cross_91':(-12,0,0)},labels={'10':(10,0,94.8),'03':(0,0,125),'M3x16':(-20,0,91)})
if ONLY and (OUT/'render-metadata.json').exists():
    meta=json.loads((OUT/'render-metadata.json').read_text())|meta
(OUT/'render-metadata.json').write_text(json.dumps(meta,indent=2))
# Keep an editable assembly view without external asset dependencies.
for (r,i),ob in objects.items():ob.hide_render=r!=16;ob.hide_viewport=r!=16;ob.matrix_world=T
cam.location=(350,580,260);cam.rotation_euler=(Vector((0,90,0))-cam.location).to_track_quat('-Z','Y').to_euler()
scene.render.filepath='//renders/'
for library in list(bpy.data.libraries):
    if Path(library.filepath).name.startswith('essentials_brushes'):bpy.data.libraries.remove(library)
bpy.context.preferences.filepaths.save_version=0
bpy.ops.wm.save_as_mainfile(filepath=str(ROOT/'r3-assembly.blend'),compress=True)
