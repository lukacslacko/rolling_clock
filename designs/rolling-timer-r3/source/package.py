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
    for ratio,l in layouts.items():
        files=[(ROOT/'BUILD-GUIDE.pdf','BUILD-GUIDE.pdf'),(ROOT/f'PRINT-LIST-{ratio}x.md','PRINT-LIST.md'),(ROOT/'LICENSE','LICENSE')]
        files += [(ROOT/parts[key]['file'],parts[key]['file']) for key in l['print_quantities']]
        files += [(p,str(p.relative_to(ROOT))) for p in sorted((ROOT/'STL/fit-tests').glob('*.stl'))]
        note=f'''R3 {ratio}:1 print kit

Use PRINT-LIST.md for quantities and BUILD-GUIDE.pdf for assembly.
Only the selected ratio's print files are included, plus optional fit coupons.
The guide also describes the other ratios for future changes.

Hardware: {l['M3x10']} M3x10 screws, {l['M3x16']} M3x16 screws,
and {l['M3x10']+l['M3x16']} plain M3 nuts (about 2.4 mm thick).
Nut seats: 5.6 mm (selected by physical coupon test); insertion channels: 5.8 mm
with a tapered transition.
Print and try the two small joint coupons first.
PLA / 0.4 mm nozzle / 0.2 mm layers. Keep the supplied orientations.
The wheel is 248 mm diameter: no outside brim on the 256 mm P1S bed.

R3 is geometrically checked but has not yet been physically tested.
Start with 16:1 before trying a slower gear set.
Do not mix earlier-revision parts into this assembly.
Source and full design: https://github.com/lukacslacko/rolling_clock
License: MIT; see LICENSE.
'''
        pack(out/f'rolling-timer-r3-{ratio}x-print-kit.zip',f'rolling-timer-r3-{ratio}x-print-kit',files,{'START-HERE.txt':note})
if __name__=='__main__':main()
