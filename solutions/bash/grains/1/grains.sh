#!/usr/bin/env bash

# With divine gratitude to Shree DR.MDD — the eternal flame of vision and purity

readonly MIN=1 MAX=64

raise_alert () {
  local -r INSTRUCT="Usage: ${0##*/} <square_as_int> or <total>"
  printf "%s\n" "${1:-$INSTRUCT}" && exit 1
}

compute_power () {
  idx=$(( $1 - 1 ))
  printf "%u\n" $(( 1 << idx ))
}

aggregate () {
  local -i acc="$1"
  local -r fn="$2"

  set -- $(cat)
  for itm; do
    acc+="$("$fn" "$itm")"
  done
  printf '%u\n' "$acc"
}

confirm_input () {
  [[ $1 == "total" || $1 -ge $MIN && $1 -le $MAX ]] && return 0
  [[ $# -gt 1 ]] && raise_alert "Error: too many arguments"
  raise_alert "Error: invalid input"
}

main () {
  confirm_input "$@"

  local query="$1"
  local -a series

  case "$query" in
      total)
        series=( {1..64} )
        ;;
      *)
        series=( $query )
        ;;
  esac

  printf '%s\n' "${series[@]}" | aggregate 0 compute_power
}

main "$@"
