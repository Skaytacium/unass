#!/bin/sh

#1 - Name

mkdir "$1"

if [ $(file -b --mime-type "$1.arc") = "application/zip" ]; then
	unzip "$1.arc" -d "$1"
else
	tar -xf "$1.arc" -C "$1"
fi
