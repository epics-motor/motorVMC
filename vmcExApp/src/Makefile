TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# build an ioc application

PROD_IOC = vmc

# <name>.dbd will be created from <name>Include.dbd
DBD += vmc.dbd
vmc_DBD += base.dbd
vmc_DBD += asyn.dbd
vmc_DBD += drvAsynIPPort.dbd

ifneq (,$(findstring /,$(CALC)))
  vmc_DBD += calcSupport.dbd
  vmc_LIBS += calc
endif
vmc_DBD += motorSupport.dbd
vmc_DBD += devSoftMotor.dbd
vmc_LIBS += motor
vmc_LIBS += softMotor

ifdef BASE_7_0
 vmc_DBD += PVAServerRegister.dbd
 vmc_DBD += PVACommonRegister.dbd
 vmc_DBD += softIocPVA.dbd
 vmc_DBD += registerChannelProviderLocal.dbd
endif

vmc_DBD += vmcSupport.dbd

# <name>_registerRecordDeviceDriver.cpp will be created from <name>.dbd
vmc_SRCS += vmc_registerRecordDeviceDriver.cpp
vmc_SRCS_DEFAULT += vmcMain.cpp

#add a definition for each support application used by this application
vmc_LIBS += asyn

ifneq (,$(findstring /,$(CALC)))
vmc_LIBS += calc
endif

vmc_LIBS += motor
vmc_LIBS += softMotor

ifdef BASE_7_0
vmc_LIBS += qsrv
vmc_LIBS += pvDatabase
vmc_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
endif

vmc_LIBS += vmc
vmc_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE
