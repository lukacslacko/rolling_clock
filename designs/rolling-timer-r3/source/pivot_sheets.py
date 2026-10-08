"""Per-ratio spacer and wheel direction diagrams, using projected CAD outlines.

Axial coordinates preserve assembly positions; diameters are compressed to make
four separate pivot rows readable. These sheets are explicitly not 1:1 templates.
"""
import json
from reportlab.lib.colors import HexColor

W, H = 841.89, 595.28
INK, MUTED, BLUE = '#243548', '#5D6C79', '#2868AF'
COL = {'B':'#48B79F', 'D':'#AF91CC', 'C':'#EDC55C', 'P':'#E78196', 'A':'#ED9B5A'}


def draw_pivot_sheet(c, root, ratio, page_number, total_pages):
    ratio = str(ratio)
    data = json.loads((root/'pivot-reference.json').read_text())[ratio]
    layouts = json.loads((root/'layouts.json').read_text())
    x = lambda z: 236+(z-72)*5.1
    radial_scale = .65

    def text(px, py, value, size=10, bold=False, color=INK, align='left'):
        c.setFillColor(HexColor(color)); c.setFont('Bold' if bold else 'Body',size)
        getattr(c, {'left':'drawString','right':'drawRightString','center':'drawCentredString'}[align])(px,py,value)

    def line(points, color=MUTED, width=.65, dash=()):
        c.setStrokeColor(HexColor(color)); c.setLineWidth(width); c.setDash(dash)
        p=c.beginPath(); p.moveTo(*points[0])
        for point in points[1:]:p.lineTo(*point)
        c.drawPath(p); c.setDash()

    def rect(px,py,w,h,fill,stroke=INK):
        c.setFillColor(HexColor(fill)); c.setStrokeColor(HexColor(stroke)); c.setLineWidth(.6)
        c.rect(px,py,w,h,stroke=1,fill=1)

    def shape(part,cy,color):
        p=c.beginPath()
        for ring in [part['outline']]+part['holes']:
            p.moveTo(x(ring[0][0]),cy-ring[0][1]*radial_scale)
            for z,y in ring[1:]:p.lineTo(x(z),cy-y*radial_scale)
            p.close()
        c.setFillColor(HexColor(color));c.setStrokeColor(HexColor(INK));c.setLineWidth(.65)
        c.drawPath(p,fill=1,stroke=1,fillMode=0)

    def spacer_label(part,cy):
        mid=x(sum(part['z'])/2)
        label=f"{part['name'][:2]} / {part['length_mm']:g} mm"
        text(mid,cy+34,label,10,True,align='center')
        line([(mid,cy+28),(mid,cy+4.3)],INK,.6)

    def frame(cy,anchor=False):
        # Local sectional symbols, not a projection of the entire carrier frame.
        rect(x(72),cy-17,6*5.1,34,'#ECF0F2','#9DABB6')
        bore=(6.2 if anchor else 4.2)*radial_scale
        if anchor:
            for sign in (-1,1):
                yy=cy+bore if sign==1 else cy-17
                rect(x(132),yy,6*5.1,17-bore,'#ECF0F2','#9DABB6')
        else:
            rect(x(132),cy-17,6*5.1,34,'#ECF0F2','#9DABB6')
            rect(x(132),cy-bore,3*5.1,2*bore,'#FFFFFF','#9DABB6')
        text(x(75),cy-28,'05',9,True,MUTED,'center')
        text(x(135),cy-28 if not anchor else cy+25,'06',9,True,MUTED,'center')
        if anchor:
            rect(x(165),cy-17,6*5.1,34,'#ECF0F2','#9DABB6')
            rect(x(165),cy-4.2*radial_scale,3*5.1,8.4*radial_scale,'#FFFFFF','#9DABB6')
            text(x(168),cy-28,'22',9,True,MUTED,'center')

    c.setFillColor(HexColor('#FFFFFF'));c.rect(0,0,W,H,fill=1,stroke=0)
    text(32,H-27,'05 / RATIO-SPECIFIC ASSEMBLY REFERENCE',9,True,MUTED)
    text(32,H-64,f'{ratio}:1 - spacer order and wheel orientation',24,True)
    text(32,500,'Side diagrams show the assembled order. Axial positions come from CAD; diameters are compressed. Not 1:1.',10)
    text(236,478,'REAR / ballast bowl side',10,True,BLUE)
    text(809,478,'FRONT / pendulum side',10,True,BLUE,'right')
    line([(400,481),(604,481)],BLUE)
    line([(598,484),(604,481),(598,478)],BLUE)

    # Pivot locator, looking from the pendulum side. Unused seats are crossed out.
    text(32,476,'PIVOT MAP',10,True,BLUE)
    text(32,460,'Seen from the front',9,color=MUTED)
    points={'A':layouts['16']['axes']['A'],'B16':layouts['16']['axes']['B'],
            'Bslow':layouts['32']['axes']['B'],'D':layouts['32']['axes']['D'],
            'C':layouts['16']['axes']['C'],'P':layouts['16']['axes']['P']}
    xy=lambda v:(106-v[0]*1.1,339-v[1]*1.1)
    chain=['A','B16','C'] if ratio=='16' else ['A','Bslow','D','C']
    active=chain+['P']
    for a,b in zip(chain,chain[1:]):line([xy(points[a]),xy(points[b])],'#AABAC5',1.5)
    line([xy(points['C']),xy(points['P'])],'#E78196',1.3)
    offsets={'A':(-4,-19),'B16':(-14,8),'Bslow':(-34,-18),'D':(5,6),'C':(-16,7),'P':(-4,10)}
    for label,point in points.items():
        px,py=xy(point);chosen=label in active
        c.setFillColor(HexColor(COL.get(label[0],'#CCD3D8') if chosen else '#EEF1F3'))
        c.setStrokeColor(HexColor(INK if chosen else '#CCD3D8'));c.circle(px,py,4,fill=1,stroke=1)
        if not chosen:line([(px-5,py-5),(px+5,py+5)],'#A5AFB7')
        dx,dy=offsets[label];text(px+dx,py+dy,label,9,chosen,INK if chosen else '#A5AFB7')
    left_notes=[(312,'B uses B16.' if ratio=='16' else 'B uses Bslow.',9,True),
        (295,f'Gear files: STL/{ratio}x/',10,True),
        (280,'Spacer label: part / length.',9,False),
        (258,'Anchor file:',9,True),
        (244,'STL/16x/' if ratio=='16' else 'STL/slow-common/',9,False),
        (230,'18_anchor_forward.stl' if ratio=='16' else '18_anchor_reversed.stl',8.5,True),
        (207,'Pinions always face REAR.',9,True),
        (193,'Anchor sleeve faces FRONT.',9,False),
        (167,'13 = short gear pivot',9,False),
        (153,'19 = long anchor pivot',9,False),
        (128,'Rear spacers sit against the',9,False),
        (114,'pivot foot, ahead of frame 05.',9,False)]
    for py,value,size,bold in left_notes:text(32,py,value,size,bold)

    ys=[428,296,151] if ratio=='16' else [428,334,240,146]
    for row,cy in zip(data['rows'],ys):
        axis=row['axis'];pivot,rear,wheel,front=row['parts'];anchor=axis=='P'
        line([(200,cy-49),(810,cy-49)],'#E5E9EC',.55)
        c.setFillColor(HexColor(COL[axis]));c.circle(211,cy,12,fill=1,stroke=0)
        text(211,cy-4,axis,12,True,align='center')
        frame(cy,anchor)
        shape(pivot,cy,'#BDCCD9')
        shape(rear,cy,'#DFE7EE')
        shape(wheel,cy,COL[axis])
        shape(front,cy,'#DFE7EE')
        line([(x(78),cy),(x(167.5 if anchor else 134.5),cy)],'#5B7795',.55,(4,2))
        text(x(83),cy-21,'19 foot' if anchor else '13 foot',8,color=MUTED,align='center')
        spacer_label(rear,cy);spacer_label(front,cy)
        if not anchor:
            # Number sits on the broad wheel face; rear pinion extends to its left.
            large_start=102 if axis=='B' else 114 if axis=='D' else 123
            wheel_x=x((large_start+wheel['z'][1])/2)
            text(wheel_x,cy+12,wheel['name'][:2],9,True,align='center')
            teeth=18 if axis!='C' or ratio!='32' else 30
            front_teeth=72 if axis=='B' else (60 if ratio=='32' else 72) if axis=='D' else 30
            text(593,cy+22,wheel['name']+'.stl',10,True)
            text(593,cy+6,f'{teeth}T pinion toward REAR',10,color=INK)
            text(593,cy-10,f'{front_teeth}T '+('escape teeth' if axis=='C' else 'wheel')+' toward FRONT',10,color=INK)
            order=f"{rear['name'][:2]} ({rear['length_mm']:g})  >  {wheel['name'][:2]}  >  {front['name'][:2]} ({front['length_mm']:g})  >  front frame 06"
            text(326,cy-42,order,9,color=BLUE)
        else:
            # Pendulum 24 clamps AROUND the forward end of the anchor sleeve.
            c.setStrokeColor(HexColor('#AB405B'));c.setLineWidth(1.4)
            c.rect(x(151),cy-10,6*5.1,20,fill=0,stroke=1)
            text(x(154),cy+25,'24',9,True,'#AB405B','center')
            text(x(125),cy+25,'18',9,True,'#AB405B','center')
            text(x(144),cy-23,'long sleeve',9,False,'#AB405B','center')
            text(756,cy+8,'Bridge',9,color=MUTED)
            text(756,cy-6,'22',10,True)
            text(326,cy-42,'20 (34.2)  >  18 [sleeve forward]  >  21 (7.7)  >  bridge 22',9,color=BLUE)

    c.setFillColor(HexColor('#EDF3F7'));c.roundRect(32,39,778,53,6,fill=1,stroke=0)
    text(43,77,'P: sleeve 18 passes through frame 06; clamp 24 surrounds its front end. Spacer 21 goes beyond both.',10,True)
    text(43,62,'One of each spacer shown. Use common/ for 20 and 21. Main axle A and its sleeves: guide page 6 / AXLE-1-TO-1.pdf.',9)
    text(43,47,'Corrected 54 mm frame posts. Nominal gear endplay: 0.6 mm total. Do not squeeze rotating parts between fixed faces.',9)
    line([(32,29),(810,29)],'#D7DFE3')
    text(32,16,f'ROLLING CLOCK R3  |  {ratio}:1 PIVOT STACKS  |  NUMBERS = STL FILE PREFIXES',8,color=MUTED)
    text(810,16,f'{page_number} / {total_pages}',8,color=MUTED,align='right')
