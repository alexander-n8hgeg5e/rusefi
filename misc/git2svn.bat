

echo This script should be executed from the root of rusEfi master GITHUB local copy
pwd 

echo Updating from SVN
call git pull
IF NOT ERRORLEVEL echo ERROR git pull-ing
IF NOT ERRORLEVEL 0 EXIT /B 1


set RUSEFI_SVN_PATH=../../rusefi.svn/
set RUSEFI_SVN_W_PATH=..\..\rusefi.svn


ls -l %RUSEFI_SVN_PATH%
rd /s /q %RUSEFI_SVN_W_PATH%\firmware
rd /s /q %RUSEFI_SVN_W_PATH%\hardware
rd /s /q %RUSEFI_SVN_W_PATH%\java_console
rd /s /q %RUSEFI_SVN_W_PATH%\unit_tests
rd /s /q %RUSEFI_SVN_W_PATH%\misc
rd /s /q %RUSEFI_SVN_W_PATH%\win32_functional_tests

cp -r firmware               %RUSEFI_SVN_PATH%
cp -r hardware               %RUSEFI_SVN_PATH%
cp -r java_console           %RUSEFI_SVN_PATH%
cp -r unit_tests             %RUSEFI_SVN_PATH%
cp -r misc                   %RUSEFI_SVN_PATH%
cp -r win32_functional_tests %RUSEFI_SVN_PATH%
rem rm -f %RUSEFI_GIT_PATH%/readme.*
rem rm -f %RUSEFI_GIT_PATH%/README.*
rem cp -r README.* %RUSEFI_GIT_PATH%
rem cp -r readme.* %RUSEFI_GIT_PATH%


rem echo Going to git copy location


cd %RUSEFI_SVN_PATH%

rem git config --global user.email "russianefi@gmail.com"
rem git config --global user.name "rusEfi"

rem git pull
rem git add *
rem git commit -a -m "auto-sync"
rem git push --repo https://rusefi:PASSWORD@github.com/rusefi/rusefi

svn ci  --no-auth-cache --non-interactive --username rusefi --password %RUSEFI_SVN_PASSWORD% -m "auto-merge from github"

