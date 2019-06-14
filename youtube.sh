#!/bin/bash

rootdir="$(dirname "$0")"
cd "$rootdir"
IFS=$'\n'

if [ ! -z "$1" ]; then

	cd "$rootdir"
	for channel in $(cat channels); do
		name="$(echo "$channel" | awk {'print $1'})"
		link="$(echo "$channel" | awk {'print $2'})"
		num=$(youtube-dl --flat-playlist "$link" | grep -Po '\d+$' | tail -1)
		case "$1" in
		"-n")
			if [ ! -d "$name" ]; then
				mkdir "$name"
				echo "0" > "$name"/videoscount
			fi
			if [ $num -ne $(cat "$name"/videoscount) ]; then
				notify-send -t 5000 "New videos" "New videos from $name"
			fi
			;;
		"-u")
			cd "$name"
			youtube-dl --dateafter now-1week --download-archive archive "$link" && notify-send "Finished" "Downloaded videos from $name" && echo $num > "$name"/videoscount
			cd ..
			;;
		"-d")
			cd "$name"
			&& rm *.mkv rm *.webm rm *.mp4
			cd ..
			;;
		esac
	done

fi
