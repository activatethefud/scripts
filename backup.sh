#!/bin/bash
# This script makes a synchronized copy of your system user's home directory, minus the files in .backup_ignore.
# The script is meant to be run from anacrontab, in which case it runs as root.
# The root user needs to have passwordless login to the server, use ssh-copy-id for this.

# Set the internal file separator to newline
IFS=$'\n'

# Basic information (Edit this for your user)
user_to_backup="nikola"
server_user="nikola"
server_address="marcus" # IP here or /etc/hosts alias
server_backup_dir="/home/nikola/Backup/$(uname -n)/"

# Change the HOME environment variable to fit the user to backup
export HOME="/home/$user_to_backup"

# Create .backup_ignore file
[ ! -f $HOME/.backup_ignore ] && su "$user_to_backup" -c "touch $HOME/.backup_ignore"

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
$(ls -a $HOME | diff --left-column - $HOME/.backup_ignore | grep '^<' | sed "s|<\s|$HOME/|" ) \
"$server_user"@"$server_address":"$server_backup_dir" &&

# Finish
su "$user_to_backup" -c 'notify-send "Backup:" "Finished backing up."' 2>/dev/null
