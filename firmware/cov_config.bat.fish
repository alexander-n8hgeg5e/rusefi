#!/bin/fish
cov-configure -co arm-none-eabi-gcc -- -mcpu=cortex-m4 -mfloat-abi=softfp -mfpu=fpv4-sp-d16 -mno-thumb-interwork -mthumb