#!/bin/sh

# Scan for Access Points and dump to file
# Usage <script> <interface>

if [ -z "$1" ]; then
	printf "Bad usage.\\nUsage: <script> <interface>\\n"
	exit 1
fi

# Use a temporary file, and dump the output to it
INTERFACE="$1"
TMP_FILE="$(mktemp)"

airodump-ng -w "$TMP_FILE" --output-format csv "$INTERFACE" 1>/dev/null 2>/dev/null &
sleep 7
killall airodump-ng

suffix="-01.csv"
TMP_FILE="$TMP_FILE$suffix"

echo "$TMP_FILE"
