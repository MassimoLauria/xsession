#!/bin/sh

USER=`whoami`

# Save audio status (per user)
which alsactl && alsactl -f .asound.conf store &

# Stop some services
pkill -TERM -u $USER mpd
pkill -TERM -u $USER emacs
pkill -TERM -u $USER cameramonitor
pkill -TERM -u $USER offlineimap


# Stop SageMath if it is running
SAGEPID=`cat ~/lavori/notebook.sagenb/twistd.pid`
kill -9 $SAGEPID
