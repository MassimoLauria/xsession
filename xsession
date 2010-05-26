#!/bin/sh
# Massimo Xsession Script
#
# startlxde:
#    Lightweight X Desktop Manager, it is a lightweight 
#    desktop manager. It is  quite usable and gnome-like, 
#    but it sucks less resources. It starts with openbox as 
#    window manager and PCmanFM as filemanager
#
#
# awesome:
#    it is a tile window manager, an option that in going to consider
#    much more in the future (i just need to solve some issues with
#    some application)
#
# xmonad:
#   another tile-window manager. Written in haskell and (sigh!) configurable
#   only in Haskell source code
#
#
#

# User's environment
[ -f ~/config/shell/shenv-common    ] && . ~/config/shell/shenv-common
[ -f ~/config/shell/shenv-gnupg     ] && . ~/config/shell/shenv-gnupg
[ -f ~/personal/conf/shenv-personal ] && . ~/personal/conf/shenv-personal

# Files
XMODMAP=~/config/xsession/Xmodmap 
XRESOURCES=~/config/xsession/Xresources
XAUTOSTART=~/config/xsession/x-autostart.sh
 XAUTOSTOP=~/config/xsession/x-autostop.sh
AUTOSTARTLOG=.x-autostart.log

export SDL_MOUSE_RELATIVE=0

# Umask settings
umask 0077

# Xorg settings
xsetroot -solid black
[ -d ~/config/fonts ] && xset +fp ~/config/fonts
xset fp rehash
xset b off
xset dpms 300 300 300 
[ -f $XMODMAP    ] && xmodmap $XMODMAP
[ -f $XRESOURCES ] && xrdb -merge $XRESOURCES



#-- Desktop Session -- 
#startlxde
#gnome-session
#startkde

#-- Plain WMs --
# Lauch my X session (delayed)
$XAUTOSTART > $AUTOSTARTLOG & 

awesome

$XAUTOSTOP

#-- Fallback Xterm --
#exec xterm