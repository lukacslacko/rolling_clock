"""Printable, illustrated instructions for the 28-piece lightweight bench kit."""
import json, math, html
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont
from reportlab.pdfgen import canvas
from reportlab.lib.colors import HexColor
from reportlab.lib.utils import ImageReader
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.platypus import Paragraph
from reportlab.lib.styles import ParagraphStyle

ROOT=Path(__file__).resolve().parents[2]
OUT=ROOT/'bench-guide'; RAW=OUT/'renders'
META=json.loads((OUT/'render-metadata.json').read_text())
FONT_PAIRS=[
    (Path('/System/Library/Fonts/Supplemental'),'Arial.ttf','Arial Bold.ttf'),
    (Path('C:/Windows/Fonts'),'arial.ttf','arialbd.ttf'),
    (Path('/usr/share/fonts/truetype/liberation2'),'LiberationSans-Regular.ttf','LiberationSans-Bold.ttf'),
    (Path('/usr/share/fonts/truetype/liberation'),'LiberationSans-Regular.ttf','LiberationSans-Bold.ttf'),
    (Path('/usr/share/fonts/truetype/dejavu'),'DejaVuSans.ttf','DejaVuSans-Bold.ttf'),
]
FONT_FILES=next(((folder/regular,folder/bold) for folder,regular,bold in FONT_PAIRS
                 if (folder/regular).is_file() and (folder/bold).is_file()),None)
if FONT_FILES is None:
    raise RuntimeError('Install Arial, Liberation Sans or DejaVu Sans, or add its directory to FONT_PAIRS.')
for name,file in zip(('Body','Bold'),FONT_FILES):
    pdfmetrics.registerFont(TTFont(name,str(file)))
