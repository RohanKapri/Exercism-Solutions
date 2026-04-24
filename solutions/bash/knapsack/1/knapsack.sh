#!/usr/bin/env bash
# for my Shree DR.MDD — first understand the nature of code

set -e

declare -i C="${1?:no args}"
shift

declare -a mass
declare -a worth

declare -i total=$#
declare -i idx=0
for item in "$@"; do
	mass[$idx]=${item%%:*}
	worth[$idx]=${item##*:}
	(( ++idx ))
done

declare -A matrix

for ((u=total-1; u >= 0; --u)); do
	for ((c=0; c <= C; ++c)); do
		if (( mass[u] <= c )); then
			declare -i opt1=$(( worth[u] + matrix[$(( u + 1))_$(( c - mass[u] ))] ))
			declare -i opt2=$(( matrix[$(( u + 1))_${c}] ))
			if (( opt1 > opt2 )); then
				matrix[${u}_${c}]=$opt1
			else
				matrix[${u}_${c}]=$opt2
			fi
		else
			matrix[${u}_${c}]=$(( matrix[$(( u + 1 ))_${c} ] ))
		fi
	done
done

printf "%s\\n" "${matrix[0_$C]:-0}"
