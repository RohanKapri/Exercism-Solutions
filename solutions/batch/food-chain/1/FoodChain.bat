@echo off
setlocal enabledelayedexpansion

set startVerse=%~1
set endVerse=%~2
set /a i=1

set "main=I know an old lady who swallowed a"
set "one=She swallowed the" & set "two=to catch the"
set "end=I don't know why she swallowed the fly. Perhaps she'll die."

set "exl[spider]=It wriggled and jiggled and tickled inside her.\n"
set "exl[bird]=How absurd to swallow a bird^!\n"
set "exl[cat]=Imagine that, to swallow a cat^!\n"
set "exl[dog]=What a hog, to swallow a dog^!\n"
set "exl[goat]=Just opened her throat and swallowed a goat^!\n"
set "exl[cow]=I don't know how she swallowed a cow^!\n"

for %%a in (fly spider bird cat dog goat cow horse) do (
  if !i! GTR 1 set "mid=%one% %%a !ani[%i%]!.\n!mid!"
  if !i! GEQ %startVerse% if !i! LEQ %endVerse% if not "%%a" == "horse" (
    set "result=!result!\n%main% %%a.\n!exl[%%a]!!mid!%end%
  ) else if "%%a" == "horse" set "result=!result!\n%main% %%a.\nShe's dead, of course^!"
  set /a i+=1
  set "ani[%i%]=%two% %%a"
  if !i! EQU 3 set "ani[%i%]=!ani[%i%]! that !exl[spider]:~3,43!"
)

echo !result:~2!