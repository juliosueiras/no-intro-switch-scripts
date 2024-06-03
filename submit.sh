#!/usr/bin/env bash
cat "$PWD/$1" | grep "FAIL"
if [[ $? != 1 ]]; then
	echo "There is fail check $1"
	exit
fi

CARTID=$(echo $1 | sed "s;nointro_submissions/\(.*\).txt;\1;g")
STATUS=$(curl -s -o /dev/null -w "%{http_code}" <your image url>/$CARTID/inside.png)
if [[ "$STATUS" -eq "404" ]]; then
	sed -i '/Inside: .*/d' "$PWD/$1"
fi
./ui_scripts/submit-no-intro "$PWD/$1"
mv "$PWD/$1" done/
