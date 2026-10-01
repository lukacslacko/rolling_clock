# Rolling timer - P1S prototype, revision 2

A 240 mm rolling drum containing a weighted carrier, a 16:1 gear train and a short pendulum with a Graham deadbeat escapement. Every printable part fits the 256 mm P1S volume. The ballast bucket and pendulum bob are open; neither has a lid. All rotating pivots are printed plain bearings. This revision adds pinion teeth through both compound wheels and an 8 mm chamfered square main shaft, with separate round journal sleeves in the unchanged carrier plates.

**This modular grid-frame variant has checked CAD geometry but has not been physically tested. The lightweight sibling uses the same 16:1 gears and was reported running on 2026-10-01.** Start with the fit coupon and the 16:1 mechanism. The animation prescribes pendulum motion; it does not establish that friction, losses or carrier rocking will permit sustained running.

## Files and first prints

- `STL/`: the initial **16:1** build, individually oriented on the bed. Print quantities are in `PRINT-LIST.md` and `parts.json`. Do not import every file as one assembled model.
- `ASSEMBLY.md`: assembly order, fit adjustment and first running trial.
- `mounting-layout.png`: dimensioned axis and mounting-hole layout.
- `renders/`: perspective studio views of the assembly and revised components. See its README for the parts omitted in the open inspection view.
- `REVISION-2.md`: changes, compatibility, fit and assembly differences.
- `perspective-assembly.blend`: editable assembled mesh scene with perspective camera and studio lighting. Numerical dimensions are millimetres. It is not a parametric solid model or a print plate.
- `source/`: editable Python geometry and CAD generators.
- `upgrade-32x/`: a separate, optional development set. **Do not mix these parts into the first build.**

Print parts 27-30 and 38-39 first. Parts 38-39 test the new square drive fit: the notched coupon has 8.20, 8.30 and 8.40 mm sockets from left to right with the notch at lower-left. Production sockets are 8.30 mm across flats. The key should slide by hand with little angular play. The original parts 27-30 comprise a hole coupon and matching 4, 6 and 12 mm test pins. The coupon has a notched corner. With that corner at the lower-left in a top view, the row nearest it is Ø6.2, 6.3, 6.4, 6.5 left to right, followed by Ø4.0, 4.1, 4.2. The farther row is Ø12.2, 12.3, 12.4. The coupon illustration shows the exact orientation.

## Main dimensions

| Feature | Dimension |
|---|---:|
| Complete drum | Ø240 × 140 mm |
| Reusable carrier plates | Ø216 mm; 5 mm plate + 4 mm main bearing collar |
| Mounting lattice | 20 mm positions on 40 mm rails; Ø4.1 holes |
| Printed main shaft | 8 x 8 x 140 mm; 1.4 mm corner chamfers |
| Main round journal sleeves | OD12; lengths 66.6 and 23.6 mm |
| Square drive sockets | 8.30 mm across flats; matching corner relief |
| B, C and anchor pivot journals | Ø6 mm |
| Gear / anchor running bores | Ø6.35 mm |
| Main running bores | Ø12.4 mm |
| Module and pressure angle | 1.25 mm, 20° |
| Both gear pairs | 72:18; 56.25 mm centre distance |
| 72-tooth gear pitch / tip diameter | 90 / 92.5 mm |
| 18-tooth pinion pitch / tip diameter | 22.5 / 25 mm |
| Escape wheel | 30 teeth; Ø68 mm tip circle |
| Escape wheel–anchor spacing | 48.08326 mm |
| Lock / lift / drop | 1.5° / 4.5° / 2° |
| Pendulum bob settings | 135, 140, 145, 150, 155 mm from pivot |
| Nominal effective pendulum length | Approximately 140 mm; calibrate after filling |
| Ballast bucket, external | 110 × 58 × 46 mm, plus 2 mm mounting bosses |
| Ballast internal volume | Approximately 244 cm³ |

The larger ballast bucket is behind the gear train. The pendulum and its much smaller open bob are in front, so their front-view outlines can overlap. Start with about **600 g of balls in the ballast bucket and 15–20 g in the bob**; your 750 g supply leaves adjustment material. Loosely packed screws have a different bulk density, so use the actual filled mass. Leave space below the rim.

## Reusing the plates for different gearing

Both carrier plates have the same mounting lattice. The B gear in the first build already uses a **removable rear pivot module and matching front bearing module** (31 and 32), located by three printed pins each. These are small parts: changing a shaft position means changing its modules, gears and spacers while retaining the plates. New shafts can have integral pivots or blind bearing seats on the inner faces; they do not require new holes drilled through plate rails. Carrier posts also fit unused lattice holes if a later layout needs them moved.

The complete list of usable grid positions is `mounting-grid.json`; the central bearing and existing C/P mounting areas exclude some positions. The main rolling axis stays fixed. The supplied escapement stays at C/P for the two included layouts. Other arbitrary layouts still require clearance and strength checks; the grid cannot make every gear combination fit.

As a concrete extension, `upgrade-32x/` uses **72:18 × 72:18 × 36:18 = 32:1**. It retains both plates, drum, main shaft, C/P pivots, front B module, bucket and pendulum. A replacement rear module adds an Ø8 mm cantilever pivot for the extra compound gear. A recessed retaining collar keeps that shaft clear of the escape wheel. Adding one external mesh reverses the output, so the upgrade includes **both a mirrored escape wheel and a mirrored pallet anchor**, with matching axial spacers. This layout has been checked for static interference and spur engagement, but is a development set to try after the 16:1 version works.

## Printing

