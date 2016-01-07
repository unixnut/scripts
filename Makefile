PREFIX=/usr/local
USER_SCRIPTS=aws-host-fingerprints find_swapfiles seconds milliseconds \
  microseconds nanoseconds pem-foreach pgp_verify showcn fileinfo file-format \
  smooth _s.sh
# ... TO-DO: mkhtml or makehtml
ADMIN_SCRIPTS=clowncar zonedate userlist hostrename reactivate

.PHONY: update install install_user install_admin install_doc
update:
	git pull

install: install_user install_admin install_doc

install_user: $(PREFIX)/bin $(USER_SCRIPTS:%=$(PREFIX)/bin/%)

install_admin: $(PREFIX)/sbin $(ADMIN_SCRIPTS:%=$(PREFIX)/sbin/%)

install_doc: $(PREFIX)/share/doc/smooth $(PREFIX)/share/doc/smooth/README.md \
 $(PREFIX)/share/doc/userlist $(PREFIX)/share/doc/userlist/README.md

$(PREFIX)/bin $(PREFIX)/sbin:
	install -d $@

$(PREFIX)/share/doc/smooth/README.md: doc/s\ for\ smooth\ source\ control.md
	install -p -m 644 '$^' '$@'

$(PREFIX)/share/doc/smooth:
	install -d -p $@

$(PREFIX)/share/doc/userlist/README.md: doc/userlist.md
	install -p -m 644 '$^' '$@'

$(PREFIX)/share/doc/userlist:
	install -d -p $@

# -- implicit rules --
$(PREFIX)/bin/%: %
	install -p '$<' '$@'

$(PREFIX)/sbin/%: %
	install -p '$<' '$@'

# -- extra requirements --
$(PREFIX)/bin/smooth: $(PREFIX)/bin/_s.sh

# Install requirements for certain files
# TO-DO: move to $(PREFIX)/lib
$(PREFIX)/bin/_s.sh: _s.sh
	install -p -m 644 '$^' '$@'

# Generate requirements needed above
# TO-DO: allow for highlighted letter in the middle of an action
_s.sh: doc/s\ for\ smooth\ source\ control.md
	(sed -n -e 's/^| `s \*\*\([^*]*\)\*\*\([^` (]*\)` *| *`\(svn[^`]*\).*/r_svn[\1\2]="\3"\nr_svn[\1]="\3"/p' \
	       -e 's/^| `s \*\*\([^*]*\)\*\*` (\([^)]*\)) *| *`\(svn[^`]*\).*/r_svn[\1]="\3"\nr_svn[\2]="\3"/p' \
	   '$^' ; \
	 sed -n -e 's/^| `s \*\*\([^*]*\)\*\*\([^` (]*\)` *|[^|]*| *`\(git[^`]*\).*/r_git[\1\2]="\3"\nr_git[\1]="\3"/p' \
	       -e 's/^| `s \*\*\([^*]*\)\*\*` (\([^)]*\)) *|[^|]*| *`\(git[^`]*\).*/r_git[\1]="\3"\nr_git[\2]="\3"/p' \
	   '$^') | \
	  sed -e '/???/d' > $@
