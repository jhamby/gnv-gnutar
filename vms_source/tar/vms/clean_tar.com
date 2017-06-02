$file = "sys$disk:[.gnu]langinfo.h"
$! File: CLEAN_TAR.COM
$!
$! Procedure to clean tar build products on VMS.
$!
$! Copyright 2008, John Malmberg
$!
$! Permission to use, copy, modify, and/or distribute this software for any
$! purpose with or without fee is hereby granted, provided that the above
$! copyright notice and this permission notice appear in all copies.
$!
$! THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
$! WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
$! MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
$! ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
$! WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
$! ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT
$! OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
$!
$!
$!
$file = "sys$disk:[]*.pcsi$text"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[]*.pcsi$desc"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[]tar-*.bck"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[]tar-*.release_notes"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[]*.obj"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$login:sh*."
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$login:make*."
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[]confdefs.h"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[]conftest.dsf"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[]conftest.lis"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[]conftest.sym"
$if f$search(file) .nes. "" then delete 'file';*
$!
$!
$file = "sys$disk:[.conf*...]*.*"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[]conf*.dir
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[.tests.conf*...]*.*"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.tests]conf*.dir
$if f$search(file) .nes. "" then delete 'file';*
$!
$!
$file = "sys$disk:[.lib]*.out"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.lib]*.o"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[.gnu]alloca.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]arg-nonnull.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]c^+^+defs.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]configmake.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]dirent.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]errno.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]fcntl.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]fnmatch.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]getopt.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]inttypes.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]langinfo.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]locale.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]rmt-command.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]signal.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]stdalign.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]stddef.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]stdint.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]stdio.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]stdlib.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]string.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]strings.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]sysexits.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]time.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]unistd.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]unitypes.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]uniwidth.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]unused-parameter.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]warn-on-use.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]wchar.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]wctype.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]charset.alias"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu]*.sed"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[.gnu]*.a"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[.lib]*.lis"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[.src]*.lis"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[.src]cc_temp*."
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[.src]*.dsf"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[.src]*.o"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[.gnu...]*.o"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[.gnu...]*.lis"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[.tests]*.lis"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[.tests]*.dsf"
$if f$search(file) .nes. "" then delete 'file';*
$!
$!
$file = "sys$disk:[.lib]ar*."
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[.lib]cc_temp*."
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[.lib.uniwidth].dirstamp"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[.lib.uniwidth.^.deps].dirstamp"
$if f$search(file) .nes. "" then delete 'file';*
$!
$!
$if p1 .nes. "REALCLEAN" then exit
$!
$!
$file = "sys$disk:[]gnv$conftest.c_first"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[]tar.exe"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[]*.obj"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[]*.lis"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[]vms_configure.sh"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[...]Makefile."
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[...]POTFILES."
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[.po]Makefile.in"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[.tests]atconfig."
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[.tests]atlocal."
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[]config.h"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[]config.log"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[]config.status"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[]config.cache"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[]conftest.dangle"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[]CXX$DEMANGLER_DB."
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[]stamp-h1."
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[.src]tar."
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[.tests.structure]file."
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[.tests.testsuite_dir...]*.*"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[.tests]archive.*"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.tests]orig."
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.tests]*.o"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.tests]done."
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.tests]file1."
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.tests]genfile."
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.tests]testsuite.log"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[.gnu.sys]stat.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu.sys]time.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu.sys]types.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu.selinux]context.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.gnu.selinux]selinux.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.lib.attr]xattr.h"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[...]gnv$first_include.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[...]gnv$tar.opt"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[...CXX_REPOSITORY]CXX$DEMANGLER_DB."
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[...]CXX_REPOSITORY.dir"
$if f$search(file) .nes. "" then set file/prot=o:rwed 'file';*
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[...].dirstamp"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[.lib.vms]*.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.lib]*.a"
$if f$search(file) .nes. "" then delete 'file';*
