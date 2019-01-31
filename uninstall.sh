#!/bin/bash

# for i in $(ls /usr/bin); do du -h $i; done | sort -r -n -k1 | grep M | less


selection=$(for i in $(ls /usr/bin); do du -h /usr/bin/"$i"; done | awk {'gsub("/usr/bin/","");print'} | sort -r -n -k1 | grep M | dmenu -p "Select software:" -i -l 6)

selection=$(echo "$selection" | awk {'print $2'})

sudo apt-get autoremove "$selection"