pdfmetrics.registerFontFamily('Body',normal='Body',bold='Bold')
W,H=841.89,595.28
BG='#F6F4EF';INK='#233345';MUTED='#5C6B78';LINE='#D8DEE1';ACCENT='#2868AF'
COLORS={'frame':'#BAC5CD','pins':'#53677B','shaft':'#2868AF','input':'#EA7830','compound':'#169C89','escape':'#E5B52C','regulator':'#D44859'}
PARTS=json.loads((ROOT/'parts.json').read_text())
by_number={int(n[:2]):n for n in PARTS}
KIT={3:1,4:1,5:1,6:1,7:3,10:1,11:1,12:1,13:1,15:1,16:1,17:1,18:1,19:1,20:1,21:1,22:1,23:2,24:1,25:1,26:1,34:1,35:1,36:1,37:1}
assert len(KIT)==25 and sum(KIT.values())==28
STEPS=[
 dict(n=1,title='Build the rear support',image='01-rear',add={5:1,7:3,13:1,19:1},
  caption='Looking from the gear / pendulum side. B is already printed into frame 05.',
  steps=[
   'Hold rear frame <b>05</b> with its long built-in B pin pointing toward you. The two small bowl screw holes are at the bottom; leave them empty.',
   'Insert short pivot <b>13</b> through hole C and long pivot <b>19</b> through the top hole P, both <b>from behind</b>. Their flat heads stay behind frame 05.',
   'Insert the three posts <b>07</b> into the three small corner holes shown. Their thick shoulders sit against the gear-side face of 05.'
  ],check='Check: 13 is 49 mm overall; 19 is 67 mm. Use all three 47 mm carrier posts. Set front frame 06 aside.',
  special='map'),
 dict(n=2,title='Fit the square shaft and rear sleeve',image='02-shaft',add={3:1,36:1},
  caption='The long round sleeve passes through the rear frame bearing.',
  steps=[
   'Identify the <b>rear end</b> of shaft <b>03</b>: the middle cross-hole is <b>81 mm</b> from it, and 59 mm from the other end. Mark the rear end temporarily.',
   'Slide long round sleeve <b>36</b> onto the square shaft. Feed the sleeved shaft through the large A hole of frame 05 from behind.',
   'Set the front end of sleeve 36 <b>flush with the front face of the raised collar on 05</b>. Hold it there while adding the next parts.'
  ],check='Check: the 66.6 mm sleeve provides the round bearing surface. The bare square shaft should not rub directly in the frame hole.',
  special='shaft'),
 dict(n=3,title='Add the orange input gear',image='input-exploded',add={35:1,10:1,4:1,34:1},
  caption='Exploded detail: parts are spread apart along the shaft. Frame omitted here.',
  steps=[
   'From the front, slide thin washer <b>35</b> onto the square shaft, against the rear collar. This is the very thin <b>0.6 mm</b> washer.',
   'Slide drive gear <b>10</b> on with its <b>taller central hub facing forward</b>. Align its cross-slot with the shaft hole 81 mm from the rear end.',
   'Push crosspin <b>04</b> through the hub and shaft. Then add the larger keyed sleeve <b>34</b> in front of the gear. Its length is <b>19.2 mm</b>.'
  ],check='Check: gear 10 and shaft 03 turn together. The square socket transmits torque; a little tangential play in the retaining pin slot is intentional.',
  stack=[('05','rear collar'),('35','0.6 mm washer'),('10 + 04','gear + pin'),('34','19.2 mm sleeve')]),
 dict(n=4,title='Fit the green compound gear',image='04-compound',add={11:1,15:1},
  caption='The green wheel sits farther forward than the orange wheel.',
  steps=[
   'Slide compound gear <b>11</b> onto the built-in B pivot of rear frame 05.',
   'Point its <b>projecting small pinion toward the rear frame</b>. Its large 72-tooth wheel faces forward. The small pinion meshes with orange gear 10.',
   'Slide spacer <b>15</b>, length <b>11.4 mm</b>, onto the B pivot in front of gear 11.'
  ],check='Check: turn the gears gently while supporting the loose shafts. The large green wheel should clear the orange wheel rather than mesh with it.',
  stack=[('05 / B','integral pivot'),('11','pinion rearward'),('15','11.4 mm spacer')]),
 dict(n=5,title='Fit the yellow escape compound',image='05-escape',add={16:1,12:1,17:1},
  caption='The yellow small pinion engages the large green wheel.',
  steps=[
   'On pivot <b>13</b> at C, slide on rear spacer <b>16</b>, length <b>14.4 mm</b>. It rests against frame 05.',
   'Add escape compound <b>12</b>: its projecting small pinion points <b>rearward</b>, and its large pointed escape wheel faces <b>forward</b>. Turn gently to engage the green wheel.',
   'Add front spacer <b>17</b>, length <b>4.4 mm</b>. Before fitting the anchor, check that both gear meshes turn without a hard spot.'
  ],check='Check: 16 is the long spacer behind the yellow gear; 17 is the short spacer in front. Do not press on the pointed tooth tips.',
  stack=[('05','rear frame'),('16','14.4 mm'),('12','pinion rearward'),('17','4.4 mm')]),
 dict(n=6,title='Place the pallet anchor',image='anchor-detail',add={20:1,18:1},
  caption='Isolated escapement detail. Rear frame and other gears omitted for clarity.',
  steps=[
   'On long top pivot <b>19</b>, slide rear spacer <b>20</b> against frame 05. This narrow spacer is <b>27.4 mm</b> long.',
   'Slide anchor <b>18</b> onto that pivot with its two pallet arms pointing down toward the escape wheel. Its long round sleeve points <b>forward</b>.',
   'Ease the pallets around the upper teeth of wheel 12, rotating the wheel a little if necessary. The pallet faces and escape wheel occupy the <b>same front-to-back plane</b>.'
  ],check='Check: the anchor pivots freely on 19. Preserve the little working faces and tooth tips; do not force the wheel past a locked pallet.',
  stack=[('05','rear frame'),('20','27.4 mm spacer'),('18','arms at wheel'),('sleeve','points forward')]),
 dict(n=7,title='Close the two frames',image='07-front',add={6:1,37:1},
  caption='Front frame and front sleeve are shown pulled forward before seating.',
  steps=[
   'Orient front frame <b>06</b> with its raised main collar and <b>blind B bearing seat facing rearward</b>, toward the gears.',
   'Bring it onto all three posts 07. Guide B\'s built-in pin into its blind seat, C pivot 13 into its hole, and the anchor\'s round sleeve through the large top opening.',
   'Seat the frame gently. Slide short round sleeve <b>37</b> over the front of the square shaft and into the A bearing. Its rear end should be <b>flush with the rear face of the front frame collar</b>.'
  ],check='Check: sleeves 36 and 37 turn with the shaft. Keep a little axial play in the gears. If closure makes anything stiff, reopen and check the spacer order.',
  special='seats'),
 dict(n=8,title='Clamp the pendulum to the anchor',image='clamp-detail',add={24:1},
  caption='Close-up of the anchor sleeve and split pendulum clamp. Rod continues below.',
  steps=[
   'Slide the split clamp of pendulum <b>24</b> over the anchor\'s protruding round sleeve, ahead of front frame 06. The rod points downward.',
   'Place one plain <b>M3 nut</b> in the hexagonal recess of the clamp ear. Insert an <b>M3 x16 screw</b> through the opposite ear and start it into the nut.',
   'Set the front face of the clamp approximately flush with the end of the anchor sleeve. Tighten only enough to hold it provisionally; you will adjust its angle during the test.'
  ],check='Check: the pendulum clamps to the rotating anchor sleeve, not to the stationary 6 mm pivot. Keep the clamp clear of frame 06.',
  special='clamp'),
 dict(n=9,title='Fit the open bob',image='bob-detail',add={25:1,26:1},
  caption='Rear close-up of the bob; its pin is pulled back before insertion.',
  steps=[
   'Slide open bob <b>25</b> onto the bottom of the pendulum rod with its two open pockets facing <b>upward</b>.',
   'Align its hole with the <b>150 mm</b> rod hole: the <b>fourth hole from the pivot</b>, or the <b>second hole from the free end</b>.',
   'Insert bob pin <b>26</b>. Keep the bob empty until the assembled frame is supported upright; then put <b>15-20 g total</b> of iron into its two pockets.'
  ],check='Check: the bob pin passes through the rod and bob. Split the iron approximately evenly between the two pockets; this is the only ballast used in this bench test.',
  special='holes'),
 dict(n=10,title='Support the front of the anchor pivot',image='bridge-exploded',add={21:1,23:2,22:1},
  caption='Exploded close-up: washer, two bridge posts and bridge are pulled forward.',
  steps=[
   'Slide thin washer <b>21</b>, thickness <b>1.4 mm</b>, over the exposed end of pivot 19, just in front of the pendulum clamp and anchor sleeve.',
   'Fit both short bridge posts <b>23</b> into the two small holes beside the top of front frame 06. Each post is <b>23 mm overall</b>.',
   'Fit bridge <b>22</b> onto the posts while guiding pivot 19 into its central hole. Seat all three locations together without bending the pivot.'
  ],check='Check: the anchor pivot is now supported at both ends. The anchor and pendulum must turn freely with slight endplay; the bridge must not squeeze the clamp.',
  stack=[('18 + 24','sleeve + clamp'),('21','1.4 mm washer'),('22','front bridge')]),
]
seen={}
for s in STEPS:
    for num,qty in s['add'].items():seen[num]=seen.get(num,0)+qty
