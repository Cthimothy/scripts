#!/bin/bash

## TODO check for existence of mp3 tags

default_cover=; musicdir=; mfile=; fulldir=; covers=; trycovers=
foo=; slash=; front=; mocp_album_path=; artist=; album=; glurk=; cover_file_name=
clear

default_cover="/path/to/defaultcover.png"
musicdir="/media/music/albums/"
musicdir=${musicdir:16}
musicdir=${musicdir%/$}

mfile=${mfile%/*}
mfile=${mfile%/$}
fulldir="$musicdir/$mfile"

mfile=$(mocp --format "%file")
if [ -n "$mfile" ]; then
    fulldir=$(dirname "$mfile")
fi
if [ -n "$fulldir" ]; then
    covers=$(find "$fulldir" \*.jpg -o \*.png -o \*.gif -print)
fi    
if [ -z "$covers" ]; then
    covers="$default_cover"
else
    #trycovers=`echo "$covers" | grep -i "_cover\|front\|folder\|front\|albumart" | head -n 1`
    trycovers=$(echo "$covers" | grep -i "_cover\|front\|folder\|front" | head -n 1)
    if [ -z "$trycovers" ]; then
        trycovers=$(echo "$covers" | head -n 1)
        if [ -z "$trycovers" ]; then
            trycovers="$default_cover"
        else
            trycovers="$fulldir/$trycovers"
        fi
    else
        trycovers="$fulldir/$trycovers"
    fi
    covers="$trycovers"
fi

if [ ! -f "$covers" ]; then
    echo "[+]Album art not found..."
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
    clear
    feh "$mocp_album_path$slash$front"
else
    feh "$covers"
fi
