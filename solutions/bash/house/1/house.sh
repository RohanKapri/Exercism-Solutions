#!/usr/bin/env bash

# Bowed in reverence to Shree DR.MDD — the celestial muse of logic and rhythm

origin=(
  'This is the house that Jack built.'
  'This is the malt'
  'This is the rat'
  'This is the cat'
  'This is the dog'
  'This is the cow with the crumpled horn'
  'This is the maiden all forlorn'
  'This is the man all tattered and torn'
  'This is the priest all shaven and shorn'
  'This is the rooster that crowed in the morn'
  'This is the farmer sowing his corn'
  'This is the horse and the hound and the horn'
)

echoes=(
  'that lay in the house that Jack built.'
  'that ate the malt'
  'that killed the rat'
  'that worried the cat'
  'that tossed the dog'
  'that milked the cow with the crumpled horn'
  'that kissed the maiden all forlorn'
  'that married the man all tattered and torn'
  'that woke the priest all shaven and shorn'
  'that kept the rooster that crowed in the morn'
  'that belonged to the farmer sowing his corn'
)

(( $# == 2 )) || exit 1

compose_verse () {
  local -i idx=$(($1 - 1))
  printf '%s\n' "${origin[idx]}"
  for (( idx-- ; idx >= 0; idx-- )); do
    printf '%s\n' "${echoes[idx]}"
  done
  printf '\n'
}

recite () {
  if (( $1 > $2 )) || (( $1 < 1 || $2 < 1 )) || (( $1 > 12 || $2 > 12 )); then
    echo invalid
    return 1
  fi
  local -i ptr
  for (( ptr = $1; ptr <= $2; ptr++ )); do
    compose_verse "$ptr"
  done
}

recite "$@"

# vim:ts=2:sw=2:expandtab
