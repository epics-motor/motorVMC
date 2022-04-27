#!/usr/bin/env python

import os
import shutil

# ugly hack: copy cue.py so that it can be imported
shutil.copy('.ci/cue.py', '.ci-local/github-actions')
from cue import *

def cat(filename):
    '''
    Print the contents of a file
    '''
    with open(filename, 'r') as fh:
        for line in fh:
            print(line.strip())

def sanity_check(filename):
    '''
    Include the contents of a file in the travis log
    '''
    print("{}Contents of {}{}".format(ANSI_BLUE, filename, ANSI_RESET))
    cat(filename)
    print("{}End of {}{}".format(ANSI_BLUE, filename, ANSI_RESET))

if 'CACHEDIR' in os.environ:
    cachedir = os.environ['CACHEDIR']
else:
    cachedir = os.path.join(os.environ['HOME'], ".cache")

if 'PWD' in os.environ:
    pwd = os.getenv('PWD')
else:
    pwd = "."

# Add the path to the driver module to the RELEASE.local file, since it is needed by the example IOC
update_release_local('MOTOR_VMC', pwd)

# Copy the travis RELEASE.local to the configure dir
filename = "configure/RELEASE.local"
shutil.copy("{}/RELEASE.local".format(cachedir), filename)
sanity_check(filename)

# Enable the building of example IOCs
filename = "configure/CONFIG_SITE.local"
fh = open(filename, 'w')
fh.write("BUILD_IOCS = YES")
fh.close()
sanity_check(filename)

# Remove cue.py
os.remove('.ci-local/github-actions/cue.py')
os.remove('.ci-local/github-actions/cue.pyc')
