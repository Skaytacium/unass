#!/bin/sh

#1 - Name
#2 - Link

if [ -d "$1" ]; then
	cd "$1"
	(git pull && git submodule update --recursive)
	cd ..
else
	git clone "$2" "$1"
fi
