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

# Load User's environment
[ -f ~/config/shell/shenv-common    ] && . ~/config/shell/shenv-common
[ -f ~/personal/conf/shenv-personal ] && . ~/personal/conf/shenv-personal

# Files
XAUTOSTART=~/config/xsession/x-autostart.sh
 XAUTOSTOP=~/config/xsession/x-autostop.sh


exec awesome


#-- Fallback Xterm --
#exec xterm
