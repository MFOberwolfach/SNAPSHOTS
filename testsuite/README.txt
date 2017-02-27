testsuite README
================

purpose
-------
The test suite provides numerous latex files to test specific
features of the snapshot class snapshotmfo.cls and the template
file template.tex.

Conversly, the test suite can be used to check the sanity of the
latex and snapshots installation on a computer.


usage
-----
 * on Linux and macOS, resp.:

  1. run copy-aux-files.bash

  2. compile some test-*.tex files that attract your attention
     and edit them ad libitum

  3. run full-test.bash and examine the output data/all.pdf

 * on Windows:
 
  1. run copy-aux-files.cmd

  2. compile some test-*.tex files that attract your attention
     and edit them ad libitum

  3. download and install pdftk-server from
     https://www.pdflabs.com

  4. run full-test.cmd and examine the output data/all.pdf
  
You may have to adapt these scripts to your system.


content
-------
 * "data" subdirectory:

  - the unit tests test-*.tex are latex files, that can be
    compiled to test most of the changes since version 1.2.0
    case by case.

  - test-hyperref.tex contains quite a bit of documentation
    along with the test.

  - test-template.tex is somewhat special as it documents the
    warnings when compiling template.tex.

  - external-bibliography.bib is a supplement to
    test-references-from-separate-bib-file.tex. It has been
    created manually and should not be deleted.

 * "programs" subdirectory:

  - copy-aux-files.bash copies files from the main directory into
    the data directory needed to compile the latex files. This
    script works with Linux and macOS.

  - copy-aux-files.cmd does the same on Windows.

  - full-test.bash compiles all tests and merges the output into
    the single file data/all.pdf. A copy of the terminal output is
    stored in data/full-test.log. This script works with Linux
    and macOS.

  - full-test.cmd does essentially the same on Windows, but
    does not create a log file.

  - full-test-core.bash is called by full-test.bash.  

