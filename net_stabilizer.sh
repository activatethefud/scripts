#!/bin/sh

while true; do
	if ! ping -W 2 -c 2 google.com; then
		nmcli radio wifi off
		nmcli radio wifi on
		if nmcli device wifi | grep -q 3639be; then
			nmcli connection up 3639be
		else
			if nmcli device wifi | grep -q D676; then
				nmcli connection up D67688
			fi
		fi
	fi
	sleep 6
done
