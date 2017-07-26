#!/usr/bin/env bash
# This script copies auxiliary files into the testsuite/data directory.

## preparations
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace   # for debugging
__olddir="`pwd`"
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__script="$(basename "${BASH_SOURCE[0]}")"
__workdir="${__dir/%programs/data}"
function finish {
  cd "$__olddir"
}
trap finish EXIT
cd "$__workdir"

## main program
m=0
a="maya.pdf mfo.jpg snapshotmfo.cls trackchanges.sty"
for f in $a; do
  if test ! -e "$f" ; then
    echo "$__script: copying $f ..."
    cp "../../$f" .
    m=1
  fi
done

if test "$m" -eq 1 ; then
  echo "$__script: The files $a are necessary to compile the test files. Therefore the missing files have been copied into the data directory."
  read -p 'Press RETURN to proceed!' d 
else
  echo "$__script: Copies of the files $a are already in the data directory."
fi

