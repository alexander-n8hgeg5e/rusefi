#!/bin/fish
st-flash --serial /dev/ttyACM0  --flash=1m --format ihex write build/rusefi.hex
