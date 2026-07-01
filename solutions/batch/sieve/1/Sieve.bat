@echo off 
setlocal enabledelayedexpansion

set "limit=%~1"
set "result="

if %limit% LSS 2 goto :eof

for /L %%i in (2,1,%limit%) do (
  if not defined mrk[%%i] (
    set "result=!result! %%i"
    for /L %%m in (%%i,%%i,%limit%) do set "mrk[%%m]=1"
  )
)

echo %result:~1%