assert seen==KIT,(seen,KIT)

PDF=OUT/'bench-assembly-guide.pdf'
c=canvas.Canvas(str(PDF),pagesize=(W,H));c.setTitle('Lightweight rolling timer - bench assembly guide')
c.setAuthor('Codex - illustrations from the supplied lightweight STL assembly')
page=0
def txt(x,y,t,size=11,color=INK,bold=False):
    c.setFillColor(HexColor(color));c.setFont('Bold' if bold else 'Body',size);c.drawString(x,y,t)
def para(t,x,top,w,size=11.4,leading=15.6,color=INK):
    style=ParagraphStyle('p',fontName='Body',fontSize=size,leading=leading,textColor=HexColor(color))
    p=Paragraph(t,style);_,h=p.wrap(w,800);p.drawOn(c,x,top-h);return top-h
def start(title,kicker):
    global page
    page+=1;c.setFillColor(HexColor(BG));c.rect(0,0,W,H,fill=1,stroke=0)
    txt(32,H-28,kicker.upper(),9,MUTED,True);txt(32,H-61,title,25,INK,True)
    c.setStrokeColor(HexColor(LINE));c.line(32,29,W-32,29)
    txt(32,16,'LIGHT 16:1  |  Bench kit only  |  Numbers match your STL filenames',8,MUTED)
    c.setFont('Body',8);c.drawRightString(W-32,16,str(page)+' / 13')
