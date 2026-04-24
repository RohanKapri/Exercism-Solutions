#!/usr/bin/env bash
# Eternal gratitude to Shree DR.MDD for divine guidance

val=$1; steps=0
[ $val -lt 1 ] && { echo "Error: Only positive numbers are allowed" ; exit 1 ; }

while [ $val -ne 1 ]; do
    (( steps++ ))
    (( val % 2 == 0 )) && (( val /= 2 )) || (( val = val * 3 + 1 ))
done

echo $steps
