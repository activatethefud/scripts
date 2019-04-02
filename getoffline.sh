#!/bin/bash

cd "$(dirname "$0")"

while true; do
	url="$(xsel -b -o)"
	if [ ! -f archive ]; then
		touch archive
	fi

	if [ ! -z "$url" ] && [ -z "$(grep "$url" archive)" ]; then
		if [ ! -z "$(echo "$url" | grep youtube)" ]; then
			youtube-dl -f 22 "$url" || youtube-dl "$url" &
		else
			wget -U mozilla -t 2 -k -p -e robots=off "$url" &&
			echo "$url" >> archive
		fi
	fi

	sleep 2
done
