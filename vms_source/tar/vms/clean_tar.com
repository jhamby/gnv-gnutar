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
$file = "sys$disk:[.lib.uniwidth]*.o"
$if f$search(file) .nes. "" then delete 'file';*
$!
$file = "sys$disk:[.lib]alloca.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.lib]configmake.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.lib]dirent.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.lib]fcntl.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.lib]fnmatch.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.lib]inttypes.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.lib]rmt-command.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.lib]stdio.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.lib]stdint.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.lib]stdlib.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.lib]string.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.lib]sysexits.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.lib]time.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.lib]unistd.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.lib]charset.alias"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.lib]*.sed"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.lib.sys]stat.h"
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
$!
$file = "sys$disk:[.lib.vms]*.h"
$if f$search(file) .nes. "" then delete 'file';*
$file = "sys$disk:[.lib]*.a"
$if f$search(file) .nes. "" then delete 'file';*