def end():c.showPage()
def picture(name,x,y,w,h,labels=True):
    im=Image.open(RAW/(name+'.png'));s=min(w/im.width,h/im.height)
    dw,dh=im.width*s,im.height*s;xx=x+(w-dw)/2;yy=y+(h-dh)/2
    c.drawImage(ImageReader(im),xx,yy,dw,dh,mask='auto')
    if labels:
        points=META[name]['labels'];left=[];right=[]
        for label,(px,py) in points.items():(left if px<.5 else right).append((label,px,py))
        for side,items in [('l',left),('r',right)]:
            items.sort(key=lambda a:a[2])
            for i,(label,px,py) in enumerate(items):
                by=y+h*(.20+.60*(i/(len(items)-1) if len(items)>1 else .5))
                bw=max(29,pdfmetrics.stringWidth(label,'Bold',10)+14)
                bx=x+3 if side=='l' else x+w-bw-3
                ax=bx+bw if side=='l' else bx
                tx,ty=xx+px*dw,yy+py*dh
                c.setStrokeColor(HexColor('#748390'));c.setLineWidth(.8);c.line(ax,by,tx,ty)
                c.setFillColor(HexColor(ACCENT));c.circle(tx,ty,2.2,fill=1,stroke=0)
                c.setFillColor(HexColor('#FFFFFF'));c.setStrokeColor(HexColor(LINE));c.roundRect(bx,by-9,bw,19,5,stroke=1,fill=1)
                txt(bx+7,by-3,label,10,INK,True)
    return xx,yy,dw,dh
def band(t,y=48,h=54):
    c.setFillColor(HexColor('#E7EDF0'));c.roundRect(32,y,W-64,h,8,fill=1,stroke=0)
    bottom=para(t,45,y+h-11,W-90,10.5,14)
    assert bottom>=y+5,(page,bottom)
def stack(items,y=112):
    txt(35,y+31,'REAR  >  FRONT',8.2,MUTED,True)
    x=150;available=W-184;gap=13;w=(available-gap*(len(items)-1))/len(items)
    for i,(n,desc) in enumerate(items):
        c.setFillColor(HexColor('#FFFFFF'));c.setStrokeColor(HexColor(LINE));c.roundRect(x,y,w,43,5,fill=1,stroke=1)
        txt(x+8,y+27,n,11,ACCENT,True);txt(x+8,y+11,desc,8.7,MUTED)
        if i<len(items)-1:txt(x+w+3,y+16,'>',10,MUTED,True)
        x+=w+gap
def small_note(title,body):
    txt(35,145,title,9,ACCENT,True);para(body,35,133,770,10.2,13.2)
def shaft_diagram():
    x=194;y=128;s=3.9
    c.setFillColor(HexColor('#BBD0E5'));c.rect(x,y-5,140*s,10,fill=1,stroke=0)
    for mm in [5,81,135]:
        c.setFillColor(HexColor(INK));c.circle(x+mm*s,y,3,fill=1,stroke=0)
        txt(x+mm*s-12,y+18,str(mm)+' mm',9,INK,True)
    txt(35,y+11,'SHAFT 03',9,ACCENT,True);txt(35,y-4,'140 mm overall',9,MUTED)
    txt(x-6,y-24,'REAR END',8,MUTED,True);txt(x+140*s-46,y-24,'FRONT END',8,MUTED,True)
def hole_diagram():
    x=247;y=132;c.setStrokeColor(HexColor('#D44859'));c.setLineWidth(8);c.line(x-140,y,x+350,y)
    for i,mm in enumerate([135,140,145,150,155]):
        xx=x+i*72;c.setFillColor(HexColor('#FFFFFF'));c.circle(xx,y,4,fill=1,stroke=0)
        txt(xx-14,y+16,str(mm),9,INK,mm==150)
        if mm==150:c.setStrokeColor(HexColor(ACCENT));c.setLineWidth(1.3);c.circle(xx,y,10,fill=0,stroke=1)
    txt(40,y-4,'PIVOT SIDE',9,MUTED,True);txt(682,y-4,'FREE END',9,MUTED,True)
    txt(242,y-25,'135, 140, 145, 150, 155 mm from pivot (diagram spacing enlarged)',9,MUTED)

