#!/bin/bash


printbar(){
# Get variables
	battemp="$(acpi -t | awk {'print $4'})" 2>/dev/null
	homespace="$(df -h | grep -w /home | awk {'print $4'})" 2>/dev/null
	rootspace="$(df -h | grep -w / | awk {'print $4'})" 2>/dev/null
	ethip="$(ip address show | grep 192 | head -1 | awk {'print $2'})" 2>/dev/null
	downloading="$(transmission-remote --auth transmission:transmission -l | grep Downloading | wc -l)" 2>/dev/null
	finished="$(transmission-remote --auth transmission:transmission -l | grep Idle | grep Done | wc -l)" 2>/dev/null
	idle="$(transmission-remote --auth transmission:transmission -l | grep Idle | grep -v Done | wc -l)" 2>/dev/null
	batlvl="$(acpi -b | grep -Po "\d+%")"
	batstate="$(acpi -b | awk {'print $3'} | sed 's/,//g')"
	ramused="$(free -h | grep Mem | awk {'print $3'})"
	
	
# Print bar
	echo -e "RAM:$ramused | D:$downloading I:$idle F:$finished | $battemp/C BAT:$batlvl | $batstate | $ethip | $rootspace+$homespace | "$(date -R)" \c"
	
}

printbar

# Loop it
while true; do
	printbar
	sleep 1
done
