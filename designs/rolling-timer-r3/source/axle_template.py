"""Vector, physically 1:1 axle sheet, shared by the guide and standalone PDF."""
import json
from reportlab.lib.colors import HexColor
from reportlab.lib.units import mm

W, H = 841.89, 595.28
INK, MUTED, BLUE = '#243548', '#5D6C79', '#2868AF'
COLORS = {'03': '#B7D2EF', '36': '#DAE1E8', '35': '#BFAED3', '38': '#9DD5C3',
          '10': '#F4A568', '34': '#C9D7E2', '37': '#DAE1E8'}
X0, YC, YBARE = 55, 295, 113


def draw_axle_template(c, root, page_number=1, total_pages=1):
    data = json.loads((root / 'axle-reference.json').read_text())
    parts = data['parts']
    x = lambda z: X0 + z * mm

    def text(px, py, value, size=10, bold=False, color=INK, align='left'):
        c.setFillColor(HexColor(color)); c.setFont('Bold' if bold else 'Body', size)
        getattr(c, {'left': 'drawString', 'right': 'drawRightString', 'center': 'drawCentredString'}[align])(px, py, value)

    def line(points, color=MUTED, width=.6, dash=()):
        c.setStrokeColor(HexColor(color)); c.setLineWidth(width); c.setDash(dash)
        p = c.beginPath(); p.moveTo(*points[0])
        for point in points[1:]: p.lineTo(*point)
        c.drawPath(p); c.setDash()

    def dimension(a, b, py, label, from_y):
        for z in (a, b): line([(x(z), from_y), (x(z), py+5)], '#9EABB6', .45)
        line([(x(a), py), (x(b), py)], INK)
        for z, sign in ((a, 1), (b, -1)):
            line([(x(z)+sign*5, py+2), (x(z), py), (x(z)+sign*5, py-2)], INK)
        text(x((a+b)/2), py+7, label, 10, True, align='center')

    def mesh_outline(name, cy):
        part = parts[name]
        p = c.beginPath()
        for ring in [part['outline']] + part['holes']:
            p.moveTo(x(ring[0][0]), cy + ring[0][1]*mm)
            for z, y in ring[1:]: p.lineTo(x(z), cy+y*mm)
            p.close()
        c.setFillColor(HexColor(COLORS[name[:2]])); c.setStrokeColor(HexColor(INK)); c.setLineWidth(.55)
        c.drawPath(p, stroke=1, fill=1, fillMode=0)

    c.setFillColor(HexColor('#FFFFFF')); c.rect(0, 0, W, H, fill=1, stroke=0)
    text(32, H-27, '04 / AXLE IDENTIFICATION AT ACTUAL SIZE', 9, True, MUTED)
    text(32, H-64, 'Main axle: rear, front and gear orientation', 26, True)
    text(32, 499, 'Corrected R3 • 54 mm frame posts • 186 mm axle • identical for 16x / 32x / 64x', 11)
    text(X0, 475, 'REAR — main ballast bowl side', 12, True, BLUE)
    text(x(186), 475, 'FRONT — pendulum side', 12, True, BLUE, 'right')
    dimension(0, 97, 446, '97 mm to middle hole', 433)
    dimension(97, 186, 446, '89 mm to middle hole', 433)
    line([(x(97), 438), (x(97), YC-34)], BLUE, .55, (3, 3))

    # Local section of the rear frame's bearing collar: OD20 / bore12.4,
    # Z78..82. Its thrust face makes the purpose of collar 38 visible.
    c.setFillColor(HexColor('#EDF0F2'));c.setStrokeColor(HexColor('#798C99'));c.setLineWidth(.6)
    for y0 in (-10,6.2):c.rect(x(78),YC+y0*mm,4*mm,3.8*mm,fill=1,stroke=1)
    for name in parts: mesh_outline(name, YC)
    # Hidden axle edges establish its path through the sleeves and wheel.
    for y in (-4, 4): line([(x(12.4), YC+y*mm), (x(173.6), YC+y*mm)], BLUE, .45, (3, 3))
    line([(x(0)-5, YC), (x(186)+5, YC)], BLUE, .45, (8, 3, 1, 3))
    for z in data['hole_centres_mm']:
        line([(x(z)-7, YC), (x(z)+7, YC)], BLUE, .6)
        line([(x(z), YC-7), (x(z), YC+7)], BLUE, .6)

    text(116, 355, '36  Rear journal', 11, True)
    text(116, 340, '76 mm long', 10, color=MUTED)
    line([(184, 331), (184, YC+6*mm)], INK)
    text(386, 355, '37  Front journal', 11, True)
    text(386, 340, '45.6 mm long', 10, color=MUTED)
    line([(471, 331), (471, YC+6*mm)], INK)
    text(202, 378, '35 / 1.2 mm washer', 10, True)
    line([(257,369),(x(89),347),(x(89),YC+8*mm)],INK)
    text(105,265,'05  Rear-frame collar',10,True,color=MUTED)
    line([(222,268),(x(82),270)],MUTED)
    text(91,231,'38  NEW rear thrust collar',11,True)
    text(91,216,'6 mm long / Ø12.4 mm ROUND bore',10,color=MUTED)
    line([(246,235),(x(85.4),252),(x(85.4),YC-8*mm)],INK)
    text(375, 231, '34  Front thrust sleeve', 11, True)
    text(375, 216, '26.4 mm long', 10, color=MUTED)
    line([(402, 239), (402, YC-7.5*mm)], INK)
    text(163, 404, 'Flat face toward REAR', 11, True)
    line([(279, 393), (x(90), 381)], INK)
    text(357, 404, 'Raised hub → FRONT', 11, True)
    line([(373, 393), (357, 372), (x(100.8), YC+10*mm)], INK)
    text(341, 182, '10  Fixed orange wheel', 11, True)
    text(341, 167, '72 teeth • hub on the right', 10, color=MUTED)
    line([(336, 182), (x(96), 200)], INK)

    tx = 614
    text(tx, 449, 'CHECK THE ASSEMBLY', 10, True, BLUE)
    notes = [(427, 'Long side of the middle hole:'), (412, 'REAR (97 mm).'),
             (382, 'Fix gear 10 at this middle hole'), (367, 'with one M3x16 screw + nut.'),
             (337, '38 surrounds rear journal 36.'), (322, 'It fits between frame 05'), (307, 'and rear thrust washer 35.'),
             (292, 'Parts are in their assembled'), (277, 'positions. Small gaps are'), (262, 'intentional; do not clamp tight.'),
             (232, 'Rear frame collar shown in section.'), (217, 'Other frame parts / drum omitted.'),
             (187, 'Lay the bare axle on the outline'), (172, 'below to identify its three holes.')]
    for py, value in notes: text(tx, py, value, 10)

    text(X0, 144, 'BARE AXLE 03  •  8 mm square  •  Ø3.4 mm cross-holes', 10, True, BLUE)
    mesh_outline('03_square_main_axle', YBARE)
    for z in data['hole_centres_mm']:
        line([(x(z), YBARE+7), (x(z), YBARE-7)], BLUE, .45)
        line([(x(z)-7, YBARE), (x(z)+7, YBARE)], BLUE, .45)
        text(x(z), 89, f'{z} mm', 9, color=BLUE, align='center')
    dimension(0, 186, 65, '186 mm overall', YBARE-4*mm-2)
    text(X0, 45, 'Hole labels are measured from the REAR end. Both end holes are 6 mm from their nearest end.', 9, color=MUTED)

    # A dimensional printer calibration, deliberately in page units (not an image).
    bar_x, bar_y = 626, 83
    line([(bar_x, bar_y), (bar_x+50*mm, bar_y)], INK, 1)
    for px in (bar_x, bar_x+50*mm): line([(px, bar_y-4), (px, bar_y+4)], INK, 1)
    text(bar_x+25*mm, 98, 'This bar must measure 50 mm', 10, True, align='center')
    text(tx, 59, 'Print A4 landscape at 100% / Actual size.', 9, True)
    text(tx, 45, 'Disable Fit / Shrink. Check the bar first.', 9)
    line([(32, 29), (W-32, 29)], '#D7DFE3')
    text(32, 16, 'ROLLING CLOCK R3  |  TRUE 1:1 VECTOR DRAWING  |  8 OCTOBER 2026', 8, color=MUTED)
    text(W-32, 16, f'{page_number} / {total_pages}', 8, color=MUTED, align='right')