start('Assemble your printed bench mechanism','Illustrated workshop guide / lightweight 16:1')
picture('complete',25,115,475,394,False)
txt(529,490,'YOUR TWO PRINT BATCHES',11,ACCENT,True)
y=para('This guide uses exactly the <b>28 printed pieces</b> from the <b>25 STL files</b> in your two batches, plus one M3 x16 screw and one M3 nut.',529,474,274,12,16.5)
y=para('The result is a supported bench mechanism: gear train, escapement and pendulum. You supply a gentle turning force by hand for this first test.',529,y-12,274,11.5,15.6)
y=para('<b>Front</b> means the pendulum side, facing you in these pictures. <b>Rear</b> means the side with the heads of pivots 13 and 19.',529,y-13,274,11.5,15.6)
for color,label in [('frame','Frames, posts and bridge'),('input','10 - orange input wheel'),('compound','11 - green compound'),('escape','12 - yellow escape wheel'),('regulator','18 / 24 / 25 - regulator'),('pins','Printed pins and spacers')]:
    y-=26;c.setFillColor(HexColor(COLORS[color]));c.roundRect(529,y-1,12,12,3,fill=1,stroke=0);txt(549,y,label,10.7)
band('Before assembly: remove brims and obvious seam burrs. Try shafts in their bores by hand. Clean tight shaft surfaces gently; preserve gear teeth and pallet working faces. Keep the bob empty until the mechanism is upright.',48,64)
end()

for s in STEPS:
    start(s['title'],f'Step {s["n"]:02d} / 10 assembly steps')
    # One spacious CAD view and a short action column.
    picture(s['image'],26,179,481,322)
    para(s['caption'],38,176,462,9.5,12.2,MUTED)
    txt(532,495,'PARTS TO ADD NOW',9,ACCENT,True)
    y=479
    for num,qty in s['add'].items():
        filename=by_number[num]+'.stl'
        txt(532,y,filename+('  x'+str(qty) if qty>1 else ''),9.8,INK,True);y-=14
    if s['n']==8:txt(532,y,'+ M3 x16 screw and plain M3 nut',9.8,INK,True);y-=14
    y-=10
    for i,body in enumerate(s['steps'],1):
        y=para(f'<b>{i}.</b> '+body,532,y,276,11.1,15.1)-12
    assert y>=166,(s['n'],y)
    if 'stack' in s:stack(s['stack'])
    elif s.get('special')=='shaft':shaft_diagram()
    elif s.get('special')=='holes':hole_diagram()
    elif s.get('special')=='map':small_note('FOUR WORKING AXES','A: large main bearing. B: built-in gear pin. C: escape-wheel pivot 13. P: top anchor pivot 19. The three separate corner holes take posts 07; none goes into a bowl screw hole.')
    elif s.get('special')=='seats':small_note('SEAT THE FRAME EVENLY','Posts locate the two frames. If a joint is loose during the bench test, a small removable tape wrap around the fixed joint can hold it; keep tape away from teeth and rotating surfaces. Do not glue the assembly yet.')
    elif s.get('special')=='clamp':small_note('LEAVE ACCESS FOR BEAT ADJUSTMENT','The angle between anchor and pendulum is adjustable. Tightening the clamp makes them move together; it must not pinch the stationary pivot. The illustrated screw and nut are unthreaded visual envelopes.')
    band(s['check'])
    end()

start('Support it, then try the escapement','First bench test / after all ten assembly steps')
xx,yy,dw,dh=picture('test-front',27,157,455,346,False)
ap=META['test-front']['labels']['A'];cx=xx+ap[0]*dw;cy=yy+ap[1]*dh
# Arrow is counterclockwise as viewed from the pendulum/front side.
r=45;a0=math.radians(20);a1=math.radians(295)
path=c.beginPath()
for i in range(61):
    a=a0+(a1-a0)*i/60;x=cx+r*math.cos(a);y=cy+r*math.sin(a)
    (path.moveTo if i==0 else path.lineTo)(x,y)
