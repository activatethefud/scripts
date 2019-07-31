#!/bin/bash

ERR_NO_DIR=33
cd "$PWD" || exit $ERR_NO_DIR

for i in *; do
	echo "File $i in progress"
	term=$(echo "$i" | awk '{print $1 " " $2}')
	id=$(gdrive list -q "'1jnS1iH5lmGPFdUJkU92hp_h3f7tjuYZX' in parents and trashed = false" | grep "$term" | awk '{print $1}')
	time=$(gdrive list -q "'1jnS1iH5lmGPFdUJkU92hp_h3f7tjuYZX' in parents and trashed=false" | grep "$term" | grep -o "[0-9][0-9]:[0-9][0-9]:[0-9][0-9]")
	curtime=$(ls -l --time-style=+%H:%M:%S | grep $term | awk '{print $6}')
	timedif=$(python /home/nikola/Documents/Python/timediff.py "$time" "$curtime" 2>/dev/null)
	if [ "$timedif" -ge 7 ] || [ "$time" = '' ]; then
		if [ ! -z $id ]; then
			gdrive delete "$id"
			echo "File deleted for reupload..."
		fi
		if [ ! -d "$i" ]; then
			gdrive upload -p 1jnS1iH5lmGPFdUJkU92hp_h3f7tjuYZX "$i"
		else
			echo "$i is a directory. Skipping..."
		fi
		touch "$i"
	else
		echo "File is not new. Skipping..."
	fi
	
done
