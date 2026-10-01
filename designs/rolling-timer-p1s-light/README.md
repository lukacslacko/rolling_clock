# Lightweight 16:1 rolling timer

This is a dedicated first-print alternative to the revision-2 grid frames. It retains the same gear train, escapement, square shaft, round journal sleeves, pendulum, open ballast capacity and 240 mm drum. Only three existing print files change: rear carrier 05, front carrier 06 and bowl 08.

## What changed

- The two grid discs become small triangular frames with only the required bearing bosses, pendulum supports and bowl bracket.
- The B pivot is integrated into rear frame 05; its blind front bearing is integrated into frame 06. Parts 31, 32 and all six pins 33 are omitted.
- Three original-size carrier posts 07 join the frames, at new positions. Print only three, not four. The six long drum posts 02 remain unchanged.
- The bowl uses two upper M3 x10 screws and plain M3 nuts. Head recesses shorten the clamped plastic stack; hex pockets inside the bowl locate the nuts. Two lower contact pads resist rocking without lower fasteners. Omit the four original pins 09.

The pair of frames has **49.8 cm3** CAD solid volume versus **145.2 cm3** for the old grid plates: **65.7% less**, even including the integrated B supports. There are 39 printed assembly instances rather than 52. Slicer time and filament savings depend on settings; these are geometry-volume figures, not a sliced-time prediction.

## Files to use

- `STL/05_rear_carrier.stl`, `STL/06_front_carrier.stl`, `STL/08_open_ballast_bucket.stl`: the three replacement parts.
- `STL/`: complete compatible 16:1 print set, including unchanged R2 pieces and fit tests.
- `PRINT-LIST.md`: quantities and print orientations.
- `bob-1mm/`: optional 2026-10-01 replacement bob with 1 mm outer walls and a matching shorter pin, preserving the rod fit and iron capacity. Use its own instructions; the original `STL/` files remain preserved.
- `ASSEMBLY.md`: revised complete assembly order.
- `bowl-bolt-section.png` and `.svg`: the M3 x10 mounting stack.
- `renders/`: perspective views of the new assembly and frame pair.
- `light-assembly.blend`: editable rendered assembly; its floor, loose ballast and fastener envelopes are not print parts.
- `source/`: generators and checks. `light-layout.json` records the axes, post locations and fastener dimensions.

The old R2 package is preserved separately. This light frame has no interchangeable mounting grid and is intended for the first 16:1 build. Use the original grid-frame version for the supplied 32:1 upgrade.

## The two M3 x10 bowl screws

The screw heads sit on the mechanism side of the rear frame. Their 7 mm diameter recesses are 2.5 mm deep. Use cap, button or pan heads with flat undersides, head diameter no more than 6.5 mm and head height no more than 3.2 mm. Screw length is measured under the head.

From the head seat to the nut face, the plastic stack is 2.5 mm of rear frame + 2 mm bowl boss + 2.4 mm bowl wall = **6.9 mm**. A plain **2.4 mm-thick M3 nut** leaves **0.7 mm** of the 10 mm screw beyond the nut. No washer is needed in the intended stack. The nut pockets are 5.7 mm across flats and 3 mm deep, sized around a plain M3 nut with 5.5 mm flats. The nut dimensions follow [Accu's M3 plain-nut specification](https://www.accu.co.uk/hexagon-nuts/766459-NUT203M3); use your existing matching nuts.

Seat both nuts and fit both screws before filling the bowl. Tighten gently until the upper bosses and lower pads contact the rear frame. The nuts can be held with a fingertip inside the open cup while starting the screws. Begin with about 600 g of ballast as before.

## Printing

PLA, 0.4 mm nozzle and 0.2 mm layers remain the design assumptions. Both frames print with their outside faces on the bed. The rear frame's integral B pivot points upward; the front frame's bearing bosses and blind seat point upward. Use 5-6 walls and 5 top/bottom layers; 25-35% infill is a reasonable initial choice for the frame webs. The integral pivot should be solid. These settings are starting choices, not a printer-specific strength validation.

Rear frame envelope: **128.3 x 188.9 x 41 mm**. Front frame: **120 x 163.9 x 9 mm**. Bowl: **110 x 60 x 46 mm**, exported open-mouth-up. All fit the P1S. Keep general supports off the frames. Inspect the small horizontal nut-pocket roofs and screw holes in the bowl's slicer preview; clean up any loose bridge strands before fitting the nuts.

The saved meshes are closed, connected solids. Nominal assembly, both spur meshes, escapement motion, the pendulum range and a full rotation of the keyed shaft were checked, including the bowl fastener envelopes. The unchanged printed files are byte-identical to R2. On 2026-10-01, the user reported the complete mechanism running on its first trial, with occasional pendulum-bob contact against the carrier or case spokes. The narrower replacement in `bob-1mm/` addresses that contact; it has been checked geometrically but has not yet been physically tested. Long-term wear and running accuracy remain unmeasured.

## Regenerating

With the dependencies in `source/requirements.txt`, run `python source/check_motion.py`, then `python source/validate_light.py`. The first command regenerates the print meshes and assembled geometry. For images, use Blender: `blender -b --factory-startup -t 6 --python source/render_light.py`.
