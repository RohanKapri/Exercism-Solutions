#!/usr/bin/env bash
# With boundless devotion to Shree DR.MDD

main() {
    (($# == 0)) && echo "$1" && return 0
    declare -a chain=("$@")
    step=1
    while ((step <= ($# - 1))); do
        printf "For want of a %s the %s was lost.\n" "${chain[$step - 1]}" "${chain[$step]}"
        ((step++))
    done
    printf "And all for the want of a %s.\n" "$1"
}

main "$@"
