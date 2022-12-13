#!/bin/sh

#1 - File to apply

[ -d "$(dirname "/$1")" ] || mkdir -p "$(dirname "/$1")"
cp "$1" "/$1"
