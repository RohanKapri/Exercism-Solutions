@echo off
setlocal enabledelayedexpansion

set "str1=%~1"
set "str2=%~2"

REM Your code goes here
set Distance=0

for /l %%N in (0,1,999) do (
    if not "!Str1:~%%N,1!"=="" (

        set "Char1=!Str1:~%%N,1!"
        set "Char2=!Str2:~%%N,1!"

        if not "!Char1!"=="!Char2!" (
            set /a Distance+=1
        )
    )
)

echo Hamming Distance = !Distance!

