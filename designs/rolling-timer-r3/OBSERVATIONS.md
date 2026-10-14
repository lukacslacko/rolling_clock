# Physical observations motivating R3

Recorded from the builder on 2 October 2026, after the original lightweight 16:1 clock ran successfully.

1. Press-fit case posts expanded their wheel holes and produced six bumps in the rolling rim, sometimes stopping the roll. Frame and pendulum-bridge joints loosened or failed to maintain an exact distance.
2. The printed bob pin was unreliable; a toothpick was used successfully instead.
3. The pendulum still occasionally touched the frame or case. Inexact post spacing contributed.
4. Pendulum motion visibly rocked the case, with no clear running problem reported from that effect alone.
5. The clock rolled well on an 80 cm board raised 4 cm, and also at 3 cm. At 2 cm, setting the pendulum clamp angle was finicky.
6. The main axle crosspins worked, but screws were preferred for consistency and easier assembly.

Requested changes: square, flat-ended posts with captive M3 nuts; M3x10 and M3x16 fasteners; 5.25 mm nut-slot width; loose locating lips; a thicker rolling rim; more pendulum space; screw-retained axle and bob; one frame design supporting 16x, 32x and 64x; and a new illustrated build guide. A few centimetres of extra width were acceptable.

Nut-access clarification: the originally requested 5.25 mm applied only to the final anti-rotation seat. The insertion channel should be wider, approximately 5.8 mm, especially on the pendulum bob.

Physical coupon result: after printing and trying the coupons, the builder selected **5.6 mm** for all final nut seats. This supersedes the original 5.25 mm request. Current R3 production parts use 5.6 mm seats throughout, with the 5.8 mm insertion channels retained. The labelled comparison coupons remain unchanged.

R3 is a response to these observations. Its subsequent running report is recorded below. The previous working version is preserved under the v0.1.0 repository tag.

## Pivot-foot issue - 7 October 2026

The builder found in the slicer that the gear-pivot nut slot nearly severed the shaft from its base and could expose the nut near a gear. At this point the printed R3 parts were the four 32x wheels, reversed anchor, rear frame, anchor bridge, three frame posts and two bridge posts. Widening was acceptable.

The CAD confirmed that the 2.8 mm nut pocket reached 1.2 mm above the original 4.5 mm foot into the 8 mm journal. Connected-mesh and collision checks had not caught this weak section. The correction uses 10.5 mm feet on both pivot types, a blind bolt bore below the shaft, and a 6 mm forward shift of the mechanism. Frame posts become 54 mm long and overall plastic width becomes 186 mm. Of the reported printed parts, only the three frame posts need replacement. At that point, physical strength and running tests were pending.

## Successful roll and faceted rim - 8 October 2026

After printing and fitting the missing rear thrust collar 38, the builder reported: "Printed well, rolls well". The remaining reported issue was a visibly faceted outer rim: the wheel appeared to move from one flat face to the next, and the flats could be seen in reflected light and felt by hand. The ongoing build was prepared for 32:1; this message does not independently confirm trials of all three gear sets. Timing accuracy and durability remain unmeasured.

Inspection of the exported wheel STL found exactly 192 outer angular vertices, 4.058 mm between neighbours and 0.01660 mm ideal radial chord error. The source circle used 48 segments per quadrant. The correction refines only that outside circle to 384 segments per quadrant (1,536 total), retaining all mounting features and every other print file. The revised STL and a finer slicing-resolution suggestion are ready for a new print; smoother physical rolling is not yet confirmed.

## Pendulum displacement and deeper engagement - 13 October 2026

The builder clarified the observed failure: while resting on a flat, the pendulum is roughly one or two degrees away from its intended relative position. The case then suddenly rolls to the next flat, pushing the anchor deeper into the escape wheel and sometimes jamming it. The builder plans to try a finer rim and requests longer slanted anchor faces so that a tooth can still push the over-engaged pallet toward release. The actual event has not been captured or dynamically measured here.

