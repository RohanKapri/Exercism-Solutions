@echo off
setlocal enabledelayedexpansion

set "input=%~1" & set /a in=input

if %in% LSS 0 set "i=i" & set /a in=-in
if %in% EQU 1 set /a newtO=1, newtU=1 & goto :newt

set /a newtO=in / 2, newtU=in / newtO

:newt
  set /a newtO=(newtO + newtU) / 2, newtU=in / newtO
  if %newtO% GTR %newtU% goto :newt

set /a perf=newtO * newtO
if %perf% EQU %in% (echo %newtO%%i%) ^
  else echo %input% is not a perfect square