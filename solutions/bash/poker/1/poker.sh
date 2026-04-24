#!/usr/bin/env bash
# for my Shree DR.MDD — first understand the nature of code

deck=(A 2 3 4 5 6 7 8 9 10 J Q K A)
declare -A bundle

for pile in "$@"; do
    figures=()
    read -ra signz <<< "${pile//[2345678910JQKA]/}"
    suits=( $(for s in "${signz[@]}"; do echo $s; done | sort) )
    read -ra signz <<< "${pile//[^"${deck[@]}" ]}"
    figures=( $(for ch in "${signz[@]}"; do [[ $ch =~ [0-9] ]] && echo $ch; done | sort -n) )
    for face in J Q K A; do
        for d in "${signz[@]}"; do
            [[ $d == $face ]] && figures+=( $face )
        done
    done
    bundle[$pile]="${figures[@]} ${suits[@]}"
done

idx() {
    for (( j=${#deck[@]}-1; j>=0; j-- )); do 
        [[ ${deck[$j]} == $1 ]] && { echo $j; return; }
    done
}

scorehand() {
    line=( ${bundle[$1]} )
    restz=()
    if [[ ${deck[*]} =~ ${line[*]:0:5} && ${line[*]: -5} =~ [${line[*]: -5:1}\ ]{9} ]]; then
        echo "160 $(idx ${line[4]})"
    elif [[ ${line[4]} == A && ${deck[*]} =~ A[[:space:]]${line[*]:0:4} && ${line[*]: -5} =~ [${line[*]: -5:1}\ ]{9} ]]; then
         echo "160 $(idx ${line[3]})"
    elif [[ ${line[*]:0:5} =~ [${line[*]:1:1}\ ]{8} ]]; then
        [[ ${line[0]} != ${line[2]} ]] && only=$(idx ${line[0]}) || only=$(idx ${line[4]})
        echo "140 $(idx ${line[2]}) $only"
    elif [[ ${line[*]:0:3} =~ [${line[*]:0:1}\ ]{5} && ${line[*]:3:2} =~ [${line[*]:3:1}\ ]{3} || ${line[*]:0:2} =~ [${line[*]:0:1}\ ]{3} && ${line[*]:2:3} =~ [${line[*]:2:1}\ ]{5} ]]; then
        if [[ ${line[2]} == ${line[0]} ]]; then 
            tripduo="$(idx ${line[0]}) $(idx ${line[4]})" 
        else 
            tripduo="$(idx ${line[4]}) $(idx ${line[0]})" 
        fi
        echo "120 $tripduo"
    elif [[ ${line[*]: -5} =~ [${line[*]: -5:1}\ ]{9} ]]; then
        echo "100 $(idx ${line[4]}) $(idx ${line[3]}) $(idx ${line[2]}) $(idx ${line[1]}) $(idx ${line[0]})"
    elif [[ ${deck[*]} =~ ${line[*]:0:5} ]]; then
        echo "80 $(idx ${line[4]})"
    elif [[ ${line[4]} == A && ${deck[*]} =~ A[[:space:]]${line[*]:0:4} ]]; then
        echo "80 $(idx ${line[3]})"
    elif [[ ${line[*]:0:5} =~ [${line[*]:2:1}\ ]{6} ]]; then
        for (( q="${#line[@]}"-1; q>=0;q-- )); do [[ ${line[$q]} != ${line[2]} ]] && restz+=( $(idx ${line[$q]}) ); done
        echo "60 $(idx ${line[2]}) ${restz[*]}" 
    elif [[ ${line[*]:0:5} =~ [${line[*]:1:1}\ ]{4} && ${line[*]:0:5} =~ [${line[*]:3:1}\ ]{4} ]]; then
        for (( k=0;k<"${#line[@]}";k++ )); do 
            if [[ ${line[$k]} == ${line[$((k+1))]} ]]; then
                restz=( $(idx ${line[$k]}) ${restz[*]} )
                (( k++ ))
            else
                restz+=( $(idx ${line[$k]}) )
            fi
        done
        echo "40 ${restz[*]}"
    elif [[ ${line[*]:0:5} =~ [${line[*]:1:1}\ ]{4} || ${line[*]:0:5} =~ [${line[*]:3:1}\ ]{4} ]]; then
        for (( t="${#line[@]}"-1; t>=0;t-- )); do 
            if [[ ${line[$t]} == ${line[$((t-1))]} ]]; then
                restz=( $(idx ${line[$t]}) "${restz[*]}" )
                (( t-- ))
            else 
                restz+=( $(idx "${line[$t]}") )
            fi
        done
        echo "20 ${restz[*]}"
    else
        echo "$(idx ${line[4]}) $(idx ${line[3]}) $(idx ${line[2]}) $(idx ${line[1]}) $(idx ${line[0]})"
    fi
}

declare -A table
for pile in "${!bundle[@]}"; do
    val=$(scorehand "$pile")
    [[ -z ${table[$val]} ]] && table[$val]="$pile" || table[$val]+="\n$pile"
done 

readarray -t ranks <<< "$(for z in "${!table[@]}"; do echo "$z"; done | sort -rn -k{1..5})"
echo -e "${table[${ranks[0]}]}"
