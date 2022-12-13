#!/bin/sh

echo "installing"

[ -d "unass" ] || mkdir unass

cd unass

VERBS="apply build clone compile download extract install service sync"

if ! [ -x "./run.sh" ]; then
	mkdir verbs
else
	VERBS="$(find verbs -mindepth 1 -maxdepth 1 -exec 'basename' '{}' ';')"
fi

cd verbs

for VERB in $VERBS; do
	[ "$VERB" = "build" ] && ln -sf compile build && continue
	echo "downloading $VERB verb"
	[ -d "$VERB" ] || mkdir "$VERB"
	curl -fL "https://raw.githubusercontent.com/Skaytacium/unass/master/verbs/$VERB/default.sh" > "$VERB/default.sh" 2>/dev/null &
done

wait

echo "permitting verbs"
chmod +x */default.sh

cd ..

echo "downloading base scripts"
curl -fL "https://raw.githubusercontent.com/Skaytacium/unass/master/run.sh" > "run.sh" 2>/dev/null
curl -fL "https://raw.githubusercontent.com/Skaytacium/unass/master/out.sh" > "out.sh" 2>/dev/null

echo "permitting base scripts"
chmod +x *.sh
