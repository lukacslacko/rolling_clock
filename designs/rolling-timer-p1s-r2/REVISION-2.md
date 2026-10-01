# Revision 2 - print support and square drive

This is the new complete print set. Use matching revision-2 drive parts together.

## Through pinions

The green 18/72 compound (11) now carries its 18-tooth pinion profile through all 16 mm of thickness. The yellow escape compound (12) carries its pinion through all 17 mm. Their large wheel faces remain the printing faces. This removes the unsupported starts at the small pinion teeth in the old design. Gear ratios, phases, pitch, centre distances and outer envelopes are unchanged.

The same through-pinion change is included in the optional 32:1 compounds U02-U04. That remains a development set; build and test 16:1 first.

## Square drive with round bearing sleeves

Main shaft 03 is 8 x 8 x 140 mm, with 1.4 mm corner chamfers. The orange gear and both blue drum wheels have matching sockets, 8.30 mm across flats. Chamfers keep the profile inside a small round envelope; the four long flats provide the positive drive.

The weighted carrier must stay free to turn relative to this shaft. Two separately printed sleeves have square sockets inside and 12 mm round exteriors. They rotate with the shaft inside the existing 12.4 mm carrier bores. Minimum sleeve wall at a socket corner is about 1.07 mm. Their extended lengths locate them between the wheel hubs and the existing thrust stack.

The three printed crosspins remain as axial retainers. Wheel and gear hub slots have tangential relief, so the square drive can engage without relying on the pins to transmit torque. Thrust pieces 34 and 35 now have square sockets too.

The shaft prints lying on its long flat, with length along the bed; the sleeves print upright. Print square coupon 38 and key 39 first. Nominal clearances must be calibrated to the actual PLA print.

## Changed print files

| Part | Change |
|---|---|
| 01_case_wheel, quantity 2 | Square socket; relieved retaining slot |
| 03_main_shaft | Chamfered square section; lying-flat print orientation |
| 10_drive_72 | Square socket; relieved retaining slot |
| 11_compound_18_72 | Pinion teeth through the full thickness |
| 12_escape_compound | Pinion teeth through the full thickness |
| 34_main_front_thrust_sleeve | Square socket |
| 35_main_rear_thrust_washer | Square socket |
| 36_rear_round_journal | New; OD12 x 66.6 mm |
| 37_front_round_journal | New; OD12 x 23.6 mm |
| 38_square_fit_coupon, 39_square_fit_key | New fit tests, not assembly parts |

Both reusable carrier plates (05 and 06) and all their mounting locations are unchanged. The earlier STL package, Blender scene and illustrated PDF remain revision 1. This package has updated assembly instructions and perspective renders; it does not silently mix the old guide with the new shaft.

## Checks and limits

See assembly-checks.json, motion-checks.json and revision-checks.json. The geometry has been checked for intersections, gear engagement, the full-turn keyed rotor and pinion support in the supplied print orientation. No physical printing, shaft strength, friction or sustained-running test has been performed. Fit, smooth motion and timing still need the first prototype trial.
