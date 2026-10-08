"""Build the R3 illustrated PDF and browser guide from the exact CAD renders."""
from pathlib import Path
import json, math, html
from reportlab.pdfgen import canvas
from reportlab.lib.colors import HexColor
from reportlab.lib.utils import ImageReader
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.platypus import Paragraph
from reportlab.lib.styles import ParagraphStyle
from PIL import Image
from axle_template import draw_axle_template
ROOT=Path(__file__).resolve().parents[1];RAW=ROOT/'renders'
LAY=json.loads((ROOT/'layouts.json').read_text());META=json.loads((RAW/'render-metadata.json').read_text())
PARTS=json.loads((ROOT/'parts.json').read_text())
for ratio,layout in LAY.items():
    rows=[f'# R3 print list - {ratio}:1','',f'One complete {ratio}:1 clock. Keep the folder names: identically numbered gear files differ between ratios. Dimensions are millimetres. See BUILD-GUIDE.pdf.','',f'Hardware: **{layout["M3x10"]} M3x10**, **{layout["M3x16"]} M3x16**, **{layout["M3x10"]+layout["M3x16"]} plain M3 nuts**. Fit coupons are optional extras.','','| File | Qty | Print envelope | Orientation / note |','|---|---:|---|---|']
    for key,n in sorted(layout['print_quantities'].items(),key=lambda x:(0 if x[0].startswith('common/') else 1,x[0])):
        p=PARTS[key];dims=' x '.join(f'{v:g}' for v in p['dimensions_mm'])
        rows.append(f'| [{key}.stl]({p["file"]}) | {n} | {dims} | {p["print_note"]} |')
    rows+=['','## Fit coupons first','','- [5.60 mm nut-post coupon - selected production fit](STL/fit-tests/40_nut_post_coupon_560.stl)','- [Matching frame-seat coupon](STL/fit-tests/41_post_seat_coupon.stl)','- Alternative nut seats: [5.25 mm](STL/fit-tests/40_nut_post_coupon_525.stl), [5.40 mm](STL/fit-tests/40_nut_post_coupon_540.stl). All insertion channels are 5.8 mm.','','Print at 100% scale in the exported orientation. Do not rescale complete gears to change a fit. All parts must be R3.']
    (ROOT/f'PRINT-LIST-{ratio}x.md').write_text('\n'.join(rows)+'\n')
FONT_PAIRS=[(Path('/System/Library/Fonts/Supplemental'),'Arial.ttf','Arial Bold.ttf'),(Path('C:/Windows/Fonts'),'arial.ttf','arialbd.ttf'),(Path('/usr/share/fonts/truetype/liberation2'),'LiberationSans-Regular.ttf','LiberationSans-Bold.ttf'),(Path('/usr/share/fonts/truetype/dejavu'),'DejaVuSans.ttf','DejaVuSans-Bold.ttf')]
fonts=next(((d/a,d/b) for d,a,b in FONT_PAIRS if (d/a).exists() and (d/b).exists()),None)
if not fonts:raise RuntimeError('Install Arial, Liberation Sans or DejaVu Sans; add its folder to FONT_PAIRS if needed.')
for key,p in zip(('Body','Bold'),fonts):pdfmetrics.registerFont(TTFont(key,str(p)))
pdfmetrics.registerFontFamily('Body',normal='Body',bold='Bold')
W,H=841.89,595.28;INK='#243548';MUTED='#5D6C79';BG='#F6F4EF';LINE='#D7DFE3';BLUE='#2868AF';RED='#CC435C'
PAGE_COUNT=14
c=canvas.Canvas(str(ROOT/'BUILD-GUIDE.pdf'),pagesize=(W,H));c.setTitle('Rolling clock R3 - bolted assembly guide');c.setAuthor('László Lukács - CAD illustrations and guide created with OpenAI Codex')
c.setViewerPreference('PrintScaling','None')
page=0

def text(x,y,s,size=11,color=INK,bold=False):
    c.setFillColor(HexColor(color));c.setFont('Bold' if bold else 'Body',size);c.drawString(x,y,s)
def para(s,x,top,w,size=12,leading=17):
    style=ParagraphStyle('p',fontName='Body',fontSize=size,leading=leading,textColor=HexColor(INK))
    p=Paragraph(s,style);_,h=p.wrap(w,1000);p.drawOn(c,x,top-h);return top-h
