#!/bin/bash

#
# Massimo Lauria 2010-07-07


# User's environment
[ -f ~/config/shell/shenv-common    ] && . ~/config/shell/shenv-common
#[ -f ~/config/shell/shenv-gnupg     ] && . ~/config/shell/shenv-gnupg
#[ -f ~/config/shell/shenv-ssh       ] && . ~/config/shell/shenv-ssh
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
# SPEED=fast/slow

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
else
    echo "OFF"
fi


Keyboard shortcuts
echo -n "XSession Autostart... XBindkeys "
if [ -f /usr/bin/xbindkeys -a -f "$HOME/.xbindkeysrc.noauto" ]; then
   xbindkeys -f "$HOME/.xbindkeysrc.noauto" &
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
# echo -n "XSession Autostart... Ban Idle Mouse "
# if [ -f /usr/bin/unclutter ]; then
#     unclutter -noevents -idle 2 -root &
#     echo "ON"
# else
#     echo "OFF"
# fi

## Control audio and volumes
echo -n "XSession Autostart... Audio Controls"
if [ -f /usr/bin/gnome-volume-control-applet ]; then
    gnome-volume-control-applet &
    echo "ON"
elif [ -f /usr/bin/gnome-sound-applet ]; then
    gnome-sound-applet &
    echo "ON"
elif [ -f /usr/bin/pasystray ]; then
    pasystray &
    echo "ON"
elif [ -f /usr/bin/padevchooser ]; then
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
    if [ -f /usr/bin/gconftool-2 ]; then
        gconftool-2 -s /desktop/gnome/url-handlers/org-protocol/command '/usr/bin/emacsclient %s' --type String
        gconftool-2 -s /desktop/gnome/url-handlers/org-protocol/enabled --type Boolean true
        echo "ON (gconf org-protocol YES)"
    else
        echo "ON (gconf org-protocol NO)"
    fi
else
    echo "OFF"
fi

## Sage Math Environment
echo -n "XSession Autostart... SageMath Environment "
if [ x$SAGEMATH = "xyes" -a -f `which sage` ]; then
    export SAGE_BROWSER=$BROWSER
    sage -n lavori/notebook open_viewer=False &
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

## OfflineImap
echo -n "XSession Autostart... Offline Imap "
if [ -f ~/.offlineimaprc -a -f /usr/bin/offlineimap ]; then
    offlineimap &
    echo "ON"
else
    echo "OFF"
fi
