#!/bin/sh

#1 - Verb(s)
#2 - Name

[ "$#" -lt 2 ] && (echo "\033[4;1;31m*** not enough parameters\033[0m"; exit 1)

ROOT_DIR="$(dirname -- "$0")"

alias log="$ROOT_DIR/out.sh 0"
alias warn="$ROOT_DIR/out.sh 1"
alias error="$ROOT_DIR/out.sh 2"
alias head="$ROOT_DIR/out.sh 3"

for NAME in $2; do
	for VERB in $1; do
		echo
		head "$VERB $NAME"

		if [ -x "$ROOT_DIR/verbs/$VERB/$NAME.sh" ]; then
			"$ROOT_DIR/verbs/$VERB/$NAME.sh" &
		elif [ -x "$ROOT_DIR/verbs/$VERB/default.sh" ]; then
			warn "$VERB $NAME: defaulting"
			"$ROOT_DIR/verbs/$VERB/default.sh" &
		else
			error "$VERB $NAME: no script found"
		fi

		head "$VERB $NAME: done"
	done

	wait
done
