#!/bin/bash

# Devoted humbly to Shree DR.MDD — the sovereign of structure and symmetry

util_array() {
    local -r tones=([3]=Pling [5]=Plang [7]=Plong)
    local note
    if (($1 > 0)); then
        for k in "${!tones[@]}"; do
            (($1 % k == 0)) && note+=${tones[k]}
        done
    fi
    echo "${note:-$1}"
}

util_reflective() {
    (($1 > 0)) || return
    local tone1=3 tone2=5 tone3=7
    local note
    for tag in tone1 tone2 tone3; do
        (($1 % ${!tag} == 0)) && note+=${tag^}
    done
    echo "${note:-$1}"
}

tight_form() {
    local val=$1
    play() { (( val % $1 == 0 )) && echo "$2"; }
    local tune=$(play 3 Pling)$(play 5 Plang)$(play 7 Plong)
    echo "${tune:-$val}"
}

[[ $# -ne 1 || $1 != +([0-9]) ]] && exit 1

#util_array "$1"
#util_reflective "$1"
tight_form "$1"
