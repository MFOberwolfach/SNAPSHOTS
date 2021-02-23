#!/usr/bin/env python3

'''This script
 * copies auxiliary files into the data subdirectories,
 * removes previous pdf output,
 * generates the latex files from the ini files, if necessary,
 * compiles the latex files thoroughly,
 * merges the relevant pdf output into 01_result.pdf,
 * removes temporary files.
'''

import argparse, configparser, glob, os, os.path, platform, re, subprocess, sys
from datetime import datetime

script = os.path.basename(__file__)
progdir = os.path.dirname(os.path.realpath(__file__))
workdir = os.path.join(progdir, '../data')
subs = next(os.walk(workdir))[1]
langs = ('USenglish', 'ngerman', 'spanish')

## parse command line
parser = argparse.ArgumentParser(description = 'generate 01_result*.pdf in each data subdirectory')
parser.add_argument(
  'vars',
  nargs = '*',
  help = f'Data subdirectories to process. Admissible values: {", ".join(subs)}.\
Without arguments, all subdirectories (relevant to the chosen language) are processed.'
)
parser.add_argument(
  '-l',
  '--lang',
  help = f'Language to process. Admissible values: {", ".join(langs)}. Default is to process all languages.'
)
parser.add_argument(
  '-k',
  '--keep',
  action = 'store_true',
  help = 'preserve temporary files'
)
parser.add_argument(
  '-n',
  '--dryrun',
  action = 'store_true',
  help = 'only pretend to execute all the work'
)
args = parser.parse_args()

## start work
print(f'{script}: start time: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}')
cmd = ['python3', os.path.join(progdir, 'copy-aux-files.py')]
if args.dryrun: cmd.insert(2, '-n')
subprocess.Popen(cmd).communicate()
os.chdir(workdir)

## determine subdirectories to process
if args.lang in langs:
  mysubs = ['lang_' + args.lang, 'junioreditor']
else:
  mysubs = []
if len(args.vars) > 0:
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
elif not mysubs:
  mysubs = subs
  print(f'{script}: processing all subdirectories as no command line arguments are present')

print('args.lang =', args.lang)
print('mysubs', mysubs)
#sys.exit()

## process subdirectories
for sub in mysubs:
  if sub == 'junioreditor':
    if args.lang:
      langlist = [args.lang, ]
    else:
      langlist = langs
    for lang in langlist:
      cmd = ['python3', os.path.join(progdir, 'test-junioreditor.py'), '-c', lang]
      if args.dryrun: cmd.insert(2, '-n')
      subprocess.Popen(cmd).communicate()
  else:
    cmd = ['python3', os.path.join(progdir, 'test-standard.py'), 'sub']
    if args.dryrun: cmd.insert(2, '-n')
    subprocess.Popen(cmd).communicate()

print(f'{script}: end time: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}')

#input('Press RETURN to proceed!') 