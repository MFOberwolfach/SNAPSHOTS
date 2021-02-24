#!/usr/bin/env python3

import argparse, os, os.path, shutil, sys
from datetime import datetime

script = os.path.basename(__file__)
progdir = os.path.dirname(os.path.realpath(__file__))
workdir = os.path.join(progdir, '../data')
subs = next(os.walk(workdir))[1]
clsfiles = ['maya.pdf', 'mfo.jpg', 'snapshotmfo.cls', 'trackchanges.sty']

def mylog(a):
  print(script + ': ' + a, flush = True)
  
mylog(f'start time: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}')

## parse command line
parser = argparse.ArgumentParser(description = f'copy {", ".join(clsfiles)} into the data subdirectories')
parser.add_argument(
  '-s',
  '--sub',
  choices = subs,
  action = 'append',
  help = f'Data subdirectories to process. Without arguments, all subdirectories are processed.'
)
parser.add_argument(
  '-n',
  '--dryrun',
  action = 'store_true',
  help = 'pretend only to execute the tasks'
)
args = parser.parse_args()
#mylog(f"options are {args}")
  
## determine subdirectories to process
if not args.sub:
  args.sub = subs

## main program
os.chdir(workdir)
for sub in args.sub:
#  mylog(f"processing subdirectory '{sub}' ...")
  for f in clsfiles:
#    mylog(f'copying {f} to {sub} ...')
    if not args.dryrun:
      shutil.copy(os.path.join('../../', f), sub)

mylog(f'''
The files 
   {', '.join(clsfiles)}
are necessary to compile the test files. 
So their latest versions have been copied into the subdirectories 
   {', '.join(args.sub)}
of testsuite/data/.''')

mylog(f'end time: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}')

#input('Press RETURN to proceed!') 
