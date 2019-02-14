#!/bin/bash
# Get date when anacron scripts started lastly


get_data() {
	for i in /var/spool/anacron/*; do
		echo ""$(basename "$i")" last ran on $(date --date="$(cat "$i")" +%d\ %b\ %Y)."
	done
}

get_data
