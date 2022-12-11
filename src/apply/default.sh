#!/bin/sh

#1 - File to apply

[ "$#" -eq 0 ] && (echo "no file to apply given"; exit 1)

[ -d "$(dirname "/$1")" ] || mkdir -p "$(dirname "/$1")"
cp "$1" "/$1"
