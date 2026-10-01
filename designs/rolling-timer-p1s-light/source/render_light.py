"""Perspective studio renders of the dedicated light 16:1 variant.
Run with Blender 5.x: blender -b --factory-startup -t 6 --python this_file.py
Use -- --pilot for one low-resolution framing check.
"""
import bpy, json, math, sys
from pathlib import Path
from mathutils import Vector, Matrix

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT/'renders'
RAW = OUT
RAW.mkdir(parents=True, exist_ok=True)
ASM = ROOT/'source/assembly'
PILOT = '--pilot' in sys.argv
bpy.ops.object.select_all(action='SELECT')
bpy.ops.object.delete(use_global=False)

PALETTE = {
    'drum': ('2464AB', 'Rolling drum and main shaft'),
    'input': ('EA7830', 'A - 72-tooth input gear'),
    'compound': ('11998A', 'B - 18/72 compound gear'),
    'escape': ('E0AD22', 'C - 18/30 escape compound'),
    'regulator': ('CE4051', 'Anchor, pendulum and bob'),
    'modules': ('8255B8', 'Replaceable B pivot modules'),
    'frame': ('B8C3CE', 'Carrier, bridge and ballast cup'),
    'pivots': ('526171', 'Printed pivots, spacers and pins'),
    'steel': ('8493A1', 'Illustrative loose steel ballast'),
}
def linear(c):
    return c/12.92 if c <= .04045 else ((c+.055)/1.055)**2.4
materials = {}
for key, (hx,label) in PALETTE.items():
    c = tuple(linear(int(hx[i:i+2],16)/255) for i in (0,2,4))+(1,)
    m=bpy.data.materials.new(label);m.diffuse_color=c;m.use_nodes=True
    p=m.node_tree.nodes.get('Principled BSDF')
    p.inputs['Base Color'].default_value=c
    p.inputs['Roughness'].default_value=.4 if key!='steel' else .24
    p.inputs['Metallic'].default_value=0 if key!='steel' else .82
    materials[key]=m

def group_for(i):
    p=manifest[i]['part']
    if manifest[i].get('hardware'):return 'steel'
    if p.startswith(('01_','02_','03_')):return 'drum'
    if p.startswith('10_'):return 'input'
    if p.startswith('11_'):return 'compound'
    if p.startswith('12_'):return 'escape'
    if p.startswith(('18_','24_','25_')):return 'regulator'
    if p.startswith(('05_','06_','07_','08_','22_','23_')):return 'frame'
    return 'pivots'

cad_to_world=Matrix(((1,0,0,0),(0,0,1,0),(0,-1,0,0),(0,0,0,1)))
collection=bpy.data.collections.new('LIGHT 16:1 PRINTED PARTS + HARDWARE ENVELOPES')
bpy.context.scene.collection.children.link(collection)
objects=[]
manifest=json.loads((ASM/'assembly.json').read_text())
for i,item in enumerate(manifest):
    bpy.ops.wm.stl_import(filepath=str(ASM/item['file']))
    ob=bpy.context.object
    ob.name=f'{i:02d} | {item["name"]}'
    ob.data.materials.append(materials[group_for(i)])
    ob.matrix_world=cad_to_world
    ob['STL part']=item['part']; ob['assembly_index']=i
    ob['color_group']=group_for(i)
    # Keep CAD facets and all mating surfaces unchanged.
    for coll in list(ob.users_collection): coll.objects.unlink(ob)
    collection.objects.link(ob)
    objects.append(ob)

# Loose metal is a visual aid; it is not part of the print files or a packing model.
props=bpy.data.collections.new('ILLUSTRATIVE BALLAST - not printable parts')
bpy.context.scene.collection.children.link(props)
bpy.ops.mesh.primitive_ico_sphere_add(subdivisions=2,radius=1)
unit=bpy.context.object; sphere=unit.data
for p in sphere.polygons:p.use_smooth=True
sphere.materials.append(materials['steel'])
bpy.data.objects.remove(unit,do_unlink=True)
ballast=[];bobfill=[]
def ball(name, xyz, radius, dest):
    ob=bpy.data.objects.new(name,sphere);props.objects.link(ob)
    ob.location=(xyz[0],xyz[2],-xyz[1]);ob.scale=(radius,)*3
    ob['illustration_only']=True;dest.append(ob)
for layer in range(5):
    y=83.0-layer*4.1
    for row in range(11):
        z=13.1+row*4.34+(layer%2)*1.45
        if z>60.8:continue
        for col in range(21):
            x=-56.8+col*5.03+((row+layer)%2)*2.515
            if x>42.8:continue
            ball('Ballast - illustrative ball',(x,y,z),2.45,ballast)
ang=math.radians(-5);P=(-25,-94.853978)
for layer in range(4):
    for xx in (-12.4,-8.2,8.2,12.4):
        for zz in (121.7,126.0):
            yy=157.2-layer*4.2
            x=P[0]+xx*math.cos(ang)-yy*math.sin(ang)
            y=P[1]+xx*math.sin(ang)+yy*math.cos(ang)
            ball('Bob - illustrative ball',(x,y,zz),1.95,bobfill)

