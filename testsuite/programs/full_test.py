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
  help = f"Language to process. Default is to process all languages, if subdirectory 'junioreditor' is chosen."
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

## determine subdirectories to process
if args.lang:
  chosensubs = ['lang_' + args.lang, 'junioreditor',]
  if args.sub:
    chosensubs.extend(args.sub)
else:
  if args.sub:
    chosensubs = args.sub
  else:
    chosensubs = allsubs
chosensubs = sorted(list(set(chosensubs)))

## junioreditor tests
je = False
if 'junioreditor' in chosensubs:
  je = True
  if args.lang:
    langs = [args.lang, ]
  else:
    langs = alllangs
  test_junioreditor.do(
    workdir,
    cfbase = langs,
    keep = args.keep,
    cls = args.cls,
    dry = args.dry
  )

## standard tests
st = False
remains = [s for s in chosensubs if not re.match('junioreditor', s)]
if remains:
  st = True
  test_standard.do(
    workdir,
    remains,
    lang = args.lang,
    keep = args.keep,
    cls = args.cls,
    dry = args.dry
  )

## produce overall result file
os.chdir(workdir)
cmd = ['pdftk', ]
if je:
  cmd.append(os.path.join('junioreditor', '01_result.pdf'))
if st:
  cmd.append('01_result_standard.pdf')
cmd.extend(['cat', 'output', '01_result.pdf'])
mylog(f"producing overall result file in direcotry '{workdir}' ...")
myproc(cmd, dry = args.dry)

mylogtime('end')

#input('Press RETURN to proceed!')
