#!/bin/sh

## Delay startup to allow WM to settle.
# sleep 1

## Root desktop
alsactl -f .asound.conf restore &
xcompmgr -D5 -fc &
xscreensaver -no-splash &

## Keyboards/OSD shortcuts
xbindkeys -f ~/config/xclients/xbindkeysrc  &
/usr/lib/notify-osd/notify-osd &

## Desktop services
unclutter -noevents -idle 2 -root &
#ivman &

# Desktop applets
padevchooser &
dropbox start &
nm-applet --sm-disable &
cameramonitor &

# Autostart applications
mpd &
emacs --daemon &
sage -notebook open_viewer=False &
sonata &
ssh-add ~/personal/ssh/id_dsa


