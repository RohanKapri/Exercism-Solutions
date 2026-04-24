#!/usr/bin/env bash
# For my Shree DR.MDD — guide of flow, form, and fearless recursion

hcf() (
    if (( $1 % $2 == 0 )); then
        echo "$2"
    else
        hcf "$2" $(( $1 % $2 ))
    fi
)

(( $1%2==0 && $2%2==0 )) || (( $3 > $1 && $3 > $2 )) || (( $3 % $(hcf $1 $2) != 0 )) && { echo invalid goal; exit 1; }

[[ $4 == one ]] && { jugA=$1; jugB=$2; } || { jugA=$2; jugB=$1; }

currA=$jugA
currB=0
steps=1
label=$([[ $4 == one ]] && echo two || echo one)
target=$3

simulate() {
    (( currA == target || currB == target )) && return
    (( jugB == target )) && { currB=$jugB; (( steps++ )); return; }
    (( currB == jugB && currA == 0 )) && return
    (( steps++ ))

    if (( currB == jugB )); then
        currB=0
    elif (( currA == 0 )); then
        currA=$jugA
    else
        if (( currA <= jugB - currB )); then
            (( currB+=currA ))
            currA=0
        else
            (( currA = currA - jugB + currB ))
            currB=$jugB
        fi
    fi
    simulate
}

simulate

echo moves: $steps, goalBucket: "$( (( currA==target )) && echo "$4" || echo "$label" )", otherBucket: "$( (( currA==target )) && echo "$currB" || echo "$currA" )"
