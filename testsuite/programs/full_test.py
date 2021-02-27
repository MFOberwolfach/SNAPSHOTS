#!/usr/bin/env python3

'''This script
 * copies auxiliary files into the data subdirectories,
 * removes previous pdf output,
 * generates the latex files from the ini files, if necessary,
 * compiles the latex files thoroughly,
 * merges the relevant pdf output into 01_result.pdf,
 * removes temporary files.
'''

import argparse, configparser, datetime, glob, os, os.path, re, subprocess, sys
import test_standard, test_junioreditor

script = os.path.basename(__file__)
progdir = os.path.dirname(os.path.realpath(__file__))
workdir = os.path.join(progdir, '../data')
allsubs = sorted(next(os.walk(workdir))[1])
alllangs = ['USenglish', 'ngerman', 'spanish']

def mylog(a):
  if isinstance(a, str):
    b = [a,]
  else:
    b = a
  for line in b:
    print(script + ': ' + line, flush = True)

def mylogtime(*a):
  if a:
    b = a[0]
  else:
    b = 'current'
  mylog(f'{b} time: {datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")}')

def myproc(b, dry = False):
  mylog(f'executing \'{" ".join(b)}\' ...')
  if not dry:
    subprocess.Popen(b).communicate()

mylogtime('start')

## parse command line
parser = argparse.ArgumentParser(description = 'generate 01_result*.pdf in each data subdirectory')
parser.add_argument(
  '-s',
  '--sub',
  choices = allsubs,
  action = 'append',
  help = f'Data subdirectories to process. Without arguments, all subdirectories (relevant to the chosen language) are processed.'
)
parser.add_argument(
  '-l',
  '--lang',
  choices = alllangs,
  help = f'Language to process. Default is to process all languages.'
)
parser.add_argument(
  '-k',
  '--keep',
  action = 'store_true',
  help = 'preserve temporary files'
)
parser.add_argument(
  '--cls',
  action = 'store_true',
  help = 'delete the class file and others'
)
parser.add_argument(
  '-n',
  '--dry',
  action = 'store_true',
    help = 'pretend only to execute the tasks'
)
args = parser.parse_args()

if args.sub:
  chosensubs = args.sub
else:
  chosensubs = allsubs
chosensubs = sorted(list(set(chosensubs)))

## junioreditor tests
if 'junioreditor' in chosensubs or args.lang:
  if args.lang:
    langs = [args.lang, ]
  else:
    langs = alllangs
  for lang in langs:
    test_junioreditor.do(
      workdir,
      cfbase = lang,
      keep = args.keep,
      cls = args.cls,
      dry = args.dry
    )

## standard tests
remains = [s for s in chosensubs if not re.match('junioreditor', s)]
test_standard.do(
  workdir,
  remains,
  lang = args.lang,
  keep = args.keep,
  cls = args.cls,
  dry = args.dry
)

mylogtime('end')

#input('Press RETURN to proceed!')
