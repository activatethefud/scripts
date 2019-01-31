#!/bin/bash

user=$(echo "$USER")

media=$(sudo fdisk -l | grep "Disk /dev" | dmenu -l 5 -i -p "Choose media:" | awk {'gsub(":","");print $2'})


if [ "$media" = "" ]; then
	echo "Error! No media selected! Exiting..."
	exit 2
fi

partition=$(sudo fdisk -l | grep "$media" | tail -n+2 | dmenu -l 5 -i -p "Choose partition:" | awk {'print $1'})

if [ "$partition" = "" ]; then
	echo "Error! No partition selected! Exiting..."
	exit 2
fi
#echo "$partition"
sudo umount "$partition" 2>/dev/null
while [ $? -eq 1 ]; do
	sudo umount "$parition" 2>/dev/null
done

sudo mount "$partition" /mnt/backup


if [ $? -eq 0 ]; then
	sudo mkdir /mnt/backup/Backup 2>/dev/null
	sudo rsync -L --size-only --progress -hrv /home/"$user"/Documents /mnt/backup/Backup/
	sudo find /home/"$user" -maxdepth 1 -iname '.*' -exec rsync --size-only --progress -hrv {} /mnt/backup/Backup/ \;
	sudo find /home/"$user" -maxdepth 1 -iname '.*' -execdir rsync --size-only --progress -hrv {} /mnt/backup/Backup/ \;
	sudo rsync -l --size-only --progress -hrv /etc /mnt/backup/Backup/ 2>/dev/null
	sudo dpkg --get-selections > /mnt/backup/Backup/software_list
fi

echo "Unmounting media..."
sudo umount "$partition"

while [ $? -ne 0 ]; do
	sleep 1
	sudo umount "$partition"
done
