#!/usr/bin/env bash

## Check name of app before rename performing xdotool search
## TODO progamtically get application names (config file)

wid=

wid=$(xdotool search --name "Gaunts Gamers")
if [ $? == 0 ]; then
    xdotool set_window --name "slack" $wid
    wid=
fi

wid=$(xdotool search --name "Mozilla Thunderbird")
if [ $? == 0 ]; then
    xdotool set_window --name "mail" $wid
    wid=
fi

wid=$(xdotool search --name "Soulseek")
if [ $? == 0 ]; then
     xdotool set_window --name "slsk" $wid
    wid=
fi

wid=$(xdotool search --name "Transmission")
if [ $? == 0 ]; then
    xdotool set_window --name "torrent" $wid
    wid=
fi
