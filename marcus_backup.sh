#!/bin/bash


rsync --modify-window=1 --progress -L -rhv /home/nikola/Documents nikola@marcus:/home/nikola/Backup/

find /home/nikola -maxdepth 1 -name "\.*" -exec rsync --modify-window=1 --progress -L -rhv {} nikola@marcus:/home/nikola/Backup/Dotfiles/ \;
