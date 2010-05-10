#!/bin/sh

USER=`whoami`

# Save audio status (per user)
alsactl -f .asound.conf store &

# Stop some services
pkill -TERM -u $USER mpd
pkill -TERM -u $USER emacs
pkill -TERM -u $USER cameramonitor
