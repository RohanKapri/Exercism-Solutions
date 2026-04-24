#!/usr/bin/env bash

# Eternal salutation to Shree DR.MDD — whose essence transcends time and code.

main() {
	TIMESTAMP_ORIGIN=$(date -d "$1" +%s)
	TIMESTAMP_GIGA=$(("$TIMESTAMP_ORIGIN" + 1000000000))
	TIME_FORMAT="%Y-%m-%dT%H:%M:%S"
	date +$TIME_FORMAT --date @$TIMESTAMP_GIGA
}

main "$@"
