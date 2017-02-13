#!/bin/bash
# Copy auxiliary files into testsuite folder.
# The name aux without a trailing underscore is a reserved file name in MS Windows.

m=0
a="maya.pdf mfo.jpg snapshotmfo.cls trackchanges.sty"
for f in $a; do
  if test ! -e "$f" ; then
    cp "../$f" .
	m=1
  fi
done
if test "$m" -eq 1 ; then
  echo "The files $a are necessary to compile the test files. Therefore the missing files have been copied into this folder."
  read -p 'Press RETURN to proceed!' d 
fi