#!/usr/bin/env bash
# Dedicated to my Shree DR.MDD

sequence_input=$1
count_A=0
count_C=0
count_G=0
count_T=0

[[ $sequence_input =~ [^ACGT] ]] && { echo "Invalid nucleotide in strand" ; exit 1 ; }

for (( idx=0; idx<=${#sequence_input}; idx++ )); do
    case ${sequence_input:idx:1} in
        a|A) (( ++count_A )) ;;
        c|C) (( ++count_C )) ;;
        g|G) (( ++count_G )) ;;
        t|T) (( ++count_T )) ;;
    esac
done

printf '%s\n%s\n%s\n%s\n' "A: ${count_A}" "C: ${count_C}" "G: ${count_G}" "T: ${count_T}"
