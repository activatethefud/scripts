#!/bin/sh

# Increase the TX power of your interface
# Used in Fake wireless Access Point attacks
# Usage <script> <interface>

INTERFACE="$1"

ifconfig "$INTERFACE" down
iw reg set BZ # Set TX region to BZ (To increase db to 30)
iwconfig "$INTERFACE" txpower 30
ifconfig "$INTERFACE" up
