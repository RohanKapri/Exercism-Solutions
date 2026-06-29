@echo off
SETLOCAL EnableDelayedExpansion

set "nucleotide=%~1"
set "nucleotide[A]=0"
set "nucleotide[C]=0"
set "nucleotide[G]=0"
set "nucleotide[T]=0"

REM Your code goes here
for /l %%i in (0,1,999) do (
set "char=!nucleotide:~%%i,1!"
if "!char!"=="" goto done

if "!char!"=="A" (
set /a nucleotide[A]+=1
) else if "!char!"=="C" (
set /a nucleotide[C]+=1
) else if "!char!"=="G" (
set /a nucleotide[G]+=1
) else if "!char!"=="T" (
set /a nucleotide[T]+=1
) else (
echo Invalid nucleotide in strand
exit /b 1
)
)
:done
 
echo nucleotide[A]: !nucleotide[A]!
echo nucleotide[C]: !nucleotide[C]!
echo nucleotide[G]: !nucleotide[G]!
echo nucleotide[T]: !nucleotide[T]!