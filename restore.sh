#!/bin/sh


software=1
clear
while [ $software != 0 ]; do
	printf "Enter software for settings restore:"
	read -r software
	find /home/nikola/Documents/etc -maxdepth 1 -iname "$software*" -exec sudo cp -r {} /etc/ \;
	
done
