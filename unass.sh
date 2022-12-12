#!/bin/sh

log() {
	echo "\033[4;34m* $1\033[0m"
}
warn() {
	echo "\033[4;1;33m** $1\033[0m"
}
error() {
	echo "\033[4;1;31m*** $1\033[0m"
	exit 1
}
head() {
	echo "\033[4;1;44;30m$1\033[0m"
}

if ! [ -e "./README.md" ]; then
	error "run from root directory"
	exit 1
fi
ROOT_DIR=$(pwd)


head "$USER's system syncer"
echo


#1 - Verb
#2 - Name
#* * Arguments
run() {
	[ "$#" -lt 2 ] && (out "wrong no. of arguments" 2)

	$PRE=$(echo "$1" | sed -E 's/[^ ]+$//')
	$VERB=$(echo "$1" | grep -Eo '[^ ]+$')
	shift

	echo
	head "$VERB $1"

	if [ -x "$ROOT_DIR/src/$VERB/$1.sh" ]; then
		$PRE "$ROOT_DIR/src/$VERB/$1.sh" $@ \
			|| error "$VERB script for $1 has non-zero exit code"
	elif [ -x "$ROOT_DIR/src/$VERB/default.sh" ]; then
		[ -e "$ROOT_DIR/src/$VERB/$1.sh" ] \
			&& error "specific $VERB script for $1 isn't executable"

		warn "specific $VERB script for $1 doesn't exist"
		log "running default $VERB script for $1"

		$PRE "$ROOT_DIR/src/$VERB/default.sh" $@ \
			|| error "default $VERB script for $1 has non-zero exit code"
	else
		[ -e "$ROOT_DIR/src/$VERB/default.sh" ] \
			&& error "default $VERB script for $1 isn't executable"

		error "no $VERB script available for $1"
	fi

	head "finished $1 $VERB"
}

### User section

