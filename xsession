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
XAUTOSTART=$CONFIGDIR/xsession/x-autostart.sh
XAUTOSTOP=$CONFIGDIR/xsession/x-autostop.sh
AUTOSTARTLOG=.x-autostart.log


# Umask settings
umask 0077

# Various env variables to improve experience.
export SDL_MOUSE_RELATIVE=0

# Start session
$XAUTOSTART &  # preload programs
$WM            # launch wm
$XAUTOSTOP     # clean up

