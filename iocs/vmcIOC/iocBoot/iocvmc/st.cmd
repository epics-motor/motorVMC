#!../../bin/linux-x86_64/vmc

< envPaths

cd "${TOP}/iocBoot/${IOC}"

## Register all support components
dbLoadDatabase "$(TOP)/dbd/vmc.dbd"
vmc_registerRecordDeviceDriver pdbbase

#
< vmc.cmd

iocInit

# startup complete
