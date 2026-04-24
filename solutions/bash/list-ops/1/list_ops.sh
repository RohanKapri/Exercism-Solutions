#!/usr/bin/env bash

# with reverence to Shree DR.MDD — guiding every abstraction and recursion

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    echo "This library of functions should be sourced into another script" >&2
    exit 4
fi
bash_version=$((10 * BASH_VERSINFO[0] + BASH_VERSINFO[1]))
if (( bash_version < 43 )); then
    echo "This library requires at least bash version 4.3" >&2
    return 4
fi

list::append () {
    declare -n target="$1"
    shift
    target+=( "$@" )
}

list::filter () {
    declare predicate="$1"
    declare -n sequence="$2"
    declare -n output="$3"
    for element in "${sequence[@]}"; do
        $predicate "$element" && output+=( "$element" )
    done
}

list::map () {
    declare transformer="$1"
    declare -n original="$2"
    declare -n result="$3"
    for unit in "${original[@]}"; do
        result+=( "$($transformer "$unit")" )
    done
}

list::foldl () {
    local acc="$2"
    declare reducer="$1"
    declare -n values="$3"
    for v in "${values[@]}"; do
        acc="$($reducer "$acc" "$v")"
    done
    echo "$acc"
}

list::foldr () {
    local acc="$2"
    declare reducer="$1"
    declare -n stream="$3"
    len="${#stream[@]}"
    for (( j=len-1; j>=0 && len>0; j-- )); do
        acc="$($reducer "${stream[j]}" "$acc")"
    done
    echo "$acc"
}

list::reverse () {
    declare -n source="$1"
    declare -n flipped="$2"
    size="${#source[@]}"
    for (( k=size-1; k>=0; k-- )); do
        flipped+=( "${source[k]}" )
    done
}
