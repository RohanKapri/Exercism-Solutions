#!/usr/bin/env bash

word=$1
shift

play() {
    local lettersRemaining=$word
    local state=Ongoing
    local remainingIncorrectGuesses=9

    while (( $# )) && [[ $state == "Ongoing" ]]; do
        guess "$1"
        shift
    done

    report $#
}

guess() {
    local letter=$1
    if [[ $lettersRemaining == *"$letter"* ]]; then
        lettersRemaining=${lettersRemaining//$letter/}
        [[ -z $lettersRemaining ]] && state=Win
    elif (( remainingIncorrectGuesses == 0 )); then
        state=Lose
    else
        (( remainingIncorrectGuesses -= 1 ))
    fi
}

die() { echo "$*" >&2; exit 1; }

report() {
    if (( $1 > 0 )); then
        [[ $state == "Win" ]]  && die 'cannot guess after the game is won'
        [[ $state == "Lose" ]] && die 'cannot guess after the game is lost'
    fi

    printf 'State: %s\n' "$state"
    printf 'Masked word: %s\n' "${word//["$lettersRemaining"]/_}"
    printf 'Remaining failures: %d\n' "$remainingIncorrectGuesses"
}

play "$@"