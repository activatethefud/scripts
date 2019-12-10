#!/bin/bash

# Randomize your MAC address before doing anything fishy d:^)
# Usage <script> <interface>

INTERFACE="$1"

ifconfig "$INTERFACE" down
macchanger -r "$INTERFACE"
ifconfig "$INTERFACE" up
