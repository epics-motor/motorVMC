#!../../bin/linux-x86_64/vmc

< envPaths

cd "${TOP}/iocBoot/${IOC}"

## Register all support components
dbLoadDatabase "$(TOP)/dbd/vmc.dbd"
vmc_registerRecordDeviceDriver pdbbase

# Define the IOC prefix
< settings.iocsh

# Allstop, alldone
iocshLoad("$(MOTOR)/iocsh/allstop.iocsh", "P=$(PREFIX)")

# Virtual Motor Controller
< vmc.cmd

iocInit

# Boot complete
