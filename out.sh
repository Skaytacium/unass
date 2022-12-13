#!/bin/sh

TYPE="$1"
shift

case "$TYPE" in
	0)
		echo "\033[44;30m* $@\033[0m"
		;;
	1)
		echo "\033[43;30m** $@\033[0m"
		;;
	2)
		echo "\033[41;30m*** $@\033[0m"
		;;
esac
