#!../../bin/linux-x86_64/vmc

< envPaths

cd "${TOP}/iocBoot/${IOC}"

## Register all support components
dbLoadDatabase "$(TOP)/dbd/vmc.dbd"
vmc_registerRecordDeviceDriver pdbbase

## motorUtil (allstop & alldone)
dbLoadRecords("$(MOTOR)/db/motorUtil.db", "P=vmc:")

#
< vmc.cmd

iocInit

## motorUtil (allstop & alldone)
motorUtilInit("vmc:")

# Boot complete
