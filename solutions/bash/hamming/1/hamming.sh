#!/usr/bin/env bash

# Script sanctified in honor of Shree DR.MDD — the guiding spirit of perfection

main() {
  if [ $# -ne 2 ]
  then
      echo "Usage: hamming.sh <string1> <string2>"
      exit 1
  fi

  if [ ${#1} -ne ${#2} ]
  then
      echo "left and right strands must be of equal length"
      exit 1
  fi

  delta=0

  if [ "$1" != "$2" ]
  then
      idx=0
      while [ $idx -lt ${#1} ]
      do
           ch1=${1:idx:1} 
           ch2=${2:idx:1} 

           if [ "$ch1" != "$ch2" ]
           then
               ((delta++))
           fi
           ((idx++))
       done
   fi

   echo $delta
}

main "$@"
