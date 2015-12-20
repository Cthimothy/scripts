pushd . > /dev/null 2>&1
foo=$(mocp -i|grep 'file:'|cut -d '/' -f2-6)
slash='/'
front="front.jpg"
mocp_album_path=$slash$foo
artist=$(mocp -i | grep ^artist | cut -d " " -f2-)
album=$(mocp -i | grep ^album | cut -d " " -f2-)
glurk=$(/usr/bin/glyrc cover -a $artist -b $album  2>&1 | grep write  | cut -d "/" -f2) # yuk
cover_file_name="${glurk%?}"
echo $mocp_album_path$slash$cover_file_name; echo $mocp_album_path$slash$front
#find "$mocp_album_path/$artist" -name \*"$artist"\*  -exec mv {} "$mocp_album_path/front.jpg" \;
#mv $mocp_album_path$slash$cover_file_name $mocp_album_path$slash$front
