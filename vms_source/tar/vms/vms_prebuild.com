$! VMS_PREBUILD.COM
$!
$! This script sets up everything needed to run the Bash configure script
$! and subsequent makefile
$!
$! 03-Jul-2016	J. Malmberg
$!
$!=======================================================================
$!
$ project_name = "tar"
$!
$! Use a period for the current working directory in the source_dirs list.
$! source_dirs is a string with comma separated names.
$ source_dirs = "gnu,lib,src"
$!
$! List of binaries to be produced.
$! binaries is a list of comma separated names.
$ binaries = "tar"
$!
$ cstand = "/standard=(relaxed,isoc94)"
$ caccept = "/accept=(novaxc,restr,c99)"
$ prefix = "/prefix=except=(strtoimax,strtoumax,iswblank)"
$ clist = "/list/show=(expan,inclu)"
$ cname = "/names=(as_is,short)/main=posix_exit"
$ cfloat = "/float=IEEE/IEEE_MODE=DENORM_RESULTS"
$ cinc = "/nested=NONE"
$ cc :== cc'cstand''caccept''clist''cname''cfloat''cinc''prefix'/debug
$ defdir = f$environment("default")
$ defdir_base = defdir - "]" - ">"
$ delim = f$extract(f$length(defdir) -1, 1, defdir)
$ define decc$user_include 'defdir_base'.vms'delim'
$ define decc$system_include 'defdir_base'.vms'delim'
$!
$ if p1 .eqs. "DEBUG"
$ then
$   cc :== 'cc'/debug/nooptimize
$   link :== link/threads_enable/debug
$ else
$   if f$type(link) .eqs. "STRING"
$   then
$       del/sym/glo link
$   endif
$   link :== link/threads_enable
$ endif
$!
$! CRTL pre-init
$!----------------
$ if f$search("vms_crtl_init.obj") .eqs. ""
$ then
$   cc/object=sys$disk:[]vms_crtl_init.obj -
        [.vms]vms_crtl_init.c
$ endif
$!
$! VMS to Unix filenames
$!------------------------
$ if f$search("vms_fname_to_unix.obj") .eqs. ""
$ then
$   cc/object=sys$disk:[]vms_fname_to_unix.obj -
        [.vms]vms_fname_to_unix.c
$ endif
$!
$! VMS termios hacks
$!------------------
$ if f$search("vms_terminal_io.obj") .eqs. ""
$ then
$   cc/object=sys$disk:[]vms_terminal_io.obj -
        [.vms]vms_terminal_io.c
$ endif
$!
$!
$! Set ACL to override protection, as makefile is removing write
$! access from files it then tries to rename or delete.
$ acl_perms = "access=read+write+execute+delete"
$ set security/acl=(identifier='f$user()','acl_perms') sys$disk:[]src.dir
$ set security/acl=(identifier='f$user()',options=default,'acl_perms') -
   sys$disk:[]src.dir
$!
$! Needed for make check
$ sys_disk = f$trnlnm("sys$disk") - ":"
$ max_index = f$trnlnm(sys_disk,,,,, "max_index")
$ if max_index .ne. 0
$ then
$   base_disk = f$trnlnm(sys_disk,, 0)
$   set directory/version_limit=1 'base_disk'[.tests]
$ else
$   set directory/version_limit=1 sys$disk:[.tests]
$ endif
$!
$! Setup header files
$!-----------------------
$! For the configure step.
$ src_file = "gnv_conftest.c_first"
$ dst_file = "sys$disk:[]gnv$conftest.c_first"
$ if f$search(dst_file) .eqs. ""
$ then
$   copy/log [.vms]'src_file' 'dst_file'
$ endif
$ src_file = "gnv_conftest.opt"
$ dst_file = "sys$disk:[]gnv$conftest.opt"
$ if f$search(dst_file) .eqs. ""
$ then
$   if f$search("[.vms]''src_file'") .nes. ""
$   then
$	copy/log [.vms]'src_file' 'dst_file'
$   endif
$ endif
$!
$!
$ src_file = "[.vms]gnv_first_include.h"
$ if f$search(src_file) .nes. ""
$ then
$   i = 0
$source_loop:
$       src_dir = f$element(i, ",", source_dirs)
$       if src_dir .eqs. "" then goto source_loop_end
$       if src_dir .eqs. "," then goto source_loop_end
$       if src_dir .eqs. "."
$       then
$           src_dir = ""
$       else
$           src_dir = "." + src_dir
$       endif
$       dst_file = "sys$disk:[''src_dir']gnv$first_include.h"
$       if f$search(dst_file) .eqs. ""
$       then
$           copy/log 'src_file' 'dst_file'
$       endif
$       i = i + 1
$       goto source_loop
$source_loop_end:
$ endif
$!
$ src_file = "[.vms]gnv_program.opt"
$ if f$search(src_file) .nes. ""
$ then
$   i = 0
$opt_loop:
$       bin_file = f$element(i, ",", binaries)
$       if bin_file .eqs. "" then goto opt_loop_end
$       if bin_file .eqs. "," then goto opt_loop_end
$       dst_file = "sys$disk:[.src]gnv$''bin_file'.opt"
$       if f$search(dst_file) .eqs. ""
$       then
$           copy/log 'src_file' 'dst_file'
$       endif
$       i = i + 1
$       goto opt_loop
$opt_loop_end:
$ endif
$!
$!
$! Need to build a script to run configure
$!
$ vms_cfg_script = "sys$disk:[]vms_configure.sh"
$if f$search(vms_cfg_script) .eqs. ""
$then
$   config_hack1 = "sys$disk:[]config_hack1.out"
$   search/out='config_hack1' -
	configure "checking absolute name of <", ">&6;"/match=and
