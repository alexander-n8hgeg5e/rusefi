#!/bin/fish
cd ..
cd unit_tests
make -j16
./build/rusefi_test
cd ..
cd firmware
