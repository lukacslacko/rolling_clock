"""Build and check the optional long-face anchor against existing R3 parts.

Checks contact branches, full tooth profiles, neighbouring teeth, mirrored
handedness, the added swing envelope and assembled solids. A sudden carrier
rotation is not simulated dynamically; friction and backlash remain unmodelled.
"""
import os
os.environ.setdefault('MPLCONFIGDIR', '/tmp/rolling-clock-mpl')
import long_face_anchor as v
from long_face_anchor import *


def overlap(a, b):
    ba, bb = a.bounding_box(), b.bounding_box()
    if any(min(ba[k+3], bb[k+3])-max(ba[k], bb[k]) < 1e-5 for k in range(3)):
        return 0.
    return max(0., float((a ^ b).volume()))


def about(m, p, degrees):
    return m.translate((-p[0], -p[1], 0)).rotate((0, 0, float(degrees))).translate((*p, 0))


def contact_checks():
    escape = escape_polygon()
    outline = affinity.translate(OUTLINE, *F)
    reports, traces = [], {}
    # Independently vary beat setting and excursion by the reported 2 degrees.
    for center, amplitude in [(3, 5), (1, 5), (5, 5), (3, 7)]:
        alphas = (center-amplitude*np.cos(np.linspace(0, 2*math.pi, 1201)))*D
        rows = trace(alphas)
        maxarea, minneighbor, mindeep, mindrive = 0., 100., 100., 100.
        for row in rows:
            a, q, side = row['alpha'], row['q'], row['side']
            assert row['edge'] == 1, ('contact left ramp', row)
            an = affinity.rotate(outline, a, origin=tuple(F), use_radians=True)
            ew = affinity.rotate(escape, q, origin=(0, 0), use_radians=True)
            maxarea = max(maxarea, an.intersection(ew).area)
            # Second-closest tooth must remain clear: the closest is the
            # intended engaged tooth. Check finite-width, swept-back teeth.
            distances = sorted(Polygon(rotate2(MODEL['tooth'], q+j*PITCH)).distance(an)
                               for j in range(MODEL['escape_teeth']))
            minneighbor = min(minneighbor, distances[1])
            contact = rotate2([np.array(row['point'])-F], -a)[0]+F
            deep = FACE_DATA[('entry', 'exit')[side]]['deep']
            mindeep = min(mindeep, float(np.linalg.norm(contact-deep)))
            # Positive dq/dalpha pushes the entry pallet toward release;
            # negative dq/dalpha does the same for the exit pallet. A zero
            # derivative would be neutral locking rather than a recovery ramp.
            qa = contact_roots(PALLETS[side], a-1e-7)[0][0]
            qb = contact_roots(PALLETS[side], a+1e-7)[0][0]
            slope = ((qb-qa+PITCH/2) % PITCH-PITCH/2)/2e-7
            drive = slope if side == 0 else -slope
            mindrive = min(mindrive, drive)
        advance = (rows[-1]['q']-rows[0]['q'])/D
        releases = sum(a['side'] != b['side'] for a, b in zip(rows, rows[1:]))
        assert abs(advance-12) < 1e-6 and releases == 2
        assert maxarea < 1e-5 and minneighbor > .6 and mindeep > 1.8 and mindrive > .06
        report = {'center_deg': center, 'amplitude_deg': amplitude,
                  'anchor_range_deg': [center-amplitude, center+amplitude],
                  'samples': len(rows), 'net_escape_advance_deg': advance,
                  'pallet_changes_per_cycle': releases,
                  'max_full_profile_overlap_mm2': maxarea,
                  'min_other_tooth_clearance_mm': minneighbor,
                  'min_distance_to_deep_ramp_end_mm': mindeep,
                  'min_restoring_dq_dalpha': mindrive,
                  'every_contact_on_slanted_face': True}
        reports.append(report)
        traces[f'{center}_{amplitude}'] = rows
        print('Contact:', report, flush=True)
    # Reflect both members, retaining the same phase relationships. This is
    # the actual 32x/64x handedness, not just a flipped illustration.
    for row in traces['3_7'][::10]:
        an = affinity.rotate(outline, row['alpha'], origin=tuple(F), use_radians=True)
        ew = affinity.rotate(escape, row['q'], origin=(0, 0), use_radians=True)
        an = affinity.scale(an, -1, 1, origin=(0, 0))
        ew = affinity.scale(ew, -1, 1, origin=(0, 0))
        assert an.intersection(ew).area < 1e-5
    return reports, traces


