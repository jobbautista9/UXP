#!/bin/sh

# Only enable pthread_setname_np on Linux, as it's unsupported in Hurd
patch -p1 < mcp-only-enable-pthread_setname-on-linux.patch
