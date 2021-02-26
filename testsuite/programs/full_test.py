#!/usr/bin/env python3

'''This script
 * copies auxiliary files into the data subdirectories,
 * removes previous pdf output,
 * generates the latex files from the ini files, if necessary,
 * compiles the latex files thoroughly,
 * merges the relevant pdf output into 01_result.pdf,
 * removes temporary files.
'''

import argparse, configparser, glob, os, os.path, re, subprocess, sys
from datetime import datetime

script = os.path.basename(__file__)
progdir = os.path.dirname(os.path.realpath(__file__))
workdir = os.path.join(progdir, '../data')
subs = next(os.walk(workdir))[1]
langs = ['USenglish', 'ngerman', 'spanish']

def mylog(a):
  print(script + ': ' + a, flush = True)
  
def myproc(b, internal = True):
  if internal:
    if args.dryrun: b.insert(2, '-n')
    mylog(f'executing \'{" ".join(b)}\' ...')
    subprocess.Popen(b).communicate()
  else:
    mylog(f'executing \'{" ".join(b)}\' ...')
    if not args.dryrun:
      subprocess.Popen(b).communicate()

mylog(f'start time: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}')
  
## parse command line
parser = argparse.ArgumentParser(description = 'generate 01_result*.pdf in each data subdirectory')
parser.add_argument(
  '-s',
  '--sub',
  choices = subs,
  action = 'append',
  help = f'Data subdirectories to process. Without arguments, all subdirectories (relevant to the chosen language) are processed.'
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
  '-p',
  '--purge',
  action = 'store_true',
  help = 'delete the class file and others'
)
parser.add_argument(
  '-n',
  '--dryrun',
  action = 'store_true',
  help = 'only pretend to execute all the work'
)
args = parser.parse_args()
#mylog(f"options are {args}")

## start work
os.chdir(workdir)

## determine subdirectories to process
if args.lang:
  mysubs = ['lang_' + args.lang, 'junioreditor']
  if args.sub:
    mysubs.extend(args.sub)
else:
  if args.sub:
    mysubs = args.sub
  else:
    mysubs = subs


## process subdirectories
for sub in mysubs:
  if sub == 'junioreditor':
    if args.lang:
      langlist = [args.lang, ]
    else:
      langlist = langs
    for lang in langlist:
      cmd = ['python3', os.path.join(progdir, 'test-junioreditor.py'), '-c', lang]
      if args.keep: cmd.insert(2, '-k')
      if args.purge: cmd.insert(2, '-p')
      myproc(cmd)
  else:
    cmd = ['python3', os.path.join(progdir, 'test-standard.py'), '-s', sub]
    if args.keep: cmd.insert(2, '-k')
    if args.purge: cmd.insert(2, '-p')
    myproc(cmd)

mylog(f'end time: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}')

#input('Press RETURN to proceed!') 
