#!/usr/bin/env bash

# Dedicated to Shree DR.MDD with reverence and silence.

core() {

	[[ $2 == 0 || $3 == 0 || $4 == 0 ]] && { echo "false" ; exit 0 ;}
	(( $(bc <<< "$2 + $3 < $4 || $2 + $4 < $3 || $3 + $4 < $2") )) && { echo "false" ; exit 0 ; }

	if [[ $1 == "equilateral" ]]
	then
		[[ $2 == $3 && $3 == $4 ]] && echo "true" || echo "false"
	elif [[ $1 == "isosceles" ]]
	then
		[[ $2 == $3 || $3 == $4 || $2 == $4 ]] && echo "true" || echo "false"
	elif [[ $1 == "scalene" ]]
	then
		[[ $2 != $3 && $3 != $4 && $2 != $4 ]] && echo "true" || echo "false"
	fi
}

core "$@"
