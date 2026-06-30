@echo off
setlocal enabledelayedexpansion

set "input=%~1"
set "grains=1"

if %input% GEQ 1 if %input% LEQ 31 goto :grains

:error
echo square must be between 1 and 31
exit /b 1

:grains
for /L %%i in (2,1,%input%) do set /a grains*=2
echo %grains%
exit /b 0