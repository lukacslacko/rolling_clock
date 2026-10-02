"""Shared CAD primitives. Dimensions in millimetres."""
import math
import numpy as np
import manifold3d as mf
import trimesh
from shapely.geometry import Point, LineString, Polygon, box
from shapely.ops import unary_union
from shapely.geometry.polygon import orient
D=math.pi/180
MOD=1.25
TOOTH_THINNING=.18
def circle(r,c=(0,0)): return Point(c).buffer(r,quad_segs=48)
def bar(a,b,w): return LineString([a,b]).buffer(w/2,cap_style=1)
def section(g):
    if g.geom_type=='Polygon': gs=[g]
    else: gs=list(g.geoms)
    contours=[]
    for poly in gs:
        if poly.area<1e-8: continue
        po=orient(poly,sign=1)
        contours.append(np.asarray(po.exterior.coords)[:-1])
        contours.extend(np.asarray(i.coords)[:-1] for i in po.interiors)
    return mf.CrossSection(contours)
def extr(g,z,h): return section(g).extrude(h).translate((0,0,z))
def cyl(r,z,h,xy=(0,0),n=96): return mf.Manifold.cylinder(h,r,circular_segments=n).translate((*xy,z))
def cub(x,y,z,dx,dy,dz): return mf.Manifold.cube((dx,dy,dz)).translate((x,y,z))
def hx(r,x,y,z,length):return mf.Manifold.cylinder(length,r,circular_segments=64).rotate((0,90,0)).translate((x,y,z))
def hy(r,x,y,z,length):return mf.Manifold.cylinder(length,r,circular_segments=64).rotate((-90,0,0)).translate((x,y,z))
def mesh(m):
    raw=m.simplify(0.0001).to_mesh64()
    tm=trimesh.Trimesh(np.asarray(raw.vert_properties)[:,:3],np.asarray(raw.tri_verts),process=True)
    tm.update_faces(tm.nondegenerate_faces())
    tm.update_faces(tm.unique_faces())
    tm.remove_unreferenced_vertices()
    return tm
def polar(r,a):return np.array([r*math.cos(a),r*math.sin(a)])
KEY_WIDTH=8.0
KEY_CHAMFER=1.4
KEY_CLEARANCE=.15 # offset of each face; socket is 8.30 across flats
key_half=KEY_WIDTH/2;key_flat_end=key_half-KEY_CHAMFER
key_profile=Polygon([(key_half,key_flat_end),(key_flat_end,key_half),(-key_flat_end,key_half),(-key_half,key_flat_end),(-key_half,-key_flat_end),(-key_flat_end,-key_half),(key_flat_end,-key_half),(key_half,-key_flat_end)])
key_socket=key_profile.buffer(KEY_CLEARANCE,join_style=2)
def key_hole(m,z,h):return m-extr(key_socket,z,h)
def retainer_slot(m,z):
    # Tangential relief lets the square faces carry torque before the pin bears.
    cut=hx(1.95,-12,-1.2,z,24)+hx(1.95,-12,1.2,z,24)+cub(-12,-1.2,z-1.95,24,2.4,3.9)
    return m-cut
def rotate2(p,a):return np.asarray(p)@np.array([[math.cos(a),math.sin(a)],[-math.sin(a),math.cos(a)]])
def spur(n,phase=0):
    rp=MOD*n/2; rb=rp*math.cos(20*D); ra=rp+MOD; rf=rp-1.25*MOD
    inv=lambda r: math.sqrt(max(0,(r/rb)**2-1))-math.acos(min(1,rb/r))
    half=math.pi/(2*n)-TOOTH_THINNING/(2*rp); invp=inv(rp); pts=[]
    for i in range(n):
        mid=i*2*math.pi/n+phase
        pts.append(polar(rf,mid-half-invp))
        for r in np.linspace(max(rf,rb),ra,14):pts.append(polar(r,mid-half-invp+inv(r)))
        atop=half+invp-inv(ra)
        for a in np.linspace(mid-atop,mid+atop,5)[1:]:pts.append(polar(ra,a))
        for r in np.linspace(ra,max(rf,rb),14)[1:]:pts.append(polar(r,mid+half+invp-inv(r)))
        pts.append(polar(rf,mid+half+invp))
        end=(i+1)*2*math.pi/n+phase-half-invp
        for a in np.linspace(mid+half+invp,end,5)[1:]:pts.append(polar(rf,a))
    return Polygon(pts)
def spoked(poly,outer,inner,spokes=6,width=5,offset=30):
    material=circle(inner) | (circle(150)-circle(outer))
    for k in range(spokes):material|=bar((0,0),polar(outer+1,(k*360/spokes+offset)*D),width)
    return poly.intersection(material)
def hole(m,xy,r,z=0,h=160):return m-cyl(r,z,h,xy)
