# Pendulum bob with 1 mm walls

Replacement for the bob that occasionally touches the carrier or front drum spokes. The original print set is preserved; use the two STL files in this folder for this revision.

Print one each:

- `25_open_pendulum_bob_1mm.stl`
- `26_bob_pin_short.stl`

The four outer vertical cup walls are now **1.0 mm**, reduced from 2.4 mm by moving the exterior faces inward. The printed envelope is **31.2 x 13.2 x 24 mm**, previously 34 x 16 x 24 mm. This gives **1.4 mm more clearance on each face**, including both faces toward the frame and drum spokes. The iron pocket dimensions and capacity are unchanged. The 2.4 mm floor and central structural web remain to carry the iron and pin loads.

The rod slot, 3.1 mm pin hole and 150 mm starting position are unchanged. The new pin has the same head and 2.9 mm shank diameter, but its shank is **13.2 mm** instead of 16 mm. Overall length is **14.8 mm** instead of 17.6 mm.

## Printing and fitting

1. Print the holder at 100% scale, open mouth upward as exported, using your PLA and 0.2 mm layers. Check that the slicer retains the continuous 1 mm walls. No added supports are intended. Print the pin on its head as exported.
2. Empty the old holder, remove its pin and slide it off the pendulum rod.
3. Slide on the replacement with the pockets facing upward. Use the same rod hole as your successful test (150 mm was the starting recommendation).
4. Insert the short pin from behind, with its head facing the interior frame. It should seat gently, with its plain end approximately flush with the front of the holder. Do not leave the longer pin protruding: it can consume the clearance gained by this change.
5. Refill with the same iron amount, then turn the case through a complete revolution while gently swinging the pendulum to check actual clearance. The lower plastic mass may slightly change the rate; recheck travel against elapsed time after the swap.

Instead of printing the new pin, you can shorten the **plain end** of your existing pin by **2.8 mm**, giving a 13.2 mm shank measured from under its head, and remove the cutting burr. Preserve the head.

## Checks

Both exported STLs are watertight, single connected solids and fit the P1S. The replacement was checked through 81 pendulum poses from -25 to +15 degrees against the fixed assembly and pendulum rod. Axial and radial bounds cover every drum rotation within that range. No nominal CAD intersections were found.

Nominal gaps are 3.4 mm between holder and front carrier, 1.8 mm between the seated pin head and front carrier, and 2.4 mm between holder/pin tip and front drum spokes. These figures do not include print error, frame flex or axial play. The user has reported the original complete mechanism running; this replacement has not yet been physically tested.

`checks.json` records the geometry checks. `source/build_bob.py` regenerates only this replacement folder, using the original assembly as a reference. `assembly/` contains development meshes in assembled positions, not files to print.
