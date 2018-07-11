### virtual motor controller support

epicsEnvSet("PREFIX", "vmc:")
epicsEnvSet("VMC_PORT1", "31337")

drvAsynIPPortConfigure("VMC_ETH","127.0.0.1:$(VMC_PORT1)", 0, 0, 0)

# Show communication
#!asynSetTraceMask("VMC_ETH", 0, 3)
# Only show errors
asynSetTraceMask("VMC_ETH", 0, 1)
# Leave ascii selected so traces can be turned on with a single click
asynSetTraceIOMask("VMC_ETH", 0, 1)

# Set end-of-string terminators
asynOctetSetInputEos("VMC_ETH",0,"\r\n")
asynOctetSetOutputEos("VMC_ETH",0,"\r")

# These motor records can get their prefix from the environment variable
dbLoadRecords("$(MOTOR)/motorApp/Db/asyn_motor.db","P=$(PREFIX),M=m1,DTYP=asynMotor,PORT=VMC1,ADDR=0,DESC=X,EGU=mm,DIR=Pos,VELO=1,VBAS=.1,ACCL=.2,BDST=0,BVEL=1,BACC=.2,MRES=.0025,PREC=4,DHLM=100,DLLM=-100,INIT=")
dbLoadRecords("$(MOTOR)/motorApp/Db/asyn_motor.db","P=$(PREFIX),M=m2,DTYP=asynMotor,PORT=VMC1,ADDR=1,DESC=Y,EGU=mm,DIR=Pos,VELO=1,VBAS=.1,ACCL=.2,BDST=0,BVEL=1,BACC=.2,MRES=.0025,PREC=4,DHLM=100,DLLM=-100,INIT=")
dbLoadRecords("$(MOTOR)/motorApp/Db/asyn_motor.db","P=$(PREFIX),M=m3,DTYP=asynMotor,PORT=VMC1,ADDR=2,DESC=Z,EGU=mm,DIR=Pos,VELO=1,VBAS=.1,ACCL=.2,BDST=0,BVEL=1,BACC=.2,MRES=.0025,PREC=4,DHLM=100,DLLM=-100,INIT=")
# If a substitutions file is used, the "P" macro needs to be modified by hand
#!dbLoadTemplate("templates/vmc.substitutions")

# VirtualMotorController(
#    portName          The name of the asyn port that will be created for this driver
#    VirtualMotorPortName     The name of the drvAsynSerialPort that was created previously to connect to the VirtualMotor controller 
#    numAxes           The number of axes that this controller supports 
#    movingPollPeriod  The time between polls when any axis is moving 
#    idlePollPeriod    The time between polls when no axis is moving 

# 1-second idle polling
VirtualMotorCreateController("VMC1", "VMC_ETH", 3, 250, 1000)
# 10-second idle polling
#!VirtualMotorCreateController("VMC1", "VMC_ETH", 3, 250, 10000)
# No idle polling
#!VirtualMotorCreateController("VMC1", "VMC_ETH", 3, 250, 0)
# Extra axes, 10-second idle polling
#!VirtualMotorCreateController("VMC1", "VMC_ETH", 8, 250, 10000)

dbLoadRecords("$(ASYN)/db/asynRecord.db","P=$(PREFIX),R=asyn1,PORT=VMC_ETH,ADDR=0,OMAX=0,IMAX=0")
