#!/bin/sh

#
# Massimo Lauria, 2010-05-10
#
# This script produce a status bar for Xmonad.  
#
# The configuration is hard coded to match my former xmonad.hs


POSX=1000
POSY=0
W=860
H=16

BG='#2c2c32'
FG='grey70'
FONT='-*-profont-*-*-*-*-11-*-*-*-*-*-iso8859'

SEP=" ^fg(grey60)^r(3x3)^fg() "

DZEN2ARGS="-x $POSX -y $POSY -bg $BG -fg $FG -w $W -h $H -sa c -fn $FONT -e '' -xs 1 -ta r"
TIME="%A, %e %B %Y $SEP %H:%M $SEP"

BATTERY=

while true; do

    echo -n $SEP " " 

   
    # Power data
    #AC=`acpi -BaT|grep on-line`
    #if [ -z "$AC" ]; then 
    #    AC=" " 
    #else 
    #    AC="X"
    #fi
    #TEMP=`acpi -BAt|cut -f9 -d ' '`
    #echo -n "BAT" `acpi -bAT|cut -d, -f2` "[$AC]" $SEP $TEMP "C°" 

    #echo -n " " $SEP " " 
    
    #LOAD=`uptime| cut -d: -f 5`
    #echo -n $SEP $LOAD 
   
    date +"$TIME"
    
    sleep 10
done | dzen2 $DZEN2ARGS
