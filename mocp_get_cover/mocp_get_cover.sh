
#!/usr/bin/env bash
foo=; slash=; front=; mocp_album_path=; artist=; album=; glurk=; cover_file_name=
clear
foo=$(mocp -i|grep 'File:'|cut -d '/' -f2-6)
slash="/"
front="front.jpg"
mocp_album_path="$slash$foo"
echo "[+] Getting album information..."
artist=$(mocp -i | grep ^Artist | cut -d " " -f2-)
album=$(mocp -i | grep ^Album | cut -d " " -f2-)
echo "[+] Downloading cover art for $album..."
glurk=$(glyrc cover -a "$artist" -b "$album"  2>&1 | grep WRITE  | cut -d "/" -f2) # yuk
cover_file_name="${glurk%?}"
mv "$cover_file_name" "$mocp_album_path$slash$front"
echo "[+] Done."