c.setStrokeColor(HexColor(ACCENT));c.setLineWidth(2);c.drawPath(path)
endx,endy=cx+r*math.cos(a1),cy+r*math.sin(a1)
dx,dy=-math.sin(a1),math.cos(a1)
p=c.beginPath();p.moveTo(endx,endy);p.lineTo(endx-10*dx+4*dy,endy-10*dy-4*dx);p.lineTo(endx-10*dx-4*dy,endy-10*dy+4*dx);p.close()
c.setFillColor(HexColor(ACCENT));c.drawPath(p,fill=1,stroke=0)
txt(43,155,'VIEWED FROM THE PENDULUM SIDE',9,ACCENT,True)
para('Orange and yellow turn counterclockwise; green turns clockwise. This corrects the earlier clockwise instruction for this front view.',43,142,424,10.4,14)
test_steps=[
 'Support the <b>fixed frame upright</b> with a padded clamp or blocks, leaving the pendulum and both gear faces free. Avoid squeezing the bearing areas.',
 'Without drum wheels, sleeves <b>36 and 37 can slide outward</b>. Keep them seated. Small removable tape collars on the exposed shaft just outside their outer ends can retain them; keep tape away from the frame bearings.',
 'Add <b>15-20 g</b> to the bob. Apply very light <b>counterclockwise torque to orange gear 10</b>, viewed from the pendulum side. Move the pendulum gently, initially about 5 degrees each side.',
 'Look for <b>release, then a definite stop on the opposite pallet</b> on each half-swing. Adjust the pendulum clamp angle until release occurs at similar excursions either side of vertical; retighten lightly.'
]
y=496
for i,t in enumerate(test_steps,1):y=para(f'<b>{i}.</b> '+t,513,y,294,11,14.7)-12
assert y>=115,y
band('Pass: alternating catches without tooth skipping, scraping or a tight spot. If it binds or skips, stop and inspect the fit and pallet contact before adding force. This hand-driven check does not yet establish self-running performance.',48,57)
end()

start('Keep these small parts straight','Quick reference / lengths, locations and troubleshooting')
txt(33,493,'SPACERS AND SLEEVES',11,ACCENT,True)
rows=[
 ('15','11.4 mm','In front of green gear 11'),
 ('16','14.4 mm','Behind yellow gear 12'),
 ('17','4.4 mm','In front of yellow gear 12'),
 ('20','27.4 mm','Behind anchor 18'),
 ('21','1.4 mm','Before the anchor bridge 22'),
 ('34','19.2 mm','In front of orange gear 10'),
 ('35','0.6 mm','Behind orange gear 10'),
 ('36','66.6 mm','Long round sleeve; rear A bearing'),
 ('37','23.6 mm','Short round sleeve; front A bearing'),
]
y=470
for i,(num,length,loc) in enumerate(rows):
    if i%2==0:c.setFillColor(HexColor('#FFFFFF'));c.roundRect(32,y-17,442,25,3,fill=1,stroke=0)
    txt(42,y-8,num,10.6,INK,True);txt(86,y-8,length,10.3);txt(171,y-8,loc,10.1,MUTED);y-=27
txt(33,197,'PINS, POSTS AND PIVOTS',11,ACCENT,True)
others=[('07','3 copies','47 mm overall; joins frames'),('13','1 copy','49 mm overall; escape pivot'),('19','1 copy','67 mm overall; anchor pivot'),('23','2 copies','23 mm overall; bridge supports'),('04 / 26','1 each','Main gear retainer / bob retainer')]
y=173
for num,qty,loc in others:
    txt(42,y,num,10.3,INK,True);txt(97,y,qty,10.1);txt(171,y,loc,10.1,MUTED);y-=22
txt(509,493,'IF SOMETHING DOES NOT FIT',11,ACCENT,True)
y=471
for title,body in [
 ('Frame will not close','Check the three posts, the blind B seat and both pivot tips. Back off and align them together; do not use the front plate to bend a pin into place.'),
 ('Gears stiff after closure','Check spacer lengths, shaft seams and remaining endplay. The front frame should not clamp a gear between two thrust faces.'),
 ('Anchor does not swing freely','Check spacer 20, washer 21, bridge seating and clamp position. Nothing rotating should be trapped against a fixed frame or bridge.'),
 ('Teeth pass without a firm catch','Confirm that the wheel and pallets are in the same plane, then adjust the beat. If catches remain marginal or skip, keep the tooth tips intact and record a close-up.'),
 ('It stops when you release the gear','Expected for this bench setup: the rolling drum and its drive are not fitted. Keep very light hand torque while assessing the escapement.')]:
    y=para('<b>'+title+'</b><br/>'+body,509,y,297,10.8,14.5)-12
assert y>=51,y
end();c.save()

