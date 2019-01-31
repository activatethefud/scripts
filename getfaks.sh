#!/bin/bash

izabran=0
folder=1YRteTap-5DiDQSeAvGLljd3cweEWJuvl

while [ $izabran -ne 1 ]; do
	selection=$(gdrive list -q "'$folder' in parents and trashed=false" | tail -n+2 | dmenu -i -l 10)
	tip=$(echo "$selection" | grep -o "dir")
	id=$(echo "$selection" | awk {'print $1'})
	if [ "$tip" = "dir" ]; then
		folder=$(echo "$id")
		continue
		
	fi
	gdrive download "$id"
	izabran=1
done
