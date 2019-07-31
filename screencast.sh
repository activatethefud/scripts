#!/bin/sh

# Check for a running screen recording, and quit it
# Otherwise start a screen recording with the current
# screen resolution

if ! pgrep ffmpeg; then
	ffmpeg -f x11grab -r 23 -s "$(xrandr | grep -P '\*' | awk '{print $1}' | grep -Po '\d*x\d*')" -i "$DISPLAY" /home/"$(whoami)"/Videos/Screencast-"$(date +%d%m%Y%T)".mp4 2>/home/"$(whoami)"/Logs/ffmpeg.log & 
else
	pkill --signal SIGQUIT ffmpeg screenkey overheat
fi
