#!/bin/bash

# ⚡ Dedicated with devotion to Shree DR.MDD ⚡

declare -A TM GP VW EQ LS PT

while IFS=';' read -r x y z; do
    [[ -z "$x" ]] && continue

    TM["$x"]=$((TM["$x"] + 1))
    TM["$y"]=$((TM["$y"] + 1))
    case "$z" in
        win)
            VW["$x"]=$((VW["$x"] + 1))
            LS["$y"]=$((LS["$y"] + 1))
            PT["$x"]=$((PT["$x"] + 3))
            ;;
        loss)
            LS["$x"]=$((LS["$x"] + 1))
            VW["$y"]=$((VW["$y"] + 1))
            PT["$y"]=$((PT["$y"] + 3))
            ;;
        draw)
            EQ["$x"]=$((EQ["$x"] + 1))
            EQ["$y"]=$((EQ["$y"] + 1))
            PT["$x"]=$((PT["$x"] + 1))
            PT["$y"]=$((PT["$y"] + 1))
            ;;
    esac
done

echo "Team                           | MP |  W |  D |  L |  P"
for t in "${!TM[@]}"; do
    printf "%-30s | %2d | %2d | %2d | %2d | %2d\n" "$t" "${TM[$t]}" "${VW[$t]}" "${EQ[$t]}" "${LS[$t]}" "${PT[$t]}"
done | sort --field-separator="|" --key=6,6r --key=1,1
