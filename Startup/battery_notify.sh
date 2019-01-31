#!/bin/bash


while true; do

	battery_level=`acpi -b | awk {'gsub("%|,",""); print $4'}`
	battery_state=`acpi -b | awk {'gsub(",",""); print $3'}`
	export DISPLAY=:0
	if [ $battery_level -ge 100 ] && [ "$battery_state" = "Full" ]; then
		notify-send "Battery full" "Unplug the charger."
		sleep 5m
		continue
	fi
	if [ $battery_level -le 30 ] && [ "$battery_state" = "Discharging" ]
	then
		if [ $battery_level -ge 10 ]; then
		notify-send "Battery low" " Battery level is ${battery_level}%!"
		sleep 5m

		else 
			if [ $battery_level -le 10 ]; then
		notify-send --urgency=critical "Battery critical" "Battery level is ${battery_level}%!"
			sleep 2m

			fi
		fi
	else
		sleep 10m
	fi
	
done
