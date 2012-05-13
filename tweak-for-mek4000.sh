#!/bin/sh
#
# (needs 'xmodmap' and 'evrouter' software installed)

#
# Microsoft Ergonomic Keyboard 4000 fixes for Linux.
#
MEK4000_ID="usb-Microsoft_Natural®_Ergonomic_Keyboard_4000-event-kbd"
MEK4000_CONF="evrouter-mek4000.conf"
MEK4000_KEYCODE="0xfa"

if [ -e "/dev/input/by-id/$MEK4000_ID" ]; then

    xmodmap -e "keycode 0xfa = XF86Spell"

    which "evrouter" 2>/dev/null >/dev/null || \
        echo "Error: missing required program \"evrouter\" (needed for MEK4000)."

    sudo -n $(dirname $0)/run-evrouter.sh "$MEK4000_ID" "$(dirname $0)/$MEK4000_CONF"

fi

