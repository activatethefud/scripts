#!/bin/bash

while true; do
	if [ "$(acpi -t | awk {'print $4'})" \> "84" ]; then
		notify-send -t 5000 "High temperature! Possible reasons:" "$(ps -eo comm,pcpu,pid | sort -nr -k2 | head -5)"
	fi
	sleep 5
done
