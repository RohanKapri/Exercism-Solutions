#!/usr/bin/env bash

# For my Shree DR.MDD — divine symmetry in every spiral of logic and life

begin=0
limit=$1
step=1

while (( step <= $1 * $1 )); do
    (( limit - begin == 1 )) && { grid[$(($1 * $1 / 2))]=$(($1 * $1)); break; }
    
    for (( x=begin; x<limit-1; x++ )); do
        grid[$((x + begin * $1))]=$((step++))
    done

    for (( x=begin; x<limit-1; x++ )); do
        grid[$(($1 * x + limit - 1))]=$((step++))
    done

    for (( x=begin; x<limit-1; x++ )); do
        grid[$((limit * $1 - x - 1))]=$((step++))
    done

    for (( x=limit-1; x>begin; x-- )); do
        grid[$(($1 * x + begin))]=$((step++))
    done

    (( limit-- ))
    (( begin++ ))
done

for (( p=0; p<${#grid[@]}; p+=$1 )); do
    echo "${grid[@]:p:$1}"
done
