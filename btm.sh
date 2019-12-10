#!/bin/sh

user="$USER"

media=$(sudo fdisk -l | grep "Disk /dev" | dmenu -l 5 -i -p "Choose media:" | awk '{gsub(":","");print $2}')

exit_err() {
		echo "$1"
		exit 2
}

[ "$media" = "" ] && exit_err "No media selected!"

partition=$(sudo fdisk -l | grep "$media" | tail -n+2 | dmenu -l 5 -i -p "Choose partition:" | awk '{print $1}')

if [ "$partition" = "" ]; then
	echo "Error! No partition selected! Exiting..."
	exit 2
fi
#echo "$partition"
sudo umount "$partition" 2>/dev/null
while [ $? -eq 1 ]; do
	sudo umount "$partition" 2>/dev/null
done

if [ ! -d /mnt/backup ]; then
	sudo mkdir /mnt/backup
fi


if sudo mount "$partition" /mnt/backup 
then
	sudo mkdir /mnt/backup/Backup 2>/dev/null
	sudo rsync -L --size-only --progress -hrv /home/"$user"/Documents /mnt/backup/Backup/
	sudo find /home/"$user" -maxdepth 1 -iname '.*' -exec rsync --size-only --progress -hrv {} /mnt/backup/Backup/ \;
	sudo find /home/"$user" -maxdepth 1 -iname '.*' -execdir rsync --size-only --progress -hrv {} /mnt/backup/Backup/ \;
	sudo rsync -l --size-only --progress -hrv /etc /mnt/backup/Backup/ 2>/dev/null
	sudo dpkg --get-selections | sudo tee /mnt/backup/Backup/software_list
fi

echo "Unmounting media..."
until sudo umount "$partition"
do
	sleep 1
done
