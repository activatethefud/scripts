#!/bin/sh

ERR_NO_DIR=33
cd "$(dirname "$0")" || exit $ERR_NO_DIR

while true; do
	url="$(xsel -b -o)"
	if [ ! -f archive ]; then
		touch archive
	fi

	if [ -n "$url" ] && ! grep -q "$url" archive
		then
		if echo "$url" | grep -q youtube
			then
			youtube-dl -f 22 "$url" || youtube-dl "$url" &
		else
			wget -U mozilla -t 2 -k -p -e robots=off "$url" &&
			echo "$url" >> archive
		fi
	fi

	sleep 2
done
