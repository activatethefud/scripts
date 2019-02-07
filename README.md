This repo is a collection of random scripts. Some are useful and will be documented.

### drive.sh

![drive.sh in action](https://i.imgur.com/7vvWdOl.png)

This script uses ```dmenu``` and ![gdrive](https://github.com/prasmussen/gdrive). After ![gdrive](https://github.com/prasmussen/gdrive) is configured, run ```./drive.sh``` and you can browse your drive locally to fetch the file you need. Currently only supports fetching files and not whole directories. A recursive fetch will be added later.

### backup\_to\_media.sh

This script also uses ```dmenu```. It backs up all files from Documents and config files from the ~ home directory. Use this to make backups to external drives (e.g. Removable USB drive). Very useful for when you need a quick backup on-the-go.

Just run ```./backup_to_media.sh``` and select your drive and partition.

### battery\_notify

Simple script for displaying warnings for low battery. It should be started on boot.

#### Dependencies

* libnotify
* acpi