Use PLA, a 0.4 mm nozzle and 0.2 mm layers at 100% scale. The exports already have their intended printing faces on Z=0. Do not resize the gears to change a fit: that also changes their pitch.

- Gears, anchor, pivots, pins and pivot modules: 4–6 walls; solid or near-solid small sections. Put the seam away from journal surfaces and pallet contacts. Use a moderate outer-wall speed, about 30–40 mm/s as a starting point.
- Carrier plates and wheels: 4 walls, 5 top/bottom layers, around 20–30% infill. Keep both wheel rims flat and equal in diameter.
- Main shaft: lie on the long flat as exported, with solid infill and 4-6 walls. Its 45-degree corner chamfers start from a 5.2 mm-wide bed face.
- Tall posts and round journal sleeves: upright with a 5-6 mm brim, 6 walls or solid where space allows. Journal sleeves have about 1.07 mm minimum wall at the socket corners; preview the toolpaths there.
- Both compound gears: broad wheel face on the bed. Their small pinion teeth now continue down to the bed rather than starting partway up the print.
- Buckets: print open mouth upward as exported; their 2.4 mm walls are intended to print solid. Ordinary bridging is needed over the small horizontal pin holes.
- The 240 mm wheels fit individually with 8 mm nominal margins on a 256 mm plate. Avoid adding a large outside brim or purge structure that extends beyond the usable bed.
- General supports should be off. Inspect the slicer preview around transverse holes and the pendulum clamp's nut pocket; use local support only there if your profile needs it. Keep support material off the gear teeth and pallet contact edges.

Remove elephant foot and burrs from gears and bearing entrances. A running journal should turn freely under a small load; a locating pin should stay put without being hammered in. The starting PLA running allowance is 0.35–0.4 mm on diameter. It is an allowance to test, not a claim about your printer's exact output. This is consistent with the practical range discussed by [MatterHackers in its assembly-design notes](https://www.matterhackers.com/articles/matterhackers-lab:-design-assemblies-).

The only recommended metal fastener in the initial build is **one M3×16 screw and one M3 nut for the pendulum beat clamp**. A sufficiently snug printed clamp can be tried first, but it must not slip relative to the anchor. All other joints use printed pins. Calibrate the new square socket by changing KEY_CLEARANCE in source/build.py after printing coupon 38 and key 39. Calibrate other tight stationary fits by changing only the pins' XY dimensions or the relevant source allowance; do not scale their lengths or complete gear parts.

## Timing and operation

At an effective length of 140 mm, the ideal pendulum period is 0.75060 s. The escape wheel advances one tooth per full oscillation, giving 480 oscillations per drum turn at 16:1. One beat advances the drum about 0.7854 mm.

| Nominal result | 16:1 first build | 32:1 development set |
|---|---:|---:|
| One drum revolution | 6 min 00 s | 12 min 01 s |
| Travel in five minutes | 628 mm | 314 mm |
| Time for one metre | 7 min 58 s | 15 min 56 s |

These are kinematic values, not measured accuracy. The rod, bob, anchor mass and fill distribution determine the actual effective length; the moving weighted carrier also affects the rate. Set the bob initially at 150 mm and calibrate travel against a stopwatch. Moving the bob down slows the timer. For a practical egg-timer demonstration, marking a measured five-minute travel distance is easier than achieving an exact calculated pendulum length.

Use a straight board around 1 m long and at least 170 mm wide, with a soft end stop. Start at 1–2° (approximately 17–35 mm rise per metre), then increase only enough to sustain ticking. The animation's 6° is an illustration, not a required setting. Aim initially for about ±5° pendulum swing. Reset by **lifting and carrying the drum uphill**; forcing it to roll backward drives the escapement backward.

## What was checked

- Every initial-build STL is a closed, single-body mesh and fits the stated build volume.
- The revised compound pinion cross-sections have full support from the broad wheel face in the supplied print orientation.
- The complete keyed input rotor checked at 73 positions over a full revolution; both carrier plates are byte-identical to revision 1.
- Both spur meshes over 121 input positions and the complete pallet outline over 241 pendulum positions.
- The initial assembly for unintended intersections, plus 41 mechanism poses and 41 pendulum positions from −25° to +15° relative to the carrier.
- Approximately 3 mm clearance between the carrier envelope and the swept inside surface of the rotating drum posts.
- The 32:1 alternative's additional gear meshes and complete nominal assembly, allowing only its explicitly intended collar press fit.

Reports are included as JSON. These reports record geometric checks, not physical tests of this modular variant. See the repository README for the lightweight build's running report. Print the fit coupon, then bench-test the mechanism while supporting the carrier vertically before committing to the two large drum wheels.

## Editing and regenerating

Use Python 3.11+ and install `manifold3d==3.5.4`, `trimesh==5.1.0`, `shapely==2.1.2` and NumPy. From `source/`, run:

```sh
python geometry.py
python check_motion.py
python upgrade32.py
python validate_revision.py
```

`check_motion.py` rebuilds the 16:1 CAD; `upgrade32.py` rebuilds it and then the optional set. Generated STL and assembly files are overwritten. `build.py` defines the plates, modules, clearances and axial stack. `geometry.py` generates the deadbeat contact geometry and animation samples. Change related dimensions together and rerun the checks; they intentionally fail if a revised layout interferes.

## Geometry references

The pallet construction follows the geometric method described by [Roman Y. Andronov](https://romanandronov.github.io/pgc/ryapgce.html), also implemented in [Rainer Hessmer’s Deadbeat Escapement Builder](https://hessmer.org/gears/DeadbeatEscapementBuilder.html). The supplied CAD, mounting system, tooth relief and size choices are this prototype’s design.
