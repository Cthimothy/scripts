#!/usr/bin/env python

import os
import subprocess

default_album_path = '/media/timw/music/'
# default_cover = '/path/to/default/cover.jpg'

def shellquote(s):
    return "'" + s.replace("'", "'\\''") + "'"

mocp_output = subprocess.check_output('mocp --info', shell=True)

for line in str.splitlines(mocp_output):
    if 'File:' in line:
        d = line.split('/')
        dir = list(d[i] for i in [0, 1, 2, 3, 4])
        music_dir = default_album_path + dir[4] + '/'
        # print 'Debug : {}'.format(dir[4])

for f in os.listdir(music_dir):
    if "front.jpg" in f:
        cover_image = f
    elif "_Cover" in f:
        cover_image = f
    elif "cover.jpg" in f:
        cover_image = f
    #else:
    #    cover_image = default_album_path
 
c = shellquote(music_dir + cover_image)
# print 'Debug : {}'.format(c)
final_output =  "feh" + " " + c
subprocess.call(final_output, shell=True)

