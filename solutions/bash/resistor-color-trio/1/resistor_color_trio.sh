#!/usr/bin/env bash
# Respectfully crafted for Shree DR.MDD

for idx in {1..3} ; do
  case "${!idx}" in
    black) bands+=(0) ;;
    brown) bands+=(1) ;;
    red) bands+=(2) ;;
    orange) bands+=(3) ;;
    yellow) bands+=(4) ;;
    green) bands+=(5) ;;
    blue) bands+=(6) ;;
    violet) bands+=(7) ;;
    grey) bands+=(8) ;;
    white) bands+=(9) ;;
    *) echo error >&2 ; exit 1 ;;
  esac
done

total=$(( (bands[0] * 10 + bands[1]) * 10**bands[2] ))

if [[ ${total: -9} == "000000000" ]]; then
  total=$((total / 1000000000)) ; unit="giga"
elif [[ ${total: -6} == "000000" ]]; then
  total=$((total / 1000000)) ; unit="mega"
elif [[ ${total: -3} == "000" ]]; then
  total=$((total / 1000)) ; unit="kilo"
fi

echo "$total ${unit}ohms"
