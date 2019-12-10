#!/bin/sh

# Use this script to prepare your wireless
# interface for monitoring. Disable services, or enable them.
# Usage <script> <options> <interface> Options: -e(enable), -d(disable)

case "$1" in
  "-e")	ifconfig "$2" down
	iwconfig "$2" mode monitor
	ifconfig "$2" up
  	;;
  "-d") ifconfig "$2" down
	iwconfig "$2" mode managed
	ifconfig "$2" up
esac
