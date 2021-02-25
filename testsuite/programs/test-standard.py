#!/usr/bin/env python3

'''This script
 * removes previous pdf output,
 * compiles the latex files thoroughly,
 * merges the pdf output into 01_result.pdf,
 * removes temporary files.
This is done for the subdirectories other than 'junioreditor'.
'''

import argparse, configparser, glob, os, os.path, re, subprocess, sys
from datetime import datetime

script = os.path.basename(__file__)
progdir = os.path.dirname(os.path.realpath(__file__))
workdir = os.path.join(progdir, '../data')
subs = next(os.walk(workdir))[1]
subs.remove('junioreditor')
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
parser = argparse.ArgumentParser(description = 'generate 01_result.pdf in the standard data subdirectories')
parser.add_argument(
  '-s',
  '--sub',
  choices = subs,
  action = 'append',
  help = f'Data subdirectories to process. Without arguments, all subdirectories are processed.'
)
parser.add_argument(
  '-l',
  '--lang',
  choices = langs,
  help = f'Language to process. Default is to process all languages.'
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
  help = 'include the class file and others for deletion'
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
  mysubs = ['lang_' + args.lang, ]
  if args.sub:
    mysubs.extend(args.sub)
else:
  if args.sub:
    mysubs = args.sub
  else:
    mysubs = subs
    
## process subdirectories
for sub in mysubs:
  #
  # pdftk is not installed by default, but is freely available for Linux, macOS and Windows:
  # pdftk test-*.pdf cat output 01_result.pdf
  #
  # ghostscript most likely works on Linux and macOS:
  # gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=01_result.pdf test-*.pdf
  #
  # On macOS the following preinstalled python script should work, too:
  # "/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py" -o 01_result.pdf test-*.pdf
  #
  cmd = ['pdftk', ]
  os.chdir(workdir)
  mylog(f"descending into subdirectory '{sub}' ...")
  os.chdir(sub)
  
  ## remove old temporary files
  myproc(['python3', os.path.join(progdir, 'tidy-up.py'), '--pdf', '-s', sub])
  
  ## remove old result
  fnresult = '01_result.pdf'
  if os.path.exists(fnresult):
    mylog(f"deleting '{fnresult}' ...")
    if not args.dryrun:
      os.remove(fnresult)
      
  ## copy cls files
  myproc(['python3', os.path.join(progdir, 'copy-cls-files.py'), '-s', sub])

  ## compile latex files
  for fn in sorted(glob.glob('test-*.tex')):
    fnbase = re.sub('.tex$', '', fn)
    for cmd1 in ('pdflatex', 'bibtex', 'pdflatex', 'pdflatex'):
      myproc([cmd1 , fnbase], internal = False)
    cmd.append(fnbase + '.pdf')
  
  ## produce final pdf
  mylog(f'merging pdf output into {fnresult} ...')
  cmd.extend(['cat', 'output', fnresult])    
  myproc(cmd, internal = False)
  
  ## tidy up directory
  if not args.keep:
    cmd1 = ['python3', os.path.join(progdir, 'tidy-up.py'), '--pdf', '-s', sub]
    if args.purge: cmd1.insert(2, '-p')
    myproc(cmd1)

mylog(f'end time: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}')

#input('Press RETURN to proceed!') 
