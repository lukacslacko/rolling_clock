"""Perspective studio renders of revision 2, using exact printable meshes.
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
    if i<=8: return 'drum'
    if i==23: return 'input'
    if i==24: return 'compound'
    if i==25: return 'escape'
    if i in (40,47,48): return 'regulator'
    if i in (27,28): return 'modules'
    if i in (12,13,14,15,16,17,18,44,45,46): return 'frame'
    return 'pivots'

cad_to_world=Matrix(((1,0,0,0),(0,0,1,0),(0,-1,0,0),(0,0,0,1)))
collection=bpy.data.collections.new('R2 PRINTED PARTS - square drive and through pinions')
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
scene.render.engine='CYCLES';scene.cycles.samples=24 if PILOT else 96
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
def render(name,w=2300,h=1800):
    scene.render.resolution_x=w;scene.render.resolution_y=h
    scene.render.filepath=str(OUT/(name+'.png'));bpy.ops.render.render(write_still=True)

allparts=set(range(len(objects)))
show(allparts)
aim((340,615,265),(0,70,-9),55)
render('perspective-front',1000 if PILOT else 2300,800 if PILOT else 1800)
if PILOT:sys.exit(0)
aim((-325,-510,395),(0,65,-18),55)
render('perspective-rear')
show(allparts-{1,11,13,28,32,33,34,44,45,46})
aim((195,610,235),(0,70,-12),55)
render('perspective-open')

# Print-oriented component portraits, using the supplied print STL files directly.
show(set(),False,False)
portraits=[]
def part(name,color,x,y,rot_z=0):
    bpy.ops.wm.stl_import(filepath=str(ROOT/'STL'/(name+'.stl')))
    ob=bpy.context.object;ob.name='Component portrait | '+name
    ob.rotation_euler.z=math.radians(rot_z)
    bpy.context.view_layer.update()
    bounds=[ob.matrix_world@Vector(v) for v in ob.bound_box]
    lo=Vector(tuple(min(v[i] for v in bounds) for i in range(3)))
    hi=Vector(tuple(max(v[i] for v in bounds) for i in range(3)))
    ob.location=Vector((x,y,-120)) - Vector(((lo.x+hi.x)/2,(lo.y+hi.y)/2,lo.z))
    ob.data.materials.append(materials[color]);portraits.append(ob);return ob
part('11_compound_18_72','compound',-53,63)
part('12_escape_compound','escape',45,63)
aim((70,280,104),(-6,63,-110),60)
render('compound-gears-on-print-faces',2300,1600)
for ob in portraits:ob.hide_render=True;ob.hide_set(True)
part('03_main_shaft','drum',-28,120,90)
part('10_drive_72','input',40,46)
part('36_rear_round_journal','pivots',-78,15)
part('37_front_round_journal','pivots',-61,46)
part('35_main_rear_thrust_washer','pivots',-39,11)
part('34_main_front_thrust_sleeve','pivots',-14,10)
aim((132,298,171),(-15,63,-91),55)
render('square-drive-components',2300,1600)
for ob in portraits:bpy.data.objects.remove(ob,do_unlink=True)
show(allparts)
aim((340,615,265),(0,70,-9),55)
scene.render.resolution_x=2300;scene.render.resolution_y=1800
for ar in bpy.context.screen.areas:
    if ar.type=='VIEW_3D':
        ar.spaces.active.region_3d.view_perspective='CAMERA'
        ar.spaces.active.shading.color_type='MATERIAL'
bpy.ops.wm.save_as_mainfile(filepath=str(ROOT/'perspective-assembly.blend'))
(OUT/'README.md').write_text('''# Revision 2 perspective renders

All views use a perspective camera and the exact supplied R2 print geometry.

- `perspective-front.png`: complete assembly, front three-quarter view.
- `perspective-rear.png`: complete assembly from the ballast side.
- `perspective-open.png`: front wheel, front carrier, B front module and anchor bridge removed for inspection, with their associated retaining hardware. These supports are required in the actual build.
- `compound-gears-on-print-faces.png`: green and yellow gears resting on their exported printing faces. Small pinion teeth now continue through the large-wheel thickness.
- `square-drive-components.png`: square shaft, orange input gear, two round bearing sleeves and keyed thrust parts, arranged separately on the studio floor.

The studio floor and loose steel spheres are illustrative. No printed part geometry was altered for rendering. Colors identify the same functional groups as the previous guide. The old visual guide belongs to revision 1; follow this revision's ASSEMBLY.md for the square axle and its additional sleeves.
''')
print('R2 PERSPECTIVE RENDERS COMPLETE')
