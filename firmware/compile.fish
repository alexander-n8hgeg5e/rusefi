#!/bin/fish
make clean
cd ..
rm firmware/controllers/algo/auto_generated_enums.cpp
rm firmware/controllers/algo/auto_generated_enums.h
rm firmware/controllers/algo/engine_configuration_generated_structures.h
rm firmware/tunerstudio/rusefi.ini
rm java_console/models/src/com/rusefi/config/Fields.java
cd java_tools/enum_to_string
ant
cd ../..
cd java_tools/configuration_definition
ant
cd ../..
cd java_console
ant
cd ..
cd firmware
export "PATH=/tmp/gcc-arm-none-eabi-7-2018-q2-update/bin:/usr/bin:/bin:/usr/sbin:/sbin/"
./gen_enum_to_string.bat.fish
./gen_config.bat.fish
make -j16
cp ./tunerstudio/rusefi.ini /home/tunerstudio/rusefi.ini
