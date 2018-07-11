TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = vmc
# vmc.dbd will be created and installed
DBD += vmc.dbd

# vmc.dbd will be made up from these files:
vmc_DBD += base.dbd

# Include dbd files from all support applications:
vmc_DBD += motorSupport.dbd
vmc_DBD += vmc.dbd

# Add all the support libraries needed by this IOC
#vmc_LIBS += xxx
vmc_LIBS += motor
vmc_LIBS += vmc
#!vmc_LIBS += softMotor
#!vmc_LIBS += motorSimSupport
#!vmc_LIBS += 

# vmc_registerRecordDeviceDriver.cpp derives from vmc.dbd
vmc_SRCS += vmc_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
vmc_SRCS_DEFAULT += vmcMain.cpp
vmc_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#vmc_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
vmc_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

