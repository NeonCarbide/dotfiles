#!/bin/bash

DEV="ETPS/2 Elantech Touchpad"
STATE=$(xinput list-props "$DEV" | grep "Device Enabled" | sed -e "s/.*:*\([0-1]\)/\1/")

if [ $STATE = "1" ]; then
    xdotool mousemove 0 768
    xinput set-prop 14 147 0
else
    xdotool mousemove 342 384
    xinput set-prop 14 147 1
fi
