"""CAD comparison render: original bob and narrower replacement, same scale."""
from pathlib import Path
import bpy
from mathutils import Vector

OUT=Path(__file__).resolve().parents[1];ROOT=OUT.parent
bpy.ops.object.select_all(action='SELECT');bpy.ops.object.delete(use_global=False)
def material(name,rgb):
    m=bpy.data.materials.new(name);m.use_nodes=True
    bs=m.node_tree.nodes.get('Principled BSDF');bs.inputs['Base Color'].default_value=(*rgb,1);bs.inputs['Roughness'].default_value=.48
    return m
old=material('Original',(0.35,.41,.47));new=material('1 mm walls',(.66,.075,.13))
for name,path,x,m in [('Original',ROOT/'STL/25_open_pendulum_bob.stl',-25,old),('Replacement',OUT/'25_open_pendulum_bob_1mm.stl',25,new)]:
    bpy.ops.wm.stl_import(filepath=str(path));ob=bpy.context.object;ob.name=name
    lo=Vector(tuple(min(v[k] for v in ob.bound_box) for k in range(3)))
    hi=Vector(tuple(max(v[k] for v in ob.bound_box) for k in range(3)))
    ob.location=(x-(lo.x+hi.x)/2,-(lo.y+hi.y)/2,-lo.z);ob.data.materials.append(m)
bpy.ops.mesh.primitive_plane_add(size=2000,location=(0,0,-.04));bpy.context.object.data.materials.append(material('Ivory floor',(.8,.78,.72)))
scene=bpy.context.scene;scene.render.engine='CYCLES';scene.cycles.samples=32;scene.cycles.use_denoising=True
scene.render.resolution_x=1500;scene.render.resolution_y=950;scene.render.resolution_percentage=100
scene.render.image_settings.file_format='PNG';scene.render.image_settings.color_mode='RGB'
scene.world.use_nodes=True;scene.world.node_tree.nodes['Background'].inputs[0].default_value=(.85,.9,1,1);scene.world.node_tree.nodes['Background'].inputs[1].default_value=.35
scene.view_settings.view_transform='AgX';scene.view_settings.look='AgX - Medium High Contrast'
for loc,energy,size in [((-65,-70,100),90000,80),((65,-30,70),45000,90),((10,75,90),65000,60)]:
    bpy.ops.object.light_add(type='AREA',location=loc);ob=bpy.context.object;ob.data.energy=energy;ob.data.size=size
    ob.rotation_euler=(Vector((0,0,12))-ob.location).to_track_quat('-Z','Y').to_euler()
bpy.ops.object.camera_add(location=(40,-165,118));cam=bpy.context.object;scene.camera=cam
cam.data.type='PERSP';cam.data.lens=55;cam.data.clip_end=5000
cam.rotation_euler=(Vector((0,0,12))-cam.location).to_track_quat('-Z','Y').to_euler()
scene.render.filepath=str(OUT/'comparison-cad.png');bpy.ops.render.render(write_still=True)
