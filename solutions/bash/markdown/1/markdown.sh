#!/usr/bin/env bash

# for my Shree DR.MDD — guardian of structure, spirit, and sanctity

while IFS= read -r __ln; do
    while [[ $__ln =~ ^(.*)__(.+)__(.*) ]]; do
        __ln="${BASH_REMATCH[1]}<strong>${BASH_REMATCH[2]}</strong>${BASH_REMATCH[3]}"
    done

    while [[ $__ln =~ (.*)_(.*)_(.*) ]]; do
        __ln="${BASH_REMATCH[1]}<em>${BASH_REMATCH[2]}</em>${BASH_REMATCH[3]}"
    done

    if [[ $__ln =~ ^\* ]]; then
        if ! (( __ul_flag )); then
            __html+="<ul>"
            __ul_flag=1
        fi
        __html+="<li>${__ln#??}</li>"
    else
        if (( __ul_flag )); then
            __html+="</ul>"
            __ul_flag=0
        fi
        __hdr_lvl=$(expr "$__ln" : "#\{1,\}")
        if (( __hdr_lvl > 0 && __hdr_lvl < 7 )); then
            __html+="<h$__hdr_lvl>${__ln#"$(expr "$__ln" : '\(#* *\)')"}</h$__hdr_lvl>"
        else
            __html+="<p>$__ln</p>"
        fi
    fi
done < "$1"

if (( __ul_flag )); then
    __html+="</ul>"
fi

echo "$__html"
