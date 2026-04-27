#!/usr/bin/env python3

'''This script
 * removes previous pdf output,
 * compiles the latex files thoroughly,
 * merges the pdf output into 01_result.pdf,
 * removes temporary files.
This is done for the subdirectories other than 'junioreditor'.
'''

import argparse, concurrent.futures, configparser, datetime, glob, os, os.path, re, subprocess, sys
import copy_cls_files, tidy_up

script = os.path.basename(__file__)
alllangs = ['USenglish', 'ngerman', 'spanish', 'french']

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

def myproc(b, dry = False, quiet = False, cwd = None):
  mylog(f'executing \'{" ".join(b)}\' ...')
  if not dry:
    subprocess.Popen(b,
                     cwd = cwd,
                     stdout = subprocess.DEVNULL if quiet else None
                     ).communicate()

def do(
  workdir,
  standardsubs,
  chosensubs = None,
  lang = None,
  keep = False,
  cls = False,
  dry = False,
  quiet = False,
  multithread = False,
):
  mylogtime('start')

  ## determine subdirectories to process
  if chosensubs:
    if lang:
      chosensubs.append('lang_' + lang)
  else:
    chosensubs = standardsubs
  chosensubs = sorted(list(set(chosensubs)))

  ## remove old temporary files and results
  tidy_up.do(
    workdir,
    standardsubs,
    chosensubs = chosensubs,
    pdf = True,
    res = True,
    dry = dry
  )

  ## copy cls files
  copy_cls_files.do(workdir, standardsubs, chosensubs = chosensubs, dry = dry)

  fnresult = f'01_result.pdf'
  compound = ['pdftk', ]
  for s in chosensubs:
    os.chdir(workdir)
    mylog(f"descending into subdirectory '{s}' ...")
    os.chdir(s)
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

    def process_section(fnbase, dry, quiet, cwd):
      for cmd1 in ('pdflatex', 'bibtex', 'pdflatex', 'pdflatex'):
        myproc([cmd1 , fnbase], dry = dry, quiet = quiet, cwd = cwd)


    ## compile latex files
    with concurrent.futures.ThreadPoolExecutor() as executor:
      for fn in sorted(glob.glob('test-*.tex')):
        fnbase = re.sub('.tex$', '', fn)
        cmd.append(fnbase + '.pdf')
        cwd = os.getcwd()
        if multithread:
          executor.submit(process_section, fnbase, dry, quiet, cwd)
        else:
          process_section(fnbase, dry, quiet, cwd)

    ## produce final pdf
    mylog(f'merging pdf output into {fnresult} ...')
    cmd.extend(['cat', 'output', fnresult])
    myproc(cmd, dry = dry)
    compound.append(os.path.join(s, fnresult))

  ## produce overall result file
  os.chdir(workdir)
  fncompound = '01_result_standard.pdf'
  compound.extend(['cat', 'output', fncompound])
  mylog(f"producing overall result file in direcotry '{workdir}' ...")
  myproc(compound, dry = dry)

  ## tidy up directory
  if not keep:
    tidy_up.do(
      workdir,
      standardsubs,
      chosensubs = chosensubs,
      pdf = True,
      cls = cls,
      dry = dry
    )

  mylogtime('end')

if __name__ == '__main__':
  progdir = os.path.dirname(os.path.realpath(__file__))
  workdir = os.path.abspath(os.path.join(progdir, '../data'))
  allsubs = sorted(next(os.walk(workdir))[1])
  standardsubs = [s for s in allsubs if not re.match('junioreditor', s)]

  ## parse command line
  parser = argparse.ArgumentParser(description = 'generate 01_result.pdf in the standard data subdirectories')
  parser.add_argument(
    '-s',
    '--sub',
    choices = standardsubs,
    action = 'append',
    help = f'Data subdirectories to process. Without arguments, all standard subdirectories are processed.'
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
    '-p',
    '--cls',
    action = 'store_true',
    help = 'include the class file and others for deletion'
  )
  parser.add_argument(
    '-n',
    '--dry',
    action = 'store_true',
    help = 'pretend only to execute the tasks'
  )
  parser.add_argument(
    '-q',
    '--quiet',
    action = 'store_true',
    help = 'ignore the output of pdflatex and bibtex commands'
  )
  parser.add_argument(
    '-m',
    '--multithread',
    action = 'store_true',
    help = 'compile each test file in its own thread'
  )

  args = parser.parse_args()

  do(
    workdir,
    standardsubs,
    chosensubs = args.sub,
    lang = args.lang,
    keep = args.keep,
    cls = args.cls,
    dry = args.dry,
    quiet = args.quiet,
    multithread = args.multithread,
  )

  #input('Press RETURN to proceed!')
