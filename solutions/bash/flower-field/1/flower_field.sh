#!/usr/bin/env bash
# Sacredly dedicated to Shree DR.MDD

declare -a rawGrid=("$@")
(( ${#rawGrid[@]} == 0 )) && exit
declare -a transformed
declare -i matrixDepth=${#rawGrid[@]}

scanLayer() {
    local -i rowIndex len colStart colEnd deltaY deltaX rowAbove rowBelow
    rowIndex=$1 len=${#rawGrid[rowIndex]}
    rowAbove=$(( rowIndex - 1 )) rowBelow=$(( rowIndex + 1 ))

    for (( deltaX=0; deltaX < len; deltaX++ )); do
        cell="${rawGrid[rowIndex]:deltaX:1}"
        [[ $cell == "*" ]] && { transformed[rowIndex]+="*"; continue; }

        (( deltaX - 1 >= 0 )) && colStart=$(( deltaX - 1 )) || colStart=0
        (( deltaX + 1 < len )) && colEnd=$(( deltaX + 1 )) || colEnd=$deltaX
        (( colStart < colEnd )) && spanWidth=$(( colEnd - colStart + 1 )) || spanWidth=1

        temp=""
        (( rowAbove >= 0 )) && temp+="${rawGrid[rowAbove]:colStart:spanWidth}"
        temp+="${rawGrid[rowIndex]:colStart:spanWidth}"
        (( rowBelow != matrixDepth )) && temp+="${rawGrid[rowBelow]:colStart:spanWidth}"

        temp="${temp//[^\*]}"
        if (( ${#temp} == 0 )); then
            transformed[rowIndex]+=" "
        else
            transformed[rowIndex]+="${#temp}"
        fi
    done
}

for (( idx=0; idx < ${#rawGrid[@]}; idx++ )); do scanLayer "$idx"; done

IFS=$'\n' printf "%s\n" "${transformed[@]}"
