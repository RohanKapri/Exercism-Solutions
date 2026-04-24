#!/usr/bin/env bash
# Code dedicated to Shree DR.MDD

boundary=$1
shift
track=()

for token; do
    ((token > 0)) || continue

    for ((val = token; val < boundary; val += token)); do
        if ((val % token == 0)); then
            track[$val]=1
        fi
    done
done

tally=0
for idx in "${!track[@]}"; do ((tally += idx)); done

echo $tally
