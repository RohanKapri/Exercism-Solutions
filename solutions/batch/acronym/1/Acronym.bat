@echo off
setlocal enabledelayedexpansion

:inicio
cls
set /p nombre=Escriba su nombre:

If "%nombre%" == "" (goto :inicio)

:frase
cls
set /p phrase=Hola %nombre% Escribe tu frase:

If "%phrase%" == "" (goto :frase)

set "clean=!phrase:-= !"
set "!clean!=!phrase:.=!"
set "!clean!=!phrase:!=!"
set "!clean!=!phrase:?=!"

for %%b IN ("a=A" "b=B" "c=C" "d=D" "e=E" "f=F" "g=G" "h=H" "i=I" "j=J" "k=K" "l=L" "m=M" "n=N" "o=O" "p=P" "q=Q" "r=R" "s=S" "t=T" "u=U" "v=V" "w=W" "x=X" "y=Y" "z=Z") DO (
	set "clean=!clean:%%~b!")

set "acronym="
FOR %%a IN (!clean!) DO (
	set word=%%a
	set "acronym=!acronym!!word:~0,1!"
	)

echo Tu frase es %phrase%
echo El acronimo es: !acronym!
echo.
echo.
echo.
echo Pulse una tecla para continuar
pause >nul

:Respuesta
cls
echo Si quiere volver a intentarlo, escriba Si
echo Si no quiere, escriba No
set /p respuesta=Escriba su respuesta:

If not defined respuesta (goto :respuesta)
If /i %respuesta% == si (goto :frase)
If /i %respuesta% == no (echo Gracias por participar && echo pulse una tecla para salir && pause >nul && exit)
iF /i %respuesta% NEQ si (echo Error, vuelva a intentarlo && goto :respuesta
	) else if /i %respuesta% NEQ no (echo Error, vuelva a intentarlo && goto :respuesta
	)

pause