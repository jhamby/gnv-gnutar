#!/bin/bash

set +x

# In case the timestamps get messedup from unpacking/copying etc.
touch configure.ac
sleep 2
touch aclocal.m4
sleep 2
touch config.h.in
sleep 2
touch Makefile.in
touch gnu/Makefile.in
touch lib/Makefile.in
touch rmt/Makefile.in
touch src/Makefile.in
touch scripts/Makefile.in
touch tests/Makefile.in
touch doc/Makefile.in
touch po/Makefile.in
sleep 2
touch configure
ls --full-time configure
# Handle bad clock skew for NFS served volumes.
sleep 90
touch config.status
ls --full-time config.status
sleep 2
touch Makefile
touch gnu/Makefile
touch lib/Makefile
touch rmt/Makefile
touch src/Makefile
touch scripts/Makefile
touch tests/Makefile
touch doc/Makefile
touch po/Makefile
sleep 2
touch doc/tar.1 doc/rmt.8
touch doc/tar.info

export GNV_OPT_DIR=.
make
