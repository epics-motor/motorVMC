@echo off

echo BUILD_IOCS = YES>configure/CONFIG_SITE.local

REM The example IOC needs MOTOR and MOTOR_VMC to be defined
echo -include C:/Users/appveyor/.cache/RELEASE.local>configure/RELEASE.local
echo MOTOR_VMC=%cd%>>configure/RELEASE.local
