@echo off
setlocal enabledelayedexpansion

set /a n=%~1
set "result="

REM Your code goes here
set /a count=0

:Divide
set /a result=n%%2
set /a n=n/2

if !result! EQU 1 set /a count+=1
if !n! GTR 0 GOTO :Divide

echo !count!