$!
$   create 'vms_cfg_script'
$   open/append cfg_out 'vms_cfg_script'
$   write cfg_out "#!/bin/bash"
$   write cfg_out "#"
$   write cfg_out "# Generated by vms/vms_prebuild.com"
$   write cfg_out "#"
$   write cfg_out "# Run the configure script with options needed for VMS"
$   write cfg_out "#"
$   write cfg_out "export gl_cv_func_working_mkstemp=yes"
$   write cfg_out "export gl_cv_func_getcwd_path_max=no"
$   write cfg_out "export gl_cv_func_working_utimes=yes"
$   write cfg_out "export gl_cv_func_getcwd_null=yes"
$   write cfg_out "export gl_cv_func_getcwd_posix_signature=yes"
$   write cfg_out "export gl_cv_func_getcwd_path_max=yes"
$   write cfg_out "export gl_cv_func_getcwd_abort_bug=no"
$   write cfg_out "export gl_cv_func_getcwd_short_bug=no"
$   write cfg_out "export gl_cv_func_rmdir_works=yes"
$!
$! The assumption here is that there may local files with the same
$! name as system header files.  For VMS, configure tests fail for these
$! headers.  We add a hopefully fake path, which causes VMS to pull the
$! header from the text library after junking the path.
$   open/read cfg_hack1 'config_hack1'
$hack1_loop:
$	read cfg_hack1/end=hack1_loop_end line_in
$	if line_in .eqs. "" then goto hack1_loop
$	header_part = f$element(1, "<", line_in)
$	if header_part .eqs. "<" then goto hack1_loop
$	header = f$element(0, ">", header_part)
$	if header .eqs. "<" then goto hack1_loop
$	header = header - ".h"
$	pre_dir = f$element(0, "/", header)
$	if pre_dir .nes. header
$	then
$	    header = f$element(1, "/", header)
$	    header1 = pre_dir + "_" + header + "_h"
$	else
$	    header1 = header + "_h"
$	endif
$	header2 = header + ".h"
$	write cfg_out -
	   "export gl_cv_next_''header1'=""<vms_fake_path/''header2'>"""
$	goto hack1_loop
$hack1_loop_end:
$   close cfg_hack1
$!
$   write cfg_out -
  "./configure --prefix=/usr --config-cache  --disable-dependency-tracking"
