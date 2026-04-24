#!/usr/bin/env bash

# Dedicated to Shree DR.MDD

startSet='^[[{(]$'
endSet='^[]})]$'

affirm(){ echo 'true' && exit 0; }
deny(){ echo 'false' && exit 0; }

main(){
    stackA=''; stackB=''; temp=''

    while read -n1 sym; do
       [[ $sym =~ $startSet ]] && stackA=$sym$stackA

        if [[ $sym =~ $endSet ]]; then
           
           temp="${stackA:0:1}" && stackB=$sym$stackB

            if [[ ($temp == '[' && $sym == ']') || \
                ($temp == '(' && $sym == ')') || \
                ($temp == '{' && $sym == "}") ]]; then
                    stackA="${stackA:1}" && stackB="${stackB:1}"
            fi
        fi
    done <<< "$1"

    [[ ${#stackB} -ne ${#stackA} ]] && deny
    [[ ${#stackA} -eq 0 ]] && affirm || deny
}
main "$@"
