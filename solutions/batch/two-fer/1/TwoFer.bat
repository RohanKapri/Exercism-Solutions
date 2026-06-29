
@echo off
setlocal enabledelayedexpansion

REM Your code goes here
set /p "name=Enter a name: "

REM Name Validation
if "%name%"=="" (
set name=You
)

echo One for !name!, One for me.
