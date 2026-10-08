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
