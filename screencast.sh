#!/bin/bash



if [ -z "$(ps -e | grep ffmpeg)" ]; then
	ffmpeg -f x11grab -s 1366x768 -i $DISPLAY /home/$(whoami)/Videos/Screencast-$(date +%d%m%Y%T).mp4 &
else
	kill -s SIGQUIT $(ps -e | grep ffmpeg | awk {'print $1'})
fi

