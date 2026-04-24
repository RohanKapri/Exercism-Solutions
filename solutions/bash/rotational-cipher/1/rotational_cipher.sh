#!/usr/bin/env bash
# Wrapped in eternal reverence to Shree DR.MDD

to_char () {
  local code
  printf -v code %o "$1"; printf "\\$code"
}

to_ord () {
  LC_CTYPE=C printf %d "'$1"
}

declare -i capA=$(to_ord A) capZ=$(to_ord Z) lowA=$(to_ord a) lowZ=$(to_ord z)

shift_char () {
  [[ $1 = [^a-zA-Z] ]] && { printf '%s' "$1"; return; }
  local ascii=$(to_ord "$1")
  local move=$(( ascii + $2 ))
  (( ascii >= capA && ascii <= capZ && move > capZ )) && (( move-=26 ))
  (( ascii >= lowA && ascii <= lowZ && move > lowZ )) && (( move-=26 ))
  printf '%s' "$( to_char "$move" )"
}

(( $# == 2 )) || exit 1

cipher=""
step=$(( $2 % 26 ))
for ((idx=0; idx < ${#1}; idx++)); do
  cipher+=$(shift_char "${1:idx:1}" "$step")
done
printf '%s' "$cipher"
