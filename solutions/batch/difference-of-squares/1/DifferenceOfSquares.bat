@echo off
setlocal enabledelayedexpansion

set "N=%~1"

set /a "gauss=%N% * (%N% + 1) / 2"
set /a "sqsm=%gauss% * %gauss%"
set /a "smsq=%gauss% * (2 * %N% + 1) / 3"

set /a "difference=%sqsm% - %smsq%"

echo %difference%