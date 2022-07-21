#!/bin/sh

# Usage: ./update.sh /path/to/freetype-2.xx.x
#
# Copies the needed files from a tarball directory containing the
# original freetype2 source needed for rendering fonts.

if [ -e $1/ChangeLog ]
then
  cp $1/ChangeLog ChangeLog
else
  echo "Warning: Can't find current ChangeLog. Please manually copy ChangeLog from the latest tarball."
fi

cp $1/autogen.sh autogen.sh
cp $1/CMakeLists.txt CMakeLists.txt
cp $1/configure configure
cp $1/LICENSE.TXT LICENSE.TXT
cp $1/Makefile Makefile
cp $1/meson.build meson.build
cp $1/meson_options.txt meson_options.txt
cp $1/modules.cfg modules.cfg
cp $1/README README
cp $1/README.git README.git
cp $1/docs/oldlogs/ChangeLog.* .

cp -r $1/devel .
cp -r $1/include .
cp -r $1/src .

echo "Remember to update the README.mcp-patches file for version details and (if any) local changes."
