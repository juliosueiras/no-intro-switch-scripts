#!/usr/bin/env nix-shell
#!nix-shell -i bash -p rsbkb mono dos2unix hactool
#!nix-shell "import ./hactoolnet.nix"
dd status=progress bs=512 skip=4096 iflag=skip_bytes if="$3" of=tmp.xci

SCENE_CRC=$(cat "tmp.xci" | crc32)
SCENE_MD5=$(md5sum "tmp.xci" | awk '{print $1}')
SCENE_SHA256=$(sha256sum "tmp.xci" | awk '{print $1}')
SCENE_SHA1=$(sha1sum "tmp.xci" | awk '{print $1}')
SCENE_SIZE=$(du -b "tmp.xci" | awk '{print $1}')

hactool --disablekeywarns -t xci --verify "tmp.xci" > hactool_log.txt 

./nx_game_info.sh "tmp.xci" "$6" > nx_game_info.txt

cat <<EOF
Format: Default
Filename: $1 ($2).xci
MD5: $SCENE_MD5
SHA256: $SCENE_SHA256
SHA1: $SCENE_SHA1
SIZE: $SCENE_SIZE
CRC32: $SCENE_CRC

EOF

cat <<EOF
Format: Initial Key Area
Filename: $1 ($2) (Initial Area).bin
MD5: $(md5sum "$4" | awk '{print $1}')
SHA256: $(sha256sum "$4" | awk '{print $1}')
SHA1: $(sha1sum "$4" | awk '{print $1}')
SIZE: $(du -b "$4" | awk '{print $1}')
CRC32: $(cat "$4" | crc32)

EOF

cat <<EOF
Format: FullXCI
Filename: $1 ($2).xci
MD5: $(md5sum "$3" | awk '{print $1}')
SHA256: $(sha256sum "$3" | awk '{print $1}')
SHA1: $(sha1sum "$3" | awk '{print $1}')
SIZE: $(du -b "$3" | awk '{print $1}')
CRC32: $(cat "$3" | crc32)

EOF
CARDSETS=($(xxd -g 4 -u "$5" |sed 's/00000000://g'))
cat <<EOF
Format: Card ID Sets
Card ID 1: ${CARDSETS[0]}
Card ID 2: ${CARDSETS[1]}
Card ID 3: ${CARDSETS[2]}
CRC32: $(cat "$5" | crc32 | tr '[:lower:]' '[:upper:]')
EOF
hactoolnet --listtitles --disablekeywarns -t xci --verify "$3" | sed 's///g' > hactoolnet_log.txt 
