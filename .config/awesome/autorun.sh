#!/bin/env bash

# function to only run program if it is not already running
function run {
        if ! pgrep $1 > /dev/null ;
        then
                $@&
        fi
}

# Set volume at 50%
amixer set Master unmute
amixer set Master 50%

# Restore feh background
# ~/.fehbg &

# Compton
run compton -b 

# Dunst
# dunst &

# Start libinput-gestures
libinput-gestures-setup start

# Start xss-lock
run xss-lock -l fade-lock +resetsaver &

# Set redshift value
run redshift -c ~/.config/redshift/redshift.conf

# Run nm-applet
# run nm-applet &
