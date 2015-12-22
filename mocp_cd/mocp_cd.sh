echo; echo "'Pushd'-ing current directory...'popd' to return."; echo
pushd . > /dev/null 2>&1
foo=$(mocp -i|grep 'File:'|cut -d '/' -f2-6)
slash='/'
mocp_album_path=$slash$foo
cd "$mocp_album_path"
