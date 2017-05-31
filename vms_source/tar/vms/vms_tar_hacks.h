#ifndef _VMS_TAR_HACKS_H
#define _VMS_TAR_HACKS_H


#define __UNIX_PUTC
#pragma message disable questcompare
#pragma message disable questcompare1

/* For strtoumax */
#pragma message disable notincrtl

#include "vms_getcwd_hack.h"
#include "vms_getrlimit_hack.h"

/* TODO: Fix older VMS versions with out STD_STAT. */
#define SAME_INODE_H 1
#define SAME_INODE(a, b)    \
    ((a).st_ino == (b).st_ino \
     && (a).st_dev == (b).st_dev)

#define fork vfork


/* checkpoint needs termios.h - grab from bash port */
#ifdef HAVE_TERMIOS_H
#undef HAVE_TERMIOS_H
#endif
#define HAVE_TERMIOS_H 1

#include "vms_lstat_hack.h"

#endif /* _VMS_TAR_HACKS_H */
