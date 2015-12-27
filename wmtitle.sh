xdotool search --name "general" > /dev/null
if [ $? == 0 ]; then
    xdotool set_window --name "slack"
fi
xdotool search --name "Mozilla Thunderbird" > /dev/null
if [ $? == 0 ]; then
    xdotool set_window --name "mail"
fi
xdotool search --name "Soulseek" > /dev/null
if [ $? == 0 ]; then
     set_window --name "slsk"
fi
xdotool search --name "Transmission" > /dev/null
if [ $? == 0 ]; then
    set_window --name "torrent"
fi
