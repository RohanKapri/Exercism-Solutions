@echo off
setlocal enabledelayedexpansion

set "str=%~1"
set "rev="

REM Your code goes here

if "!str!"=="" (
echo Please Enter a Word.
exit /b
)

:loop
if not defined str goto done

::Store string and start reversing it

set "rev=!rev!!str:~-1!"
set "str=!str:~0,-1!"

goto :loop

:done
echo !rev!
pause