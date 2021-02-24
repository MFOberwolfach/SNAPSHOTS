testsuite README
================

purpose
-------
The test suite provides numerous latex files to test specific
features of the snapshot class snapshotmfo.cls and the template
file template.tex.

Conversly, the test suite can be used to check the sanity of the
latex and snapshots installation on a computer.

prerequisites
-------------
  - latex environment
  - python3
  - pdftk
  
On Windows download and install pdftk-server from
https://www.pdflabs.com.

The scripts should work on Linux, macOS and Windows, but you may
have to adapt them to your system. 

usage
-----
  0. run each scripts with the option --help first
  
  1. run copy-aux-files.py

  2. compile some test-*.tex files that attract your attention
     and edit them ad libitum

  3. run test-junioreditor.py to process the speical subdirectory
     data/junioreditor/
     
  4. run full-test.py and examine the output files
     data/<subdir>/01_result.pdf

content
-------
 * "data" directory:
 
  - the subdirectory "general" contains language-independent tests
  
  - the subdirectories "lang_*" contain tests of the language
    settings USenglish, ngerman and spanish
    
  - the subdirectory "junioreditor" contains automated tests
    of the three languages to be run by test-junioreditor.py
  
  - the unit tests test-*.tex are latex files, that can be
    compiled to test most of the changes since version 1.2.0
    case by case

  - test-hyperref.tex contains quite a bit of documentation
    along with the test

  - test-template.tex is somewhat special as it documents the
    warnings when compiling template.tex

  - external-bibliography.bib is a supplement to
    test-references-from-separate-bib-file.tex. It has been
    created manually and should not be deleted.

 * "programs" directory:

  - copy-aux-files.py copies files from the main directory into
    the data directory needed to compile the latex files.

  - full-test.py compiles all tests and merges the output into
    the files data/<subdir>/01_result*.pdf.

  - "test-junioreditor.py -c <lang>", where lang = USenglish,
    ngerman or spanish, runs the tests in data/junioreditor.
    
  - tidy-up.py removes temporary files.