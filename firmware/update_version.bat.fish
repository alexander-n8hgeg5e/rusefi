#!/bin/fish
# Let's regemerate 'svnversion.h'
# TODO: handle std err - for example, in case svn needs upgrade
java -jar ../java_tools/version2header.jar 10000 https://github.com/rusefi/rusefi