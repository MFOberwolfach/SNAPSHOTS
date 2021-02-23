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
langs = ('USenglish', 'ngerman', 'spanish')

## parse command line
parser = argparse.ArgumentParser(description = 'generate 01_result.pdf in each data subdirectory')
parser.add_argument(
  'vars',
  nargs = '*',
  help = 'Data subdirectories to process. Admissible values: general, junioreditor, lang_USenglish, lang_ngerman, lang_spanish.\
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
args = parser.parse_args()
script = os.path.basename(__file__)
progdir = os.path.dirname(os.path.realpath(__file__))
workdir = os.path.join(progdir, '../data')

## start work
print(f'{script}: start time: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}')
subprocess.Popen(['python3', os.path.join(progdir, 'copy-aux-files.py')]).communicate()
os.chdir(workdir)

# determine subdirectories to process
subs = next(os.walk('.'))[1]
if args.lang in langs:
  mysubs = ['lang_' + args.lang, 'junioreditor']
else:
  mysubs = []
if len(args.vars) > 0:
  for v in args.vars:
    if v in subs:
      mysubs.append(v)
    else:
      print(f"ignoring '{v}' as it is not a subdirectory name")
  mysubs = list(set(mysubs))
  if len(mysubs) > 0:
    print(f'{len(mysubs)} of {len(subs)} possible subdirectories chosen')
  else:
    print('no subdirectory chosen, nothing to do')
    sys.exit(0)
elif not mysubs:
  mysubs = subs
  print('processing all subdirectories as no command line arguments are present')


print('args.lang =', args.lang)
print('mysubs', mysubs)
#sys.exit()

# process subdirectories
for sub in mysubs:
  if sub == 'junioreditor':
    if args.lang:
      langlist = [args.lang, ]
    else:
      langlist = langs
    for lang in langlist:
      subprocess.Popen(['python3', os.path.join(progdir, 'test-junioreditor.py'), '-c', lang, 'fs']).communicate()
  else:
    cmd = ['pdftk', ]      
    os.chdir(workdir)
    os.chdir(sub)
    
    # remove old temporary files
    subprocess.Popen(['python3', os.path.join(progdir, 'tidy-up.py'), '--pdf']).communicate()
    
    # remove old result
    fnresult = '01_result.pdf'
    if os.path.exists(fnresult):
      os.remove(fnresult)
    
    # compile latex files
    for fn in glob.glob('test-*.tex'):
      fnbase = re.sub('.tex$', '', fn)
      for cmd1 in ('pdflatex', 'bibtex', 'pdflatex', 'pdflatex'):
        subprocess.Popen([cmd1 , fnbase]).communicate()
      cmd.append(fnbase + '.pdf')
    
    ## produce final pdf
    print(f'merging pdf output into {fnresult}')
    cmd.extend(['cat', 'output', fnresult])    
    subprocess.Popen(cmd).communicate()
    
    ## tidy up directory
    if not args.keep:
      subprocess.Popen(['python3', os.path.join(progdir, 'tidy-up.py'), '--pdf', '--workdir', os.path.join(workdir, sub)]).communicate()
