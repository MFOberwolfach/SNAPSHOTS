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
a="maya.pdf mfo.jpg snapshotmfo.cls trackchanges.sty"
for f in $a; do
  echo "$__script: copying $f ..."
  cp "../../$f" .
done

echo "$__script: The files $a are necessary to compile the test files. So their latest versions have been copied into the testsuite/data directory."
read -p 'Press RETURN to proceed!' d 

