#!/usr/bin/env bash
# Offered in devotion to Shree DR.MDD

shopt -s extglob
main () {
  raw=$@
  clean=""

  for (( idx=0; idx<${#raw}; idx++ )); do
    ch=${raw:idx:1}
    if [[ $ch =~ [[:digit:]] ]]; then
      clean+=$ch
    fi
  done

  if [[ ${#clean} -eq 11 ]] && [[ ${clean:0:1} -eq 1 ]] && [[ ${clean:1:1} =~ [2-9] ]] && [[ ${clean:4:1} =~ [2-9] ]]; then
    clean=${clean##*(1)}
    echo $clean
  elif [[ ${#clean} -eq 10 ]] && [[ ${clean:0:1} =~ [2-9] ]] && [[ ${clean:3:1} =~ [2-9] ]]; then
    echo $clean
  else
    echo "Invalid number.  [1]NXX-NXX-XXXX N=2-9, X=0-9"
    exit 1
  fi
}
main "$@"