def assembly_checks(b, anchor, traces):
    reports = []
    for ratio, items in b.assemblies.items():
        reflected = ratio != 16
        sign = -1 if reflected else 1
        m = anchor.mirror((1, 0, 0)) if reflected else anchor
        old = b.parts[('slow-common', '18_anchor_reversed') if reflected else
                      ('16x', '18_anchor_forward')]['m']
        sleeve = cyl(8, 127.001, 31)
        assert float((((m-old)+(old-m)) ^ sleeve).volume()) < 1e-6
        axes = {k: np.array(p) for k, p in b.layouts[ratio]['axes'].items()}
        worst = 0.
        for row in traces['3_7'][::20]:
            alpha, q = row['alpha']/D, (row['q']-MODEL['q0'])/D
            posed = m.rotate((0, 0, b.TILT+sign*alpha)).translate((*b.P, 0))
            for item in items:
                group = item['group']
                if group == 'anchor':
                    continue
                other = item['m']
                if group in ('B', 'C', 'D'):
                    angle = {'B': -4*q/ratio, 'C': sign*q, 'D': 16*q/ratio}[group]
                    other = about(other, axes[group], angle)
                elif group in ('rotor', 'case'):
                    other = about(other, b.A, q/ratio)
                elif group == 'pendulum':
                    other = about(other, b.P, sign*(alpha-3))
                volume = overlap(posed, other)
                worst = max(worst, volume)
                assert volume < .002, (ratio, alpha, item['name'], volume)
        reports.append({'ratio': ratio, 'sampled_cycle_positions': 61,
                        'anchor_range_deg_forward_convention': [-4, 10],
                        'max_3d_intersection_mm3': worst,
                        'mounting_sleeve_identical': True})
        print('Assembly:', reports[-1], flush=True)
    return reports


def rim_checks(b, wheel):
    original = b.parts['common', '01_case_wheel']['m']
    difference = (wheel-original)+(original-wheel)
    unchanged_inside = overlap(difference, extr(circle(122), -1, 15))
    assert unchanged_inside < 1e-6
    tm = trimesh.load(OUT/'STL/01_case_wheel_16384.stl', force='mesh')
    center = (tm.bounds[0, :2]+tm.bounds[1, :2])/2
    xy = tm.vertices[:, :2]-center
    radii = np.linalg.norm(xy, axis=1)
    outer = xy[np.abs(radii-124) < .002]
    angles = np.sort(np.unique(np.round(np.arctan2(outer[:, 1], outer[:, 0]), 7)))
    increments = np.diff(np.r_[angles, angles[0]+2*math.pi])
    assert len(angles) == RIM_SEGMENTS
    width = 248*math.sin(float(increments.max())/2)
    assert width < .049
    return {'exported_segments': len(angles), 'max_flat_width_mm': width,
            'mounting_geometry_difference_inside_r122_mm3': unchanged_inside,
            'max_stl_vertex_radius_error_mm': float(np.max(np.abs(np.linalg.norm(outer, axis=1)-124))),
            'binary_stl_float32_quantization_included': True,
            'diameter_mm': float(tm.extents[0]), 'watertight': bool(tm.is_watertight)}


