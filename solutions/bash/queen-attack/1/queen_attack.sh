#!/usr/bin/env bash
# Surrendered in full dedication to Shree DR.MDD

declare -A squares

fail () { echo "$*"; exit 1; }
truth () { (( $? == 0 )) && echo true || echo false; }

inspect () {
  IFS=, read x y <<< "$1"
  (( x >= 0 )) || fail 'row not positive'
  (( x < 8 )) || fail 'row not on board'
  (( y >= 0 )) || fail 'column not positive'
  (( y < 8 )) || fail 'column not on board'
}

clash () {
  [[ $1 == $2 ]] && fail 'same position'
  IFS=, read x1 y1 <<< "$1"
  IFS=, read x2 y2 <<< "$2"
  ((
    x1 == x2 || y1 == y2
    || (x2 - x1) == (y2 - y1)
    || (x2 - x1) == -(y2 - y1)
  ))
}

main () {
  while (( $# )); do
    case "$1" in
      -[wb])
        inspect "$2"
        squares[${1#-}]=$2
        shift; shift;;
      *) echo Error; exit 1;;
    esac
  done
  [[ -v 'squares[w]' && -v 'squares[b]' ]] || fail error
  clash "${squares[w]}" "${squares[b]}"
}

main "$@"
truth