scene=bpy.context.scene
scene.render.engine='CYCLES';scene.cycles.samples=20 if PILOT else 64
scene.cycles.use_denoising=True
scene.render.image_settings.file_format='PNG';scene.render.image_settings.color_mode='RGB'
scene.render.film_transparent=False
scene.render.resolution_percentage=100
scene.view_settings.view_transform='AgX';scene.view_settings.look='AgX - Medium High Contrast'
scene.world.use_nodes=True
scene.world.node_tree.nodes['Background'].inputs[0].default_value=(.85,.9,1,1)
scene.world.node_tree.nodes['Background'].inputs[1].default_value=.28

def area(name,loc,energy,size,target=(0,65,0)):
    bpy.ops.object.light_add(type='AREA',location=loc);ob=bpy.context.object
    ob.name=name;ob.data.energy=energy;ob.data.shape='DISK';ob.data.size=size
    ob.rotation_euler=(Vector(target)-ob.location).to_track_quat('-Z','Y').to_euler()
area('Large warm key',(-200,320,400),1700000,230)
area('Front softbox',(290,200,180),650000,260)
area('Rear edge light',(20,-180,250),1500000,180)
bpy.ops.mesh.primitive_plane_add(size=20000,location=(0,0,-120.05))
floor=bpy.context.object;floor.name='Studio floor - render only'
mat=bpy.data.materials.new('Warm ivory studio');mat.use_nodes=True
bs=mat.node_tree.nodes.get('Principled BSDF')
bs.inputs['Base Color'].default_value=(.70,.66,.57,1);bs.inputs['Roughness'].default_value=.72
floor.data.materials.append(mat)
bpy.ops.object.camera_add(location=(350,680,300));cam=bpy.context.object
cam.name='Perspective camera - 55 mm';scene.camera=cam
cam.data.type='PERSP';cam.data.lens=55;cam.data.sensor_width=36;cam.data.clip_end=10000

def aim(loc,target,lens=55):
    cam.location=loc;cam.rotation_euler=(Vector(target)-cam.location).to_track_quat('-Z','Y').to_euler();cam.data.lens=lens
def show(indices,fill=True,bob=True):
    for i,ob in enumerate(objects):ob.hide_render=i not in indices;ob.hide_set(i not in indices)
    for ob in ballast:ob.hide_render=not fill;ob.hide_set(not fill)
    for ob in bobfill:ob.hide_render=not bob;ob.hide_set(not bob)
def render(name,w=1900,h=1500):
    scene.render.resolution_x=w;scene.render.resolution_y=h
    scene.render.filepath=str(OUT/(name+'.png'));bpy.ops.render.render(write_still=True)

allparts=set(range(len(objects)))
show(allparts)
aim((340,615,265),(0,70,-9),55)
render('light-assembled',1000 if PILOT else 1900,800 if PILOT else 1500)
if PILOT:sys.exit(0)

# Open view: remove the front drum wheel; all mechanism supports remain fitted.
show(allparts-{1,11})
aim((215,610,250),(0,70,-7),55)
render('light-mechanism')

# A rear view exposes the two nut pockets and the lower contact pads.
show(allparts,False,True)
aim((-280,-465,330),(0,65,-20),55)
render('light-rear')

# Two new carriers shown on their exported printing faces.
show(set(),False,False)
portraits=[]
def part(name,x,y):
    bpy.ops.wm.stl_import(filepath=str(ROOT/'STL'/(name+'.stl')))
    ob=bpy.context.object;ob.name='Print face portrait | '+name
    bounds=[ob.matrix_world@Vector(v) for v in ob.bound_box]
    lo=Vector(tuple(min(v[i] for v in bounds) for i in range(3)))
    hi=Vector(tuple(max(v[i] for v in bounds) for i in range(3)))
    ob.location=Vector((x,y,-120))-Vector(((lo.x+hi.x)/2,(lo.y+hi.y)/2,lo.z))
    ob.data.materials.append(materials['frame']);portraits.append(ob)
part('05_rear_carrier',-77,65)
part('06_front_carrier',77,65)
aim((180,430,290),(0,65,-112),52)
render('lightweight-frames',1900,1500)
for ob in portraits:bpy.data.objects.remove(ob,do_unlink=True)
show(allparts)
aim((340,615,265),(0,70,-9),55)
for ar in bpy.context.screen.areas:
    if ar.type=='VIEW_3D':
        ar.spaces.active.region_3d.view_perspective='CAMERA'
        ar.spaces.active.shading.color_type='MATERIAL'
bpy.ops.wm.save_as_mainfile(filepath=str(ROOT/'light-assembly.blend'))
(OUT/'README.md').write_text('''# Lightweight 16:1 variant - perspective views

All views use the supplied printable meshes. The steel screw/nut envelopes omit threads; loose steel ballast and the studio floor are illustrative.

- light-assembled.png: the complete rolling timer.
- light-mechanism.png: front drum wheel and its shaft crosspin removed; both lightweight carrier frames remain fitted.
- light-rear.png: complete assembly, empty ballast cup so its upper mounting region can be inspected.
- lightweight-frames.png: the new rear and front frames lying on their intended printing faces. Rear frame has the integral B pivot and bowl bracket; front has the blind B bearing and pendulum bridge supports.
''')
print('LIGHTWEIGHT PERSPECTIVE RENDERS COMPLETE')
