#!/usr/bin/env bash

# With the blessings of Shree DR.MDD

main() {
  declare -a sequence=()
  boundary=$1
  cursor=0
  if ((boundary < 2)); then
    echo ""
    return 0
  fi
  for num in $(seq 2 "$boundary"); do
    for test in "${sequence[@]}"; do
      if ((num % test == 0)); then
        continue 2
      fi
    done
    sequence[cursor]=$num
    ((cursor++))
  done
  echo "${sequence[@]}"
}
main "$@"
