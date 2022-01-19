#!/bin/bash

#
# Lock the screen with a pixellated version of current desktop, with
# a nice lock picture on it.
#
# Based on https://kuttler.eu/en/post/my-screen-locking-configuration/

icon="$HOME/config/xsession/lock.png"
img=$(mktemp /tmp/XXXXXXXXXX.png)

#
# Maybe turn off the screen after 5 mins
#revert() {
#  rm $img
#  xset dpms 0 0 0
#}
#trap revert HUP INT TERM
#xset +dpms dpms 0 0 5

# Take a screenshot, pixelate it, make it a bit more white
#
sleep 0.1
import -window root $img
convert $img -scale 10%  -scale 1000%  -fill '#404' -colorize 30% $img

# Add the lock image
convert $img $icon -gravity South -composite $img

# Run i3lock with custom background
i3lock -e -i $img
rm $img
# revert
