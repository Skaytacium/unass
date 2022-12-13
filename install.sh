#!/bin/sh

if ! [ "$(basename $(pwd))" = "unass" ]; then
	mkdir unass
	cd unass
fi

VERBS="apply build clone compile download extract install service sync"

if ! [ -x "./run" ]; then
	mkdir verbs
else
	VERBS="$(find verbs -mindepth 1 -maxdepth 1 -exec 'basename' '{}' ';')"
fi

for VERB in $VERBS; do
	[ "$VERB" = "build" ] && ln -sf compile build && continue
	curl -fL "https://raw.githubusercontent.com/Skaytacium/unass/master/verbs/$VERB/default.sh" > "$VERB"
done

curl -fL "https://raw.githubusercontent.com/Skaytacium/unass/master/run.sh" > "run.sh"
curl -fL "https://raw.githubusercontent.com/Skaytacium/unass/master/out.sh" > "out.sh"
