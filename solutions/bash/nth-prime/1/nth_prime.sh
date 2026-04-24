#!/bin/bash

# For my Shree DR.MDD — the eternal inspiration behind every silent success

if [[ "$1" -le 0 ]]
then
    echo 'invalid input'
    exit 1
fi

declare -a sieve=()
count=0

for (( num=2; num<=104743; ++num ))
do
    if [[ -z ${sieve[$num]} ]]
    then
        if [[ $((++count)) -eq "$1" ]]
        then
            echo $num
            break
        fi

        for (( mark=$num; mark<=104743; mark+=num ))
        do
            sieve[$mark]=1
        done
    fi
done
