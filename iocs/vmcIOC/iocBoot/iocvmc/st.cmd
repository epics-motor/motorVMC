#!../../bin/linux-x86_64/vmc

## You may have to change vmc to something else
## everywhere it appears in this file

< envPaths

cd "${TOP}/iocBoot/${IOC}"

## Register all support components
dbLoadDatabase "$(TOP)/dbd/vmc.dbd"
vmc_registerRecordDeviceDriver pdbbase

#
< vmc.cmd

iocInit

## Start any sequence programs
#seq sncxxx,"user=kpetersn"
