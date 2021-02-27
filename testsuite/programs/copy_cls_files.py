#!/usr/bin/env python3

import argparse, datetime, logging, os, os.path, shutil, sys

script = os.path.basename(__file__)
clsfiles = ['maya.pdf', 'mfo.jpg', 'snapshotmfo.cls', 'trackchanges.sty']

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

def do(workdir, allsubs, chosensubs = None, dry = False):
  mylogtime('start')

  ## determine subdirectories to process
  if not chosensubs:
    chosensubs = allsubs
  chosensubs = sorted(list(set(chosensubs)))

  ## main program
  os.chdir(workdir)
  for s in chosensubs:
  #  mylog(f"processing subdirectory '{s}' ...")
    for f in clsfiles:
  #    mylog(f'copying {f} to {s} ...')
      if not dry:
        shutil.copy(os.path.join('../../', f), s)

  mylog([
    "The files",
    f"   {', '.join(clsfiles)}",
    "are necessary to compile the test files.",
    "So their latest versions have been copied into the subdirectories",
    f"   {', '.join(chosensubs)}",
    "of testsuite/data/."
  ])

  mylogtime('end')

if __name__ == '__main__':
  progdir = os.path.dirname(os.path.realpath(__file__))
  workdir = os.path.join(progdir, '../data')
  allsubs = sorted(next(os.walk(workdir))[1])

  ## parse command line
  parser = argparse.ArgumentParser(description = f'copy {", ".join(clsfiles)} into the data subdirectories')
  parser.add_argument(
    '-s',
    '--sub',
    choices = allsubs,
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

  do(workdir, allsubs, chosensubs = args.sub, dry = args.dry)

  #input('Press RETURN to proceed!')
