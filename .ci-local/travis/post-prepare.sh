#!/bin/bash

set -e

# Set VV in .travis.yml to make scripts verbose
[ "$VV" ] && set -x

CACHEDIR=${CACHEDIR:-${HOME}/.cache}

# source functions
. ./.ci/travis/utils.sh

# sanity check
echo -e "${ANSI_BLUE}Contents of motor-${MOTOR}/modules/RELEASE.*.local${ANSI_RESET}"

cat ${CACHEDIR}/motor-${MOTOR}/modules/RELEASE.*

echo -e "${ANSI_BLUE}End of motor-${MOTOR}/modules/RELEASE.*.local${ANSI_RESET}"
