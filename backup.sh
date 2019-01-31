#!/bin/bash


rsync `find /home/$(whoami)/Documents/Scripts -iname '*\.sh'` /home/$(whoami)/Documents/Backup\ Scripts/
dpkg --get-selections | grep -w install | awk {'print $1'} > /home/$(whoami)/Documents/software_list
rsync -L --modify-window=1 --progress -hrv /home/$(whoami)/Documents koditv@178.148.99.220:/home/koditv/Backup/$(whoami)/
rsync -L --modify-window=1 --progress -hrv /home/$(whoami)/Books koditv@178.148.99.220:/home/koditv/Backup/$(whoami)/
rsync -L --modify-window=1 --progress -hrv /home/$(whoami)/Pictures koditv@178.148.99.220:/home/koditv/Backup/$(whoami)/
rsync -L --modify-window=1 --progress -hrv /home/$(whoami)/Music/ koditv@178.148.99.220:/home/koditv/Music/
rsync -L --modify-window=1 --progress -hrv `find /home/$(whoami) -maxdepth 1 -iname '.*'` koditv@178.148.99.220:/home/koditv/Backup/$(whoami)
rsync -L --modify-window=1 --progress -hrv --links /home/$(whoami)/Documents/etc/ koditv@178.148.99.220:/home/koditv/Backup/$(whoami)/etc/ 
