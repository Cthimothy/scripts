g=$1
dirs=$(find . -maxdepth 1 -type d -printf '%P\n') # read directories in to var
for d in $dirs; do
    echo "$d\n"
    genre=$(id3v2 -l "$d/*" |
        sed -n '/^TCON/s/^.*: //p' |
        sed 's/ (.*//' |
        uniq |
        tr '[:upper:]' '[:lower:]')
    if $genre=""; then
        echo $d >> $1.txt
    fi
    shift
done
