#!/bin/sh

# Copyright (C) 2010, 2011, 2012, 2020 by Massimo Lauria <lauria.massimo@gmail.com>
#
# Created   : "2011-03-05, sabato 01:03 (CET) Massimo Lauria"
# Time-stamp: "2020-11-28, 22:45 (CET) Massimo Lauria"

# Description::
#
# Script to setup my xsession configuration.

# -------------------- Env Variables ------------------------
CP=cp
LN=ln
RM=rm
FILE_NOT_FOUND=127


# ------------------- Utilities -----------------------------
require_program()
{
    if [ $# -ne 1 ]; then echo "Wrong argument number."; exit 1; fi

    echo -n "Checking for '$1'... "
    which $1 2> /dev/null > /dev/null
    if [ $? -ne 0 ]; then
        echo "FAIL."
        exit_on_missing_program $1
    else
        echo "OK."
    fi
}

exit_on_missing_program() {
    echo ""
    echo "Unfortunately program \"$1\" is not present, or it is not executable."
    echo "Without this software, I can't finish the installation."
    echo ""
    echo "Bye bye."
    exit $FILE_NOT_FOUND
}

backup_maybe() {
# Check backup possibility.
    if [ $# -ne 1 ]; then echo "Wrong argument number."; exit 1; fi
    if [ -e $1 ]; then
        $CP -af $1 $1.bak.`date +%Y-%m-%d.%H.%M.%S`
    fi
}


issue_warning_on_pwd() {
    if [ $# -ne 1 ]; then echo "Wrong argument number."; exit 1; fi
    if [ "$PWD" != "$HOME/$1" ]; then
        echo ""
        echo "WARNING: you are installing in a wrong path."
        echo "WARNING: the right path should be ~/$1."
        echo "WARNING: installation would go on, but something may not work properly."
        echo "WARNING: remember that moving folder requires running this script again."
        echo ""
    fi
}

# ------------------- Installation -------------------------

# Goto config folder.
cd $(dirname $0)

issue_warning_on_pwd "config/xsession"

echo "Check for the present of basic programs"
require_program $CP
require_program $LN
require_program $RM
echo ""

# Do backups
echo -n "Backing up old config files..."
backup_maybe $HOME/.xsession
echo "OK."

# Do install
echo -n "Installing new config files.."
$RM -f $HOME/.xsessionrc
$RM -f $HOME/.xsession
$LN -s $PWD/xsession    $HOME/.xsession
echo "OK"

echo "Bye, bye!"

