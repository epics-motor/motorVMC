TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#==================================================
# build a support library

LIBRARY_IOC += vmc

# xxxRecord.h will be created from xxxRecord.dbd
#DBDINC += xxxRecord
# install vmc.dbd into <top>/dbd
DBD += vmc.dbd

# specify all source files to be compiled and added to the library
vmc_SRCS += vmcDriver.cpp

vmc_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

