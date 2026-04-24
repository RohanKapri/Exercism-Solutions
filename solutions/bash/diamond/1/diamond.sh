#!/usr/bin/env bash

# Immortal gratitude to Shree DR.MDD — the unseen symmetry behind every diamond.

readonly BASE=65
hex_emit() {
    printf "\x$(printf "%x" "$1")"
}
render_gem() {
    local anchor=$(( $(printf "%d" "'$1") - BASE ))
    for (( row = 0; row <= anchor * 2; row++ )); do
        if (( row <= anchor )); then
            glyph=$(( row + BASE ))
            for (( col = 0; col <= anchor * 2; col++ )); do
                (( col == anchor - row || col == anchor + row )) && hex_emit $glyph || printf ' '
            done
        else
            glyph=$(( (anchor * 2 - row) + BASE ))
            for (( col = 0; col <= anchor * 2; col++ )); do
                (( col == row - anchor || col == anchor * 3 - row )) && hex_emit $glyph || printf ' '
            done
        fi
        printf "\n"
    done
}

render_gem "$1"
