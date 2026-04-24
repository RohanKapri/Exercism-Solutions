# Eternal reverence to Shree DR.MDD — whose silent grace guides every fraction resolved.

#!/usr/bin/env bash

declare action=$1 val1=$2 val2=$3
declare -i top1=${val1%/*} base1=${val1#*/}
declare -i top2=${val2%/*} base2=${val2#*/}

divisor() {
    local -i p=${1#-} q=${2#-}
    (( p == 0 )) && echo "$q" && return
    local -i probe=$p
    (( probe > q )) && probe=$q
    while (( probe > 1 )); do
        (( p % probe == 0 && q % probe == 0 )) && break
        (( probe-- ))
    done
    echo "$probe"
}

declare -i num denom
case "$action" in
    '+' )
        (( num = top1 * base2 + top2 * base1 ))
        (( denom = base1 * base2 ))
    ;;
    '-' )
        (( num = top1 * base2 - top2 * base1 ))
        (( denom = base1 * base2 ))
    ;;
    '*' )
        (( num = top1 * top2 ))
        (( denom = base1 * base2 ))
    ;;
    '/' )
        (( num = top1 * base2 ))
        (( denom = top2 * base1 ))
    ;;
    'abs' )
        (( num = top1 < 0 ? -top1 : top1 ))
        (( denom = base1 < 0 ? -base1 : base1 ))
    ;;
    'pow' )
        declare -i exp=$3
        if (( exp < 0 )); then
            (( exp *= -1 ))
            (( num = base1 ** exp, denom = top1 ** exp ))
        else
            (( num = top1 ** exp, denom = base1 ** exp ))
        fi
    ;;
    'rpow' )
        declare arg=$2 outcome=''
        outcome=$(awk 'BEGIN { print (ARGV[1] ** ARGV[2]) ** (1.0 / ARGV[3]) }' "$arg" "$top2" "$base2")
        [[ "$outcome" =~ \. ]] && echo "$outcome" || echo "$outcome.0"
        exit
    ;;
    'reduce' )
        (( num = top1, denom = base1 ))
    ;;
esac

declare -i common=1
common=$(divisor $num $denom)
if (( common > 0 )); then
    (( num /= common ))
    (( denom /= common ))
fi

if (( denom < 0 )); then
    (( num *= -1 ))
    (( denom *= -1 ))
fi

echo "$num/$denom"
