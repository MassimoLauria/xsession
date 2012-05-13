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


    # Kill previous running instance
    sudo -n `which evrouter` -q "/dev/input/by-id/$MEK4000_ID"

    # Remove stale temp files
    sudo -n rm -f "/tmp/.evrouter$DISPLAY"

    # Run a new instance
    sudo -n `which evrouter` -c  "$(dirname $0)/$MEK4000_CONF" "/dev/input/by-id/$MEK4000_ID"

fi

