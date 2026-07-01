@echo off
setlocal enabledelayedexpansion

set "word=%~1"
set "result="
set /a score=0

REM Your code goes here
for /l %%N in (0,1,999) do (
 if "!word:~%%N,1!"=="" goto done 
 set "Char1=!word:~%%N,1!"

set "ones=A E I O U L N R S T"
set "twos=D G"
set "threes=B C M P"
set "fours=F H V W Y"
set "five=K"
set "eights=J X"
set "tens=Q Z"


for %%L in (!ones!) do (
if /i "!char1!"=="%%L" set /a score+=1
)

for %%M in (!twos!) do (
if /i "!char1!"=="%%M" set /a score+=2
)

for %%K in (!threes!) do (
if /i "!char1!"=="%%K" set /a score+=3
)

for %%P in (!fours!) do (
if /i "!char1!"=="%%P" set /a score+=4
)


for %%F in (!five!) do (
if /i "!char1!"=="%%F" set /a score+=5
)

for %%R in (!eights!) do (
if /i "!char1!"=="%%R" set /a score+=8
)

for %%W in (!tens!) do (
if /i "!char1!"=="%%W" set /a score+=10
)

)

:done
set result=!score!
echo %result%
