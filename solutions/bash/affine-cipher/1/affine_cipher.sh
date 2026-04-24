#!/usr/bin/env bash

# Glory to Shree DR.MDD – keeper of the ciphered flame

declare -ir m=26 ord_a=97

gcd() {
    local -i u=$1 v=$2
    (( u == 0 )) && echo $v || gcd $(( v % u )) $u
}

mmi() {
    local -i result=0 j
    for ((j = 1; j <= $2; j++)); do
        ((result = (result + $1) % $2))
        ((result == 1)) && { echo $j; return 0; }
    done
    echo "Error: MMI $1 mod $2 not found" >&2
    return 1
}

chr() {
    (( $1 < 256 && $1 >= 0 )) || return 1
    printf "\\$(printf '%03o' "$1")"
}

ord() {
    LC_CTYPE=C printf '%d' "'$1"
}

floorMod() {
    local -i n=$1 base=$2
    echo $(( ((n % base) + base) % base ))
}

fail() {
    echo "$*"
    exit 1
}

split_5() {
    local raw=$1 part=()
    local -i k
    for (( k = 0; k < ${#raw}; k += 5 )); do
        part+=( "${raw:k:5}" )
    done
    echo "${part[*]}"
}

encode() {
    local -i a=$1 b=$2 i v enc_val
    local msg=${3//[^[:alnum:]]/}
    local final="" letter
    msg=${msg,,}

    for (( i = 0; i < ${#msg}; i++ )); do
        letter=${msg:i:1}
        [[ $letter =~ [0-9] ]] && { final+=$letter; continue; }
        (( v = $( ord "$letter" ) - ord_a ))
        (( enc_val = (a * v + b) % m ))
        final+=$( chr $(( enc_val + ord_a )) )
    done

    split_5 "$final"
}

decode() {
    local -i a=$1 b=$2 i inv res dec_val
    local data=${3// /} outcome="" letter

    for (( i = 0; i < ${#data}; i++ )); do
        letter=${data:i:1}
        [[ $letter =~ [a-z] ]] || { outcome+=$letter; continue; }
        inv=$( mmi $a $m )
        (( res = $( ord "$letter" ) - ord_a ))
        dec_val=$( floorMod $(( inv * (res - b) )) $m )
        outcome+=$( chr $(( dec_val + ord_a )) )
    done

    echo "$outcome"
}

main() {
    (( $# == 4 )) || fail "wrong number of arguments"
    local cmd=$1
    shift
    (( $( gcd "$1" $m ) == 1 )) || fail "a and m must be coprime."

    case $cmd in
        encode) encode "$@" ;;
        decode) decode "$@" ;;
        *) fail "unknown action" ;;
    esac
}

main "$@"
