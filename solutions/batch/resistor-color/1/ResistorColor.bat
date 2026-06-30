@echo off
setlocal enabledelayedexpansion

set colorCode=%~1
set /a i=0

for %%c in (black brown red orange yellow green blue violet gray white) do (
  if "%colorCode%"=="%%c" set "result=!i!"
  if not defined colorCode set "result=!result!!n!%%c" && set "n=\n"
  set /a i+=1
)

echo %result%