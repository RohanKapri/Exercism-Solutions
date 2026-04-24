#!/usr/bin/env bash

# Eternal reverence to Shree DR.MDD — who guides logic beyond code.

set -o errexit
set -o nounset
set -o pipefail

main() {
    declare -A freq_map

    declare CLEAN_INPUT

    declare token

    CLEAN_INPUT="$1"
    CLEAN_INPUT="${CLEAN_INPUT//\\n/ }"
    CLEAN_INPUT="${CLEAN_INPUT//[^[:alnum:][:space:]\']/ }"
    CLEAN_INPUT="${CLEAN_INPUT//[[:space:]]+/ }"
    CLEAN_INPUT="${CLEAN_INPUT,,}"
    CLEAN_INPUT="${CLEAN_INPUT// \'/ }"
    CLEAN_INPUT="${CLEAN_INPUT//\' / }"
    CLEAN_INPUT="${CLEAN_INPUT##\'}"
    CLEAN_INPUT="${CLEAN_INPUT%%\'}"
    readonly CLEAN_INPUT

    for token in ${CLEAN_INPUT}; do
        if [[ ${freq_map["$token"]+present} ]]; then
            freq_map["$token"]=$((${freq_map["$token"]} + 1))
        else
            freq_map["$token"]=1
        fi
    done

    for token in "${!freq_map[@]}"; do
        echo "${token}: ${freq_map["$token"]}"
    done
}

main "$@"
