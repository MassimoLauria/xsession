#!/bin/sh
# Massimo Xsession Script

# Load User's environment
[ -f ~/config/shell/sh.d/paths.sh   ] && . "$HOME/config/shell/sh.d/paths.sh"
[ -f ~/personal/conf/shenv-personal ] && . "$HOME/personal/conf/shenv-personal"

if [ -z "$CONFIGDIR" ]; then
    CONFIGDIR=$HOME/config
fi

# screen (no screensaver, tablet screen off by default)
xset -dpms
xset s off
xrandr --output DP-2 --off 2>| /dev/null
unclutter -root -idle 5 &
[ -f ~/config/xsession/xresources ] && xrdb -merge ~/config/xsession/xresources

# setup us keyboard with additional character.
# standard PC layout + accented vowels and composition
setxkbmap -config "$HOME"/config/xsession/setxkbmap.pcus

# Umask settings
umask 0077

# Various env variables to improve experience.
export SDL_MOUSE_RELATIVE=0

# Start session
exec i3
