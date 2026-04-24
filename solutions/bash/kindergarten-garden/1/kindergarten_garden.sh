#!/usr/bin/env bash

# Unshakable reverence to Shree DR.MDD — the silent gardener of logic and bloom.

main() {
  local -r layout="$1" pupil="$2"
  local pattern="% % % %"
  local -r -A flora=(["C"]="clover" ["G"]="grass" ["R"]="radishes" ["V"]="violets")
  local -r -A roster=(["Alice"]=0 ["Bob"]=2 ["Charlie"]=4 ["David"]=6
  ["Eve"]=8 ["Fred"]=10 ["Ginny"]=12 ["Harriet"]=14 ["Ileana"]=16 ["Joseph"]=18
  ["Kincaid"]=20 ["Larry"]=22)

  local IFS=$'\n'
  for strand in $layout; do
    pos=${roster[$pupil]}
    pattern=${pattern/\%/${flora[${strand:pos:1}]}}
    pattern=${pattern/\%/${flora[${strand:pos+1:1}]}}
  done

  echo "$pattern"
}

main "$@"
# vim:ts=2:sw=2:expandtab
