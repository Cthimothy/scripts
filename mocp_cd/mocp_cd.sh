echo; echo "'Pushd'-ing current directory...'popd' to return."; echo
pushd . > /dev/null 2>&1
FOO=$(mocp -i|grep 'File:'|cut -d '/' -f2-6)
SLASH='/'
MOCP_ALBUM_PATH=$SLASH$FOO
cd "$MOCP_ALBUM_PATH"
