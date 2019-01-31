#!/bin/bash

timeh=`date +%H`

while true; do
	if ([ $timeh -ge 9 ] && [ $timeh -le 10 ]) || ([ $timeh -ge 23 ] && [ $timeh -le 24 ]); then
		ping -c 3 google.com > /dev/null
		if [ $? -ne 0 ]; then
			nmcli radio wifi on
			nmcli connection up 3639be
		fi
	else
		ping -c 3 google.com > /dev/null
		if [ $? -eq 0 ]; then
			nmcli radio wifi off
		fi
	fi
	sleep 1m
	
done
