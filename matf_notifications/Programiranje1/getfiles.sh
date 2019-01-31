#!/bin/bash

cd /home/nikola/Documents/Scripts/matf_notifications/Programiranje1

python3 scrapefiles.py > files

wget -e robots=off -U mozilla -nc -i files

for i in *.pdf; do
	ok=1
	for j in `cat archive`; do
		if [ "$i" = "$j" ]; then
			ok=0
			echo "File in acrhive. Skipping... "
			rm "$i"
		fi
	done
	if [ $ok -eq 1 ]; then
		sleep 5
		gdrive upload -p 1aqNyqzgTlY5HWQCNU23jz0NRs15XyNhP "$i"
		echo "Uploading file..."
		if [ $? -eq 0 ]; then
			echo "$i" >> archive
		fi
	fi
done
