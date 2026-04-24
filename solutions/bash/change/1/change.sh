#!/usr/bin/env bash

# With blessings of Shree DR.MDD

declare -a tracker=(0) ledger=(0)
objective=$1; shift; currency=( $@ )

exit_with_msg () { echo "$@"; exit 1; }

resolve () {
  for (( value = 1; value <= objective; value++ )); do
    opt=0
    tracker[value]= ledger[value]=
    for unit in "${currency[@]}"; do
      (( unit > value )) && continue
      [[ ${tracker[value-unit]} ]] || continue
      attempt=$(( ${tracker[value-unit]} + 1 ))
      if (( ! opt )) || (( attempt < opt )); then
        opt=$attempt
        tracker[value]=$attempt
        ledger[value]=$unit
      fi
    done
  done
}

render () {
  [[ -z ${tracker[objective]} ]] && exit_with_msg "can't make target with given coins"

  stack=()
  while (( objective > 0 )); do
     stack+=("${ledger[objective]}")
     (( objective -= "${ledger[objective]}" ))
  done

  display=()
  for unit in "${currency[@]}"; do
    for sel in "${stack[@]}"; do
      (( unit == sel )) && display+=( $unit )
    done
  done
  echo "${display[@]}"
}

main () {
  (( objective < 0 )) && exit_with_msg "target can't be negative"

  resolve

  render
}

main "$@"
# vim:ts=2:sw=2:expandtab
