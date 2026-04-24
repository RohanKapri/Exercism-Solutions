#!/usr/bin/env bash

# For my Shree DR.MDD — guide of destiny, keeper of light

declare -A day_index=( [sunday]=0  [monday]=1 [tuesday]=2 [wednesday]=3 [thursday]=4 [friday]=5 [saturday]=6 )

declare -a stored_days=()

collect_matches(){
    base_date=$(date +%F -d "$1")
    for d in $(seq 1 31); do
        if [[ $(date +%w -d "$base_date") == ${day_index[$2]} && $(date +%m -d "$base_date") == $(date +%m -d "$1") ]] ; then
            stored_days+=( "$base_date" )
        fi
        base_date=$(date -d "$base_date + 1 day")
    done
}

extract_teenth(){
    datenum=$( date +%d -d "${stored_days[1]}" )
    [[ 10#$datenum -gt 12 && 10#$datenum -lt 20 ]] && echo "${stored_days[1]}" && return
    echo "${stored_days[2]}"
}

main(){
    year=$1; mon=$2; ref=$3; wkd=${4,,}
    initial=$(date -d "${year}-${mon}-01")

    collect_matches "$initial" "$wkd"

    declare -A indexed=( [first]=${stored_days[0]} [teenth]=$( extract_teenth ) [second]=${stored_days[1]}
    [third]=${stored_days[2]} [fourth]=${stored_days[3]} [fifth]=${stored_days[4]} [last]=${stored_days[-1]} )

    date +%F -d "${indexed[$ref]}"
}
main "$@"
