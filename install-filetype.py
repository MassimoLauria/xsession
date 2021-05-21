#!/usr/bin/env python3
"""Install custom file types in a Linux Free Desktop environment

Installing a new file type in Linux is a pain. It requires the editing
of an XML which needs to be loaded in the database (and then the
database must be updated).

"""


import subprocess
import os
import tempfile

C64ICON = "/usr/share/pixmaps/c64icon-48x42.xpm"

FILETYPES = [
    ('application/x-c64-datadisk',
     'Commodore 64 floppy image', '*.d64', C64ICON),
    ('application/x-c64-datatape',
     'Commodore 64 tape image', '*.t64', C64ICON),
    ('application/x-c64-cartridge',
     'Commodore 64 cartridge', '*.crt', C64ICON),
    ('application/x-c64-program',
     'Commodore 64 programs', '*.prg', C64ICON),
    ('audio/x-sid',
     'Commodore 64 SID tune', '*.sid', C64ICON)
]

XMLTEMPLATE = r'''<?xml version="1.0"?>
<mime-info xmlns='http://www.freedesktop.org/standards/shared-mime-info'>
  <mime-type type="{name}">
    <comment>{desc}</comment>
    <glob pattern="{glob}"/>
  </mime-type>
</mime-info>
'''


def update_db():
    """Updates the user MIME database """
    home = os.getenv("HOME")
    mimedb = home+"/.local/share/mime"
    subprocess.run(["update-mime-database", mimedb], check=True)


def install_mime_file(filepath):
    """Install a mime XML file in the MIME database"""
    cmd = ["xdg-mime", "install", "--novendor",
           "--mode", "user", filepath]
    subprocess.run(cmd, check=True)


def install_icon(filetype, iconspec):
    """Install an icon for the file type"""
    filetype_normalized = filetype.translate({ord('/'): '-'})
    cmd = ["xdg-icon-resource", "install", "--context", "mimetypes", "--size",
           "64", iconspec, filetype_normalized]
    subprocess.run(cmd, check=True)


def install_filetype(name, desc, globpattern, icon=None):
    """Install a file types in the local MIME database"""
    fd, path = tempfile.mkstemp(suffix=".xml", prefix="mxllocal-")
    try:
        with os.fdopen(fd, 'w') as tmpo:
            # do stuff with temp file
            tmpo.write(XMLTEMPLATE.format(name=name,
                                          desc=desc,
                                          glob=globpattern))
        install_mime_file(path)
        if icon is not None:
            install_icon(name, icon)
    finally:
        os.remove(path)


# Install my MIME-types
if __name__ == '__main__':
    for n, d, g, i in FILETYPES:
        install_filetype(n, d, g, i)

    update_db()
