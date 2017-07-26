#!/usr/bin/env bash
# This script
#  * copies auxiliary files into the data directory,
#  * removes previous pdf output,
#  * compiles all test-*.tex files thoroughly,
#  * merges the pdf output into all.pdf.

## preparations
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace   # for debugging
__olddir="`pwd`"
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__script="$(basename "${BASH_SOURCE[0]}")"
__workdir="${__dir}/../data"
function finish {
  cd "$__olddir"
  echo -n "$__script: end time:   "
  date +'%Y-%m-%d %H:%M:%S'
}
trap finish EXIT
cd "$__workdir"

## main program
echo -n "$__script: start time: "
date +'%Y-%m-%d %H:%M:%S'

"${__dir}/copy-aux-files.bash"

echo "$__script: removing previous pdf output ..."
rm -f all.pdf test-*.pdf

for f in test-*.tex ; do
  g="${f%.*}"
  echo "$__script: compiling $g ..."
  pdflatex $g
  # some test-*.tex do not cite anything, which causes bibtex to raise errors,
  # so we force the following command to have exit code 0:
  bibtex $g || true
  pdflatex $g
  pdflatex $g
done

echo "$__script: merging pdf output into all.pdf ..."
# ghostscript most likely works on Linux and macOS:
gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=all.pdf test-*.pdf
#
# pdftk is not installed by default, but is freely available for
# Linux, macOS and Windows:
# pdftk test-*.pdf cat output all.pdf
#
# On macOS the following preinstalled python script should work, too:
# "/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py" -o all.pdf test-*.pdf

exit 0

