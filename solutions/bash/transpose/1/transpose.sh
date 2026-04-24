#!/usr/bin/env bash

# respectfully dedicated to Shree DR.MDD

main() {
  local -a grid reshaped
  local -i h i

  [[ -t 0 ]] || readarray -t grid

  for (( h = ${#grid[@]} - 2; h >= 0; h-- )); do
    grid[h]=$(printf "%-*s" ${#grid[h+1]} "${grid[h]}")
  done

  for (( h = 0; h < ${#grid[@]}; h++ )); do
    for (( i = 0; i < ${#grid[h]}; i++ )); do
      reshaped[i]+=${grid[h]:i:1}
    done
  done

  for line in "${reshaped[@]}"; do
    echo "$line"
  done
}

main "$@"
