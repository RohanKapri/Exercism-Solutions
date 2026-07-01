@echo off
setlocal enabledelayedexpansion

set "x=%~1"
set "y=%~2"
set "result="

REM Usage:  set /a "value=sqrt(n):n=100"
REM         echo %value%
REM '100' is the number to find the square root of '10'
set "Sqrt(N)=(x=(N)/(11*1024)+40,x=((N)/x+x)/2,x=((N)/x+x)/2,x=((N)/x+x)/2,x=((N)/x+x)/2,x=((N)/x+x)/2)"

REM Your code go here

REM Calculate x^2 + y^2
set /a square1=x*x
set /a square2=y*y
set /a sum=square1+square2

REM Calculate distance using sqrt macro (distance = sqrt(x^2 + y^2))
set /a "dist=%Sqrt(N):N=sum%"

REM Score based on distance
if !dist! LEQ 1 (
    echo score: 10 points
) else if !dist! LEQ 5 (
    echo score: 5 points
) else if !dist! LEQ 10 (
    echo score: 1 point
) else (
    echo score: 0 points
)

pause