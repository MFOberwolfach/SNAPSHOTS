#!/bin/bash
# Compile all test files and merge the output into a single pdf file.
. aux_.sh
rm all.pdf test*.pdf
for f in test*.tex; do
  g="${f%.*}"
  echo "compiling $g ..."
  pdflatex $g
  bibtex $g
  pdflatex $g
  pdflatex $g
done
# ghostscript most likely works on Linux and macOS:
gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=all.pdf test-*.pdf
# pdftk is not installed by default, but is freely available for
# Linux, macOS and Windows:
# pdftk test*.pdf cat output all.pdf
# On macOS the following preinstalled python script should work, too:
# "/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py" -o all.pdf test-*.pdf
