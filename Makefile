PREFIX=/usr/local
USER_SCRIPTS=aws-host-fingerprints find_swapfiles seconds milliseconds \
  microseconds nanoseconds pem-foreach pgp_verify showcn fileinfo file-format \
  smooth _s.sh ssh_fprint \
  c_dump c_fprint c_hash c_info c_issuer c_name c_sans.py c_verify \
  k_dump k_pubkey r_dump r_name \
  s_dump_http s_dump_imap s_dump_imaps s_dump_pop3 s_dump_pop3s s_dump_smtp s_dump_smtps s_dump_ldap s_dump_ldaps \
  s_verify_http s_verify_imap s_verify_imaps s_verify_pop3 s_verify_pop3s s_verify_smtp s_verify_smtps s_verify_ldap s_verify_ldaps \
  psff urlresolve

USER_SCRIPT_LINKS=c_fp c_sans
# ... TO-DO: mkhtml or makehtml
ADMIN_SCRIPTS=clowncar zonedate userlist hostrename reactivate

.PHONY: update install install_user install_admin install_doc
update:
	git pull

install: install_user install_admin install_doc

install_user: $(PREFIX)/bin $(USER_SCRIPTS:%=$(PREFIX)/bin/%) $(USER_SCRIPT_LINKS:%=$(PREFIX)/bin/%)

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

# -- explicit rules to override implicit rules for certain targets --
$(PREFIX)/bin/c_fp:
	ln -s --force c_fprint $(PREFIX)/bin/c_fp

$(PREFIX)/bin/c_sans:
	ln -s --force c_sans.py $(PREFIX)/bin/c_sans

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
	   '$^' ; \
	 sed -n -e 's/^| `s \*\*\([^*]*\)\*\*\([^` (]*\)` *|.*| *`\(hg[^`]*\).*/r_hg[\1\2]="\3"\nr_hg[\1]="\3"/p' \
	        -e 's/^| `s \*\*\([^*]*\)\*\*` (\([^)]*\)) *|.*| *`\(hg[^`]*\).*/r_hg[\1]="\3"\nr_hg[\2]="\3"/p' \
	   '$^') | \
	 sed -e '/???/d' > $@
