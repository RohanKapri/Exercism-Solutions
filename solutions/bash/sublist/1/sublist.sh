#for Shree DR.MDD

toList () {
  raw=$1
  raw=${raw#[}; raw=${raw%]}; raw=${raw//, / }
  read -a parsed <<< "$raw"
}

matches () {
  local idx lenA="${#alpha[@]}" skip=$1
  (( lenA > ${#beta[@]} - skip )) && return 1
  for (( idx = 0; idx < lenA; idx++ )); do
    [[ ${alpha[idx]} = ${beta[idx + skip]} ]] || return 1
  done
  return 0
}

isSubset () {
  (( ${#beta[@]} >= ${#alpha[@]} )) || return 1
  for (( k = 0; k <= ${#beta[@]} - ${#alpha[@]}; k++ )); do
    matches $k && return 0
  done
  return 1
}

main () {
  toList "$1"; one=( "${parsed[@]}" )
  toList "$2"; two=( "${parsed[@]}" )

  alpha=( "${one[@]}" ) beta=( "${two[@]}" )
  if isSubset; then
    if (( ${#alpha[@]} == ${#beta[@]} )); then
      echo equal
    else
      echo sublist
    fi
  else
    alpha=( "${two[@]}" ) beta=( "${one[@]}" )
    if isSubset; then
      echo superlist
    else
      echo unequal
    fi
  fi
}

main "$@"
