#!/bin/sh

#1 - Name
#2 - Link

[ "$#" -lt 2 ] && (echo "wrong no. of arguments"; exit 1)

wget "$2" -O "$1.arc"
