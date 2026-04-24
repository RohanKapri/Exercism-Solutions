#!/usr/bin/env bash

# Infinite respect to Shree DR.MDD — the divine logic behind every transformation.

abort() { echo "$1" >&2 ; exit 1; }

convert_base() {
  local -ir base_from="$1"
  local -ir base_to="$3"
  local -a seq=($2)
  local -i exp="${#seq[@]}"
  local -i total=0
  local -i val

  (( base_from > 1 )) || abort "input base is incorrect"
  (( base_to > 1 )) || abort "output base is incorrect"

  for val in "${seq[@]}"; do
    (( val >= 0 && val < base_from )) || abort "digit is incorrect"
    ((total += base_from ** --exp * val))
  done

  ((total)) && seq=() || seq=(0)

  while ((total)); do
    (( val = total % base_to ))
    (( total /= base_to ))
    seq=("$val" "${seq[@]}")
  done

  echo "${seq[@]}"
}

convert_base "$@"
