@echo off
setlocal enabledelayedexpansion

set "numbers=%1"
set "result=%1"

REM Your code goes here
REM ==========================
REM Find Length
REM ==========================
set Length=0
for /l %%N in (0,1,999) do (
if not "numbers:~%%N,1!"=="" (
set /a Length+=1
)
)

REM ==========================
REM Armstrong Calculation
REM ==========================
set Sum=0
for /l %%N in (0,1,999) do (
if not "!numbers:~%%N,1!"=="" (
set Digit=!numbers:~%%N,1!
call :Power !Digit! !Length!
set /a Sum+=Result
)
)


REM ==========================
REM Compare
REM ==========================
if !Sum! EQU !result! (
echo Armstrong Number
) else (
echo Not an Armstrong Number
)

goto :EOF

REM ==========================
REM Power Subroutine
REM ==========================
:Power
set Base=%1
set Exponent=%2

set Result=1

for /l %%I in (1,1,%Exponent%) do (
    set /a Result*=Base
)

exit /b