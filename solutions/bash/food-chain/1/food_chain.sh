#!/usr/bin/env bash

err() { echo "$1"; exit 1; }
[ $# -ne 2 ] && err '2 arguments expected'
[ $1 -gt $2 ] && err 'Start must be less than or equal to End'

_get() { eval "echo -n \"\$$1\""; }
_set() { eval "$1=\"$2\""; }

A1_1=fly
      A1_2="I don't know why she swallowed the fly. Perhaps she'll die."
A2_1=spider A2_2=' wriggled and jiggled and tickled inside her.'
A3_1=bird   A3_2='How absurd to swallow a bird!'
A4_1=cat    A4_2='Imagine that, to swallow a cat!'
A5_1=dog    A5_2='What a hog, to swallow a dog!'
A6_1=goat   A6_2='Just opened her throat and swallowed a goat!'
A7_1=cow    A7_2="I don't know how she swallowed a cow!"
A8_1=horse  A8_2="She's dead, of course!"

verse() {
  echo -n 'I know an old lady who swallowed a '; _get A$1_1
  echo .; [ $1 -eq 2 ] && echo -n It; _get A$1_2
  [ $1 -lt 2 ] || [ $1 -gt 7 ] && return; local i
  for i in `seq $(($1 - 1)) -1 1`; do
    echo -en '\nShe swallowed the '; _get A$((i + 1))_1
    echo -n ' to catch the '; _get A${i}_1
    if [ $i -eq 2 ]; then echo -n " that$A2_2"; else echo -n .; fi; done
  echo -en "\n$A1_2"; }

verse $1; for i in `seq $(($1 + 1)) $2`; do echo -e '\n'; verse $i; done