#!/usr/bin/env python3

import argparse, os, os.path, shutil, sys

script = os.path.basename(__file__)
progdir = os.path.dirname(os.path.realpath(__file__))
workdir = os.path.join(progdir, '../data')
subs = next(os.walk(workdir))[1]

## parse command line
parser = argparse.ArgumentParser(description = f'copy {", ".join(clsfiles)} into the data subdirectories')
parser.add_argument(
  'vars',
  nargs = '*',
  help = f'Data subdirectories to process. Admissible values: {", ".join(subs)}.\
  Without arguments, all subdirectories are processed.'
)
parser.add_argument(
  '-n',
  '--dryrun',
  action = 'store_true',
  help = 'only pretend to execute all the work'
)
args = parser.parse_args()
  
## determine subdirectories to process
if len(args.vars) > 0:
  mysubs = []
  for v in args.vars:
    if v in subs:
      mysubs.append(v)
    else:
      print(f"{script}: ignoring '{v}' as it is not a subdirectory name")
  mysubs = list(set(mysubs))
  if len(mysubs) > 0:
    print(f'{script}: {len(mysubs)} of {len(subs)} possible subdirectories chosen')
  else:
    print(f'{script}: no subdirectory chosen, nothing to do')
    sys.exit(0)
else:
  mysubs = subs
  print(f'{script}: processing all subdirectories as no command line arguments are present')

## main program
os.chdir(workdir)
for t in mysubs:
  for f in clsfiles:
#    print(f'{script}: copying {f} to {t} ...')
    if not args.dryrun:
      shutil.copy(os.path.join('../../', f), t)

print(f'''\
{script}: \
The files 
   {', '.join(clsfiles)}
are necessary to compile the test files. 
So their latest versions have been copied into the subdirectories 
   {', '.join(mysubs)}
of testsuite/data/.''')
input('Press RETURN to proceed!') 
