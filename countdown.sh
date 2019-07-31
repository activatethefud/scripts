#!/bin/sh

printf "Enter the number of minutes:"
read -r min

printf "Enter message:"
read -r line

clear
while [ "$min" -ne 0 ]; do
	echo "$line"
	echo "Minutes left:$min"
	sleep 1m
	min=$((min-1))
	clear
done

notify-send -t 0 "$(date)" "$line"
#mpv /home/nikola/Documents/alert.mp3 &
