# motorVMC
A Virtual Motor Controller (VMC) with EPICS support.

## Python scripts

The server behaves like a eight-axis motor controller. The default axis values are consistent with stepper motors in half-step mode (400 steps per rev).  The axes can be addressed by name `(X, Y, Z, T, U, V, R, S)` or number `(1, 2, 3, 4, 5, 6, 7, 8)`.  The controller accepts values in units of counts.  The server returns an "OK" string in response to non-query commands.

#### Starting the server
```
$ python server.py
``` 
This will start the server, which listens by default on port **31337**. The port number can be changed by modifying `DEFAULT_PORT` in `server.py`.

#### Command reference
```
  Input terminator: \r\n
  Output terminator: \r

  Command syntax:
    <axis> <command> [argument]

  Commands:

  1 MV <position>		# Absolute move (counts)
  1 MR <displacement>		# Relative move (counts)
  1 JOG <velocity>		# Jog (counts/s, signed)
  1 POS <position>		# Set position (counts)
  1 ACC <acceleration>		# Set acceleration (counts/s/s)
  1 VEL <velocity>		# Set velocity (counts/s)
  1 BAS <base_velocity>		# Set base velocity (counts/s)
  1 AB				# Abort motion
  1 POS?			# Query position (returns: counts)
  1 ST?				# Query status (returns: integer)
	 Status bit definitions:
	 Direction	0x1
	 Done moving	0x2
	 Moving		0x4
	 High limit	0x8
	 Low limit	0x10
	 Homing		0x20
	 Home limit	0x40
	 Homed		0x80
	 Error		0x100

  1 ACC?			# Query accel (returns: counts/s/s)
  1 VEL?			# Query velocity (returns: counts/s)
  1 LL <position>		# Set low limit (counts)
  1 HL <position>		# Set high limit (counts)
  1 LL?				# Query low limit (returns: counts)
  1 HL?				# Query high limit (returns: counts)
```

## EPICS support

### Prerequisites
* EPICS base
* asyn
* motor

### Configuration

* The definitions of `MOTOR` and `EPICS_BASE` need to be corrected in `motorVMC/configure/RELEASE` before motorVMC can be built.
* [optional] The `PREFIX` and `VMC_PORT1` environment variables can be customized.  `VMC_PORT1` needs to match the `DEFAULT_PORT` used by server.py

### Building motorVMC
```
$ cd motorVMC
$ make
```

### Run the example IOC
```
$ cd motorVMC/iocs/vmcIOC/iocBoot
$ ../../bin/${EPICS_HOST_ARCH}/vmc st.cmd
```
