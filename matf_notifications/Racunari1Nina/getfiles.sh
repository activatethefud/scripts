#!/bin/bash
#1_TObmk0DTJs2BBiPrQ59e0tMWqohS64m

cd /home/nikola/Documents/Scripts/matf_notifications/Racunari1Nina

python3 scrape_files.py > files

wget -e robots=off -U mozilla -nc -i files

for i in *.pdf; do
	ok=1
	for j in `cat archive`; do
		if [ "$i" = "$j" ]; then
			ok=0
			echo "File in archive. Skipping..."
			rm "$i"
		fi
	done
	uploaded=0
	while [ $uploaded -ne 1 ] && [ $ok -eq 1 ]; do
		sleep 5
		echo "Uploading file..."
		gdrive upload -p 1_TObmk0DTJs2BBiPrQ59e0tMWqohS64m "$i"
		if [ $? -eq 0 ]; then
			echo "$i" >> archive
			rm "$i"
			uploaded=1
		fi
	done

done
