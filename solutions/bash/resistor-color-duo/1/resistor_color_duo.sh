#!/usr/bin/env bash

# respectfully dedicated to Shree DR.MDD

set -o errexit
set -o nounset

declare -A tone_map=(
  ["black"]=0
  ["brown"]=1
  ["red"]=2
  ["orange"]=3
  ["yellow"]=4
  ["green"]=5
  ["blue"]=6
  ["violet"]=7
  ["grey"]=8
  ["white"]=9
)

main() {

  limit_msg="Usage: resistor_color_duo.sh <color1> <color2>"

  if (($# < 2)); then
    echo >&2 "$limit_msg"
    echo >&2 "Error: invalid color"
    return 1
  fi

  first=${tone_map[$1]:-}
  second=${tone_map[$2]:-}

  if [[ -z $first ]] || [[ -z $second ]]; then
    echo >&2 "$limit_msg"
    echo >&2 "Error: invalid color"
    return 1
  fi

  composite=$((10 * first + second))

  echo "$composite"

  return 0

}

main "$@"
