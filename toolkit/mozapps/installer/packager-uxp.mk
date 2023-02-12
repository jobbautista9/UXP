# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# We need to include the mozilla packaging routines because we are
# very much still dependent on them
include $(MOZILLA_DIR)/toolkit/mozapps/installer/packager.mk

# Only use extreme compression when we are stripping the final
# binaries during packaging, otherwise compressing an unstripped
# package will take 20 minutes. We don't worry about package size if
# it's just a debug build, just as we don't worry about compression
# time if it's going to be a release build.
#
# We assume that --enable-strip is not active if PKG_SKIP_STRIP,
# controlled by --enable-install-strip, is set. So don't do both
# --enable-strip and --disable-install-strip. That will just give
# you slightly less compressed tarballs. ;)
ifdef PKG_SKIP_STRIP
	XZ_COMPRESS := "-0"
else
	XZ_COMPRESS := "-9e"
endif

# This is currently only used on Windows, Linux, Solaris, and
# FreeBSD. On other platforms such as Mac, we will fall back
# to the original mozilla packaging.
make-archive:
ifeq (,$(filter SunOS Linux WINNT FreeBSD,$(OS_ARCH)))
	$(MAKE) make-package
else
	$(MAKE) stage-package make-buildinfo-file
	@echo 'Compressing...'
ifeq (WINNT,$(OS_ARCH))
	cd $(DIST); $(CYGWIN_WRAPPER) 7z a -t7z -m0=lzma2 -mx=9 -aoa -bb3 $(PKG_BASENAME).7z $(MOZ_PKG_DIR)
else
	cd $(DIST); XZ_OPT=$(XZ_COMPRESS) $(TAR) --exclude='*.sym' -cJvf $(PKG_BASENAME).tar.xz $(MOZ_PKG_DIR)
endif
endif

# This is currently only used in Linux.
package-debugsymbols:
ifeq ($(OS_ARCH),Linux)
	@echo 'Compressing debug symbols...'
	cd $(DIST)/bin; find . -name '*.sym' -print0 | XZ_OPT="-0" $(TAR) cJvf ../symbols-$(MOZ_PKG_VERSION).$(MOZ_PKG_PLATFORM).tar.xz --null -T -
else
	@echo 'This function is not available for Windows and macOS.'
endif
