#!/usr/bin/env python3
'This script copies auxiliary files into the subdirectories of testsuite/data/.'
import os, os.path, shutil, sys

## preparations
script = os.path.basename(__file__)
progdir = os.path.dirname(os.path.realpath(__file__))
workdir = os.path.join(progdir, '../data')
os.chdir(workdir)

## main program
files = ('maya.pdf', 'mfo.jpg', 'snapshotmfo.cls', 'trackchanges.sty',)
sub = []
for t in next(os.walk('.'))[1]:
  sub.append(t)
  for f in files:
#    print(f'{script}: copying {f} to {t} ...')
    shutil.copy(os.path.join('../../', f), t)

print(f'''\
{script}: \
The files 
   {', '.join(files)}
are necessary to compile the test files. 
So their latest versions have been copied into the subdirectories 
   {', '.join(sub)}
of testsuite/data/.''')
input('Press RETURN to proceed!') 

