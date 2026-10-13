"""Optional R3 long-face trial anchor; millimetres, radians internally.

The original deadbeat pallets remain the production baseline. This variant
retains their release endpoints and mounting geometry but replaces the working
and locking faces with longer, gentler straight ramps. It permits recoil.
Run this script to build the two handed anchors and the finer rolling wheel.
Run check_long_face_anchor.py for contact and assembly checks and the drawing.
"""
from pathlib import Path
import json, math
from primitives import *
from shapely import affinity

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'experiments/long-face-anchor'
MODEL = json.loads((ROOT / 'escapement-reference.json').read_text())
F = np.array(MODEL['pivot'])
FACE_LENGTH = 8.0
FACE_ROTATION = 30.0
RIM_SEGMENTS = 16384
PITCH = 2 * math.pi / MODEL['escape_teeth']


def pallet(name):
    old = np.array(MODEL[name])
    # Both stored outlines run down the locking arc to the first end of the
    # impulse face, then cross it to the release end. The face is the longest
    # polygon edge; both original lengths are 3.570765 mm.
    lengths = np.linalg.norm(np.roll(old, -1, axis=0) - old, axis=1)
    i = int(np.argmax(lengths))
    lock, release = old[i:i+2]
    direction = rotate2([(lock-release)/lengths[i]], FACE_ROTATION*D)[0]
    deep = release + FACE_LENGTH*direction
    points = np.vstack([old[0], deep, old[i+1:]])
    poly = Polygon(points)
    assert poly.is_valid and poly.geom_type == 'Polygon'
    return poly, {'old_lock': lock.tolist(), 'release': release.tolist(),
                  'deep': deep.tolist(), 'old_length_mm': float(lengths[i]),
                  'new_length_mm': FACE_LENGTH, 'face_edge_index': 1}


PALLETS = [pallet(n)[0] for n in ('entry', 'exit')]
FACE_DATA = {n: pallet(n)[1] for n in ('entry', 'exit')}
ARMS = LineString([np.array(MODEL['entry'][0])-F, (-17, 4), (0, 0),
                   (17, 4), np.array(MODEL['exit'][0])-F]).buffer(2.5)
OUTLINE = unary_union([affinity.translate(p, *(-F)) for p in PALLETS] +
                      [ARMS, circle(7.5)])


def solid():
    # Same R3 plate thickness, sleeve, bore and axial coordinates.
    anchor = extr(OUTLINE, 123, 4) + cyl(6, 127, 30)
    return hole(anchor, (0, 0), 4.175, 122, 37)


def escape_polygon():
    pts = []
    for k in range(MODEL['escape_teeth']):
        pts.extend(rotate2(MODEL['tooth'], k*PITCH))
        pts.extend(polar(MODEL['rootR'], a) for a in
                   np.linspace(k*PITCH-2*D, (k+1)*PITCH-8.5*D, 6)[1:])
    return Polygon(pts)  # Absolute tooth phase: leading tooth at zero.


def contact_roots(poly, alpha):
    """Leading tooth-tip contacts, with edge identity; CCW escape convention.

    Exact segment/circle intersections, filtered for entry into material.
    Full finite-width tooth geometry is checked independently afterwards.
    """
    p = rotate2(np.asarray(poly.exterior.coords)[:-1]-F, alpha) + F
    a, v = p, np.roll(p, -1, axis=0)-p
    aa = np.sum(v*v, axis=1)
    bb = 2*np.sum(a*v, axis=1)
    cc = np.sum(a*a, axis=1)-MODEL['outerR']**2
    disc = bb*bb-4*aa*cc
    shape = Polygon(p)
    result = []
    for sign in (-1, 1):
        ts = (-bb+sign*np.sqrt(np.maximum(0, disc)))/(2*aa)
        for i in np.where((disc >= 0) & (ts >= -1e-9) & (ts <= 1+1e-9))[0]:
            point = a[i]+ts[i]*v[i]
            angle = math.atan2(point[1], point[0])
            if (shape.contains(Point(polar(MODEL['outerR'], angle+1e-6))) and
                    not shape.contains(Point(polar(MODEL['outerR'], angle-1e-6)))):
                result.append((angle % PITCH, point, int(i)))
    return result


