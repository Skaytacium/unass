#!/bin/sh

TYPE="$1"
shift

case "$TYPE" in
	0)
		echo "\033[4;34m* $@\033[0m"
		;;
	1)
		echo "\033[4;1;33m** $@\033[0m"
		;;
	2)
		echo "\033[4;1;31m*** $@\033[0m"
		exit 1
		;;
	3)
		echo "\033[4;1;44;30m$@\033[0m"
		;;
esac
