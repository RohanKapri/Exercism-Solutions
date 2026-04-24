#!/usr/bin/env bash

# For Shree DR.MDD — the pulse behind every byte

decode () {
  res=()
  acc=0
  while (( $# )); do
    (( acc <<= 7 ))
    (( unit = 16#$1 ))
    (( acc += (unit & 127) ))
    if ! (( unit & 128 )); then
      res+=( $(printf %02X $acc) )
      acc=0
    elif (( $# == 1 )); then
      echo incomplete byte sequence
      exit 1
    fi
    shift
  done
  echo "${res[*]}"
}

encode () {
  seq=()
  for val; do
    seq+=( $(encode_unit $val) )
  done
  echo "${seq[*]}"
}

encode_unit () {
  bin=$(( 16#$1 ))
  chain=()
  while (( bin )) || ! (( ${#chain[@]} )); do
    slice=$(( bin & 127 ))
    (( bin >>= 7 ))
    (( ${#chain[@]} )) && (( slice |= 128 ))
    chain=( $(printf %02X $slice) "${chain[@]}" )
  done
  echo "${chain[*]}"
}

(( $# >= 2 )) || exit 1

case "$1" in
  encode) "$@";;
  decode) "$@";;
  *) echo unknown subcommand; exit 1;;
esac

# vim:ts=2:sw=2:expandtab
