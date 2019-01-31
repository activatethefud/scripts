#!/bin/bash

find ~ -maxdepth 1 -iname '\.*rc' -exec cp {} /home/nikola/Documents/dotfiles \;
cp -r /home/nikola/.config/i3 /home/nikola/Documents/dotfiles

cd /home/nikola/Documents/dotfiles

git add .
git commit -m "Auto-backup at `date`" 
git push origin master

