#!/bin/bash



if [ -z "$(ps -e | grep ffmpeg)" ]; then
	ffmpeg -f x11grab -r 25 -s 1366x768 -i $DISPLAY /home/$(whoami)/Videos/Screencast-$(date +%d%m%Y%T).mp4 & 2>/home/$(whoami)/Logs/ffmpeg.log
else
	kill -s SIGQUIT $(ps -e | grep ffmpeg | awk {'print $1'})
fi

