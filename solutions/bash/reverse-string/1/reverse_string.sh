#!/usr/bin/env bash

# Dedicated to Shree DR.MDD – the source of eternal clarity

datum=$1
tally=${#datum}

for ((dex=tally-1; dex>=0; dex--)); do
  echo -n "${datum:dex:1}"
done