def heading(title,kicker):
    global page
    page+=1;c.setFillColor(HexColor(BG));c.rect(0,0,W,H,fill=1,stroke=0)
    text(32,H-27,kicker.upper(),9,MUTED,True);text(32,H-64,title,26,INK,True)
    c.setStrokeColor(HexColor(LINE));c.line(32,29,W-32,29)
    text(32,16,'ROLLING CLOCK R3  |  248 mm drum  |  PLA / 0.4 mm nozzle / 0.2 mm layers',8,MUTED)
    c.setFont('Body',8);c.drawRightString(W-32,16,f'{page} / {PAGE_COUNT}')
def picture(name,x,y,w,h,labels=False):
    im=Image.open(RAW/(name+'.png'));ow,oh=im.size
    bounds=im.getchannel('A').getbbox() if im.mode=='RGBA' else (0,0,ow,oh)
    left,top,right,bottom=bounds
    left=max(0,left-24);top=max(0,top-24);right=min(ow,right+24);bottom=min(oh,bottom+24)
    im=im.crop((left,top,right,bottom))
    s=min(w/im.width,h/im.height);dw,dh=im.width*s,im.height*s;xx=x+(w-dw)/2;yy=y+(h-dh)/2
    c.drawImage(ImageReader(im),xx,yy,dw,dh,mask='auto')
    if labels:
        items=list(META.get(name,{}).get('labels',{}).items())
        for i,(label,(px,py)) in enumerate(items):
            bx=x+5;by=y+h-26-i*34;tw=pdfmetrics.stringWidth(label,'Bold',9)+14
            tx,ty=xx+(px*ow-left)*s,yy+(bottom-py*oh)*s
            c.setStrokeColor(HexColor('#657C8B'));c.setLineWidth(.7);c.line(bx+tw,by,tx,ty)
            c.setFillColor(HexColor(BLUE));c.circle(tx,ty,2,fill=1,stroke=0)
            c.setFillColor(HexColor('#FFFFFF'));c.roundRect(bx,by-10,tw,20,4,fill=1,stroke=0);text(bx+7,by-3,label,9,BLUE,True)
def band(s):
    c.setFillColor(HexColor('#E5EDF1'));c.roundRect(32,47,W-64,67,8,fill=1,stroke=0)
    bottom=para(s,46,102,W-92,11,15);assert bottom>=52,(page,bottom)
def step_page(title,kicker,image,steps,check,labels=False):
    heading(title,kicker)
    if isinstance(image,tuple):
        picture(image[0],24,150,224,334,False);picture(image[1],248,150,224,334,False)
        text(55,136,'Rear: insert the screw',10,BLUE,True);text(279,136,'Front: drop in the nut',10,BLUE,True)
    else:picture(image,26,124,446,365,labels)
    y=480
    for i,s in enumerate(steps,1):y=para(f'<b>{i}.</b> '+s,495,y,310,12,17)-15
    assert y>=124,(title,y)
    band(check);c.showPage()

heading('Build the bolted rolling clock','R3 / first assembly')
para('Solid pivot roots, a rigid frame, and three gear ratios.',34,483,335,23,29)
para('<b>Start with 16:1.</b><br/>The same frames also accept 32:1 and 64:1. This guide shows the complete assembly, the captive-nut joints and the parts to change for slower rolling.',34,361,310,13,18)
para('<b>Status:</b> the earlier lightweight clock ran successfully. R3 parts and nut-fit coupons have been printed; the complete revised mechanism still needs a running test.',34,249,305,11.5,16)
picture('assembled-16x',330,97,498,420)
band('<b>Pivot correction:</b> use 54 mm frame posts, 10.5 mm pivot feet, the 186 mm axle and 76 mm rear journal. Already printed R3 gears, both frames, anchor bridge and bridge posts remain compatible. See README.md for the six changed files.')
c.showPage()

