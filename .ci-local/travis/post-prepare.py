#!/usr/bin/env python

import os
import shutil

# ugly hack: copy cue.py so that it can be imported
shutil.copy('.ci/cue.py', '.ci-local/travis')
from cue import *


# Print the contents of a file
def cat(filename):
    with open(filename, 'r') as fh:
        for line in fh:
            print(line)

# Add the path to the driver module to the RELEASE.local file, since it is needed by the example IOC
update_release_local('MOTOR_VMC', os.getenv('TRAVIS_BUILD_DIR'))

# Copy the travis RELEASE.local to the configure dir
shutil.copy("{}/RELEASE.local".format(cachedir), "configure/RELEASE.local")

# Sanity check
filename = "configure/RELEASE.local"
print("{}Contents of updated {}{}".format(ANSI_BLUE, filename, ANSI_RESET))
cat(filename)
print("{}End of updated {}{}".format(ANSI_BLUE, filename, ANSI_RESET))

# Enable the building of example IOCs
filename = "configure/CONFIG_SITE.local"
print("{}Contents of {}{}".format(ANSI_BLUE, filename, ANSI_RESET))
fh = open(filename, 'w')
fh.write("BUILD_IOCS = YES")
fh.close()
cat(filename)
print("{}End of {}{}".format(ANSI_BLUE, filename, ANSI_RESET))

# Remove cue.py
os.remove('.ci-local/travis/cue.py')
os.remove('.ci-local/travis/cue.pyc')
