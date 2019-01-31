#!/bin/bash

# Execute university notifications

find /home/$(whoami)/Documents/Scripts/matf_notifications2 -iname "*.sh" -exec sh {} \;