heading('Check the nut fit before the large prints','01 / materials and small coupons')
picture('post-nut-detail',27,147,435,341,True)
y=482
for s in [
 '<b>Selected by the builder after printing:</b> the 5.6 mm seat. To confirm on another setup, print 40_nut_post_coupon_560 and 41_post_seat_coupon from STL/fit-tests/.',
 'Slide a real M3 nut through the <b>5.8 mm entry channel</b> and its taper into the <b>5.6 mm seat</b>. Align the thread with the screw axis. The post must slip into the 12.4 mm locating lip.',
 'Use one <b>M3x10</b> screw through the seat coupon. Tighten until the flat faces meet. The 5.25 and 5.40 mm comparison coupons remain available; do not scale complete parts to change a fit.',
 '<b>16x:</b> 15 M3x10, 17 M3x16, 32 nuts.<br/><b>32x / 64x:</b> 16 M3x10, 17 M3x16, 33 nuts.'
]:y=para(s,490,y,316,11.5,16)-14
assert y>=120,y
band('Square posts print on a long flat side, with nut slots facing upward. Preload both end nuts before assembly. Screw heads: flat underside, at most 6.5 mm diameter x 3.2 mm high. Plain nuts: about 2.4 mm thick.')
c.showPage()

heading('One pair of frames, three layouts','02 / shaft positions seen from the pendulum side')
# Front view is mirrored in CAD X: the physical front lies on the +Z side.
CX,CY,S=249,304,1.42
xy=lambda v:(CX-v[0]*S,CY-v[1]*S)
c.setStrokeColor(HexColor('#B8C7D0'));c.setLineWidth(1);c.circle(CX,CY,124*S,fill=0,stroke=1)
axes=LAY['16']['axes'];slow=LAY['64']['axes'];points={'A':axes['A'],'B16':axes['B'],'Bslow':slow['B'],'D':slow['D'],'C':axes['C'],'P':axes['P']}
colors={'A':'#EB8038','B16':'#1E9D8A','Bslow':'#1E9D8A','D':'#9164BA','C':'#D4A126','P':RED}
for names,col,dash in [(['A','B16','C'],'#1E9D8A',[]),(['A','Bslow','D','C'],'#9164BA',[5,3])]:
    c.setStrokeColor(HexColor(col));c.setLineWidth(2);c.setDash(dash)
    for a,b in zip(names,names[1:]):c.line(*xy(points[a]),*xy(points[b]))
c.setDash([]);c.setStrokeColor(HexColor(RED));c.line(*xy(points['C']),*xy(points['P']))
for key,v in points.items():
    x,y=xy(v);c.setFillColor(HexColor(colors[key]));c.circle(x,y,5,fill=1,stroke=0);text(x+9,y+5,key,11,colors[key],True)
text(89,123,'248 mm rolling circle',10,MUTED)
y=483
for s in [
 '<b>A</b> is the square rolling axle. <b>C</b> is the escape-wheel pivot. <b>P</b> is the long anchor pivot. These stay fixed for every ratio.',
 '<b>16x:</b> fit one short pivot at B16 and one at C. Leave Bslow and D empty.',
 '<b>32x or 64x:</b> fit short pivots at Bslow, D and C. Leave B16 empty. Both slower layouts use the same shaft positions.',
 'Each pivot foot sits inside its loose square locating lip on rear frame 05. The front frame has matching <b>blind seats</b> for the gear-pivot tips. The large top opening passes the anchor sleeve.'
]:y=para(s,491,y,316,12,17)-16
band('The extra holes are deliberate. Install only the pivots for your chosen ratio. Match the frame to this view before tightening; unused seats require no plugs or screws.')
c.showPage()

step_page('Bolt the rear frame and pivot feet','03 / begin the 16x mechanism','frame-and-pivots',[
 'Lay <b>05</b> with its collars and locating lips facing you. The ballast-bowl bracket is at the bottom.',
 'Preload the nuts. Seat the two <b>13</b> gear pivots at <b>B16 and C</b>, and the long <b>19</b> pivot at P. Fasten each from behind with <b>M3x10</b>.',
 'Fit the three <b>07</b> square frame posts inside their locating lips. Use one <b>M3x10</b> from behind for each post; leave the front nuts loaded.',
 'Use the corrected pivots with <b>10.5 mm feet</b> and solid shaft roots. Bring their flat shoulders into contact with the frame before tightening.'
], 'The front frame is 54 mm from the rear frame\'s inside face. Reprint the three old 48 mm posts. Each nut pocket is fully below the shaft, with 4.8 mm of material above it. Print both pivot types solid.',True)

