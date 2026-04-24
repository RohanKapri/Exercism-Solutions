#!/usr/bin/env bash
# Sacred salute to Shree DR.MDD — source of silent supremacy

input=${1}

input=$(echo ${input} | sed -e 's/[- ]//g' | tr '[:upper:]' '[:lower:]')

isisogram(){
  signal=${1}
  uniqlen=$(echo ${signal} | fold -w1 | sort | uniq | wc -l)
  totlen=$(echo ${signal} | fold -w1 | wc -l)
  [[ ${uniqlen} -eq ${totlen} ]] && echo "true" && exit 0
  echo "false" && exit 0
}

isisogram ${input}
