#!/usr/bin/env bash
clear
foo=; slash=; front=; mocp_album_path=; artist=; album=; glurk=; cover_file_name=

slash="/"
front="front.jpg"
#foo=$(mocp -i|grep 'File:'|cut -d '/' -f2-6)
test_dir=$(mocp -i|grep 'File:'|cut -d '/' -f6)
if [ "$test_dir" == "___0SDM-Demos" ] ; then
    foo=$(mocp -i|grep 'File:'|cut -d '/' -f2-7)
else
    foo=$(mocp -i|grep 'File:'|cut -d '/' -f2-6)
fi
mocp_album_path="$slash$foo$slash"

echo "[+] Getting album information..."
artist=$(mocp -i | grep ^Artist | cut -d " " -f2-)
album=$(mocp -i | grep ^Album | cut -d " " -f2-)

echo "[+] Downloading cover art for $album..."
glurk=$(glyrc cover -a "$artist" -b "$album"  2>&1 | grep WRITE  | cut -d "/" -f2) # yuk
cover_file_name="${glurk%?}"
mv "$cover_file_name" "$mocp_album_path$slash$front"
echo "[+] Done."
