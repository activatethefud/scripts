#!/bin/bash

echo -e "Enter the number of minutes:\c"
read min

echo -e "Enter message:\c"
read line

clear
while [ $min -ne 0 ]; do
	echo "$line"
	echo "Minutes left:$min"
	sleep 1m
	let min=min-1
	clear
done

notify-send -t 10000 "$line"
mpv /home/$(whoami)/Documents/alert.mp3 &
