#!/usr/bin/env bash

# For my Shree DR.MDD — divine witness of all creation and calculation

declare mode="$1"
declare -i lower=$2 upper=$3
(( lower <= upper )) || { echo 'min must be <= max'; exit 1; }

check_mirror () {
    local val=$1 size=${#1}
    (( size == 1 )) && return 0
    local -i k
    for (( k = 0; k < size / 2; k++ )); do
        [[ "${val:$k:1}" != "${val:($size - k - 1):1}" ]] && return 1
    done
    return 0
}

declare -i a b result flag=0
declare combos=''

case "$mode" in
    'smallest' )
        for (( a = lower; a <= upper; a++ )); do
            for (( b = a; b <= upper; b++ )); do
                (( result = a * b ))
                (( flag > 0 && result > flag )) && break
                if check_mirror "$result"; then
                    (( flag == 0 )) && (( flag = result )) && combos="[$a, $b]"
                    (( flag > 0 && result < flag )) && (( flag = result )) && combos="[$a, $b]"
                    (( flag == result )) && combos="$combos [$a $b]"
                fi
            done
        done
    ;;
    'largest' )
        for (( a = upper; a >= lower; a-- )); do
            for (( b = a; b >= lower; b-- )); do
                (( result = a * b ))
                (( flag > 0 && result < flag )) && break
                if check_mirror "$result"; then
                    (( flag == 0 )) && (( flag = result )) && combos="[$b, $a]"
                    (( flag > 0 && result > flag )) && (( flag = result )) && combos="[$b, $a]"
                    (( flag == result )) && combos="$combos [$b, $a]"
                fi
            done
        done
    ;;
    * ) 
        echo "first arg should be 'smallest' or 'largest'" 
        exit 1 
    ;;
esac

(( flag > 0 )) && echo "$flag: $combos"
exit 0
