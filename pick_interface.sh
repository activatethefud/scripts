#!/bin/sh

# Pick an internet interface for later use
# Usage <script>

INTERFACE="$(ifconfig | grep -o -P '\w+:\s' | sed 's/:\ *//g' | dmenu -i -p 'Select interface:')"
echo "$INTERFACE"
