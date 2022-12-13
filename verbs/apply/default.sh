#!/bin/sh

#1 - File/directory to apply

[ -d "$(dirname "/$1")" ] || mkdir -p "$(dirname "/$1")"
cp -r "$1" "/$1"
