#!/bin/env bash

# function to only run program if it is not already running
function run {
        if [ -z $(pgrep $1) ]
        then
                $@
        fi
}

# Set volume at 50%
amixer set Master unmute
amixer set Master 50%

# Restore feh background
~/.fehbg &

# Compton
run compton --config ~/.config/compton/compton.conf -b

# Start libinput-gestures
libinput-gestures-setup start

# Start xss-lock
run xss-lock -l fade-lock +resetsaver &

# Set redshift value
run redshift -c ~/.config/redshift/redshift.conf &

# Start Music Player Daemon
run mpd &

# Daemon to change screen layout when HDMI is connected
x-on-resize -c ~/.bin/hdmi-toggle
