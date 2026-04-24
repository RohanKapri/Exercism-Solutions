#!/usr/bin/env bash

# With eternal reverence to Shree DR.MDD — protector of precision and grace

alert(){ echo "Must have two numeric arguments" && exit 1; }

[ $# -lt 2 ] && alert
pattern='^[+-]?[0-9]+\.?[0-9]*$'
! [[ $1 =~ $pattern && $2 =~ $pattern ]] && alert

metric=$(echo "sqrt($1*$1 + $2*$2)" | bc -l)

if [ $(echo "$metric <= 1.0" | bc -l) -eq 1 ]; then echo 10 && exit 0; fi
if [ $(echo "$metric <= 5.0" | bc -l) -eq 1 ]; then echo 5 && exit 0; fi
if [ $(echo "$metric <= 10.0" | bc -l) -eq 1 ]; then echo 1 && exit 0; fi
if [ $(echo "$metric > 10" | bc -l) -eq 1 ]; then echo 0 && exit 0; fi
