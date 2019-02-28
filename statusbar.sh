#!/bin/bash

while true; do
# Get variables
	battemp="$(acpi -t | awk {'print $4'})"
	homespace="$(df -h | grep -w /home | awk {'print $4'})"
	rootspace="$(df -h | grep -w / | awk {'print $4'})"
	ethip="$(ip address show | grep 192 | head -1 | awk {'print $2'})"
	downloading="$(transmission-remote --auth transmission:transmission -l | grep Downloading | wc -l)"
	finished="$(transmission-remote --auth transmission:transmission -l | grep Idle | grep Done | wc -l)"
	idle="$(transmission-remote --auth transmission:transmission -l | grep Idle | grep -v Done | wc -l)"
	
	
# Print bar
	echo -e "D:$downloading I:$idle F:$finished | $battemp/C | $ethip | $rootspace+$homespace | "$(date -R)" \c"
	sleep 1
	
done
