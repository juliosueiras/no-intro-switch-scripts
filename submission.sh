FULLXCI=$(ls "$1"*\[KA*)
INITIAL=$(ls "$1"*\(Initial*)
CARDID=$(ls "$1"*\(Card*)
./check.sh "$1" "$2" "$FULLXCI" "$INITIAL" "$CARDID" "$3" > info.txt
cat <<EOF > "./nointro_submissions/$3.txt"
[size=150]Game & Cart Info:[/size]
Game Name: $1
Region: $2
Card Code: LA-H-$3-$2
Language check: no
Dump Tool: nxdt_rw_poc v2.0.0 (rewrite-3c519cd-dirty)

[size=150]Hash Info for Card:[/size]
[code]
$(cat info.txt)
[/code]

[size=150]Initial Area Base64 Dump:[/size]
[code]
$(cat "$INITIAL" | base64 -w 0)
[/code] 

[size=150]Hactoolnet Info for Full XCI:[/size]
[code]
$(cat hactoolnet_log.txt)
[/code] 

[size=150]Hactool Info for Default XCI:[/size]
[code]
$(cat hactool_log.txt)
[/code]

[size=150]NX Game Info for Default XCI:[/size]
[code]
$(cat nx_game_info.txt)
[/code]

[size=200]Extra Info:[/size]
Barcode: $(./scan.sh "<your image directory>/$3/back.png")
Cart Back Serial Code: FILLIN
Box Serials: FILLIN

[size=200]Media info:[/size]
[size=150]Front: [/size] [img]<your image url>/$3/front.png[/img]
[size=150]Back: [/size] [img]<your image url>/$3/back.png[/img]
[size=150]Insert: [/size] [img]<your image url>/$3/insert.png[/img]
[size=150]Inside: [/size] [img]<your image url>/$3/inside.png[/img]
[size=150]Cart: [/size] [img]<your image url>/$3/cart.png[/img]
[size=150]Cart Back: [/size] [img]<your image url>/$3/cart-back.png[/img]
EOF

sed -i 's/^\xEF\xBB\xBF//' "./nointro_submissions/$3.txt"

rm hactool_log.txt
rm hactoolnet_log.txt
rm info.txt
rm nx_game_info.txt
