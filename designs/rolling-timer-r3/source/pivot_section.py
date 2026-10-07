"""Dimensioned section of the actual exported 32x B-pivot assembly.

Run after build.py. Requires Matplotlib in addition to the CAD dependencies.
"""
from pathlib import Path
import json
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Polygon, Patch
import trimesh

ROOT=Path(__file__).resolve().parents[1]
layout=json.loads((ROOT/'layouts.json').read_text())['32']
items=json.loads((ROOT/'assembly/32x/assembly.json').read_text())
axis=layout['axes']['B']
colors={'B_pivot':'#596e83','15_B_rear_spacer':'#bed0dd',
        '11_B_18_72':'#1e9d8a','B_pivot_bolt':'#89939d','B_pivot_bolt_nut':'#b3bac0'}
fig=plt.figure(figsize=(11,6),facecolor='#f6f4ef')
ax=fig.add_axes([.035,.15,.565,.73],facecolor='#f6f4ef')
for name,col in colors.items():
    item=next(x for x in items if x['name']==name)
    m=trimesh.load(ROOT/'assembly/32x'/item['file'],force='mesh')
    m.apply_translation([6-axis[0],6-axis[1],-78])
    section=m.section(plane_origin=[0,6,0],plane_normal=[0,1,0])
    assert section is not None,name
    for loop in section.discrete:
        ax.add_patch(Polygon(loop[:,[0,2]],closed=True,facecolor=col,edgecolor='#263648',linewidth=.8))
base=layout['pivot_base_height_mm']
def dimension(x,low,high,label):
    ax.annotate('',xy=(x,low),xytext=(x,high),arrowprops={'arrowstyle':'|-|','color':'#2868af','lw':1.3})
    ax.text(x-.8,(low+high)/2,label,rotation=90,ha='right',va='center',fontsize=11,color='#2868af')
dimension(-2.3,0,base,'10.5 mm base')
dimension(14,5.7,base,'4.8 mm cap')
ax.annotate('Solid 8 mm shaft',xy=(6,14.5),xytext=(6,17.3),ha='center',fontsize=11,
            arrowprops={'arrowstyle':'->','color':'#263648'},color='#263648')
ax.set(xlim=(-8,19),ylim=(-.5,18),aspect='equal');ax.axis('off')
fig.text(.05,.935,'The nut stays inside the taller base',fontsize=23,fontweight='bold',color='#243548')
fig.text(.64,.78,'Actual 32:1 assembly section',fontsize=14,fontweight='bold',color='#243548')
fig.text(.64,.705,'Nut pocket entirely below the shaft.\n\n4.8 mm from pocket roof to base top.\n\nBlind bolt bore ends 3.7 mm below\nthe full, solid shaft root.\n\nThe gear runs above its spacer;\nminimum gear-to-nut gap: 6.4 mm.\n\nSame M3x10 screw and M3 nut.',
         fontsize=12,linespacing=1.45,color='#243548',va='top')
fig.legend(handles=[Patch(facecolor=colors['B_pivot'],label='Printed pivot'),
                    Patch(facecolor=colors['15_B_rear_spacer'],label='Spacer'),
                    Patch(facecolor=colors['11_B_18_72'],label='Gear'),
                    Patch(facecolor=colors['B_pivot_bolt_nut'],label='Screw / nut')],
           loc='lower center',bbox_to_anchor=(.5,.08),ncol=4,frameon=False,fontsize=11)
fig.text(.05,.035,'Section through the screw axis; upper shaft and gear cropped. Dimensions in mm. Print both pivot types solid.',
         fontsize=10,color='#5d6c79')
out=ROOT/'renders/pivot-section.png';fig.savefig(out,dpi=160,facecolor=fig.get_facecolor());plt.close(fig)
print(out)
