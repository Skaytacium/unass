#!/bin/sh

#1 - File/directory to apply

# store -> unass -> verbs -> apply -> default
# ..    \  ..    \  ..    \  .
STORE=$(readlink -f "./../../..")

pwd
echo $STORE
readlink -f "$0"

# [ -d "$(dirname "/$1")" ] || mkdir -p "$(dirname "/$1")"
# cp -r "$STORE/$1" "/$1"
