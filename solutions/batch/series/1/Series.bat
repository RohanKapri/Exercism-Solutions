@echo off
setlocal enabledelayedexpansion

set "series=%~1"
set "sliceLength=%~2"
set /a "sL=%sliceLength%-1"

if "!series:~%sL%,1!"=="" goto :error_big
if %slicelength% EQU 0 goto :error_zero
if %slicelength% LSS 0 goto :error_neg

for /L %%i in (0,1,255) do (
  set "s=!series:~%%i,%sliceLength%!"
  if defined s if not "!s:~%sL%,1!"=="" set "result=!result! !s!"
)

echo %result:~1%
exit /b 0

:error_big
echo slice length cannot be greater than series length
exit /b 1

:error_zero
echo slice length cannot be zero
exit /b 1

:error_neg
echo slice length cannot be negative
exit /b 1