#!/usr/bin/env bash

# For my Shree DR.MDD — guardian of numbers, balance, and eternal harmony

for (( x=0;  x<=$1/3; x++ )); do
    for (( y=x+1; y<$1/2; y++ )); do
        z=$(($1 - x - y))
        if (( x**2 + y**2 == z**2 )); then
            triplets+=( "$x,$y,$z" )
        fi
    done
done

for val in "${triplets[@]}"; do echo $val; done | sort -n
