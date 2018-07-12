#!/bin/bash
#
# This script downloads the IOC scripts from the EPICS xxx github repo and corrects them. 
#

IOC_NAME=vmc

# Linux programs used by this script
CURL=/usr/bin/curl
ECHO=/usr/bin/echo
CHMOD=/usr/bin/chmod

# The URL prefix for downloaded raw files from xxx
GITHUB=https://raw.githubusercontent.com/epics-modules/xxx/master

# This sed substitution corrects the IOC name
SUBSTITUTION="s/xxx/${IOC_NAME}/g"

FILENAME=release.pl
if [ ! -f ${FILENAME} ]
then
  ${ECHO} "Getting ${FILENAME}"
  ${CURL} -Os ${GITHUB}/${FILENAME}
fi

FILENAME=setup_epics_common
if [ ! -f ${FILENAME} ]
then
  ${ECHO} "Getting ${FILENAME}"
  ${CURL} -Os ${GITHUB}/${FILENAME}
fi

FILENAME=start_MEDM_${IOC_NAME}
if [ ! -f ${FILENAME} ]
then
  ${ECHO} "Getting ${FILENAME}"
  ${CURL} -s ${GITHUB}/start_MEDM_xxx | sed -e "${SUBSTITUTION}" > ${FILENAME}
  ${CHMOD} a+x ${FILENAME}
fi

FILENAME=start_caQtDM_${IOC_NAME}
if [ ! -f ${FILENAME} ]
then
  ${ECHO} "Getting ${FILENAME}"
  ${CURL} -s ${GITHUB}/start_caQtDM_xxx | sed -e "${SUBSTITUTION}" > ${FILENAME}
  ${CHMOD} a+x ${FILENAME}
fi

FILENAME=iocBoot/ioc${IOC_NAME}/${IOC_NAME}.sh
if [ ! -f ${FILENAME} ]
then
  ${ECHO} "Getting ${FILENAME}"
  # The second sed substition is needed because the location of the new script is one directory above the source script
  ${CURL} -s ${GITHUB}/iocBoot/iocxxx/softioc/xxx.sh | sed -e "${SUBSTITUTION}" -e 's/\/\.\.$//' > ${FILENAME}
  ${CHMOD} a+x ${FILENAME}
fi
