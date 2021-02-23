#!/usr/bin/env python3

'''This script
 * removes previous pdf output,
 * compiles the latex files thoroughly,
 * merges the pdf output into 01_result.pdf,
 * removes temporary files.
This is done for the subdirectories other than 'junioreditor'.
'''

import argparse, configparser, glob, os, os.path, platform, re, subprocess, sys
from datetime import datetime

script = os.path.basename(__file__)
progdir = os.path.dirname(os.path.realpath(__file__))
workdir = os.path.join(progdir, '../data')
subs = next(os.walk(workdir))[1]
subs.remove('junioreditor')
langs = ('USenglish', 'ngerman', 'spanish')


## parse command line
parser = argparse.ArgumentParser(description = 'generate 01_result.pdf in the standard data subdirectories')
parser.add_argument(
  'vars',
  nargs = '*',
  help = f'Data subdirectories to process. Admissible values: {", ".join(subs)}.\
Without arguments, all standard subdirectories are processed.'
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
  cmd = ['pdftk', ]      
  os.chdir(workdir)
  os.chdir(sub)
  
  # remove old temporary files
  cmd1 = ['python3', os.path.join(progdir, 'tidy-up.py'), '--pdf', sub]
  if args.dryrun: cmd1.insert(2, '-n')
  subprocess.Popen(cmd1).communicate()
  
  # remove old result
  fnresult = '01_result.pdf'
  if os.path.exists(fnresult):
    os.remove(fnresult)
  
  # compile latex files
  for fn in glob.glob('test-*.tex'):
    fnbase = re.sub('.tex$', '', fn)
    for cmd1 in ('pdflatex', 'bibtex', 'pdflatex', 'pdflatex'):
      print(f'{script}: {cmd1} {fnbase} ...')
      if not args.dryrun:
        subprocess.Popen([cmd1 , fnbase]).communicate()
    cmd.append(fnbase + '.pdf')
  
  ## produce final pdf
  print(f'{script}: merging pdf output into {fnresult}')
  cmd.extend(['cat', 'output', fnresult])    
  if not args.dryrun:
    subprocess.Popen(cmd).communicate()
  
  ## tidy up directory
  if not args.keep:
    cmd1 = ['python3', os.path.join(progdir, 'tidy-up.py'), '--pdf', sub]
    if args.dryrun: cmd1.insert(2, '-n')
    subprocess.Popen(cmd1).communicate()

#input('Press RETURN to proceed!') 
