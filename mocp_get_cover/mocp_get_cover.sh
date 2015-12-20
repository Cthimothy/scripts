ARTIST=$(mocp -i | grep ^Artist | cut -d " " -f2-)
ALBUM=$(mocp -i | grep ^Album | cut -d " " -f2-)
glry cover -a $ARTIST -b $ALBUM
COVER=$(find . -name \*"$ALBUM"\* -exec mv {} ./front.jpg \;)
