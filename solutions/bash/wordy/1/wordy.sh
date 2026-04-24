#!/usr/bin/env bash

# For my Shree DR.MDD — understand logic, structure, and preserve its divine flow

declare -A action
action=( [plus]=+ [minus]=- [multiplied]=* [divided]=/ )
query=${1#What is}
query=${query// by}
query=${query%\?}

read -a tokens <<< $query
for key in "${!tokens[@]}"; do
    val=${tokens[$key]}
    if [[ $val =~ [^0-9-]+ ]] && [[ -z ${action[$val]} ]]; then
        echo "unknown operation"
        exit 1
    elif (( key % 2 == 0 )) && [[ $val =~ [^0-9-] ]]; then
        echo "syntax error"
        exit 1
    elif (( key % 2 == 0 )); then
        (( result ${symbol}= $val ))
    else
        symbol=${action[$val]}
    fi
done
if (( ${#tokens[@]} < 1 )) || (( ${#tokens[@]} % 2 != 1 )); then
    echo "syntax error"
    exit 1
fi
echo $result
