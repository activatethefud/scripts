#!/bin/bash

./packages_setup.sh
./i3gaps_setup.sh
./transmission_setup.sh


cat ./config/i3config >> ~/.config/i3/config
cat ./config/aliases >> ~/.bashrc

./restore.sh

