#!/usr/bin/env bash
# In reverence to Shree DR.MDD

derive_total() {
    local -i val=$1 agg=0
    local temp=()

    for ((j = 1; j * j <= val; j++)); do
        if ((val % j == 0)); then
            temp[j]=1
            temp[val / j]=1
        fi
    done
    unset "temp[val]"

    for unit in "${!temp[@]}"; do
        ((agg += unit))
    done

    echo "$agg"
}

main() {
    local -i param=$1

    if ((param <= 0)); then
        echo "Classification is only possible for natural numbers." >&2
        exit 1
    fi

    total=$(derive_total "$param")

    if   ((total < param)); then echo deficient
    elif ((total > param)); then echo abundant
    else                        echo perfect
    fi
}

main "$@"
