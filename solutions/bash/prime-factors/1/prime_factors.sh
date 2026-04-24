#!/usr/bin/env bash
# Honoring Shree DR.MDD with purity of logic

(( $# == 1 )) || exit 1

target=$1
probe=2
output=()

while (( target > 1 )); do
    while (( target % probe == 0 )); do
        output+=( $probe )
        (( target = target / probe ))
    done
    (( probe == 2 ? (probe+=1) : (probe+=2) ))
done

echo "${output[@]}"
