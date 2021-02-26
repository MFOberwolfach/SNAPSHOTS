#!/usr/bin/env python3

'''This script
 * removes previous pdf output,
 * compiles the latex files thoroughly,
 * merges the pdf output into 01_result.pdf,
 * removes temporary files.
This is done for the subdirectories other than 'junioreditor'.
'''

import argparse, configparser, glob, os, os.path, re, subprocess, sys
import copy_cls_files, tidy_up
from datetime import datetime

script = os.path.basename(__file__)
langs = ['USenglish', 'ngerman', 'spanish']

def mylog(a):
  print(script + ': ' + a, flush = True)
  
def myproc(b, dry = False):
  mylog(f'executing \'{" ".join(b)}\' ...')
  if not dry:
    subprocess.Popen(b).communicate()

def do(
  workdir,
  subs,
  sub = None,
  lang = None,
  keep = False,
  cls = False,
  dry = False
):
  mylog(f'start time: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}')
  
  ## start work
  os.chdir(workdir)
  
  ## determine subdirectories to process
  if lang:
    mysubs = ['lang_' + lang, ]
    if sub:
      mysubs.extend(sub)
  else:
    if sub:
      mysubs = sub
    else:
      mysubs = subs
      
  ## process subdirectories
  for s in mysubs:
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
    mylog(f"descending into subdirectory '{s}' ...")
    os.chdir(s)
    
    ## remove old temporary files
    tidy_up.do(
      workdir,
      subs,
      [s,],
      pdf = True,
      dry = dry
    )
    
    ## remove old result
    fnresult = '01_result.pdf'
    if os.path.exists(fnresult):
      mylog(f"deleting '{fnresult}' ...")
      if not dry:
        os.remove(fnresult)
        
    ## copy cls files
    copy_cls_files.do(workdir, subs, sub = [s,], dry = dry)
    
    ## compile latex files
    for fn in sorted(glob.glob('test-*.tex')):
      fnbase = re.sub('.tex$', '', fn)
      for cmd1 in ('pdflatex', 'bibtex', 'pdflatex', 'pdflatex'):
        myproc([cmd1 , fnbase], dry = dry)
      cmd.append(fnbase + '.pdf')
    
    ## produce final pdf
    mylog(f'merging pdf output into {fnresult} ...')
    cmd.extend(['cat', 'output', fnresult])    
    myproc(cmd, dry = dry)
    
    ## tidy up directory
    if not keep:
      tidy_up.do(
        workdir,
        subs,
        [s,],
        pdf = True,
        cls = cls,
        dry = dry
      )
  
  mylog(f'end time: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}')
  
  #input('Press RETURN to proceed!') 

if __name__ == '__main__':
  progdir = os.path.dirname(os.path.realpath(__file__))
  workdir = os.path.join(progdir, '../data')
  subs = sorted(next(os.walk(workdir))[1])
  subs.remove('junioreditor')
  
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
    '--cls',
    action = 'store_true',
    help = 'include the class file and others for deletion'
  )
  parser.add_argument(
    '-n',
    '--dry',
    action = 'store_true',
    help = 'only pretend to execute all the work'
  )
  args = parser.parse_args()
  
  do(
    workdir,
    subs,
    sub = args.sub,
    lang = args.lang,
    keep = args.keep,
    cls = args.cls,
    dry = args.dry
  )

  