#!/bin/bash



if [ -z "$(ps -e | grep ffmpeg)" ]; then
	ffmpeg -f x11grab -r 23 -s "$(xrandr | grep "*" | awk {'print $1'} | grep -Po '\d*x\d*')" -i $DISPLAY /home/$(whoami)/Videos/Screencast-$(date +%d%m%Y%T).mp4 & 2>/home/$(whoami)/Logs/ffmpeg.log
else
	kill -s SIGQUIT $(ps -e | grep ffmpeg | awk {'print $1'})
	kill -s SIGQUIT $(ps -e | grep screenkey | awk {'print $1'})
	kill -9 $(ps -e | grep overheat | awk {'print $1'})
fi

