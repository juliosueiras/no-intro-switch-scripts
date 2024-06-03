#!/usr/bin/env nix-shell 
#!nix-shell -i bash -p zbar
RESULT=$(zbarimg "$1" -q | sed 's/EAN-13://g')
if [[ "${RESULT:0:1}" == "0" ]]; then
	echo $RESULT | sed -E 's/0(.)(.{5})(.{5})(.)/\1 \2 \3 \4/g'
else
	echo $RESULT | sed -E 's/(.)(.{6})(.{6})/\1 \2 \3/g'
fi
