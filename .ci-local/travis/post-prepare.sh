#!/bin/bash

set -e

# Set VV in .travis.yml to make scripts verbose
[ "$VV" ] && set -x

CACHEDIR=${CACHEDIR:-${HOME}/.cache}

# source functions
. ./.ci/travis/utils.sh

# sanity check
#!echo -e "${ANSI_BLUE}Contents of motor-${MOTOR}/modules/RELEASE.*.local${ANSI_RESET}"
#!cat ${CACHEDIR}/motor-${MOTOR}/modules/RELEASE.*
#!echo -e "${ANSI_BLUE}End of motor-${MOTOR}/modules/RELEASE.*.local${ANSI_RESET}"

# Enable the building of example IOCs
echo -e "${ANSI_BLUE}Creating CONFIG_SITE.local${ANSI_RESET}"
echo -e "BUILD_IOCS = YES" > CONFIG_SITE.local
cat CONFIG_SITE.local
echo -e "${ANSI_BLUE}End of CONFIG_SITE.local${ANSI_RESET}"
