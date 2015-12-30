#!/bin/bash

## TODO check for existence of mp3 tags

mfile=; fulldir=; foo=; slash=; front=; mocp_album_path=; artist=; album=; glurk=; other_covers=
slash="/"
front="front.jpg"
clear

mfile=$(mocp --format "%file")
if [ -n "$mfile" ]; then
    fulldir=$(dirname "$mfile")
fi
mocp_album_art=$fulldir$slash$front
other_covers=$(find "$fulldir" -type f \( ! -iname front.jpg -iname \*.jpg -o -iname \*.gif -o -iname \*.png \))

if [ -f "$mocp_album_art" ]; then
    feh "$mocp_album_art"
    if [ -z "$other_covers" ]; then
        feh "$other_covers"
    fi
else
    echo "[+] Album art not found..."
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
    mocp_album_art="$mocp_album_path$front"
    clear
    feh "$mocp_album_art" "$other_covers"
    if [ -z "$other_covers" ]; then
        feh "$other_covers"
    fi
fi