An optional long-face anchor is supplied in [experiments/long-face-anchor](experiments/long-face-anchor/README.md), separately from the existing working anchor. Both faces are 8 mm long, with their angles changed by 30 degrees toward the locking-arc tangents and their release endpoints retained. A straight extension at the original angle intersected a neighbouring tooth in the geometric trial. The revised slope clears the complete tooth shapes and the assembled R3 mechanism over the original swing plus two extra degrees at either end. It allows recoil and is not yet physically tested; geometric feasibility does not establish recovery from a sudden impact.

The previously suggested 16,384-segment rim is now generated as the separately named `01_case_wheel_16384.stl` in the same trial folder. The standard `01_case_wheel.stl` remains the 1,536-segment version. All 51 standard print files and the existing assembled models are unchanged by this optional trial.


## 13 October 2026 — split tire and supplied G-code inspection

The builder observed irregular move lengths in Bambu Studio at 0.001 mm resolution and proposed a hand-generated solid tire with a conventionally sliced spoke frame. The supplied `01_case_wheel.gcode.3mf` confirms arc fitting: layer 2 has 59 G3 / 21 G1 outer moves and a 0.001261 mm radial range about the offset-corrected center. All 35 rim layers have less than 0.002 mm within-layer radial variation. This does not identify the physical cause of visible faceting.

The optional `experiments/split-tire` set has a Ø248 / Ø222 × 4 mm solid tire, six Ø3.4 holes on Ø228 PCD, and four tangent outer arcs per layer. Perimeter speed is 40 mm/s (25 first), with 0.15/0.075/0 mm boundary compensation and distributed seams. A matching spider keeps the original hub, post lips and mounting planes; 4 mm tire + 3 mm pads preserve the M3×16 stack and existing axle/posts. Pads require removable supports. The pilot is a slip fit with 0.10 mm radial clearance, requiring careful centering.

CAD compatibility, independently parsed command/coverage checks and Bambu Studio preview pass. Actual printing, concentricity and improved rolling remain untested. Standard 51 STL files are unchanged.


## 13 October 2026 — narrower five-pass tire

The builder requested a roughly 2 mm radial ring to avoid the wide tire's three-hour print. The new `split-tire/narrow-five-pass` job keeps Ø248 mm and 4 mm axial thickness, but uses five complete concentric circular paths per layer between six inward screw pads. Local infill is confined to those pads. The spoke frame is byte-identical and screw/axle/post stacks remain unchanged. Bambu Studio preview estimates 1 h 5 min and 11.34 g, compared with 3 h 16 min / 48.28 g for the wide tire. The command/CAD geometry is checked; the thinner ring's flexibility and roundness under load require a physical trial.


## 14 October 2026 — narrow tire too flimsy; wide zigzag replacement

The builder printed the 2 mm radial tire and reported that it was very flimsy. The new `split-tire/wide-zigzag` job restores the original Ø248 / Ø222 × 4 mm envelope. Three outer circular passes and two inner passes are joined by a 0.5 mm repeated zigzag web, interrupted by six solid screw seats. There are no top/bottom skins or roofs. The existing split-wheel spider, axle, case posts and M3×16 screws are unchanged.

Bambu Studio preview estimates 1 h 14 min / 14.44 g per tire, compared with 3 h 16 min / 48.28 g for the solid wide tire, and 1 h 5 min / 11.34 g for the narrow trial. Geometry, emitted commands, layer support and mounting checks pass. Physical stiffness and loaded roundness of the new ribbed version remain to be tested. Enable Bed leveling in the print dialog.


## 14 October 2026 — covered zigzag tire for torsion

The builder requested a few full layers on the bottom and top of the wide zigzag tire to resist torsion. The separate `split-tire/covered-zigzag` job adds three 0.2 mm concentric solid layers on each face, leaving a 2.8 mm zigzag core inside the original 4 mm thickness. All six screw bores and solid mounting seats remain; the spoke frame, axle, posts and M3×16 screws are unchanged.

The first top layer is printed at 25 mm/s across the core cells with full part cooling, with every skin path beginning on a solid pad or bore wall. Bambu Studio displays 1 h 54 min and approximately 24.5 g per tire. Geometric/command and preview checks are recorded with the job; physical bridging quality, torsional stiffness and loaded roundness remain untested.
