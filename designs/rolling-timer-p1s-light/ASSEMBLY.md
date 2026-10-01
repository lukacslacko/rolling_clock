# Assembly and first trial - lightweight 16:1

Use the new perspective views in `renders/` and `bowl-bolt-section.png` alongside this guide. Numbers refer to the STL filenames. Z is measured from the rear outside drum face toward the pendulum/front wheel. In the coordinate drawing, X is right and Y is down. The original grid-layout picture and old illustrated guide do not show this frame/post layout.

## 1. Fit and preparation

Print coupon 27 and test pins 28-30, plus square coupon 38 and key 39, before the larger parts. The square fit should slide by hand with little angular play. The stock socket is 8.30 mm across flats around an 8.00 mm chamfered square key. Select a freely turning Ø6 and Ø12 running fit, and a firm removable Ø4 locating fit. The actual gear and anchor bores are Ø6.35; static shaft seats are Ø6.2. Remove any seam ridge on a journal. Smooth thrust faces; preserve the escape-tooth tips and the pallet's curved locking/flat impulse faces.

Print the mechanism before the two case wheels if you want to limit the first trial. Support or clamp the carrier vertically for its bench test, leaving the pendulum and gear faces free. Clamp or support the skeletal carrier without obstructing either gear face. Do not rely on the ballast cup as a bench-test stand.

## 2. Lightweight carrier and two-bolt bowl

1. Hold rear frame 05 with its integral B pivot and main-bearing collar pointing toward the gears. The frame is at Z68-73; the main collar and B-pivot shoulder end at Z77. There is no separate B module.
2. Put two plain M3 nuts into the hex recesses inside bowl 08. Place the bowl behind the rear frame, mouth upward. Its two upper bosses and two lower pads contact the frame. Mount centres are X=-40 and +40, Y=55; the unfastened lower pads are at Y=80.
3. Insert two M3 x10 screws from the gear side through the recessed frame holes and into the nuts. Hold the nuts while starting the threads. Use the intended flat-under-head screws without washers; the nominal stack leaves 0.7 mm of screw past a 2.4 mm nut. Tighten gently. The lower pads resist bowl rocking and require no pins or bolts.
4. Insert C pivot 13 and the longer P pivot 19 from the rear, with their flanges resting on frame 05. Their axes remain C=(-25,-46.77072) and P=(-25,-94.85398). The integral B axis remains (-56.25,0).
5. Insert **three** carrier posts 07 at **(-76,-52), (32,-50), (-26,55)**. Their shoulders span Z73-110. Do not use the old grid-frame post locations. The six longer case posts 02 are a different part.
6. Set front frame 06 aside with its main collar and blind B bearing seat facing the gears. It has no separate front B module or module pins. Omit parts 09, 31, 32 and 33 entirely.

## 3. Main shaft and gear train

The square main shaft's three cross-holes are at **5, 81 and 135 mm from its rear end**. Keep this orientation; it is not symmetric. The square faces transmit torque. The pins provide axial retention, with tangential relief in the wheel and gear hub slots.

1. Slide long rear journal 36 onto main shaft 03. Feed the shaft and sleeve through the rear plate centre bearing. The sleeve, not the square shaft, contacts the round bearing bore. In the final stack it occupies Z10.4-77; its front end is flush with the rear bearing collar at Z77. Hold it there while assembling the next parts.
2. Add thin main thrust washer 35 in front of the rear collar, then drive gear 10, with its taller hub facing forward. Align its transverse hole to the shaft hole at 81 mm and insert crosspin 04. The square socket positively drives the gear; the pin prevents axial sliding. The hub slot deliberately permits a little tangential pin movement so torque is taken by the square faces.
3. Slide keyed main thrust sleeve 34 in front of the drive-gear hub. Together with washer 35 it limits the carrier's axial movement without clamping the bearings.
4. Fit compound B gear 11 onto the integral B pivot of rear frame 05: its 18-tooth pinion faces rearward and meshes with gear 10; its 72-tooth wheel faces forward. Add spacer 15 in front.
5. On C pivot 13, fit rear spacer 16, escape compound 12 with its 18-tooth pinion rearward, then front spacer 17. Mesh C's pinion with B's 72-tooth wheel. The escape wheel faces forward.
6. On P pivot 19, fit rear spacer 20, then anchor 18. The pallet body is in the same axial plane as the escape wheel; its long Ø10 sleeve points forward. Bring the pallets around the escape wheel without levering against tooth tips.
7. Fit the front plate. Its integral blind B seat receives B's pivot, C's pivot enters its static hole, and the anchor sleeve passes through the larger P opening. Seat all three carrier posts. Ensure that neither gear compound is axially squeezed. Slide short front journal 37 along the exposed square shaft and into the front carrier bearing from the front. It occupies Z106-129.6, with its rear end flush with the rear face of the front bearing collar. Both sleeves turn with the shaft in the stationary plates.

