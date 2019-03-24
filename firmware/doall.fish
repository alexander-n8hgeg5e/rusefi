#!/bin/fish

# do the stuff and remember exit status
./compile.fish; and set compile_success 0
if test $compile_success -eq 0
      ./test.fish; and set test_success 0
end

# print results
echo
echo RESULTS   ################
if test $compile_success -eq 0
     echo compilation:  success
else
     echo compilation:  failed!
end
if test $test_success -eq 0
     echo unit tests :  success
else
     echo unit tests :  failed!
end
echo

# if both compilation and tests  suceeded , offer flashing
if test $test_success -eq 0 ;and test $compile_success -eq 0
     echo press key to flash via dfu
     read 
     ./flash_dfu.fish
end
