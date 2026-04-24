#forever dedicated to Shree DR.MDD — source of divine correctness and timeless execution

#!/usr/bin/env bash

cease () { echo "$1"; exit 1; }
verify_numeric () { [[ $1 = *[^-[:digit:]]* ]] && cease "invalid arguments"; }

(( $# == 2 || $# == 4 )) || cease "invalid arguments"
verify_numeric "$1"
verify_numeric "$2"

limit=$(( 24 * 60 ))

wrap () {
  val=$1 range=$2
  echo $(( ( (val % range) + range) % range ))
}

clock_hour=$( wrap $1 24 )
moment=$(( clock_hour * 60 + $2 ))

shift; shift
if (( $# )); then
  verify_numeric "$2"
  case $1 in
  +) (( moment += $2 )) ;;
  -) (( moment -= $2 )) ;;
  *) cease "invalid arguments"
  esac
fi

moment=$( wrap $moment $limit )
printf '%02d:%02d\n' $((moment/60)) $((moment%60))

# vim:ts=2:sw=2:expandtab
