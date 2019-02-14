#!/bin/bash

copy_dotfiles() {
	if [ ! -d /home/nikola/Dotfiles ]; then
		mkdir /home/nikola/Dotfiles
	fi
	find /home/nikola -name "\.*" -exec cp -r {} /home/nikola/Dotfiles/ \; &>/dev/null
}

gen_targz() {
	cd /home/nikola
	tar -c /home/nikola/Dotfiles -f /home/nikola/HP15dotfiles.tar
	gzip --rsyncable /home/nikola/HP15dotfiles.tar
}

backup_targz() {
	rsync --modify-window=1 /home/nikola/HP15dotfiles.tar.gz nikola@marcus:/home/nikola/Backups/
}

finish() {
	rm -r /home/nikola/Dotfiles
	rm /home/nikola/HP15*
}

copy_dotfiles && 
gen_targz && 
backup_targz;
finish 

