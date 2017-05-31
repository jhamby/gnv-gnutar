$! File configmake_h.com
$!
$! From: http://www.gnu.org/prep/standards/html_node/Directory-Variables.html
$!
$! Copyright 2013, John Malmberg
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
$create [.lib]configmake.h
$DECK
#define PREFIX ""
#define EXEC_PREFIX ""
#define BINDIR "/bin"
#define SBINDIR "/sbin"
#define LIBEXECDIR "/libexec"
#define DATAROOTDIR "/share"
#define DATADIR "/share"
#define SYSCONFDIR "/etc"
#define SHAREDSTATEDIR "/com"
#define LOCALSTATEDIR "/var"
#define INCLUDEDIR "/include"
#define OLDINCLUDEDIR "/usr/include"
#define DOCDIR "/usr/share/doc/coreutils"
#define INFODIR "/usr/share/info"
#define HTMLDIR "/usr/share/doc/coreutils"
#define DVIDIR "/usr/share/doc/coreutils"
#define PDFDIR "/usr/share/doc/coreutils"
#define PSDIR "/usr/share/doc/coreutils"
#define LIBDIR "/lib"
#define LISPDIR "/usr/share/emacs/site-lib"
#define LOCALEDIR "/usr/share/locale"
#define MANDIR "/usr/share/man"
#define MANEXT ".1"
#define PKGDATADIR "/share"
#define PKGINCLUDEDIR "/usr/include"
#define PKGLIBDIR "/lib"
#define PKGLIBEXECDIR "/libexec"
$EOD
