#!/usr/bin/env bash
# This script
#  * executes full-test-core.bash,
#  * copies the terminal output to full-test.log.

## preparations
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace   # for debugging
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__script="$(basename "${BASH_SOURCE[0]}")"
__logfile="$__dir/../data/full-test.log"
function finish {
  echo "$__script: terminal output has been copied to $__logfile"
}
trap finish EXIT

## main program
"$__dir/full-test-core.bash" | tee "$__logfile"

