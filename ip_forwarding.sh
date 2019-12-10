#!/bin/sh

# Turn internet connection on/off for the Access Point
# Usage: <script> <option>

case "$1" in
  "-e") echo 1 > /proc/sys/net/ipv4/ip_forward
  	;;
  "-d") echo 0 > /proc/sys/net/ipv4/ip_forward
esac