# A browser-friendly companion contains the same instructions and CAD figures.
def plain(t):return t.replace('<b>','<strong>').replace('</b>','</strong>')
cards=[]
for s in STEPS:
    partlist=''.join(f'<li><code>{by_number[n]}.stl</code>'+(' x'+str(q) if q>1 else '')+'</li>' for n,q in s['add'].items())
    special=''
    if 'stack' in s:special='<p class="stack">Rear to front: '+' &rarr; '.join('<b>'+n+'</b> '+d for n,d in s['stack'])+'</p>'
    if s.get('special')=='shaft':special='<p class="stack">Shaft holes from rear end: 5 mm, <b>81 mm</b>, 135 mm. Overall length: 140 mm.</p>'
    if s.get('special')=='holes':special='<p class="stack">Holes from pivot: 135, 140, 145, <b>150</b>, 155 mm. Use the second hole from the free end.</p>'
    cards.append(f'<section><h2>{s["n"]:02d}. {s["title"]}</h2><div class="grid"><figure><img src="renders/{s["image"]}.png"><figcaption>{s["caption"]}</figcaption></figure><div><ul class="parts">{partlist}</ul><ol>'+''.join('<li>'+plain(t)+'</li>' for t in s['steps'])+'</ol></div></div>'+special+'<p class="check">'+s['check']+'</p></section>')
htmlout='''<!doctype html><html lang="en"><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Lightweight timer - bench assembly</title><style>
body{margin:0;background:#f6f4ef;color:#233345;font:17px/1.55 system-ui,sans-serif}main{max-width:1150px;margin:auto;padding:30px}h1{font-size:36px;line-height:1.15}h2{font-size:27px}section{border-top:1px solid #d8dee1;padding:24px 0;margin-top:30px}.grid{display:grid;grid-template-columns:1.05fr 1fr;gap:30px}figure{margin:0}img{width:100%;display:block}figcaption{font-size:14px;color:#5c6b78}li{margin:10px 0}.parts{font-size:14px;padding:15px 25px;background:white;border-radius:8px}.check,.stack{padding:15px;background:#e7edf0;border-radius:8px}a{color:#2868af}code{overflow-wrap:anywhere}strong{font-weight:700}@media(max-width:760px){.grid{grid-template-columns:1fr}main{padding:18px}}@media print{section{break-before:page}a{color:inherit}}
</style><main><p>LIGHT 16:1 / YOUR PRINTED BENCH KIT</p><h1>Assemble the gear train, escapement and pendulum</h1><p>28 printed pieces from 25 STL files, one M3 x16 screw and one M3 nut. <a href="bench-assembly-guide.pdf">Download the illustrated PDF</a> for numbered callouts, diagrams and the spacer reference.</p><p><b>Front</b> is the pendulum side. <b>Rear</b> is the side with the heads of pivots 13 and 19. Remove brims and obvious shaft burrs; preserve tooth tips and pallet faces.</p>'''+''.join(cards)
htmlout+='<section><h2>11. Support and test</h2><div class="grid"><img src="renders/test-front.png"><ol>'+''.join('<li>'+plain(t)+'</li>' for t in test_steps)+'</ol></div><p class="check">From the pendulum side: orange and yellow turn counterclockwise, green clockwise. This corrects the earlier clockwise instruction for this front view. Stop if it binds or skips; inspect before adding force.</p></section></main></html>'
(OUT/'index.html').write_text(htmlout)
# A useful delivery preview: all ten assembly stages on one image.
thumb=Image.new('RGB',(1800,2220),BG);d=ImageDraw.Draw(thumb)
font=lambda n,b=False:ImageFont.truetype(str(FONT_FILES[int(b)]),n)
d.text((55,35),'Your bench mechanism: ten assembly steps',font=font(47,True),fill=INK)
d.text((58,103),'Lightweight 16:1 kit | Follow the PDF for spacer order and close-ups',font=font(25),fill=MUTED)
for i,s in enumerate(STEPS):
    x=40+(i%2)*890;y=164+(i//2)*404
    d.rounded_rectangle((x,y,x+850,y+380),radius=16,fill='#FFFFFF',outline=LINE,width=2)
    d.text((x+19,y+14),f'{s["n"]:02d}  '+s['title'],font=font(25,True),fill=INK)
    im=Image.open(RAW/(s['image']+'.png')).convert('RGBA');im.thumbnail((820,307),Image.Resampling.LANCZOS)
    thumb.paste(im,(x+(850-im.width)//2,y+60+(307-im.height)//2),im)
d.text((55,2190),'Bench assembly only. Apply light hand torque for the first escapement test.',font=font(22),fill=MUTED)
thumb.save(OUT/'assembly-overview.png')
print('Created',PDF,'with',page,'pages')
assert page==13
