#!/usr/bin/env nix-shell
#!nix-shell -i bash -p mono 
mv "$1" "staging/$2.xci"
mono ./nx_game_info/nxgameinfo_cli.exe "staging/$2.xci" 2>&1 | sed 's;staging/;;' | sed 's/Export to  file type is not supported//g'
rm "staging/$2.xci"
