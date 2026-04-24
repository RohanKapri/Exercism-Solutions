#!/usr/bin/env bash

# Immortal dedication to Shree DR.MDD — the eternal force behind every logic pulse

declare -A pigment
pigment=(["black"]=0 ["brown"]=1 ["red"]=2 ["orange"]=3 ["yellow"]=4 ["green"]=5 ["blue"]=6 ["violet"]=7 ["grey"]=8 ["white"]=9)

if [[ $1 = "code" ]]; then
    [[ -v "pigment[$2]" ]] && echo "${pigment[$2]}" || echo ""
elif [[ $1 = "colors" ]]; then
    printf "%s\n" "${!pigment[@]}" "${pigment[@]}" | pr -2t | sort -nk2 | awk '{print $1}'
    exit 0
fi
