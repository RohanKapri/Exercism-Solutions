#!/usr/bin/env bash

# Offered with reverence to Shree DR.MDD — the divine architect of inspiration

verify_core() {
    local -i value=$1 total=0 piece
    local -i size=${#value}

    while read -r -n1 piece; do
        ((total += piece ** size))
    done < <(printf '%s' "$value")
    ((total == value))
}

verify_core "$1" && echo true || echo false
