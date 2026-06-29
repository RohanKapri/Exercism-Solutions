@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion


:: Que sea divisible por 4
:: Excepto si es divisble por 100. En este caso será bisiesto si es divisible por 400

:inicio
cls
set /p ano="Introduza el año:"
if "%ano%" == "" (goto :inicio)
echo %ano%|findstr /r /x "[0-9]*$">nul
if errorlevel 1 (echo No es un año válido, vuelva a intentarlo && pause && goto :inicio)

set /a r4=!ano! %%4
set /a r100=!ano! %%100
set /a r400=!ano! %%400

if !r400! == 0 (echo !ano! es bisiesto
	) else if !r100! == 0 (echo !ano! NO es bisiesto
	) else if !r4! == 0 (echo !ano! es bisiesto
	) else (echo !ano! NO es bisiesto
	)
echo Pulse una tecla para continuar
pause >nul

:otra_vez
cls
set /p continuar=¿Desea consultar otro año? Conteste Sí o No:
If /i %continuar% == Si (goto :inicio)
If /i %continuar% == No (echo Gracias por participar
	echo Pulse una tecla para salir
	Pause >nul
	exit)

If not defined continuar (goto :otra_vez)
If /i not "%continuar%" == "Si" (echo Inválido, vuelva a intentarlo && goto :otra_vez
	) else if /i not "%continuar%" == "No" (echo Inválido, vuelva a intentarlo && goto :otra_vez
	)