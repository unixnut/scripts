PREFIX=/usr/local
USER_SCRIPTS=aws-host-fingerprints find_swapfiles seconds milliseconds \
  microseconds nanoseconds pem-foreach pgp_verify showcn \
  smooth _s.sh
# ... TO-DO: mkhtml or makehtml
ADMIN_SCRIPTS=clowncar zonedate

.PHONY: install install_user install_admin install_doc
install: install_user install_admin install_doc

install_user: $(PREFIX)/bin $(USER_SCRIPTS:%=$(PREFIX)/bin/%)

install_admin: $(PREFIX)/sbin $(ADMIN_SCRIPTS:%=$(PREFIX)/sbin/%)

install_doc: $(PREFIX)/share/doc/smooth $(PREFIX)/share/doc/smooth/smooth.md \
 $(PREFIX)/share/doc/userlist $(PREFIX)/share/doc/userlist/userlist.md

$(PREFIX)/bin/_s.sh: _s.sh
	install -p -m 644 '$^' '$@'

$(PREFIX)/bin $(PREFIX)/sbin:
	install -d $@

$(PREFIX)/share/doc/smooth/smooth.md: doc/s\ for\ smooth\ source\ control.md
	install -p -m 644 '$^' '$@'

$(PREFIX)/share/doc/smooth:
	install -d -p $@

$(PREFIX)/share/doc/userlist/userlist.md: doc/userlist.md
	install -p -m 644 '$^' '$@'

$(PREFIX)/share/doc/userlist:
	install -d -p $@

$(PREFIX)/bin/%: %
	install -p '$<' '$@'

$(PREFIX)/sbin/%: %
	install -p '$<' '$@'

_s.sh: doc/s\ for\ smooth\ source\ control.md
	(sed -n -e 's/^| `s \*\*\([^*]*\)\*\*\([^` (]*\)` *| *`\(svn[^`]*\).*/r_svn[\1\2]="\3"\nr_svn[\1]="\3"/p' \
	       -e 's/^| `s \*\*\([^*]*\)\*\*` (\([^)]*\)) *| *`\(svn[^`]*\).*/r_svn[\1]="\3"\nr_svn[\2]="\3"/p' \
	   '$^' ; \
	 sed -n -e 's/^| `s \*\*\([^*]*\)\*\*\([^` (]*\)` *|[^|]*| *`\(git[^`]*\).*/r_git[\1\2]="\3"\nr_git[\1]="\3"/p' \
	       -e 's/^| `s \*\*\([^*]*\)\*\*` (\([^)]*\)) *|[^|]*| *`\(git[^`]*\).*/r_git[\1]="\3"\nr_git[\2]="\3"/p' \
	   '$^') | \
	  sed -e '/???/d' -e 's/\(\[[a-z]*\)-/\1_/' > $@
