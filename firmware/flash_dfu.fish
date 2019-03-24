#!/bin/fish
#dfu-util  -R -a 0 -s 0x08000000 -D build/rusefi.bin
dfu-util --device ,0483:df11  -R -a 0 -s 0x08000000 -D build/rusefi.bin