step_page('Fit the square axle and orange gear','04 / replace all crosspins with screws','axle-detail',[
 'Use the corrected <b>186 mm axle 03</b>. Mark the rear end: the middle cross-hole is <b>97 mm</b> from it (89 mm from the other). End holes are 6 mm from each end.',
 'Slide long rear journal <b>36 (76 mm)</b> onto the axle and through A. Add rear thrust washer <b>35 (1.2 mm)</b>.',
 'Slide on <b>10</b>: its <b>flat face points rearward</b>; the raised hub points toward the <b>short, 89 mm end / pendulum</b>. Load the hub nut, align the middle hole and fit <b>M3x16</b> in the side recess.',
 'Add keyed front thrust sleeve <b>34 (26.4 mm)</b> ahead of the orange hub. The square faces carry torque; the cross-screw holds the gear in position.'
], '<b>Next page: a 1:1 axle identification drawing.</b> Rear to front: rear wheel hub -> 36 -> 35 -> gear 10 -> 34 -> front journal 37 -> front wheel hub. Wheel hubs are fitted later. Keep loose sleeves from sliding off.',True)

page+=1
draw_axle_template(c,ROOT,page,PAGE_COUNT)
c.showPage()

step_page('Build the two gear stages','05 / 16x parts only','gear-stack',[
 'On the B16 pivot: add <b>15 (1.2 mm)</b>, then green <b>11</b> with its small pinion rearward, then <b>16 (23.7 mm)</b>. The small pinion engages the orange wheel.',
 'On C: add <b>17 (13.2 mm)</b>, then yellow <b>12</b> with its small pinion rearward, then <b>27 (4.7 mm)</b>. Its small pinion engages the large green wheel.',
 'On P: add <b>20 (34.2 mm)</b>, then the <b>18_anchor_forward</b> from STL/16x/. Its long sleeve points forward. Ease the pallet faces around the escape-wheel teeth.',
 'Turn the input gently while supporting the pivots. Stop at a locked pallet; never force the wheel past it.'
], 'All gear spacers have flat annular ends. The intended endplay is 0.6 mm per gear. Neither the front plate nor a screw should clamp a rotating gear tightly between fixed faces.')

step_page('Prepare and close the front frame','06 / fasteners must remain accessible','close-front-frame',[
 'Before fitting <b>06</b>, bolt both <b>23</b> bridge posts to its outer face with <b>M3x10</b> screws inserted from the gear side. Their ends sit flat against the frame.',
 'Temporarily use bridge <b>22</b> as an alignment template over the two posts while tightening their rear screws. Its square lips prevent twisting. Lift the bridge off again.',
 'Place frame 06 over the three frame posts, both short pivot tips and the anchor sleeve. Its blind bearing seats and A collar face inward, toward the gears.',
 'Add the three front <b>M3x10</b> frame-post screws, seating them gradually. Slide short front journal <b>37 (45.6 mm)</b> onto the axle and into A.'
], 'If anything binds as the frame closes, reopen it and check the spacer order and blind seats. There should be 0.5 mm behind each seated pivot tip. Do not tighten a screw to overcome a misalignment.')

step_page('Clamp the pendulum and close the bridge','07 / adjustable beat, rigid bridge','bridge-detail',[
 'Slide the head of <b>24</b> onto the anchor sleeve, ahead of the frame. Its bent rod runs down around the main axle. Keep the front of the clamp approximately flush with the sleeve end.',
 'Fit the clamp nut and <b>M3x16</b> screw. The screw head sits in the shallow circular recess. Tighten lightly so the angle can still be adjusted for the beat.',
 'Place <b>21 (7.7 mm)</b> on the exposed anchor pivot, ahead of the sleeve and pendulum head.',
 'Fit bridge <b>22</b> onto both posts and the pivot tip. Add its two front <b>M3x10</b> screws and snug them evenly. Confirm that the pendulum swings freely.'
], 'The bridge locates the fixed pivot; it must not squeeze the rotating sleeve. The square posts and flat faces establish the spacing. Check clearance at both clamp ears and the screw through a gentle swing.',True)

step_page('Fasten the bob with a real screw','08 / no toothpick or printed small pin',('bob-detail','bob-front-detail'),[
 'Slide bob <b>25</b> over the straight lower part of the rod, with both iron pockets facing upward. Start at the <b>150 mm hole</b>: fourth from the pivot, second from the free end.',
 'Drop a plain M3 nut into the <b>5.8 mm front channel</b>, separate from the iron pockets. Slide it through the taper into the <b>5.6 mm seat</b>, with its thread aligned to the rod hole.',
 'Insert one <b>M3x16</b> from the rear, toward the front nut. Tighten until the bob is held; do not crush its thin outside walls.',
 'With the frame upright, add <b>15-20 g total</b> iron, approximately evenly divided. Keep the main ballast bowl empty until the drum is fitted.'
], 'Nominal clearances: bob to frame 9.4 mm; screw head to frame 6.2 mm; screw tip to front spokes 15.6 mm. The 1 mm outer walls save space; the central web and thicker floor carry the attachment and ballast loads.',True)

