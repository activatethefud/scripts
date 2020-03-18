#!/bin/sh

exit_err() {
		echo "$1"
		exit 1
}

([ -n "$1" ] && [ -n "$2" ]) || exit_err "Usage: <script> <src> <dest> [<backup_dir>]"

# Send a desktop notification
export DISPLAY=:0
notify-send -t 10000 "$(date)" "Backing up $1"

echo "###### Backing up "$1" at "$(date)" ######"

if [ -z "$3" ]; then
		#rsync --progress --modify-window=1 -rv --delete "$1" "$2"
		rsync --progress -av --delete --modify-window=1 "$1" "$2"
else
		rsync --progress -av --delete --modify-window=1 --backup-dir="$3" "$1" "$2"
fi

notify-send -t 10000 "$(date)" "Finished backing up $1"
echo "###### Finished backing up ######"
