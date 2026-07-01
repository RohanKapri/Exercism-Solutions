@echo off
SETLOCAL EnableDelayedExpansion

:inicio
cls
set /p numero=Introduzca un numero:

if "%numero%" == "" (goto :inicio)
echo %numero%|findstr /r /x "^[0-9]*$">nul
IF errorlevel 1 (echo No valido, vuelva a intentarlo && echo. && echo Pulse una tecla para continuar && pause >nul && goto :inicio)

set /a r3=!numero! %% 3
set /a r5=!numero! %% 5
set /a r7=!numero! %% 7

IF !r3! == 0 (set res3=Pling)
IF !r5! == 0 (set res5=Plang)
IF !r7! == 0 (set res7=Plong)

If !r3! NEQ 0 (
	if !r5! NEQ 0 (
	if !r7! NEQ 0 (set resnot=!numero!
	)
	)
	)

echo Resultado=!res3!!res5!!res7!!resnot!
pause