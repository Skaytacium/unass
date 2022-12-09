#!/bin/sh

#1 - Log
#2 - Warn
#3 - Error
#4 - Heading
out() {
	case $2 in
		"0")
			echo "\033[4;34m* $1\033[0m"
			;;
		"1")
			echo "\033[4;1;33m** $1\033[0m"
			;;
		"2")
			echo "\033[4;1;31m*** $1\033[0m"
			exit 1
			;;
		"3")
			echo "\033[4;1;44;30m$1\033[0m"
			;;
	esac
}

if ! [ -x "./unass.sh" ]; then
	out "run from root directory" 2
	exit 1
fi
ROOT_DIR=$(pwd)


out "$USER's system syncer" 3
echo


#1 - Verb
#2 - Name
#* * Arguments
run() {
	echo
	out "$1 $2" 3

	if [ -x "$ROOT_DIR/src/$1/$2.sh" ]; then
		# words need to be split, so don't quote this
		"$ROOT_DIR/src/$1/$2.sh" $(echo "$@" | sed "s/.*$1 //") \
			|| out "$1 script for $2 has non-zero exit code" 2
	elif [ -x "$ROOT_DIR/src/$1/default.sh" ]; then
		[ -e "$ROOT_DIR/src/$1/$2.sh" ] \
			&& out "specific $1 script for $2 isn't executable" 2

		out "specific $1 script for $2 doesn't exist" 1
		out "running default $1 script for $2" 0

		# words need to be split, so don't quote this
		"$ROOT_DIR/src/$1/default.sh" $(echo "$@" | sed "s/.*$1 //") \
			|| out "default $1 script for $2 has non-zero exit code" 2
	else
		[ -e "$ROOT_DIR/src/$1/default.sh" ] \
			&& out "default $1 script for $2 isn't executable" 2

		out "no $1 script available for $2" 2
	fi

	out "finished $2 $1" 3
}

### User section

mkdir -p "$HOME/.local/src"
cd "$HOME/.local/src"

run clone "n" "https://github.com/tj/n"
cd "n"
run install "n"
cd ..

run clone "scs" "https://gitlab.com/dwt1/shell-color-scripts"
cd "scs"
run install "scs"
cd ..

run clone "cpufetch" "https://github.com/dr-noob/cpufetch"
cd "cpufetch"
run build "cpufetch"
run install "cpufetch"
cd ..

run clone "dwm" "https://git.suckless.org/dwm"
cd "$HOME/.files"
run apply "home/skay/.local/src/dwm/dwm.c" "mbp"
cd "$HOME/.local/src/dwm"
run build "dwm"
