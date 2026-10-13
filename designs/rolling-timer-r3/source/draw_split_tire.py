"""CAD-derived part outlines and an enlarged axial mounting section."""
import os
os.environ.setdefault('MPLCONFIGDIR','/tmp/rolling-clock-mpl')
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle, Circle, PathPatch
from matplotlib.path import Path as MplPath
from shapely.geometry import Polygon
from shapely.ops import unary_union
import trimesh
from split_tire import OUT,CENTERS
from primitives import circle,extr,mesh

GOLD='#e6ae39';TEAL='#168a9c';GREY='#8994a3';INK='#183449'

def main():
    fig=plt.figure(figsize=(13,10),facecolor='#f6f8fa')
    gs=fig.add_gridspec(2,2,height_ratios=[1.2,1],hspace=.15,wspace=.05)
    tire=circle(124,quad_segs=256)-circle(111,quad_segs=256)
    for q in CENTERS:tire-=circle(1.7,q,quad_segs=32)
    def plan_axis(slot,title):
        a=fig.add_subplot(slot);a.set_aspect('equal');a.set(xlim=(-133,133),ylim=(-133,133));a.axis('off')
        a.set_title(title,fontsize=15,color=INK,pad=8);return a
    a=plan_axis(gs[0,0],'1  Tire · handcrafted G-code')
    a.add_patch(Circle((0,0),124,facecolor=GOLD,edgecolor=INK,lw=.8))
    a.add_patch(Circle((0,0),111,facecolor='#f6f8fa',edgecolor=INK,lw=.8))
    for q in CENTERS:a.add_patch(Circle(q,1.7,facecolor='#f6f8fa',edgecolor=INK,lw=.6))
    a.text(.5,-.05,'Ø248 / Ø222 × 4 mm · six Ø3.4 holes\nPrint two tires, one job at a time',transform=a.transAxes,ha='center',fontsize=11,color=INK)
    m=trimesh.load(OUT/'STL/01_case_spider_for_4mm_tire.stl');m.apply_translation((-121.1,-121.1,0))
    a=plan_axis(gs[0,1],'2  Spoke frame · slice the STL normally')
    projected=unary_union([Polygon(t[:,:2]) for t in m.triangles if Polygon(t[:,:2]).area>1e-8])
    for poly in getattr(projected,'geoms',[projected]):
        verts=[];codes=[]
        for ring in [poly.exterior,*poly.interiors]:
            xy=np.asarray(ring.coords);verts.extend(xy);codes.extend([MplPath.MOVETO]+[MplPath.LINETO]*(len(xy)-2)+[MplPath.CLOSEPOLY])
        a.add_patch(PathPatch(MplPath(verts,codes),facecolor=TEAL,edgecolor=INK,lw=.7))
    for q in CENTERS:
        a.add_patch(Circle(q,1.7,facecolor='#f6f8fa',edgecolor=INK,lw=.6))
    a.text(.5,-.05,'Inside view · original hub and post lips retained\nSupport the underside of all six raised outer pads',transform=a.transAxes,ha='center',fontsize=11,color=INK)
    a=fig.add_subplot(gs[1,:]);a.set_xlim(-5,23);a.set_ylim(-12,12);a.set_aspect('equal');a.axis('off')
    a.set_title('3  Mounting section through one screw · enlarged',fontsize=15,color=INK,pad=8)
    def rect(x,y,w,h,c):a.add_patch(Rectangle((x,y),w,h,facecolor=c,edgecolor=INK,lw=.7))
    # x is the original axial z coordinate; y is local radial position.
    # Void shown through the 3.4 mm tire/pad holes and existing post bore.
    for y,h in [(-3,1.3),(1.7,8.3)]:rect(0,y,4,h,GOLD)
    for y,h in [(-6.9,5.2),(1.7,5.2)]:rect(4,y,3,h,TEAL)
    for y,h in [(-6.9,.7),(6.2,.7)]:rect(7,y,1.5,h,TEAL)
    for y,h in [(-5,3.3),(1.7,3.3)]:rect(7,y,15,h,GREY)
    rect(0,-1.5,16,3,'#bec6ce');rect(-3.2,-2.75,3.2,5.5,'#657181')
    for y,h in [(-2.8,1.3),(1.5,1.3)]:rect(12.5,y,2.4,h,'#475567')
    # Existing nut pocket is schematic; outer surfaces/stack distances are exact.
    a.text(-4.7,8.7,'Outside\nof drum',ha='left',va='top',color=INK,fontsize=10)
    a.text(24,11.5,'Inside\nof drum',ha='right',va='top',color=INK,fontsize=10)
    for x,w,label,c in [(0,4,'4 mm tire',GOLD),(4,3,'3 mm pad',TEAL),(7,15,'Existing case post',GREY)]:
        y=-8 if x!=4 else -10
        a.annotate('',(x,y),(x+w,y),arrowprops={'arrowstyle':'<->','color':INK})
        a.text(x+w/2,y-.6,label,ha='center',va='top',fontsize=9,color=INK)
    a.annotate('Same M3×16 screw',xy=(8,0),xytext=(22,-6.6),ha='right',fontsize=10,color=INK,arrowprops={'arrowstyle':'-','color':INK})
    a.annotate('Existing captive nut',xy=(13.7,2.5),xytext=(18,7.5),ha='right',fontsize=10,color=INK,arrowprops={'arrowstyle':'-','color':INK})
    fig.suptitle('Split rolling wheel · same 7 mm mounting stack',fontsize=23,fontweight='bold',color=INK,y=.975)
    fig.text(.5,.025,'Fit tire around spoke ends, align all six holes, then tighten opposite screw pairs gently.\nBed face of tire points outward; square post lips face inward. Pilot has 0.10 mm radial clearance.',ha='center',fontsize=12,color=INK)
    fig.subplots_adjust(left=.045,right=.955,top=.9,bottom=.09)
    fig.savefig(OUT/'assembly.png',dpi=170);plt.close(fig)

if __name__=='__main__':main()
