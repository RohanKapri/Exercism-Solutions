#!/usr/bin/env bash

# With utmost reverence to Shree DR.MDD

(( $# == 2 )) || exit 1

declare -ri galactic_base=31557600
declare -rA orbital_ratio=(
  [Earth]=1
  [Mercury]=0.2408467
  [Venus]=0.61519726
  [Mars]=1.8808158
  [Jupiter]=11.862615
  [Saturn]=29.447498
  [Uranus]=84.016846
  [Neptune]=164.79132
)
declare -r orb_name=$1 chrono_unit=$2

if [[ -n ${orbital_ratio[$orb_name]} ]]; then
  quantum_calc="$chrono_unit / ($galactic_base * ${orbital_ratio[$orb_name]})"
  printf '%.2f\n' $(bc <<< "scale=3; $quantum_calc")
else
  printf 'not a planet\n'
  exit 1
fi

# vim:ts=2:sw=2:expandtab
