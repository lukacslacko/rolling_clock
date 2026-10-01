# Lightweight replacement pack for the revision-2 timer

Print these three replacement STLs:

1. `05_rear_carrier.stl`: triangular rear frame, integrated B pivot and bowl bracket.
2. `06_front_carrier.stl`: triangular front frame, integrated B bearing and pendulum-bridge mounts.
3. `08_open_ballast_bucket.stl`: open bowl with two upper M3 nut pockets and two lower contact pads.

All other retained STLs are byte-identical to revision 2. Reuse the square axle, round bearing sleeves, gears, escapement, pendulum, drum wheels and their existing spacers/pins.

## Quantity changes

- Use **three** carrier posts 07, at the new frame holes. The six long drum posts 02 are unchanged.
- Omit all four bowl pins 09.
- Omit both B modules 31 and 32 and all six pins 33; their functions are integrated into the new frames.
- Add two **M3 x10** flat-under-head cap/button/pan screws and two plain M3 nuts for the bowl. The existing pendulum-clamp screw is separate.

The two frame prints together have 49.8 cm3 CAD solid volume rather than 145.2 cm3 for the original grid discs, a 65.7% reduction. Actual sliced print time and filament depend on settings. The rear frame is 128.3 x 188.9 x 41 mm; front is 120 x 163.9 x 9 mm.

## Assembly changes

The exported orientations put each frame's outside face on the bed. The rear B pivot prints pointing up; the front blind B seat opens upward. Print the bowl mouth upward. Start with 5-6 walls and 5 top/bottom layers for the frames.

Seat the two plain nuts inside the bowl. Bring the bowl against the rear frame and insert the M3 x10 screws from the gear side into the recessed upper holes. The screw heads sit on 2.5 mm-thick material; together with the 2 mm bowl bosses and 2.4 mm bowl wall, the plastic grip is 6.9 mm. A 2.4 mm plain nut leaves 0.7 mm of screw beyond it. Use the stack without washers. See `bowl-bolt-section.png`.

The two lower pads rest against the frame without fasteners. Tighten the top screws gently until the bosses and pads sit against the frame. Keep the bowl empty until the fasteners are fitted; start the running trial with about 600 g of ballast.

The new frame-post positions are (-76,-52), (32,-50), (-26,55), using the original coordinate system. All gear, pendulum and main-bearing positions stay unchanged. Fit the B compound straight onto the rear frame's integral pivot; the front frame now contains its mating blind bearing. No module mounting step remains.

Follow the included `ASSEMBLY.md` for the complete sequence. This pair is dedicated to 16:1 and does not have the original frame's upgrade grid. Geometric motion and screw-clearance checks passed; physical fit, frame stiffness and sustained running remain to be tried.
