#!/usr/bin/env python
# credits: Gilles 'SO- stop being evil' on AskUbuntu.

from ctypes import *

modifiers={
    "shift" : c_uint(1),
    "caps_lock" : c_uint(2),
    "control" : c_uint(4),
}

# Mod1=8 ... Mod5=128
for i in range(1,6):
    modifiers["mod"+str(i)] = c_uint(4 * 2**i)


class Display(Structure):
    """ opaque struct """

X11 = cdll.LoadLibrary("libX11.so.6")
X11.XOpenDisplay.restype = POINTER(Display)

display = X11.XOpenDisplay(c_int(0))
X11.XkbLockModifiers(display,
                     c_uint(0x0100),
                     modifiers['caps_lock'],
                     c_uint(0))
X11.XCloseDisplay(display)
