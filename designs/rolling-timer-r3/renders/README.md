# R3 CAD illustrations

These are perspective renders of the generated assembly meshes. Blue: case and square axle; orange: input gear; green: B compound; purple: D compound; gold: escape wheel; red: anchor, pendulum and bob; pale gray: fixed frame and cup; dark gray: printed journals and spacers; steel: screws and nuts.

`assembled-16x.png` shows the complete 16x plastic and fastener assembly. `mechanism-16x.png`, `mechanism-32x.png` and `mechanism-64x.png` omit the rolling case to expose the mechanism. Other images omit selected pieces or spread fasteners apart to show assembly access; follow the PDF for the seated positions and stack order.

Screws are unthreaded clearance envelopes, with simplified heads; drive recesses are not depicted. Nuts are nominal M3 envelopes with an unthreaded bore. No rendered metal part is an STL to print. The loose iron fill is omitted.

`render-metadata.json` supplies label locations for the PDF. The corresponding `source/render.py` regenerates all views from `assembly/` with Blender 5.x. `r3-assembly.blend` in the parent folder contains all three configurations; only 16x is visible initially.