def trace(alphas):
    """Follow the engaged pallet, allowing recoil, then catch the next tooth.

    This is a quasi-static contact construction, not a shock/dynamics model.
    """
    rows = []
    q, side = None, 0
    for alpha in alphas:
        candidates = [(angle, s, point, edge) for s, p in enumerate(PALLETS)
                      for angle, point, edge in contact_roots(p, alpha)]
        assert candidates, ('no stop', alpha/D)
        same = [c for c in candidates if c[1] == side]
        if q is None:
            angle, side, point, edge = same[0]
            q = angle
        elif same:
            angle, side, point, edge = min(same, key=lambda c:
                abs((c[0]-q+PITCH/2) % PITCH-PITCH/2))
            q += (angle-q+PITCH/2) % PITCH-PITCH/2
        else:
            angle, side, point, edge = min(candidates, key=lambda c: (c[0]-q) % PITCH)
            q += (angle-q) % PITCH
        rows.append({'alpha': float(alpha), 'q': float(q), 'side': side,
                     'point': point.tolist(), 'edge': edge})
    return rows


def export_print(m, path, simplify=True):
    bb = m.bounding_box()
    m = m.translate((-bb[0], -bb[1], -bb[2]))
    if simplify:
        tm = mesh(m)
    else:
        # The usual 0.0001 mm manifold simplification would erase this rim's
        # deliberately fine vertices. STL float32 quantization still applies.
        raw = m.to_mesh64()
        # Quantize before merging/removing collapsed Boolean seam triangles,
        # so validation checks the actual binary STL precision. Simplifying
        # the manifold at the normal tolerance would also simplify the rim.
        tm = trimesh.Trimesh(np.asarray(raw.vert_properties)[:, :3].astype(np.float32),
                             np.asarray(raw.tri_verts), process=False)
        tm.merge_vertices()
        tm.update_faces(tm.nondegenerate_faces(height=1e-10))
        tm.update_faces(tm.unique_faces())
        tm.remove_unreferenced_vertices()
    assert tm.is_watertight and tm.is_winding_consistent and len(tm.split()) == 1, (path.name, tm.is_watertight, tm.is_winding_consistent, len(tm.split()), len(tm.faces))
    assert tm.volume > 0 and max(tm.extents) <= 250.01
    path.parent.mkdir(parents=True, exist_ok=True)
    tm.export(path)
    return tm


def build_trial(b):
    OUT.mkdir(parents=True, exist_ok=True)
    anchor = solid()
    for label, m in [('forward', anchor), ('reversed', anchor.mirror((1, 0, 0)))]:
        export_print(m, OUT/'STL'/f'18_anchor_{label}_long_faces.stl')
    old_wheel = b.parts['common', '01_case_wheel']['m']
    # Replace only the outermost rolling strip. All post sockets and lips
    # are inside r=122 mm; overlap the strip with the retained solid core.
    core = old_wheel ^ extr(circle(123), -1, 15)
    fine_wheel = core + extr(circle(124, quad_segs=RIM_SEGMENTS//4)-circle(122.5), 0, 7)
    export_print(fine_wheel, OUT/'STL/01_case_wheel_16384.stl', simplify=False)
    metadata = {'status': 'experimental; physical trial pending',
                'face_length_mm': FACE_LENGTH, 'face_rotation_deg': FACE_ROTATION,
                'faces': FACE_DATA, 'plate_thickness_mm': 4, 'bore_mm': 8.35,
                'sleeve_od_mm': 12, 'sleeve_length_mm': 30,
                'rim_segments': RIM_SEGMENTS, 'rim_diameter_mm': 248,
                'nominal_flat_width_mm': 248*math.sin(math.pi/RIM_SEGMENTS),
                'release_endpoints_unchanged': True}
    (OUT/'dimensions.json').write_text(json.dumps(metadata, indent=2)+'\n')
    return anchor, fine_wheel


if __name__ == '__main__':
    import build as b
    build_trial(b)
    print('Trial print files:', OUT/'STL')
