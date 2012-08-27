#!/bin/sh
#
# American/English keyboard fixes for an italian user.
#


LAYOUT=`setxkbmap -print | grep xkb_symbols | sed 's|.*["+]\([^+"][^+"]\)["+].*|\1|'`

DOIT="nay"

case $LAYOUT in
    it) # No need here
        DOIT="nay"
        ;;
    us|gb)
        DOIT="yeah"
        ;;
    *)
        DOIT="yeah"
        ;;
esac

# Accented vowels are installed
if [ $DOIT = "yeah" ]; then
    xmodmap -e "keysym a = a A a A agrave Agrave"
    xmodmap -e "keysym e = e E e E egrave eacute"  # Italians needs both accents on e
    xmodmap -e "keysym i = i I i I igrave Igrave"
    xmodmap -e "keysym o = o O o O ograve Ograve"
    xmodmap -e "keysym u = u U u U ugrave Ugrave"
fi
