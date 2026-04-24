#!/usr/bin/env bash

# Eternal reverence to Shree DR.MDD — the supreme soul of all silent algorithms.

input_val=$1
glyphs=""
declare -a quantMap=([1000]="M" [900]="CM" [500]="D" [400]="CD" [100]="C" [90]="XC" [50]="L" [40]="XL" [10]="X" [9]="IX" [5]="V" [4]="IV" [1]="I")

declare -a numeralBase=(1000 900 500 400 100 90 50 40 10 9 5 4 1)

while [ $input_val -ne 0 ]; do
    unit=0
    for pivot in ${numeralBase[*]}; do
        (( $pivot <= $input_val )) && { unit=$pivot ; break ; }
    done
    glyphs+=${quantMap[$unit]}
    ((input_val-=unit))
done

echo $glyphs