### Working axial stack, 16:1

| Axis | Rear to front, millimetres |
|---|---|
| A | Rear journal 36: 10.4-77; washer 35: 77-77.6; drive face 78-84 / hub to 86; thrust sleeve 34: 86.4-105.6; front journal 37: 106-129.6 |
| B | Integral rear boss 73-77; pinion 78-94 (through wheel); large wheel 88-94; spacer 94.6-106; integral front boss 106-110 |
| C | Rear spacer 73-87.4; pinion 88-105 (through wheel); escape wheel 101-105; front spacer 105.6-110 |
| P | Rear spacer 73–100.4; anchor body 101–105; sleeve to 127; front washer 127.6–129; bridge 129–133 |

The small axial gaps are deliberate. Do not add a washer that removes all endplay.

## 4. Pendulum and beat

1. Slide pendulum 24 over the anchor sleeve, ahead of the front plate. Leave its split clamp loose. Install the M3 nut in the hex pocket and the M3×16 screw through the opposing ear if using the recommended clamp screw.
2. Slide open bob 25 onto the rod. Use pin 26 through the **150 mm** rod hole initially. The other settings, from the pivot outward, are 135, 140, 145 and 155 mm. The bob mouth points upward; add roughly 15–20 g of balls or small hardware, spread between its two pockets.
3. Fit washer 21, bridge posts 23 and bridge 22. The bridge supports the front end of P's stationary shaft. Its support-post holes are at **P+(−21,16)** and **P+(21,16)**.
4. With the carrier vertical, apply a very light counterclockwise torque to gear A, viewed from the pendulum/front side, and move the pendulum gently. Adjust the clamp angle so the escape wheel releases once on each half-swing with similar excursions either side of gravity vertical. Tighten only enough to prevent the pendulum slipping on the anchor sleeve.

Beat adjustment changes the pendulum's angle relative to the pallet anchor. Moving the bob changes the rate. Do the beat adjustment again under actual ramp load, because the weighted carrier tilts under drive torque. The checked rod/bob envelope is −25° to +15° relative to the carrier, including the swing; keep the neutral rod within approximately −20° to +10° at a ±5° swing.

## 5. Bench check and drum

First check free gear motion with the anchor lifted clear. Then replace the anchor and verify alternating lock/release under light hand torque. No tooth should drag on the back of a pallet. If the train is stiff, find the tight bore, tooth burr or thrust contact before increasing drive force.

Once the mechanism passes this test, ensure both round journal sleeves are fitted, then slide the rear wheel's square socket onto the shaft and lock it with crosspin 04 at Z5. Insert six case posts 02 into its rim holes. Fit the second wheel facing inward—the hub's taller side faces the mechanism—and secure the shaft crosspin at Z135. The post shoulders sit between the inner wheel faces; the main shaft crosspins retain the two wheels axially. The wheel hubs also capture the extended journal sleeves. Keep the intended small axial gaps; do not force the sleeves against the bearings.

Add about 600 g to the open ballast bucket. Turn the drum through a full revolution by hand while controlling the pendulum. Check that the case posts clear the carrier everywhere, both wheel rims run true, and the bucket and pendulum remain between the case wheels. Carry the assembly with the bucket upright.

## 6. First run

Use a straight, level-across-its-width board with a soft end stop. Start with a 1–2° incline and a small pendulum swing. Increase the slope only enough to maintain motion; use less slope if the escapement knocks or the swing grows excessively. The bucket should hold the carrier near a steady tilted position rather than rotating with the case. Adjust the beat at that operating tilt.

If the rims slide instead of rolling, improve the board's traction; do not add a thick tread without accounting for its change in rolling diameter. Mark a start and finish after a stopwatch trial. At the intended rate, five minutes uses about 628 mm in the 16:1 build. To reset, lift the timer and carry it back uphill rather than forcing the gear train backward.

## Keeping the later upgrade option

This lightweight pair is dedicated to 16:1. The original R2 grid-frame package remains available for the 32:1 development set. All gearing and pendulum parts in this first build retain their R2 positions and geometry, but the lightweight frames do not provide that upgrade's module mounts.
