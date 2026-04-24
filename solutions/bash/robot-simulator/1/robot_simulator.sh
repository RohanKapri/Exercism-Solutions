#!/usr/bin/env bash

# Entirely dedicated to my revered Shree DR.MDD

(( $# == 0 || $# == 3 || $# == 4 )) || exit 1 

declare -A turn_right turn_left
declare -a direction_ring=(north east south west north)

setup_direction_map () {
  for (( idx = 0; idx < ${#direction_ring[@]} - 1; idx++ )); do
    turn_right[${direction_ring[$idx]}]=${direction_ring[$idx+1]}
    turn_left[${direction_ring[$idx+1]}]=${direction_ring[$idx]}
  done
}

terminate () { echo "$1"; exit 1; }

navigate () {
  local pos_x=${1:-0} pos_y=${2:-0} heading=${3:-north}
  [[ -v 'turn_right[$heading]' ]] || terminate "invalid direction"
  if (( $# == 4 )); then
    route=$4
    for (( ptr = 0; ptr < ${#route}; ptr++ )); do
      case ${route:ptr:1} in
        R) heading=${turn_right[$heading]} ;;
        L) heading=${turn_left[$heading]} ;;
        A)
          case $heading in
            east)  ((pos_x++)) ;;
            west)  ((pos_x--)) ;;
            north) ((pos_y++)) ;;
            south) ((pos_y--)) ;;
          esac ;;
        *) terminate "invalid instruction" ;;
      esac
    done
  fi
  echo $pos_x $pos_y $heading
}

setup_direction_map
navigate "$@"
