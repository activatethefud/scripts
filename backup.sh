#!/bin/sh
# This script makes a synchronized copy of your system user's home directory of the files listed in .backup_list

# Set the internal file separator to newline
IFS="$(printf '%b_' '\n')"

# Helper function to remove lines from .backup_list that refer to deleted files
remove_nonexistant_files() {
	TMP=$(mktemp)
	while read -r file; do
		[ -e "$file" ] &&
		echo "$file" >> "$TMP"
	done < "$1"

	cat "$TMP" > "$1"
}


# Work from the user's directory
cd "$HOME" || (echo "Directory not known!" && exit)

# Get the list of all installed packages (distro specific)
distro="$(neofetch func_name distro)"
(echo "$distro" | grep -qi void) && xbps-query -l | grep ^ii | awk {'print $2'} > ./.packages_list

# Basic information
server_user="pi"
server_address="marcus" # IP here or /etc/hosts alias
server_backup_dir="/home/pi/Backup/$(uname -n)/"

# Create .backup_list file
[ ! -f ./.backup_list ] && touch ./.backup_list

remove_nonexistant_files ./.backup_list

# Create the backup directory on the remote site
ssh "$server_user"@"$server_address" "[ -d $server_backup_dir ] || mkdir -p $server_backup_dir"

# --recursive \ Recursively sync (Needed for directories)
# --modify-window=1 \ Allow for the local and remote files to differ up to 1 second
# --links \ Preserve symlinks
# --delete \ Delete files on remote not present locally (The sync feature)

rsync \
--recursive \
--modify-window=1 \
--links \
--delete \
--ignore-errors \
-v \
$(sed '' .backup_list) \
"$server_user"@"$server_address":"$server_backup_dir" &&

# Finish
(export DISPLAY=:0.0 &&
notify-send -t 0 "Backup @ $(date +%T)" "Backed up successfully.") ||
notify-send -t 0 "Backup @ $(date +%T)" "Error during backup."