step_page('Bench-test, then add bowl and drum','09 / finish the case around a free-running core','bowl-rear',[
 'Support the fixed frame upright, without squeezing its bearings. Keep the loose axle sleeves seated with removable tape collars if necessary. Apply light <b>counterclockwise</b> input torque, seen from the pendulum side.',
 'Adjust the pendulum clamp angle until each half-swing releases one step and catches on the other pallet. Then snug the clamp. Remove temporary tape before final assembly.',
 'Fit empty bowl <b>08</b> with two <b>M3x10</b> screws from the gear side and nuts inside the cup. Both lower pads must touch the rear frame.',
 'Use six corrected <b>172 mm case posts</b>. Preload their nuts and both wheel-hub nuts. Fit the rear wheel and its M3x16 axle screw; bolt on the posts with six M3x16. Fit the front wheel, its axle screw and six post screws.'
], 'The case uses 12 post screws plus 2 axle screws. Snug opposite posts progressively with every shoulder seated. Turn the case through a full revolution while gently moving the pendulum before adding about 600 g to the bowl.')

heading('Swap gearing without reprinting the frames','10 / the 32x and 64x options')
picture('mechanism-32x',24,145,245,343);picture('mechanism-64x',275,145,245,343)
text(85,131,'32x: final pair 60:30',12,BLUE,True);text(336,131,'64x: final pair 72:18',12,BLUE,True)
y=483
for s in [
 '<b>16x to a slower set:</b> move B\'s pivot to Bslow. Add a third short pivot at D and its M3x10 screw/nut.',
 'Use the selected folder\'s B, D and escape compounds, its spacers, and <b>18_anchor_reversed</b> from slow-common/. Small pinions face rearward.',
 'D stack: <b>28 (13.2 mm)</b>, D compound, <b>29 (11.7 mm)</b>. C\'s rear spacer 17 becomes <b>25.2 mm</b>. B spacers and C\'s 4.7 mm front spacer stay the same lengths.',
 '<b>32x to 64x:</b> swap only D and the escape compound. Both final pairs total 90 teeth, so shaft centres stay 56.25 mm apart.'
]:y=para(s,543,y,265,11.5,16)-14
assert y>=120,y
band('Use each ratio\'s print list. The reversed wheel and anchor are a pair: the extra external mesh reverses the escape-wheel direction. Input still turns counterclockwise from the pendulum side. Recheck beat after a swap.')
c.showPage()

heading('Run on the incline and calibrate','11 / start from the successful physical test')
picture('assembled-16x',25,133,430,359)
y=481
for s in [
 '<b>Start with 16x</b>, about 600 g in the main cup and 15-20 g in the bob. Use a straight board with a soft stop at the low end.',
 'The earlier clock ran well with <b>4 cm rise over 80 cm</b>, also at 3 cm. At 2 cm it required careful beat adjustment. Begin at 4 cm (about 2.9 degrees).',
 'Time a marked distance. Calculated one-metre times are about <b>7:42 / 15:25 / 30:50</b> for 16x / 32x / 64x. R3\'s changed wheel and pendulum need a new real measurement.',
 'Move the bob lower to slow its rate. Lift the drum to reset uphill. Try 32x only after 16x runs reliably, then try 64x: each slower option leaves less ideal torque at the escapement.'
]:y=para(s,490,y,318,12,17)-14
assert y>=118,y
band('A little rocking can accompany the exchange of angular momentum between pendulum, carrier and drum. Snug joints remove looseness but do not guarantee zero rocking. Check for rubbing, skipped releases or stops; record these separately from timing error.')
c.showPage()

