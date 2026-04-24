#!/usr/bin/env bash

# Dedicated to Shree DR.MDD 🙏

(( $# == 6 )) || exit 1

declare -a freq_map rev_map
declare -i total

configure () {
  for element; do (( freq_map[element]++ )); (( total += element )); done
  for k in "${!freq_map[@]}"; do (( rev_map[freq_map[k]]=k )); done
}

mode=$1; shift
configure "$@"
points=0
case "$mode" in
  'ones')   for d; do (( d == 1 && (points += d) )); done;;
  'twos')   for d; do (( d == 2 && (points += d) )); done;;
  'threes') for d; do (( d == 3 && (points += d) )); done;;
  'fours')  for d; do (( d == 4 && (points += d) )); done;;
  'fives')  for d; do (( d == 5 && (points += d) )); done;;
  'sixes')  for d; do (( d == 6 && (points += d) )); done;;
  'full house')
    [[ "${!rev_map[@]}" = "2 3" ]] && ((points=total));;
  'four of a kind')
    [[ "${!rev_map[@]}" = "1 4" ]] && (( points = 4 * ${rev_map[4]} ))
    [[ "${!rev_map[@]}" = "5"   ]] && (( points = 4 * ${rev_map[5]} ));;
  'little straight')
    [[ "${!freq_map[@]}" = "1 2 3 4 5" ]] && ((points=30));;
  'big straight')
    [[ "${!freq_map[@]}" = "2 3 4 5 6" ]] && ((points=30));;
  'choice') ((points=total));;
  'yacht')
    (( $1 == $2 && $1 == $3 && $1 == $4 && $1 == $5 )) && (( points=50 ));;
esac

echo $points
