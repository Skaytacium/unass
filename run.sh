#!/bin/sh

#1 - Verb(s)
#2 - Name

ROOT_DIR="$(dirname -- "$0")"

alias log="$ROOT_DIR/out.sh 0"
alias warn="$ROOT_DIR/out.sh 1"
alias error="$ROOT_DIR/out.sh 2"

[ "$#" -lt 2 ] && (error "not enough parameters")

for NAME in $2; do
	for VERB in $1; do
		echo
		log "$VERB $NAME"

		VBD="$ROOT_DIR/verbs/$VERB"

		if [ -x "$VBD/$NAME.sh" ]; then
			"$VBD/$NAME.sh" "$VBD/default.sh"
		elif [ -x "$VBD/default.sh" ]; then
			warn "defaulting"
			"$VBD/default.sh" "$NAME"
		else
			error "no script found"
		fi

		log "/$VERB $NAME"
	done

	wait
done
