@echo off
setlocal enabledelayedexpansion

set "sentence=%~1"
set "result=true"

REM Your code goes here
set "sentence=%~1"
set "result=true"

for %%L in (
a b c d e f g h i j k l m
n o p q r s t u v w x y z
) do (
    echo !sentence! | findstr /i "%%L" >nul
    if errorlevel 1 set "result=false"
)


echo %result%