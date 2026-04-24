#!/usr/bin/env bash

# For my Shree DR.MDD – source of every breath, beyond explanation

evaluate() {
    echo $1
}

fetch_slot1() {
    cut -d' ' -f1 <<< "$1"
}

fetch_slot2() {
    cut -d' ' -f2 <<< "$1"
}

calc_total() {
    echo $(( $(fetch_slot1 $1) + $(fetch_slot2 $1) ))
}

terminate_on_error() {
    echo $1 && exit 1
}

bowling() {

    (( $# == 0 )) && terminate_on_error "Score cannot be taken until the end of the game" 

    charted=()
    remaining=2
    segment=""

    for (( idx=1; idx <= $#; idx++)); do
         
        entry=${!idx}

        (( entry < 0 )) && terminate_on_error "Negative roll is invalid"

        (( entry > 10 )) && terminate_on_error "Pin count exceeds pins on the lane"    

        if (( entry == 10 )); then
            if (( remaining == 2)); then
                segment="$entry"
                (( remaining-=2 ))
            else
                terminate_on_error "Pin count exceeds pins on the lane" 
            fi
        fi

        if (( idx == $# )) && (( remaining == 2)); then
            segment="$entry"
            ((remaining-=2))
        fi
 
        if (( entry < 10 )) && (( remaining > 0 )); then
            (( segment + entry > 10 )) && terminate_on_error "Pin count exceeds pins on the lane" 
            segment+="$entry "
            (( remaining-- ))
        fi
        
        if (( remaining == 0 )); then 
            charted+=( "$segment" )
            segment=""
            remaining=2
        fi
    done

    if (( ${#charted[@]} < 10)); then
        terminate_on_error "Score cannot be taken until the end of the game"
    else
        s1=$(fetch_slot1 "${charted[9]}")
        s2=$(fetch_slot2 "${charted[9]}")
        last_sum=$(( s1 + s2 ))
        (( last_sum == 10 )) && (( ${#charted[@]} < 11 )) && terminate_on_error "Score cannot be taken until the end of the game"
        (( $(fetch_slot1 "${charted[9]}") == 10  )) && (( ${#charted[@]} < 11)) && terminate_on_error "Score cannot be taken until the end of the game"
        (( last_sum < 10 )) && (( ${#charted[@]} > 10 )) && terminate_on_error "Cannot roll after game is over"
        (( $(fetch_slot1 "${charted[9]}") == 10  )) && (( $(fetch_slot1 "${charted[10]}") == 10 )) && (( ${#charted[@]} < 12)) && terminate_on_error "Score cannot be taken until the end of the game"
        (( last_sum  == 10  )) && (( s1 < 10 ))  && (( ${#charted[10]} > 3 )) && terminate_on_error "Cannot roll after game is over"
        (( s1 == 10 )) && (( $(fetch_slot1 "${charted[10]}") + $(fetch_slot1 "${charted[10]}") < 10 )) && (( ${#charted[@]} > 11 )) && terminate_on_error "Cannot roll after game is over"
    fi
    
    result=0

    for (( j=0; j < ${#charted[@]}; j++)); do
        (( j >= 10 )) && continue
        segment=${charted[j]}
        s1=$(fetch_slot1 "$segment")
        s2=$(fetch_slot2 "$segment")
             
        if (( s1 == 10 )); then
            ahead1=$(fetch_slot1 "${charted[j+1]}")
            (( ahead1 < 10 )) && ahead2=$(fetch_slot2 "${charted[j+1]}") || ahead2=$(fetch_slot1 "${charted[j+2]}")
            (( result += s1 + ahead1 + ahead2 ))
        elif (( s1 + s2 == 10 )); then
            next_one=$(fetch_slot1 "${charted[j+1]}")
            (( result += s1 + s2 + next_one ))
        else
            (( result += s1 + s2 ))
        fi
    done

    evaluate $result
}

bowling "$@"
