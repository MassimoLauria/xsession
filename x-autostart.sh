#!/bin/sh

#
# Massimo Lauria 2010-05-11


# User's environment
[ -f ~/config/shell/shenv-common    ] && . ~/config/shell/shenv-common
[ -f ~/config/shell/shenv-gnupg     ] && . ~/config/shell/shenv-gnupg
[ -f ~/personal/conf/shenv-personal ] && . ~/personal/conf/shenv-personal

#
# available options are (among others)
#
# WIFI=yes/no
# WEBCAM=yes/no
# MUSIC=yes/no
# SAGEMATH=yes/no
# SSHIDENTITY=filename
# DROPBOX=yes/no
# WALLPAPER=filename
# LAPTOP=yes/no

NOOUTPUT=2>&1 > /dev/null

 
## Restore sound settings
echo -n "XSession Autostart... Sound "
if [ -f /sbin/alsactl -a -f .asounf.conf ]; then
    alsactl -f .asound.conf restore &
    echo "ON"
else
    echo "OFF"
fi


## Load X composition
echo -n "XSession Autostart... X Composition "
if [ -f /usr/bin/xcompmgr ]; then
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
else
    echo "OFF"
fi


## Keyboard shortcuts
echo -n "XSession Autostart... XBindkeys "
if [ -f /usr/bin/xbindkeys ]; then
    xbindkeys &
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

## Ban mouse as soon as possible
echo -n "XSession Autostart... Ban Idle Mouse "
if [ -f /usr/bin/unclutter ]; then
    unclutter -noevents -idle 2 -root &
    echo "ON"
else
    echo "OFF"
fi

## Ban mouse as soon as possible
echo -n "XSession Autostart... Pulseaudio Applet "
if [ -f /usr/bin/padevchooser ]; then
    padevchooser &
    echo "ON"
else
    echo "OFF"
fi


###### Conditional applications #########

## Wifi Manager
echo -n "XSession Autostart... Wifi Monitor "
if [ x$WIFI = "xyes" -a -f /usr/bin/nm-applet ]; then 
    nm-applet --sm-disable &
    echo "ON"
else
    echo "OFF"
fi


## Power manager
echo -n "XSession Autostart... Gnome Power manager "
if [ x$LAPTOP = "xyes" -a -f /usr/bin/gnome-power-manager ]; then 
    gnome-power-manager &
    echo "ON"
else
    echo "OFF"
fi


## Webcan Monitor
echo -n "XSession Autostart... Webcam Monitor "
if [ x$WEBCAM = "xyes" -a -f /usr/bin/cameramonitor ]; then
    cameramonitor &
    echo "ON"
else
    echo "OFF"
fi


## Music Daemon
echo -n "XSession Autostart... Music Daemon "
if [ x$MUSIC = "xyes" -a -f /usr/bin/mpd ]; then 
    mpd &
    if [ -f /usr/bin/sonata ]; then
        sonata &
    fi
    echo "ON"
else
    echo "OFF"
fi

## Emacs Daemon
echo -n "XSession Autostart... Emacs Daemon "
if [ -f /usr/bin/emacs ]; then 
    emacs --daemon &
    echo "ON"
else
    echo "OFF"
fi

## Sage Math Environment
echo -n "XSession Autostart... SageMath Environment "
if [ x$SAGEMATH = "xyes" -a -f `which sage` ]; then 
    export SAGE_BROWSER=firefox
    sage -notebook open_viewer=False &
    echo "ON"
else
    echo "OFF"
fi

## SSH identity load
echo -n "XSession Autostart... SSH Identity "
if [ -n "$SSHIDENTITY" -a -f $SSHIDENTITY ]; then 
    ssh-add $SSHIDENTITY
    echo "LOADED"
else
    echo "NOT LOADED"
fi

## Dropbox daemon
echo -n "XSession Autostart... Dropbox Daemon "
if [ x$DROPBOX = "xyes" -a -f /usr/bin/dropbox ]; then 
    dropbox start &
    echo "ON"
else
    echo "OFF"
fi
