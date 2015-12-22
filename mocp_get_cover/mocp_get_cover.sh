foo=; slash=; front=; mocp_album_path=; artist=; album=; glurk=; cover_file_name=
foo=$(mocp -i|grep 'file:'|cut -d '/' -f2-6)
slash='/'
front="front.jpg"
mocp_album_path=$slash$foo
artist=$(mocp -i | grep ^artist | cut -d " " -f2-)
album=$(mocp -i | grep ^album | cut -d " " -f2-)
echo $mocp_album_path; echo $slash; echo $cover_file_name; echo $mocp_album_path; echo $slash; echo $front
glurk=$(/usr/bin/glyrc cover -a $artist -b $album  2>&1 | grep write  | cut -d "/" -f2) # yuk
cover_file_name="${glurk%?}"
# echo $mocp_album_path; echo $slash; echo $cover_file_name; echo $mocp_album_path; echo $slash; echo $front
#find "$mocp_album_path/$artist" -name \*"$artist"\*  -exec mv {} "$mocp_album_path/front.jpg" \;
#mv $mocp_album_path$slash$cover_file_name $mocp_album_path$slash$front
