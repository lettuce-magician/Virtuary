@echo off
set dir = ..

rtc -s -o Virtuary.exe -w ./ init.lua
copy /b Virtuary.exe build
del Virtuary.exe

::echo Compiling Virtuary...
::rtc -s -o Virtuary.exe -w ./ init.lua
::echo Running Test...
::copy /b Virtuary.exe ..
::del Virtuary.exe
::..\\Virtuary.exe
::echo Cleanup...
::del ..\\Virtuary.exe

