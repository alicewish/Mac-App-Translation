#!/usr/local/bin/python

import os
import sys

debuggerPath = '';

for libPath in sys.path:
	testPath = libPath + os.sep + 'pdb.py'
	if (os.path.exists(testPath)):
		debuggerPath = testPath

print debuggerPath,


