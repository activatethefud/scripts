#!/bin/bash

while true; do
	ping -W 2 -c 2 google.com
	if [ $? -ne 0 ]; then
		nmcli radio wifi off
		nmcli radio wifi on
		nmcli device wifi | grep 3639be
		if [ $? -eq 0 ]; then
			nmcli connection up 3639be
		else
			nmcli device wifi | grep D676
			if [ $? -eq 0 ]; then
				nmcli connection up D67688
			fi
		fi
	fi
	sleep 6
done
