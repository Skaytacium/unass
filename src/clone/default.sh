#!/bin/sh

#1 - Name
#2 - Link

[ "$#" -eq 1 ] && (echo "no link passed to $1"; exit 1)

if [ -d "$1" ]; then
	cd "$1"
	(git pull && git submodule update --recursive)
	cd ..
else
	git clone "$2" "$1"
fi
