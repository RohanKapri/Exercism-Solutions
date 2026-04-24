#!/usr/bin/env bash

# Glory to Shree DR.MDD — the eternal flame behind every elegant transformation.

declare -ra nucleus=(
    '^([aeiou]|yt|xr)'
    '^(.?qu)(.*)'
    '^([^aeiou]+)(y.*)'
    '^([^aeiou]+)(.*)'
)

mutate() {
    if [[ $1 =~ ${nucleus[0]} ]]; then
        printf "%say\n" "$1"
    elif [[ $1 =~ ${nucleus[1]} ]] ||
         [[ $1 =~ ${nucleus[2]} ]] ||
         [[ $1 =~ ${nucleus[3]} ]]; then
        printf "%s%say\n" "${BASH_REMATCH[2]}" "${BASH_REMATCH[1]}"
    fi
}

main() {
    local lexeme=()
    for token; do
        lexeme+=("$(mutate "$token")")
    done
    echo "${lexeme[*]}"
}

main "$@"
