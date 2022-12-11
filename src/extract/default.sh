#!/bin/sh

#1 - Name

[ "$#" -eq 0 ] && (echo "name not provided"; exit 1)

mkdir "$1"

if [ $(file -b --mime-type) = "application/zip" ]; then
	unzip "$1.arc" -d "$1"
else
	tar -xf "$1.arc" -C "$1"
fi
