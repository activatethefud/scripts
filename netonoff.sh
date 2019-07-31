#!/bin/sh

timeh="$(date +%H)"

while true; do
	if [ "$timeh" -ge 9 ] && [ "$timeh" -le 10 ] || [ "$timeh" -ge 23 ] && [ "$timeh" -le 24 ]; then
		if ! ping -c 3 google.com; then
			nmcli radio wifi on
			nmcli connection up 3639be
		fi
	else
		if ping -c 3 google.com; then
			nmcli radio wifi off
		fi
	fi
	sleep 1m
	
done
