#!/bin/sh
# Massimo Xsession Script

# Load User's environment
[ -f ~/config/shell/shenv-common    ] && . "$HOME/config/shell/shenv-common"
[ -f ~/personal/conf/shenv-personal ] && . "$HOME/personal/conf/shenv-personal"

if [ -z "$CONFIGDIR" ]; then
    CONFIGDIR=$HOME/config
fi

# screen
xset -dpms
xset s off
if [ -d "$HOME/personal/wallpaper/"  ];then
    feh --no-fehbg --image-bg '#444' --bg-max --recursive --randomize "$HOME/personal/wallpaper/"
fi
unclutter -root -idle 5 &

# setup us keyboard with additional character.
# standard PC layout + accented vowels and composition
setxkbmap -config "$HOME"/config/xsession/setxkbmap.pcus

# Umask settings
umask 0077

# Various env variables to improve experience.
export SDL_MOUSE_RELATIVE=0

# Start session
exec i3
