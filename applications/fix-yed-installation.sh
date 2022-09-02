#! /bin/bash

# Set yED files after installation
ICONFILE=$HOME/.local/lib/yed/.install4j/yEd.png
DESKTOPFILE=$HOME/config/xsession/applications/yed.desktop

# Create a new mime type definition file
cat >graphml+xml-mime.xml << EOL
<?xml version="1.0"?>
 <mime-info xmlns='http://www.freedesktop.org/standards/shared-mime-info'>
   <mime-type type="application/x-graphml+xml">
   <comment>yEd graphml file (xml format)</comment>
   <glob pattern="*.graphml"/>
   <generic-icon name="x-application-graphml+xml"/>
  </mime-type>
 </mime-info>
EOL

# Install the new mime definition
sudo xdg-mime install graphml+xml-mime.xml
rm -f graphml+xml-mime.xml

# Install icon (size 48 can be extracted from i4j_extf_2_1aawyej_k3n8ea.ico file)
sudo xdg-icon-resource install --context mimetypes --size 32 $ICONFILE x-application-graphml+xml

# Append %F to yEd .desktop file so it is visible in "Open With Other Application" menu
cp $DESKTOPFILE $HOME/.local/share/applications/

echo "Go to file manager, right click, select 'Open With Other Application'"
echo "click 'View All Applications' and select yEd."
