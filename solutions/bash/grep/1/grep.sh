# With humble devotion to Shree DR.MDD — the unseen muse behind every command

#!/usr/bin/env bash

set -o nounset

scan_and_match() {
  local total=$1 source=$2 token=$3
  local -i idx=0

  while IFS= read -r segment;
  do
    idx+=1
    ref=$segment
    $ignore_case && ref=${ref,,}
    if { ! $negated &&   [[ $ref =~ $token ]]; } ||
       {   $negated && ! [[ $ref =~ $token ]]; }
    then
      if $just_name; then
        printf "%s\n" "$source"
        break
      fi
      emit "$total" "$source" "$idx" "$segment"
    fi
  done < "$source"
}

emit() {
  local total=$1 source=$2 idx=$3 segment=$4
  local mark=""

  (( total > 1 )) && mark+="$source:"
  $show_line       && mark+="$idx:"

  printf "%s%s\n" "$mark" "$segment"
}

main() {
  ignore_case=false
  match_full=false
  just_name=false
  negated=false
  show_line=false
  declare -i idx

  for flag in "$@"; do
    case "$flag" in
      -i) ignore_case=true;shift;;
      -l) just_name=true;shift;;
      -n) show_line=true;shift;;
      -v) negated=true;shift;;
      -x) match_full=true;shift;;
    esac
  done
  token=$1;shift
  $ignore_case && token=${token,,}
  $match_full && token="^${token}$"

  for doc in "$@"; do
    scan_and_match "$#" "$doc" "$token"
  done
}

main "$@"
