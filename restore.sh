#!/bin/bash


software=1
clear
while [ $software != 0 ]; do
	echo -e "Enter software for settings restore:\c"
	read software
	find /home/nikola/Documents/etc -maxdepth 1 -iname "$software*" -exec sudo cp -r {} /etc/ \;
	
done