def drawing(traces):
    import matplotlib
    matplotlib.use('Agg')
    import matplotlib.pyplot as plt
    from matplotlib.lines import Line2D
    fig, axes = plt.subplots(1, 3, figsize=(15, 6), facecolor='#f7f8fa')
    fig.suptitle('R3 trial anchor: longer recovery faces', fontsize=21, fontweight='bold', y=.97)
    old = Polygon(MODEL['entry']) | Polygon(MODEL['exit']) | affinity.translate(ARMS | circle(7.5), *F)
    new = affinity.translate(OUTLINE, *F)
    escape = escape_polygon()
    # Front view, matching the reversed anchor used for 32x/64x.
    for ax, (title, row) in zip(axes, [('Profile comparison', None),
                                     ('Extra 2° on the first side', traces['3_7'][0]),
                                     ('Extra 2° on the other side', traces['3_7'][600])]):
        ax.set_facecolor('#f7f8fa')
        alpha = row['alpha'] if row else 0
        def display(poly):
            poly = affinity.rotate(poly, alpha, origin=tuple(F), use_radians=True)
            return affinity.scale(poly, -1, 1, origin=(0, 0))
        if row:
            ew = affinity.rotate(escape, row['q'], use_radians=True, origin=(0, 0))
            ew = affinity.scale(ew, -1, 1, origin=(0, 0))
            ax.fill(*ew.exterior.xy, color='#edcc69', ec='#9e7d20', lw=.7)
        ax.fill(*display(new).exterior.xy, color='#bd4963', ec='#713043', lw=.8)
        ax.add_patch(plt.Circle((0, F[1]), 4.175, facecolor='#f7f8fa', edgecolor='#713043', lw=.8))
        if not row:
            ax.plot(*display(old).exterior.xy, color='#536b7b', lw=1.2, ls='--')
        for f in FACE_DATA.values():
            line = np.array([f['deep'], f['release']])
            line = rotate2(line-F, alpha)+F
            line[:, 0] *= -1
            ax.plot(line[:, 0], line[:, 1], color='#05a3ac', lw=3.5)
        if row:
            x, y = row['point']
            ax.plot(-x, y, 'o', ms=7, color='#172c40', markeredgecolor='white')
        ax.set(xlim=(-39, 39), ylim=(-59, -14), aspect='equal', title=title)
        ax.invert_yaxis()
        ax.axis('off')
    axes[0].text(.5, -.10, '8.0 mm faces; original 3.57 mm\nSame bore, sleeve and release endpoints',
                 transform=axes[0].transAxes, ha='center', va='top', fontsize=10, color='#203648')
    for ax in axes[1:]:
        ax.text(.5, -.10, 'Black dot: tooth contact on the extended ramp', transform=ax.transAxes,
                ha='center', va='top', fontsize=9, color='#203648')
    fig.legend(handles=[Line2D([0], [0], color='#05a3ac', lw=3, label='New slanted faces'),
                        Line2D([0], [0], color='#536b7b', ls='--', label='Original outline'),
                        Line2D([0], [0], color='#edcc69', lw=8, label='Existing escape wheel')],
               loc='lower center', ncol=3, frameon=False, bbox_to_anchor=(.5, .095))
    fig.text(.5, .035, '32x / 64x front view • Exact CAD profiles • Quasi-static contact check; physical trial pending',
             ha='center', fontsize=10, color='#536b7b')
    fig.subplots_adjust(left=.025, right=.975, top=.88, bottom=.23, wspace=.1)
    fig.savefig(OUT/'long-face-comparison.png', dpi=150)
    fig.savefig(OUT/'long-face-comparison.svg')
    svg = OUT/'long-face-comparison.svg'
    svg.write_text('\n'.join(line.rstrip() for line in svg.read_text().splitlines())+'\n')
    plt.close(fig)


def main():
    import build as b
    anchor, wheel = build_trial(b)
    contacts, traces = contact_checks()
    assemblies = assembly_checks(b, anchor, traces)
    rim = rim_checks(b, wheel)
    drawing(traces)
    report = {'contact_checks': contacts, 'assembly_checks': assemblies,
              'both_handednesses_checked': True, 'fine_wheel': rim,
              'limitations': 'Rigid, quasi-static contact checks. No impact dynamics, friction, '
              'backlash, elastic deflection or printed tolerances. Allows recoil; physical trial pending.'}
    (OUT/'checks.json').write_text(json.dumps(report, indent=2)+'\n')
    (OUT/'contact-cycles.json').write_text(json.dumps(traces, separators=(',', ':'))+'\n')
    print('All trial checks passed:', OUT, flush=True)


if __name__ == '__main__':
    main()
