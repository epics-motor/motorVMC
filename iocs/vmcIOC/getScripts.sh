#!/bin/bash
#
# This script downloads the IOC scripts from the EPICS xxx github repo and corrects them. 
#

IOC_NAME=vmc

# Linux programs used by this script
CURL=/usr/bin/curl
ECHO=/usr/bin/echo
CHMOD=/usr/bin/chmod
CD=/usr/bin/cd
RM=/bin/rm

# The URL prefix for downloaded raw files from xxx
GITHUB=https://raw.githubusercontent.com/epics-modules/xxx/master

# This sed substitution corrects the IOC name
SUBSTITUTION="s/xxx/${IOC_NAME}/g"

# Assume the script remains in the IOC's top-level directory (important for allowing the script to be called from other working dirs)
IOC_DIR=`dirname $0`

FILENAME=release.pl
if [ ! -f ${IOC_DIR}/${FILENAME} ]
then
  ${ECHO} "Getting ${IOC_DIR}/${FILENAME}"
  ${CURL} -s ${GITHUB}/${FILENAME} > ${IOC_DIR}/${FILENAME}
else
  ${ECHO} "Removing ${IOC_DIR}/${FILENAME}"
  ${RM} -f ${IOC_DIR}/${FILENAME}
fi

FILENAME=setup_epics_common
if [ ! -f ${IOC_DIR}/${FILENAME} ]
then
  ${ECHO} "Getting ${IOC_DIR}/${FILENAME}"
  ${CURL} -s ${GITHUB}/${FILENAME} > ${IOC_DIR}/${FILENAME}
else
  ${ECHO} "Removing ${IOC_DIR}/${FILENAME}"
  ${RM} -f ${IOC_DIR}/${FILENAME}
fi

FILENAME=start_medm_${IOC_NAME}
if [ ! -f ${IOC_DIR}/${FILENAME} ]
then
  ${ECHO} "Getting ${IOC_DIR}/${FILENAME}"
  ${CURL} -s ${GITHUB}/start_MEDM_xxx | sed -e "${SUBSTITUTION}" > ${IOC_DIR}/${FILENAME}
  ${CHMOD} a+x ${IOC_DIR}/${FILENAME}
else
  ${ECHO} "Removing ${IOC_DIR}/${FILENAME}"
  ${RM} -f ${IOC_DIR}/${FILENAME}
fi

FILENAME=start_caQtDM_${IOC_NAME}
if [ ! -f ${IOC_DIR}/${FILENAME} ]
then
  ${ECHO} "Getting ${IOC_DIR}/${FILENAME}"
  ${CURL} -s ${GITHUB}/start_caQtDM_xxx | sed -e "${SUBSTITUTION}" > ${IOC_DIR}/${FILENAME}
  ${CHMOD} a+x ${IOC_DIR}/${FILENAME}
else
  ${ECHO} "Removing ${IOC_DIR}/${FILENAME}"
  ${RM} -f ${IOC_DIR}/${FILENAME}
fi

FILENAME=iocBoot/ioc${IOC_NAME}/${IOC_NAME}.sh
if [ ! -f ${IOC_DIR}/${FILENAME} ]
then
  ${ECHO} "Getting ${IOC_DIR}/${FILENAME}"
  # The second sed substition is needed because the location of the new script is one directory above the source script
  ${CURL} -s ${GITHUB}/iocBoot/iocxxx/softioc/xxx.sh | sed -e "${SUBSTITUTION}" -e 's/\/\.\.$//' > ${IOC_DIR}/${FILENAME}
  ${CHMOD} a+x ${IOC_DIR}/${FILENAME}
else
  ${ECHO} "Removing ${IOC_DIR}/${FILENAME}"
  ${RM} -f ${IOC_DIR}/${FILENAME}
fi
