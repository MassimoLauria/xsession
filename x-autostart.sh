#!/bin/bash

#
# Massimo Lauria 2012-06-16


# User's environment
[ -f ~/config/shell/shenv-common    ] && . ~/config/shell/shenv-common
[ -f ~/personal/conf/shenv-personal ] && . ~/personal/conf/shenv-personal

if [ -z "$CONFIGDIR" ]; then
    CONFIGDIR=$HOME/config
fi


NOOUTPUT=2>&1 > /dev/null


## Restore sound settings
echo -n "XSession Autostart... Sound "
if [ -f /sbin/alsactl -a -f .asounf.conf ]; then
    alsactl -f .asound.conf restore &
    echo "ON"
else
    echo "OFF"
fi


## Load X composition (disabled on nVidia display adapters)
##
## On nVidia display adapters the xcompmgr produces an orrible tearing
## in video playback and other accelerated features.
NVIDIAP=`lspci|grep VGA|grep nVidia`
echo -n "XSession Autostart... X Composition "
if [ -n "$NVIDIAP" ]; then
    echo "OFF (disabled on nVidia)"
elif [ x$SPEED = "xfast" -a -f /usr/bin/xcompmgr ]; then
    xcompmgr -D1 -fcC 2> /dev/null &
    echo "ON"
else
    echo "OFF"
fi


## Start XScreensaver
echo -n "XSession Autostart... X Screensaver "
if [ -f /usr/bin/xscreensaver ]; then
    xscreensaver -no-splash &
    echo "ON"
elif [ -f /usr/bin/gnome-screensaver ]; then
    gnome-screensaver &
    echo "ON"
else
    echo "OFF"
fi


## OSD
echo -n "XSession Autostart... OSD daemon "
if [ -f /usr/lib/notify-osd/notify-osd ]; then
    /usr/lib/notify-osd/notify-osd &
    echo "ON"
else
    echo "OFF"
fi


echo -n "XSession Autostart... fix for M$ Ergo Keyboard 4000 (requires installed sudoers file)."
$(dirname $0)/tweak-for-mek4000.sh 2>/dev/null >/dev/null


###### Conditional applications #########


## Launch startup scripts
run-parts $CONFIGDIR/xsession/autostart.d/
