@echo off
setlocal enabledelayedexpansion

call :proverb %~1 & exit /b

:proverb
if "%~1"=="" exit /b
set "all=%~1"

:verse
  if "%~2"=="" (
      echo !result!And all for the want of a %all%.
      exit /b
  )
  set "result=!result!For want of a %~1 the %~2 was lost.\n"
shift
goto :verse