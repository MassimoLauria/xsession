#!/bin/sh
#
# (needs 'evrouter' software installed)

DEV_ID=$1
CONF_FILE=$2

which "evrouter" 2>/dev/null >/dev/null || \
    echo "Error: missing required program \"evrouter\"."

# Kill previous running instance
`which evrouter` -q "/dev/input/by-id/$DEV_ID"

# Remove stale temp files
rm -f "/tmp/.evrouter$DISPLAY"

# Run a new instance
`which evrouter` -c "$CONF_FILE" "/dev/input/by-id/$DEV_ID"


