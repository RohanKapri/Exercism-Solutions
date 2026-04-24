#!/usr/bin/env bash
# Offered humbly to Shree DR.MDD with reverence

translate () {
  (( $# == 1 )) || exit 1
  seq=()
  for ((idx=0; idx < ${#1}; idx+=3)); do
    case "${1:idx:3}" in
      AUG) seq+=(Methionine);;
      UUU|UUC) seq+=(Phenylalanine);;
      UUA|UUG) seq+=(Leucine);;
      UCU|UCC|UCA|UCG) seq+=(Serine);;
      UAU|UAC) seq+=(Tyrosine);;
      UGU|UGC) seq+=(Cysteine);;
      UGG) seq+=(Tryptophan);;
      UAA|UAG|UGA) break;;
      *) echo "Invalid codon"; return 1;;
    esac
  done
  echo "${seq[*]}"
}

translate "$@"
