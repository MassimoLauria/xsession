#!/bin/sh
# Massimo Xsession Script



# Setup window manager
WM=i3


# Load User's environment
[ -f ~/config/shell/shenv-common    ] && . ~/config/shell/shenv-common
[ -f ~/personal/conf/shenv-personal ] && . ~/personal/conf/shenv-personal

if [ -z "$CONFIGDIR" ]; then
    CONFIGDIR=$HOME/config
fi


# Files
XMODMAP=$HOME/.Xmodmap
XRESOURCES=$HOME/.Xresources
XAUTOSTART=$CONFIGDIR/xsession/x-autostart.sh
XAUTOSTOP=$CONFIGDIR/xsession/x-autostop.sh
AUTOSTARTLOG=.x-autostart.log


# Umask settings
umask 0077

# Xorg settings
xsetroot -solid black
[ -d ~/config/fonts ] && xset +fp ~/config/fonts
xset fp rehash
xset b off

# This is annoying watching TV
if [ x$AGGRESSIVE_SCREENSAVER = "xyes" ];then
    xset dpms 300 300 300
else
    xset -dpms
fi

[ -f $XMODMAP ] && xmodmap $XMODMAP
[ -f $XRESOURCES ] && xrdb $XRESOURCES


# Various env variables to improve experience.
export SDL_MOUSE_RELATIVE=0

# Start session

$XAUTOSTART &  # preload programs

$WM            # launch wm

$XAUTOSTOP     # clean up

