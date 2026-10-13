"""Split R3 case wheel: exact-path 4 mm tire and conventionally sliced spider."""
from pathlib import Path
import json
from primitives import *
from shapely import affinity
ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT/'experiments/split-tire'
OUTER_R, INNER_R, TIRE_H = 124., 111., 4.
PILOT_R = 110.9  # Loose centering: 0.10 mm radial clearance, no press fit.
HOLE_R, BOLT_R = 1.7, 114.
CENTERS = [polar(BOLT_R, (30+60*k)*D) for k in range(6)]


def build():
    import build as b
    old = b.parts['common', '01_case_wheel']['m']
    outline = circle(11)
    for k, q in enumerate(CENTERS):
        outline |= bar((0, 0), q, 7)
        outline |= affinity.translate(affinity.rotate(box(-6.9, -6.9, 6.9, 6.9),
                                                      30+k*60, origin=(0, 0)), *q)
    spider = old ^ extr(outline, -1, 15)
    # Raised outer pads replace the upper 3 mm of the original 7 mm rim.
    # All features inward of the pilot, including the entire original hub,
    # remain at their original axial positions.
    spider -= extr(circle(130)-circle(PILOT_R, quad_segs=1024), -1, TIRE_H+1)
    print_m = spider.translate((121.1, 121.1, 0))
    tm = mesh(print_m)
    assert tm.is_watertight and len(tm.split()) == 1 and max(tm.extents)<250
    (OUT/'STL').mkdir(parents=True, exist_ok=True)
    tm.export(OUT/'STL/01_case_spider_for_4mm_tire.stl')
    tire_poly = circle(OUTER_R, quad_segs=4096)-circle(INNER_R, quad_segs=1024)
    for q in CENTERS:
        tire_poly -= circle(HOLE_R, q, quad_segs=96)
    tire = extr(tire_poly, 0, TIRE_H)
    # Check retained interface geometry and the screw/post stacks.
    assert float((spider ^ tire).volume()) < 1e-6
    retained = extr(circle(100), -1, 15)
    assert float((((spider-old)+(old-spider)) ^ retained).volume()) < 1e-6
    contacts=[]
    for q in CENTERS:
        # Cross section of the supported pad, excluding the screw hole.
        probe = cyl(3.1, 4.01, 2.98, q)-cyl(1.71, 4, 3, q)
        assert float((probe-spider).volume()) < 1e-5
        screw = cyl(1.5, 0, 16, q)+cyl(3.25, -3.2, 3.2, q)
        assert float((screw ^ (spider+tire)).volume()) < 1e-6
        contacts.append({'center_mm':q.tolist(), 'clamped_thickness_mm':7,
                         'nut_near_z_mm':12.5, 'nut_far_z_mm':14.9,
                         'M3x16_tip_beyond_nut_mm':1.1})
    result={'outer_diameter_mm':248,'inner_diameter_mm':222,'tire_thickness_mm':4,
            'screw_holes_mm':3.4,'bolt_circle_diameter_mm':228,'hole_angles_deg':[30+60*k for k in range(6)],
            'pilot_diameter_mm':2*PILOT_R,'nominal_radial_centering_clearance_mm':.1,
            'spider_pad_thickness_mm':3,'case_post_face_z_mm':7,'hub_retained_exactly':True,
            'same_axle_posts_and_M3x16_screws':True,'mounts':contacts,
            'spider_print_bounds_mm':tm.extents.tolist(), 'spider_watertight_connected':True,
            'supports':'Build-plate supports under six raised pads; remove and clean their seating faces.'}
    (OUT/'dimensions.json').write_text(json.dumps(result,indent=2)+'\n')
    print('Split tire CAD passed:',result,flush=True)
    return spider,tire


if __name__=='__main__':build()
