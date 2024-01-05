# -*- mode: conf -*-
#
# This should set the keyboard at system level unfortunately this is
# the only option to make the setting permanent between# usb resets,
# screensavers, and so on...
#
# Variant "massimolauria" has to be installed in the system
# by editing some system file :(
#
# use Caps-Lock as another Control
# use right-alt as Lv3-modifier (i.e. AltGr)
#

# localectl [--no-convert] set-x11-keymap layout [model [variant [options]]]
localectl set-x11-keymap us pc105 massimolauria caps:ctrl_modifier,lv3:ralt_switch,compose:rwin,compose:menu
