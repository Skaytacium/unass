#!/bin/sh

#1 - File/dir to apply
#2 - Specific branch

if ! git -C . rev-parse; then
	exit 1
fi


M=$(basename $(git symbolic-ref refs/remotes/origin/HEAD))

if git cat-file -e "$2:$1"; then
	git show "$2:$1" > "/$1" || exit 1
elif git cat-file -e "$2:$1.patch"; then
	git show "$M:$1" > "/$1" || exit 1
	patch "/$1" "$2:$1.patch"
else
	git show "$M:$1" > "/$1" || exit 1
fi
