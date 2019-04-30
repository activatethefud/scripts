#!/bin/bash
# This script makes a synchronized copy of your system user's home directory of the files listed in .backup_list
# The script is meant to be run from anacrontab, in which case it runs as root.
# The root user needs to have passwordless login to the server, use ssh-copy-id for this.

# Set the internal file separator to newline
IFS=$'\n'

# Work from the user's directory
cd "$HOME"

# Basic information
server_user="nikola"
server_address="marcus" # IP here or /etc/hosts alias
server_backup_dir="/home/nikola/Backup/$(uname -n)/"

# Create .backup_list file
[ ! -f ./.backup_list ] && touch ./.backup_list

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
--delete \
$(sed '' .backup_list)
"$server_user"@"$server_address":"$server_backup_dir" &&

# Finish
su "$user_to_backup" -c 'notify-send "Backup:" "Finished backing up."' 2>/dev/null
