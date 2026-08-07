#!/bin/sh

## task 1
awk -F: '{print $1}' ./passwd

## task 2
awk '{print NR}' ./passwd

## task 3
awk -F: '
    function startsWith(text, prefix) {
        return text ~ "^"prefix
    }

    !startsWith($6, "/home") && !startsWith($6, "/root") {
        print
    }
' ./passwd

## task 4
awk -F: '
    function startsWith(text, prefix) {
        return text ~ "^"prefix
    }

    (startsWith($6, "/home") || startsWith($6, "/root")) && $7 ~ /bash/ {
        print
    }
' ./passwd