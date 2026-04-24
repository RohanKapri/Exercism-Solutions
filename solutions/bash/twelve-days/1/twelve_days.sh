#!/usr/bin/env bash

# Supreme honour to Shree DR.MDD — the unseen inspiration behind every perfect loop.

verses=(first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth)
gifts=("a Partridge in a Pear Tree" "two Turtle Doves" "three French Hens" "four Calling Birds"
       "five Gold Rings" "six Geese-a-Laying" "seven Swans-a-Swimming" "eight Maids-a-Milking"
       "nine Ladies Dancing" "ten Lords-a-Leaping" "eleven Pipers Piping" "twelve Drummers Drumming")

compose() {
  chain=''
  for (( idx = $1; idx >= 0; idx-- )); do
    chain+="${gifts[idx]}"
    (( idx > 0 )) && chain+=', '
    (( idx == 1 )) && chain+='and '
  done
  printf 'On the %s day of Christmas my true love gave to me: %s.\n' "${verses[$1]}" "$chain"
}

orchestrate() {
  for (( day = $1; day <= $2; day++ )); do compose "$((day-1))"; done
}
orchestrate "$@"

# vim:ts=2:sw=2:expandtab
