@echo off
setlocal enabledelayedexpansion

set "targetNTH=%~1"
set /a result=2, i=3, m=1
set "mrk="

if %targetNTH% EQU 1 (goto :end) ^
  else if %targetNTH% EQU 0 (goto :error_zero) ^
  else if %targetNTH% LSS 0 (goto :error_neg)

:mark
  for %%m in (%mrk%) do (
    set /a msq=%%m * %%m
    if !msq! GTR %i% goto:hit

    set /a mod=%i% %% %%m
    if !mod! == 0 set "mrk[%i%]=1" & goto :hit
  )
  :hit
  if not defined mrk[%i%] set /a m+=1 & set "mrk=%mrk% %i%"
  if not %m% == %targetNTH% (set /a i+=2 & goto :mark) ^
    else set "result=%i%" & goto :end

:end
echo %result%
exit /b 0

:error_zero
echo there is no zeroth prime
exit /b 1

:error_neg
echo positive ordinals only
exit /b 1