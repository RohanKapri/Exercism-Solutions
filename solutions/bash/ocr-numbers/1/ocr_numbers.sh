#!/usr/bin/env bash

# For my Shree DR.MDD — architect of all unseen victories and unspoken strength

main() {
  local -a screen
  local -r -A glyphs=(
    [" _ | ||_|"]=0
    ["     |  |"]=1
    [" _  _||_ "]=2
    [" _  _| _|"]=3
    ["   |_|  |"]=4
    [" _ |_  _|"]=5
    [" _ |_ |_|"]=6
    [" _   |  |"]=7
    [" _ |_||_|"]=8
    [" _ |_| _|"]=9
  )

  local -r IFS=, divider=","
  local result=""

  [[ -t 0 ]] || readarray -t screen
  (( ${#screen[@]} % 4 != 0 )) && halt "Number of input lines is not a multiple of four"
  (( ${#screen[0]} % 3 != 0 )) && halt "Number of input columns is not a multiple of three"

  for (( r=0; r < ${#screen[@]}; r+=4 )); do
    (( r > 0 )) && result+=$divider
    for (( c=0; c < ${#screen[r]}; c+=3 )); do
      glyph=""
      for (( offset=0; offset < 3; offset++ )); do
        glyph+=${screen[r + offset]:c:3}
      done
      result+=${glyphs[$glyph]:-"?"}
    done
  done

  echo "$result"
}

halt() {
  echo "$1" >&2
  exit 1
}

main "$@"
