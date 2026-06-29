```bat
@echo off
setlocal enabledelayedexpansion

set "sentence=%~1"
set "result="

REM Your code goes here
set "result=true"

for %%A in (
a b c d e f g h i j k l m
n o p q r s t u v w x y z
) do (
    echo(!sentence! | findstr /i "%%A" >nul
    if errorlevel 1 (
        set "result=false"
        goto :done
    )
)

:done
echo %result%
```
