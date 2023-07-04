#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bars on each monitor, rendering the same bar on each one
if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d " " -f 1); do
		MONITOR=$m polybar --reload main &
	done
else
	polybar --reload main &
fi

