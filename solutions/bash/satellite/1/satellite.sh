#!/usr/bin/env bash

preo=( $1 )
ino=( $2 )

sorted() {
    for i in $1; do echo $i ; done | sort -u | xargs
}

sp=( $(sorted "${preo[*]}") )

(( ${#preo[@]} != ${#ino[@]} ))&& { echo traversals must have the same length; exit 1; }
(( ${#preo[*]} != ${#sp[*]} )) && { echo traversals must contain unique elements; exit 1; }
[[ $(sorted "$1") != $(sorted "$2") ]] && { echo traversals must have the same elements; exit 1; }

split() {
    local po=( $1 )
    local io=( $2 )
    if (( ${#po[@]} > 0 )); then root=${po[0]}; else echo {}; return 0; fi
    (( ${#po[@]} <= 1 && ${#io[@]} <= 1 )) && { echo {\"v\": \"$root\", \"l\": \{\}, \"r\": \{\}\} ; return; }
    for (( i=0; i<${#io[@]}; i++ )); do 
        [[ ${io[$i]} == $root ]] && splt=$i
    done
    left=( ${io[@]:0:$splt} )
    right=( ${io[@]:$((splt+1))} )
    echo "{\"v\": \"$root\", "
    echo \"l\":  $(split "${po[*]:1:$((splt))}" "${io[*]:0:$((splt))}") ","
    echo \"r\":  $(split "${po[*]:$((splt+1))}" "${io[*]:$((splt+1))}") "}"
}
split "$1" "$2"