#!/bin/bash

external="$(xrandr | grep -w connected | grep -v primary | awk {'print $1'})"
primary="$(xrandr | grep -w primary | awk {'print $1'})"

xrandr --output "$primary" --off
xrandr --output "$external" --primary --auto

