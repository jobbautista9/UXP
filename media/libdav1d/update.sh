#!/bin/sh
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# Usage: ./update.sh <dav1d_src_directory>

# Before running this script, compile dav1d first in another directory,
# using the instructions from https://code.videolan.org/videolan/dav1d#compile

cp $1/build/include/vcs_version.h vcs_version.h
cp $1/build/include/dav1d/version.h version.h
mkdir -p upstream
cp -r $1/include upstream
cp -r $1/src upstream
cp -r $1/tests upstream
cp $1/CONTRIBUTING.md upstream/CONTRIBUTING.md
cp $1/COPYING upstream/COPYING
cp $1/gcovr.cfg upstream/gcovr.cfg
cp $1/meson.build upstream/meson.build
cp $1/meson_options.txt upstream/meson_options.txt
cp $1/NEWS upstream/NEWS
cp $1/README.md upstream/README.md
cp $1/THANKS.md upstream/THANKS.md