$   close cfg_out
$!
$   purge/log 'vms_cfg_script'
$endif
$!
$ arch_type = f$getsyi("ARCH_NAME")
$ node_swvers = f$getsyi("node_swvers")
$ vernum = f$extract(1, f$length(node_swvers), node_swvers)
$ majver = f$element(0, ".", vernum)
$ minverdash = f$element(1, ".", vernum)
$ minver = f$element(0, "-", minverdash)
$ dashver = f$element(1, "-", minverdash)
$ if dashver .eqs. "-" then dashver = ""
$ vmstag = arch_type + "_" + majver + "_" + minver
$ if dashver .nes. "" then vmstag = vmstag + "_" + dashver
$ vmstag = f$edit(vmstag, "lowercase")
$!
$!
$! Autoconf says not to provide a cached config file for a platform.
$! We do this here because configure takes too long to run and
$! will produce the same results for a VMS version.
$ vms_cache = "sys$disk:[.vms]config.cache_''vmstag'"
$ write sys$output "looking for ''vms_cache' file."
$ if f$search(vms_cache) .nes. ""
$ then
$   copy 'vms_cache' sys$disk:[]config.cache
$ endif
$!
$!
$! The CRTL can not handle if the default is set to a directory that
$! does not exist in the first member of a search list.
$!
$! For simplicity, assume sys$disk is not a search list by itself
$! ---------------------------------------------------------------
$!
$! Becaues of recursive make, we need to copy some files to the
$! beginning of the search list to make sure the order is correct
$! or make will attempt to rebuild them with tools that are not
$! currently present on VMS.
$goto skip_copy_loop
$!
$ sys_disk  = f$trnlnm("sys$disk") - ":"
$!
$ max_index = f$trnlnm(sys_disk,,,,, "max_index")
$ if max_index .ne. 0
$ then
$   base_disk = f$trnlnm(sys_disk,, 0)
$   i = 1
$   if f$search("'base_disk'[]configure.ac") .eqs. ""
$   then
$copy_loop:
$	if i .gt. max_index then goto copy_loop_end
$	diskn = f$trnlnm(sys_disk,, i)
$!
$!	May Need all the [.m4]m4 files for recursive make to work
$!      These must be oldest if needed to copy.
$!
$	if f$search("''diskn'[.m4...]*.*") .nes. ""
$	then
$!	    copy 'diskn'[.m4...]*.* 'base_disk'[.m4...]
$!	    purge 'base_disk'[.m4...]
$	endif
$!
$!      configure.ac needs to be older than aclocal.m4 files.
$	if f$search("''diskn'[]configure.ac") .nes. ""
$	then
$	    wait 00:00:01
$	    copy 'diskn'[]configure.ac 'base_disk'[]
$	    purge 'base_disk'[]configure.ac
$	endif
$!
$	if f$search("''diskn'[]aclocal.m4") .nes. ""
$	then
$	    wait 00:00:01
$	    copy 'diskn'[]aclocal.m4 'base_disk'[]
$	    purge 'base_disk'[]aclocal.m4
$	endif
$!
$	if f$search("''diskn'[.lib]config.hin") .nes. ""
$	then
$	    wait 00:00:01
$	    copy 'diskn'[.lib]config.hin 'base_disk'[.lib]
$	    purge 'base_disk'[.lib]config.hin
$	endif
$!
$	if f$search("''diskn'[]makefile.am") .nes. ""
$	then
$	    wait 00:00:01
$	    copy 'diskn'[]makefile.am 'base_disk'[]
$	    purge 'base_disk'[]makefile.am
$	endif
$!
$	if f$search("''diskn'[.lib]makefile.am") .nes. ""
$	then
$	    wait 00:00:01
$	    copy 'diskn'[.lib]makefile.am 'base_disk'[.lib]
$	    purge 'base_disk'[.lib]makefile.am
$	endif
$!
$	if f$search("''diskn'[.doc]makefile.am") .nes. ""
$	then
$	    wait 00:00:01
$	    copy 'diskn'[.doc]makefile.am 'base_disk'[.doc]
$	    purge 'base_disk'[.doc]makefile.am
$	endif
$!
$	if f$search("''diskn'[.tests]makefile.am") .nes. ""
$	then
$	    wait 00:00:01
$	    copy 'diskn'[.tests]makefile.am 'base_disk'[.tests]
$	    purge 'base_disk'[.tests]makefile.am
$	endif
$!
$!
$	if f$search("''diskn'[]makefile.in") .nes. ""
$	then
$	    wait 00:00:01
$	    copy 'diskn'[]makefile.in 'base_disk'[]
$	    purge 'base_disk'[]makefile.in
$	endif
$!
$	if f$search("''diskn'[.lib]makefile.in") .nes. ""
$	then
$	    wait 00:00:01
$	    copy 'diskn'[.lib]makefile.in 'base_disk'[.lib]
$	    purge 'base_disk'[.lib]makefile.in
$	endif
$!
$	if f$search("''diskn'[.doc]makefile.in") .nes. ""
$	then
$	    wait 00:00:01
$	    copy 'diskn'[.doc]makefile.in 'base_disk'[.doc]
$	    purge 'base_disk'[.doc]makefile.in
$	endif
$!
$	if f$search("''diskn'[.tests]makefile.in") .nes. ""
$	then
$	    wait 00:00:01
$	    copy 'diskn'[.tests]makefile.in 'base_disk'[.tests]
$	    purge 'base_disk'[.tests]makefile.in
$	endif
$!
$!	configure must be newer than m4 files
$!
$	if f$search("''diskn'[]configure.") .nes. ""
$	then
$	    wait 00:00:01
$	    copy 'diskn'[]configure. 'base_disk'[]
$	    purge 'base_disk'[]configure.
$	endif
$!
$	if f$search("''diskn'[.tests]basic.") .nes. ""
$	then
$	    wait 00:00:01
$	    copy 'diskn'[.tests]*.*/exc=(makefile.*,*.dir) 'base_disk'[.tests]
$	    purge 'base_disk'[.tests]
$	endif
$!
$!
$	i = i + 1
$	goto copy_loop
$copy_loop_end:
$   endif
$ endif
$skip_copy_loop:
$!
