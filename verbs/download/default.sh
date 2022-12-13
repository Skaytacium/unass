#!/bin/sh

#1 - Name
#2 - Link

[ "$#" -eq 1 ] && (echo "no link passed to $1"; exit 1)

wget "$2" -O "$1.arc"
