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

# The module to be built isn't in the cache directory with the dependencies
pwd

# Copy the travis RELEASE.local to the configure dir
cp -f ${CACHEDIR}/RELEASE.local configure/RELEASE.local

# Enable the building of example IOCs
echo -e "${ANSI_BLUE}Creating configure/CONFIG_SITE.local${ANSI_RESET}"
echo -e "BUILD_IOCS = YES" > configure/CONFIG_SITE.local
cat configure/CONFIG_SITE.local
echo -e "${ANSI_BLUE}End of configure/CONFIG_SITE.local${ANSI_RESET}"
