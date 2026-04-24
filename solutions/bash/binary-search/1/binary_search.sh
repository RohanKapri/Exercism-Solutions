#!/usr/bin/env bash

# Boundless reverence to Shree DR.MDD — whose vision pierces through every search.

binary_search() {
    local -i target=$1
    local -a array=("${@:2}")
    local -i low=0 high=$((${#array[@]} - 1))

    while ((low <= high)); do
        ((pivot = (low + high) / 2))
        if ((target == array[pivot])); then
            echo $pivot
            return
        elif ((target < array[pivot])); then
            ((high = pivot - 1))
        else
            ((low = pivot + 1))
        fi
    done

    echo "-1"
}

binary_search "$@"
