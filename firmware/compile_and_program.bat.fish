#!/bin/fish
@echo off
rm -rf .dep/

rm -rf build\rusefi.hex
rm -rf build\rusefi.bin


git submodule update --init
# PS:
# git submodule update --recursive --remote
# magic once needed

call update_version.bat

echo Starting compilation
# the important piece (pass external args if needed)
make %1 %2 %3

# cd build
# if not exist rusefi.hex echo "compilation failed"
# if not exist rusefi.hex exit -1
# cd ..
if errorlevel 1 echo make compilation failed
if errorlevel 1 exit -1
 
echo Build complete success.


# svn info > ../firmware_binary/version.txt
# cp config/features.h ../firmware_binary
# cp build/rusefi.hex ../firmware_binary
# cp build/rusefi.elf ../firmware_binary

# cp tunerstudio/rusefi.ini ../firmware_binary

# cd ../firmware_binary
# del firmaware_binary.zip
# 7z a firmaware_binary.zip rusefi.hex rusefi.ini features.h flash.bat
# cd ../firmware


cd build
# Generate human-readable version of the .map memory usage report
java -jar ../../java_tools/gcc_map_reader.jar rusefi.map > ../rusefi_ram_report.txt
cd ..

echo Looking at size
arm-none-eabi-size  --format=berkeley "build\rusefi.elf"
echo Compiler version
arm-none-eabi-gcc -v

echo Have the file, let's program the board right away
call flash_openocd

echo Done flashing                       

