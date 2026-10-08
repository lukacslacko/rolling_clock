"""Create the complete design archive and one selected-print archive per ratio."""
from pathlib import Path
import argparse,json,zipfile,hashlib
ROOT=Path(__file__).resolve().parents[1]
def main():
    ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);args=ap.parse_args()
    out=args.output.expanduser().resolve();out.mkdir(parents=True,exist_ok=True)
    parts=json.loads((ROOT/'parts.json').read_text());layouts=json.loads((ROOT/'layouts.json').read_text())
    paths=[p for p in ROOT.rglob('*') if p.is_file() and '__pycache__' not in p.parts and p.suffix not in ('.pyc','.blend1','.zip','.log') and p.name!='.DS_Store']
    def pack(path,prefix,files,extra=None):
        with zipfile.ZipFile(path,'w',zipfile.ZIP_DEFLATED,compresslevel=6) as z:
            for src,name in files:z.write(src,prefix+'/'+name)
            for name,text in (extra or {}).items():z.writestr(prefix+'/'+name,text)
        with zipfile.ZipFile(path) as z:
            assert z.testzip() is None,path
            assert len(z.namelist())==len(set(z.namelist())),path
        print(json.dumps({'file':str(path),'bytes':path.stat().st_size,'sha256':hashlib.sha256(path.read_bytes()).hexdigest()}))
    pack(out/'rolling-timer-r3-complete.zip','rolling-timer-r3',[(p,str(p.relative_to(ROOT))) for p in sorted(paths)])
    changed=['07_square_frame_post','13_bolted_gear_pivot','19_bolted_anchor_pivot',
             '03_square_main_axle','36_rear_round_journal','02_square_case_post']
    patch_files=[(ROOT/f'STL/common/{name}.stl',name+'.stl') for name in changed]
    patch_files += [(ROOT/'LICENSE','LICENSE'),(ROOT/'renders/pivot-section.png','pivot-section.png'),
                    (ROOT/'AXLE-1-TO-1.pdf','AXLE-1-TO-1.pdf')]
    patch_note='''R3 pivot-base correction - 7 October 2026

These six STL files replace the earlier R3 versions with the same names.
The gear and anchor pivot feet are now 10.5 mm tall, fully containing the nut
slots below a solid shaft root. Print both pivots solid (100% infill), foot down.
Nut seats remain 5.6 mm; entry channels remain 5.8 mm. Screws are unchanged.

For the 32:1 or 64:1 core, print:
3 x 07_square_frame_post.stl       54 mm long
3 x 13_bolted_gear_pivot.stl       56.5 mm total, 10.5 mm foot
1 x 19_bolted_anchor_pivot.stl     89.5 mm total, 10.5 mm foot
1 x 03_square_main_axle.stl       186 mm; cross-holes at 6, 97, 180 mm
1 x 36_rear_round_journal.stl      76 mm long
For a complete drum, also print:
6 x 02_square_case_post.stl       172 mm long
For 16:1 use two, rather than three, copies of pivot 13.

All other R3 print shapes are unchanged. Reuse the printed gears, anchor,
rear frame, anchor bridge and two bridge posts. Of the builder's reported
printed set, only the three frame posts require replacement.

Use the current build guide from the full kit or GitHub. The frame gap is
54 mm and the drum plastic width is 186 mm. Earlier 48 mm frame posts,
short pivots, 180 mm axle, 70 mm rear journal and 166 mm case posts must
not be mixed into this corrected stack.

AXLE-1-TO-1.pdf identifies the assembled axle at actual size. Print A4
landscape at 100% / Actual size, disable Fit / Shrink, and check its 50 mm bar.
Rear end: 97 mm from the middle hole. Front end: 89 mm from the middle hole.
The orange gear's flat face points rearward; its raised hub points forward.

Clearance and pivot-section checks passed for all three ratios. The new
pivots still need a physical print and strength/running test.
https://github.com/lukacslacko/rolling_clock
'''
    pack(out/'rolling-timer-r3-pivot-fix.zip','rolling-timer-r3-pivot-fix',patch_files,{'READ-ME.txt':patch_note})
    for ratio,l in layouts.items():
        files=[(ROOT/'BUILD-GUIDE.pdf','BUILD-GUIDE.pdf'),(ROOT/'AXLE-1-TO-1.pdf','AXLE-1-TO-1.pdf'),(ROOT/f'PRINT-LIST-{ratio}x.md','PRINT-LIST.md'),(ROOT/'LICENSE','LICENSE')]
        files += [(ROOT/parts[key]['file'],parts[key]['file']) for key in l['print_quantities']]
        files += [(p,str(p.relative_to(ROOT))) for p in sorted((ROOT/'STL/fit-tests').glob('*.stl'))]
        note=f'''R3 {ratio}:1 print kit

Use PRINT-LIST.md for quantities and BUILD-GUIDE.pdf for assembly.
Only the selected ratio's print files are included, plus optional fit coupons.
The guide also describes the other ratios for future changes.
Page 6 is the actual-size axle drawing, also supplied as AXLE-1-TO-1.pdf.
Print that sheet A4 landscape at 100% / Actual size, disable Fit / Shrink,
and check its 50 mm calibration bar before comparing the printed axle.

Hardware: {l['M3x10']} M3x10 screws, {l['M3x16']} M3x16 screws,
and {l['M3x10']+l['M3x16']} plain M3 nuts (about 2.4 mm thick).
Nut seats: 5.6 mm (selected by physical coupon test); insertion channels: 5.8 mm
with a tapered transition.
Print and try the two small joint coupons first.
PLA / 0.4 mm nozzle / 0.2 mm layers. Keep the supplied orientations.
The wheel is 248 mm diameter: no outside brim on the 256 mm P1S bed.

The complete R3 mechanism is geometrically checked but has not yet been run.
Start with 16:1 before trying a slower gear set.
Pivot correction: 54 mm frame posts, 10.5 mm pivot feet, 186 mm axle,
76 mm rear journal and 172 mm case posts. Older R3 gears, frames, anchor,
bridge and bridge posts remain compatible. See README.md in the full package.
Do not substitute the six earlier short parts or parts from R1/R2.
Source and full design: https://github.com/lukacslacko/rolling_clock
License: MIT; see LICENSE.
'''
        pack(out/f'rolling-timer-r3-{ratio}x-print-kit.zip',f'rolling-timer-r3-{ratio}x-print-kit',files,{'START-HERE.txt':note})
if __name__=='__main__':main()
