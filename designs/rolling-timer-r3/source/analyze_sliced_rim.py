"""Measure rolling-rim moves from a Bambu sliced 3MF or raw G-code.

Example: python analyze_sliced_rim.py wheel.gcode.3mf --output report.json
The supplied wheel has G-code center 128,126 because extruder_offset is 0x2.
Use --center for a differently positioned job. Does not execute G-code.
"""
import re,math,json,collections,argparse,zipfile
from pathlib import Path
import numpy as np
ap=argparse.ArgumentParser();ap.add_argument('file',type=Path);ap.add_argument('--center',type=float,nargs=2,default=[128,126]);ap.add_argument('--output',type=Path,required=True);cli=ap.parse_args()
if cli.file.name.endswith('.3mf'):
 with zipfile.ZipFile(cli.file) as z:text=z.read('Metadata/plate_1.gcode').decode()
else:text=cli.file.read_text()
pattern=re.compile(r'([A-Z])([-+]?(?:\d*\.\d+|\d+\.?\d*))')
center=np.array(cli.center);xyz=np.zeros(3);rel=False;erel=True;e=0.;layer=0;feature='';width=None;feed=0.;moves=[]
for lineno,line in enumerate(text.splitlines(),1):
 if line.startswith('; CHANGE_LAYER'):layer+=1
 if line.startswith('; FEATURE:'):feature=line.split(':',1)[1].strip()
 if line.startswith('; LINE_WIDTH:'):width=float(line.split(':',1)[1])
 code=line.split(';')[0].strip();tokens=code.split()
 if not tokens:continue
 cmd=tokens[0];args={k:float(v) for k,v in pattern.findall(code[len(cmd):])}
 if cmd=='G90':rel=False
 elif cmd=='G91':rel=True
 elif cmd=='M82':erel=False
 elif cmd=='M83':erel=True
 elif cmd=='G92':
  if 'E'in args:e=args['E']
  for i,k in enumerate('XYZ'):
   if k in args:xyz[i]=args[k]
 elif cmd in ['G0','G1','G2','G3']:
  start=xyz.copy()
  for i,k in enumerate('XYZ'):
   if k in args:xyz[i]=(xyz[i] if rel else 0)+args[k]
  de=args.get('E',0) if erel else args.get('E',e)-e
  if 'E'in args:e=(e if erel else 0)+args['E']
  if 'F'in args:feed=args['F']
  if layer and feature=='Outer wall' and de>0:
   if min(np.linalg.norm(p[:2]-center) for p in [start,xyz])<123.3:continue
   if cmd in ['G2','G3']:
    c=start[:2]+[args.get('I',0),args.get('J',0)]
    a=math.atan2(*(start[:2]-c)[::-1]);b=math.atan2(*(xyz[:2]-c)[::-1]);sign=1 if cmd=='G3' else -1
    sweep=(sign*(b-a))%(2*math.pi)
    if sweep<1e-9:sweep=2*math.pi
    r=np.linalg.norm(start[:2]-c);r2=np.linalg.norm(xyz[:2]-c)
    ts=a+sign*np.linspace(0,sweep,max(3,math.ceil(sweep/.002)))
    points=c+r*np.column_stack([np.cos(ts),np.sin(ts)])
    length=r*sweep
    ce=float(np.linalg.norm(c-center));radius_mismatch=float(abs(r-r2))
   else:
    points=np.linspace(start[:2],xyz[:2],20);length=np.linalg.norm(xyz-start);r=ce=radius_mismatch=None
   radial=np.linalg.norm(points-center,axis=1)
   if length<1e-7:continue
   moves.append({'line':lineno,'layer':layer,'z':float(xyz[2]),'cmd':cmd,'length':float(length),'rmin':float(radial.min()),'rmax':float(radial.max()),'width':width,'speed':feed/60,'center_error':ce,'fitted_radius':r,'radius_mismatch':radius_mismatch,'start':start[:2].tolist(),'end':xyz[:2].tolist(),'points':points.tolist()})
report=[]
for l in sorted(set(x['layer'] for x in moves)):
 m=[x for x in moves if x['layer']==l]
 report.append({'layer':l,'z':m[0]['z'],'commands':dict(collections.Counter(x['cmd'] for x in m)),'length_range_mm':[min(x['length'] for x in m),max(x['length'] for x in m)],'centerline_radii_mm':[min(x['rmin'] for x in m),max(x['rmax'] for x in m)],'widths':sorted(set(x['width'] for x in m)),'speeds':sorted(set(x['speed'] for x in m)),'max_arc_radius_mismatch':max(x['radius_mismatch']or 0 for x in m)})
print(json.dumps(report[:5]+report[-2:],indent=2))
cli.output.write_text(json.dumps(report,indent=2)+'\n')
