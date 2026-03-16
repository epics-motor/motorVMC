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

## Virtual Motor Controller (choose one of the following setups)
# Use this line for 3-axes
< vmc.cmd
# Use this line for 8-axes
#!< vmc.iocsh

iocInit

# Boot complete