heading('Keep these lengths and screw counts handy','12 / assembly reference')
rows=[('15','B rear','1.2','1.2'),('16','B front','23.7','23.7'),('17','C rear','13.2','25.2'),('27','C front','4.7','4.7'),('28 / 29','D rear / front','-','13.2 / 11.7'),('20','Anchor rear','34.2','34.2'),('21','Anchor front','7.7','7.7'),('34','Main front thrust','26.4','26.4'),('35','Main rear washer','1.2','1.2'),('36 / 37','Rear / front journal','76 / 45.6','76 / 45.6')]
text(34,482,'Part',10,BLUE,True);text(87,482,'Position',10,BLUE,True);text(249,482,'16x (mm)',10,BLUE,True);text(350,482,'32x / 64x (mm)',10,BLUE,True)
y=451
for i,(num,loc,a,b) in enumerate(rows):
    if i%2==0:c.setFillColor(HexColor('#FFFFFF'));c.roundRect(30,y-10,430,29,3,fill=1,stroke=0)
    for x,s in [(35,num),(87,loc),(249,a),(350,b)]:text(x,y,s,10.6)
    y-=30
fasteners=[('Case posts','12 x M3x16'),('All axle retainers','3 x M3x16'),('Pendulum clamp + bob','2 x M3x16'),('Frame posts','6 x M3x10'),('Bridge posts','4 x M3x10'),('Bowl','2 x M3x10'),('Gear / anchor feet','3 x M3x10 (16x)'),('','4 x M3x10 (32x / 64x)')]
text(500,482,'One nut per screw',12,BLUE,True);y=453
for loc,count in fasteners:text(500,y,loc,10.4);text(647,y,count,10.4);y-=30
para('<b>R3 check results:</b> closed connected print meshes; no unintended nominal intersections; spur and pallet checks; -15 to +15 degree pendulum sweep; full drum rotation. Nominal gap to the rotating posts is at least 2.35 mm.',498,188,308,11,15)
band('This guide documents a geometrically checked prototype, not a physically tested R3 clock. Keep the first working version as a reference. Report the selected ratio, slope, ballast, measured run time and any contact or skipped beats.')
c.showPage();assert page==PAGE_COUNT;c.save()
axle_canvas=canvas.Canvas(str(ROOT/'AXLE-1-TO-1.pdf'),pagesize=(W,H))
axle_canvas.setTitle('Rolling clock R3 - main axle at 1:1 scale')
axle_canvas.setAuthor('László Lukács - CAD reference created with OpenAI Codex')
axle_canvas.setViewerPreference('PrintScaling','None')
draw_axle_template(axle_canvas,ROOT)
axle_canvas.showPage();axle_canvas.save()
# Browser entry point uses the PDF as the complete numbered build guide.
(ROOT/'guide.html').write_text('''<!doctype html><html lang="en"><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Rolling clock R3 build guide</title><style>body{max-width:1050px;margin:30px auto;padding:0 20px;background:#f6f4ef;color:#243548;font:17px/1.6 system-ui}img{max-width:100%;display:block}a{color:#2868af}.grid{display:grid;grid-template-columns:1fr 1fr;gap:24px}@media(max-width:700px){.grid{display:block}}h1{line-height:1.2}</style><h1>Build the bolted rolling clock</h1><p>R3: shared frames for 16:1, 32:1 and 64:1. Geometrically checked; not yet physically tested.</p><p><a href="BUILD-GUIDE.pdf"><b>Open the complete 14-page illustrated build guide</b></a></p><p><a href="AXLE-1-TO-1.pdf"><b>Print the 1:1 main-axle identification sheet</b></a> (also page 6 of the guide). A4 landscape, 100% / Actual size, with Fit / Shrink disabled. Check the 50 mm bar.</p><p><b>Pivot correction:</b> 10.5 mm pivot feet, 54 mm frame posts, 186 mm axle and 76 mm rear journal. Existing R3 gears, frames, anchor bridge and bridge posts remain compatible.</p><p>Print lists: <a href="PRINT-LIST-16x.md">16x</a> / <a href="PRINT-LIST-32x.md">32x</a> / <a href="PRINT-LIST-64x.md">64x</a>. Begin with the nut-post and seat coupons, then the 16x mechanism. <a href="README.md">Full design notes</a>.</p><img src="renders/assembled-16x.png" alt="Assembled R3 clock"><div class="grid"><div><h2>Captive-nut posts</h2><img src="renders/post-nut-detail.png" alt="Square post and metal screw and nut"></div><div><h2>Screw-fixed bob</h2><img src="renders/bob-detail.png" alt="Thin-wall bob with screw and nut"></div></div><h2>Same frames, slower gearing</h2><div class="grid"><img src="renders/mechanism-32x.png" alt="32 to 1 mechanism"><img src="renders/mechanism-64x.png" alt="64 to 1 mechanism"></div></html>''')
print('Created',ROOT/'BUILD-GUIDE.pdf','pages',page)
