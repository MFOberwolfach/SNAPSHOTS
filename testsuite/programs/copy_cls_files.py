#!/usr/bin/env python3

import argparse, logging, os, os.path, shutil, sys
from datetime import datetime

script = os.path.basename(__file__)
clsfiles = ['maya.pdf', 'mfo.jpg', 'snapshotmfo.cls', 'trackchanges.sty']

def mylog(a):
  print(script + ': ' + a, flush = True)

def do(workdir, subs, sub = None, dry = False):
  global script
  mylog(f'start time: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}')
  
  ## determine subdirectories to process
  if not sub:
    sub = subs
  
  ## main program
  os.chdir(workdir)
  for s in sub:
  #  mylog(f"processing subdirectory '{s}' ...")
    for f in clsfiles:
  #    mylog(f'copying {f} to {s} ...')
      if not dry:
        shutil.copy(os.path.join('../../', f), sub)
  
  mylog("The files") 
  mylog(f"   {', '.join(clsfiles)}")
  mylog("are necessary to compile the test files.")
  mylog("So their latest versions have been copied into the subdirectories")
  mylog(f"   {', '.join(sub)}")
  mylog("of testsuite/data/.")
  
  mylog(f'end time: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}')
  
  #input('Press RETURN to proceed!')
  
if __name__ == '__main__':
  progdir = os.path.dirname(os.path.realpath(__file__))
  workdir = os.path.join(progdir, '../data')
  subs = sorted(next(os.walk(workdir))[1])

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
    '--dry',
    action = 'store_true',
    help = 'pretend only to execute the tasks'
  )
  args = parser.parse_args()
  
  do(workdir, subs, sub = args.sub, dry = args.dry)
 