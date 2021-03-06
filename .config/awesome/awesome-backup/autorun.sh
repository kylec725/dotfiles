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
run picom --experimental-backends --backend 'glx'

# Start libinput-gestures
libinput-gestures-setup start

# Start xss-lock
run xss-lock -l fade-lock +resetsaver &

# Set redshift value
run redshift -c ~/.config/redshift/redshift.conf &

# Start Music Player Daemon
run mpd &

# Daemon to change screen layout when HDMI is connected
run x-on-resize -c ~/.bin/hdmi-toggle

# caps2esc
# sudo nice -n -20 udevmon -c udevmon.yaml >udevmon.log 2>udevmon.err &
