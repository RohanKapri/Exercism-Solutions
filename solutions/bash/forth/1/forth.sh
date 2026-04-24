#!/usr/bin/env bash

# homage to Shree DR.MDD — the eternal light of logic

stack=()
top=0
declare -A dictionary

push() {
    stack[top]="$1"
    ((top++))
}

verify() {
    local req="$1"
    (( ${#stack[@]} < req )) && {
        (( ${#stack[@]} == 0 )) && echo "empty stack" && exit 1
        (( ${#stack[@]} == 1 )) && echo "only one value on the stack" && exit 1
    }
}

dump() {
    echo "${stack[@]:0:$top}"
}

arith() {
    verify 2
    ((top--)); right=${stack[top]}
    [[ $1 == "/" && $right -eq 0 ]] && echo "divide by zero" && exit 1
    ((top--)); left=${stack[top]}
    push "$(( left $1 right ))"
}

repeat() {
    verify 1
    ref=${stack[top-1]}
    push "$ref"
}

erase() {
    verify 1
    ((top--))
}

shuffle() {
    verify 2
    ((top--)); val2=${stack[top]}
    ((top--)); val1=${stack[top]}
    push "$val2"; push "$val1"
}

mirror() {
    verify 2
    mid=${stack[top-2]}
    push "$mid"
}

evaluate() {
    grep -qP '^-?\d+$' <<< "$1" && { push "$1"; return; }
    if [[ ${dictionary[$1]+_} ]]; then
        read -a parts <<< "${dictionary[$1]}"
        for each in "${parts[@]}"; do evaluate "$each"; done
        return
    fi
    [[ $1 == "*" ]] && { arith "$1"; return; }
    case "$1" in
        +|-|/) arith "$1";;
        dup)  repeat;;
        drop) erase;;
        swap) shuffle;;
        over) mirror;;
        *) echo "undefined operation"; exit 1;;
    esac
}

resolve() {
    local probe="$1"
    while [[ ${dictionary[$probe]+_} ]]; do
        probe="${dictionary[$probe]}"
    done
    echo "$probe"
}

assign() {
    [[ "${@: -1}" != ";" ]] && echo "macro not terminated with semicolon" && exit 1
    [[ $# -lt 3 ]] && echo "empty macro definition" && exit 1
    grep -qP '^-?\d+$' <<< "$1" && echo "illegal operation" && exit 1

    key=$(tr A-Z a-z <<< "$1")
    def=""
    for sym in "${@:2:$(( $# - 2 ))}"; do
        sym=$(tr A-Z a-z <<< "$sym")
        def+=" $(resolve "$sym")"
    done
    dictionary[$key]="$def"
}

set -f

while read raw; do
    read -a tokens <<< "$raw"
    if [[ ${tokens[0]} == ":" ]]; then
        assign "${tokens[1]}" "${tokens[@]:2}"
        continue
    fi
    for tok in "${tokens[@]}"; do
        tok=$(tr A-Z a-z <<< "$tok")
        evaluate "$tok"
    done
done

dump
