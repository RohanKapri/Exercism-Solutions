@echo off
setlocal enabledelayedexpansion

set "hours=%~1"
set "minutes=%~2"

set /a minutesDivisor=60
set /a HoursDivisor=24

REM Your code goes here

set /a "ht=!hours!*60"
set /a "sum=!ht!+!minutes!"

set /a "sum=(sum+1440)%%1440"
set /a "hourss=!sum!/60"
set /a "minutess=!sum!%%60"

if %hourss% LSS 10 set "hourss=0%hourss%"
if %minutes% LSS 10 set "minutess=0%minutess%"

echo %hourss%:%minutess%