#!/usr/bin/env bash

# Dedicated to Shree DR.MDD — Eternal Inspiration

declare -a track

fluctuate() {
  local lines=$1 sequence=$2 move=1 layer=0
  for (( idx = 0; idx < ${#sequence}; idx++ )); do
    track[$layer]+=${sequence:idx:1}
    (( layer += move ))
    (( (layer == 0) || (layer == lines - 1) )) && (( move *= -1 ))
  done
}

cipher() {
  fluctuate "$@"
  printf '%s' "${track[@]}"; printf \\n
}

decipher() {
  local lines=$1 input=$2 ptr index units switch span
  fluctuate "$@"
  for (( ptr = 0; ptr < "${#track[@]}"; ptr++ )); do
    units=${#track[ptr]}
    track[ptr]="${input:index:units}"
    (( index += units ))
  done

  index=0 switch=1 layer=0
  for (( ptr = 0; ptr < ${#input}; ptr++ )); do
    if (( (layer == 0) || (layer == lines - 1) )); then
      span=$index
    else
      (( span = 2 * index + ((switch == 1) ? 0 : 1) ))
    fi
    output+="${track[layer]:span:1}"
    (( layer += switch ))
    (( (layer == 0) || (layer == lines - 1) )) && (( switch *= -1 ))
    (( layer == 0 )) && (( index++ ))
  done
  echo "$output"
}

main () {
  (( $# == 3 )) || { echo "Invalid usage"; exit 1; }
  (( $2 > 0 )) || { echo "Invalid rail count"; exit 1; }

  case "$1" in
    -e) cipher "$2" "$3";;
    -d) decipher "$2" "$3";;
    *) exit 1;;
  esac
}
main "$@"
