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

# doWork infile outfile exe subs1 subs2 subs3
doWork () {
  IN_FILE=$1
  OUT_FILE=$2
  EXE=$3
  SUBS1=$4
  SUBS2=$5
  SUBS3=$6

  if [ ! -f ${IOC_DIR}/${OUT_FILE} ]
  then
  ${ECHO} "Getting ${IOC_DIR}/${OUT_FILE}"
  ${CURL} -s ${GITHUB}/${IN_FILE} | sed -e "${SUBS1}" -e "${SUBS2}" -e "${SUBS3}" > ${IOC_DIR}/${OUT_FILE}
  if [ "${EXE}" != "" ]
  then
    ${CHMOD} a+x ${IOC_DIR}/${OUT_FILE}
  fi
else
  ${ECHO} "Removing ${IOC_DIR}/${OUT_FILE}"
  ${RM} -f ${IOC_DIR}/${OUT_FILE}
  fi

}

doWork release.pl release.pl
doWork setup_epics_common setup_epics_common
doWork start_MEDM_xxx start_medm_${IOC_NAME} "Yes" "${SUBSTITUTION}" 
doWork start_caQtDM_xxx start_caQtDM_${IOC_NAME} "Yes" "${SUBSTITUTION}" 
# The second sed substition is needed because the location of the new script is one directory above the source script
# The third sed substitution is needed because we changed the case of the medm start script
doWork iocBoot/iocxxx/softioc/xxx.sh iocBoot/ioc${IOC_NAME}/${IOC_NAME}.sh "Yes" "${SUBSTITUTION}" 's/\/\.\.$//' 's/MEDM/medm/g'
