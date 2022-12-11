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

if ! [ -x "./unass.sh" ]; then
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

	VERB="$1"
	shift 1

	echo
	head "$VERB $1"

	if [ -x "$ROOT_DIR/src/$VERB/$1.sh" ]; then
		"$ROOT_DIR/src/$VERB/$1.sh" $@ \
			|| error "$VERB script for $1 has non-zero exit code"
	elif [ -x "$ROOT_DIR/src/$VERB/default.sh" ]; then
		[ -e "$ROOT_DIR/src/$VERB/$1.sh" ] \
			&& error "specific $VERB script for $1 isn't executable"

		warn "specific $VERB script for $1 doesn't exist"
		log "running default $VERB script for $1"

		"$ROOT_DIR/src/$VERB/default.sh" $@ \
			|| error "default $VERB script for $1 has non-zero exit code"
	else
		[ -e "$ROOT_DIR/src/$VERB/default.sh" ] \
			&& error "default $VERB script for $1 isn't executable"

		error "no $VERB script available for $1"
	fi

	head "finished $1 $VERB"
}

#1 - File path
#2 - Verb
#* * Arguments
for_files() {
	[ "$#" -lt 2 ] && (out "wrong no. of arguments" 2)

	FILEPATH="$1"
	VERB="$2"
	shift 2

	if [ -d "$FILEPATH" ]; then
		for FILE in $(find "$FILEPATH" -type f); do run "$VERB" "$FILE" $@; done
	else
		run "$VERB" "$FILEPATH" $@ 
	fi
}

### User section
