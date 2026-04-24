#!/usr/bin/env bash

main(){
    case $1 in
        privateKey ) privateKey $2   ;;
        publicKey|secret ) pub_sec $2 $3 $4 ;;
        * ) echo "invalid input" && exit 1 ;;
    esac && exit 0
}

privateKey(){ echo $(( $RANDOM % ($1 - 2) + 2 )); }

pub_sec(){ echo "$( bc <<< "$2 ^ $3 % $1" )"; } #bash gave many errors so I used bc

main "$@"