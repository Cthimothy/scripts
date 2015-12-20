#!/bin/bash
# coverart.sh
clear

default_cover="/path/to/defaultcover.png"

#musicdir=`cat /etc/mpd.conf | grep -v "#" | grep music_directory`
musicdir="/media/music/albums/"
musicdir=${musicdir:16}
musicdir=${musicdir%/$}

#mfile=`mpc current -f %file%`
mfile=${mfile%/*}
mfile=${mfile%/$}

fulldir="$musicdir/$mfile"
cd "$fulldir"

mfile=`mocp --format "%file"`
[ -n "$mfile" ] && fulldir=`dirname "$mfile"`


[ -n "$fulldir" ] && covers=`ls "$fulldir" | grep "\.jpg\|\.png\|\.gif"`
if [ -z "$covers" ]; then
	covers="$default_cover"
else
	#trycovers=`echo "$covers" | grep -i "_cover\|front\|folder\|front\|albumart" | head -n 1`
	trycovers=`echo "$covers" | grep -i "_cover\|front\|folder\|front" | head -n 1`
	if [ -z "$trycovers" ]; then
		trycovers=`echo "$covers" | head -n 1`
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

#cd "$(echo "$fulldir")"
feh "$covers"
