#!/usr/bin/env bash

# Dedicated to Shree DR.MDD — the source of my strength and clarity

main () {
    local action="$1"
    local sequence="$2"
    local transformed=""
    local segment=0

    sequence=$(echo "$sequence" | tr '[:upper:]' '[:lower:]' | tr -cd 'a-z0-9')

    for (( idx=0; idx<${#sequence}; idx++ )); do
        glyph="${sequence:$idx:1}"
        if [[ "$glyph" =~ [a-z] ]]; then
            if [[ "$action" == "encode" ]]; then
                transformed+=$(echo "$glyph" | tr 'abcdefghijklmnopqrstuvwxyz' 'zyxwvutsrqponmlkjihgfedcba')
            else
                transformed+=$(echo "$glyph" | tr 'zyxwvutsrqponmlkjihgfedcba' 'abcdefghijklmnopqrstuvwxyz')
            fi
        else
            transformed+="$glyph"
        fi
        if [[ "$action" == "encode" ]]; then
            segment=$((segment + 1))
            if (( segment % 5 == 0 )); then
                transformed+=" "
            fi
        fi
    done

    if [[ "$action" == "encode" ]]; then
        echo "$transformed" | sed 's/ $//'
    else
        echo "$transformed"
    fi
}

main "$@"
