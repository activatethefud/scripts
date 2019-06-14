#!/bin/bash
# This script makes a synchronized copy of your system user's home directory of the files listed in .backup_list

# Set the internal file separator to newline
IFS=$'\n'

# Helper function to remove lines from .backup_list that refer to deleted files
remove_nonexistant_files() {
	for file in $(sed '' "$1"); do
		[ ! -e "$file" ] &&
		sed -i "/$file/d" "$1"
	done
}


# Work from the user's directory
cd "$HOME"

# Basic information
server_user="nikola"
server_address="marcus" # IP here or /etc/hosts alias
server_backup_dir="/home/nikola/Backup/$(uname -n)/"

# Create .backup_list file
[ ! -f ./.backup_list ] && touch ./.backup_list

remove_nonexistant_files ./.backup_list

# Create the backup directory on the remote site
ssh "$server_user"@"$server_address" "[ -d $server_backup_dir ] || mkdir $server_backup_dir"

# --recursive \ Recursively sync (Needed for directories)
# --modify-window=1 \ Allow for the local and remote files to differ up to 1 second
# --copy-links \ Preserve symlinks
# --delete \ Delete files on remote not present locally (The sync feature)

rsync \
--recursive \
--modify-window=1 \
--copy-links \
--del \
-v \
$(sed '' .backup_list) \
"$server_user"@"$server_address":"$server_backup_dir" &&

# Finish
notify-send -t 0 "Backup @ $(date +%T)" "Backed up successfully." ||
notify-send -t 0 "Backup @ $(date +%T)" "Error during backup."
