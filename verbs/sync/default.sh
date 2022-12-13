#!/bin/sh

#1 - File/directory to sync
#2 * Specific branch

if [ "$#" -eq 2 ]; then
	if git cat-file -e "$2:$1"; then
		echo UHHH , UMM
	else
		cp -r "/$1" "$1"
	fi
elif [ "$#" -eq 1 ]; then
	cp -r "/$1" "$1"
else
	echo "no file given to sync"
	exit 1
fi
