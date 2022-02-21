scripts
=======

Small, useful platform-agnostic scripts (mostly just for Linux) that don't justify having their own repo

Highlights
----------
* **[clowncar](clowncar)**: This is a wrapper for `useradd` that handles an
  SSH public key.  It can be run in order to create a user immediately, or be
  run in "clowncar factory mode" to create a script that will create the user
  later.  In either case it prompts for a key.
* **[smooth](smooth)**: Unified wrapper for various source control systems.  Assumes
  collaborative workflow.  [Full documentation](doc/s for smooth source control.md)
* **[userlist](userlist)**: Shows columns of useful information about Unix
  users, including account expiry and everything to do with password (when run
  as root).  Has many modes to show extra stuff.

Scripts
-------
* **[_s.sh](_s.sh)**: 
* **[_template.sh](_template.sh)**: 
* **[alias_dups](alias_dups)**: 
* **[archive](archive)**: 
* **[argdemo](argdemo)**: 
* **[argtest](argtest)**: 
* **[aws-host-fingerprints](aws-host-fingerprints)**: Crawls the EC2 instance logs for a hosts's SSH key fingerprints
* **[aws-iterate](aws-iterate)**: 
* **[aws-upload-cert](aws-upload-cert)**: 
* **[aws_create_vpn_sg](aws_create_vpn_sg)**: 
* **[bbracket](bbracket)**: 
* **[c_dump](c_dump)**: 
* **[c_fp](c_fp)**: 
* **[c_fprint](c_fprint)**: 
* **[c_hash](c_hash)**: 
* **[c_info](c_info)**: 
* **[c_issuer](c_issuer)**: 
* **[c_name](c_name)**: 
* **[c_sans](c_sans)**: 
* **[c_sans.py](c_sans.py)**: 
* **[c_verify](c_verify)**: 
* **[clockoff](clockoff)**: 
* **[clockon](clockon)**: 
* **[clowncar](clowncar)**: 
* **[codefold](codefold)**: 
* **[colour_name](colour_name)**: 
* **[colsum](colsum)**: 
* **[commit](commit)**: 
* **[compare_times](compare_times)**: 
* **[config_hierarchy.py](config_hierarchy.py)**: 
* **[crate](crate)**: 
* **[current-song](current-song)**: Scrobbles the currently play song details to STDOUT
* **[d](d)**: 
* **[deidle](deidle)**: 
* **[delsubst](delsubst)**: 
* **[dequote](dequote)**: 
* **[desktop_url](desktop_url)**: 
* **[dir](dir)**: 
* **[dump-crontabs](dump-crontabs)**: 
* **[dups](dups)**: 
* **[e-mail](e-mail)**: 
* **[elm-pager](elm-pager)**: 
* **[elm-pager.awk](elm-pager.awk)**: 
* **[erecover](erecover)**: 
* **[extract_addr](extract_addr)**: 
* **[extract_addr.sed](extract_addr.sed)**: 
* **[extract_alt_text](extract_alt_text)**: 
* **[file-format](file-format)**: Reports line ending type for a group of files
* **[fileinfo](fileinfo)**: Prints time & inode info about a file
* **[find_co](find_co)**: 
* **[find_encrypted](find_encrypted)**: 
* **[find_folders](find_folders)**: 
* **[find_grep](find_grep)**: 
* **[find_swapfiles](find_swapfiles)**: 
* **[find_templates](find_templates)**: 
* **[find_witdocs](find_witdocs)**: 
* **[find_writerdocs](find_writerdocs)**: 
* **[fix_pandoc_html](fix_pandoc_html)**: 
* **[fix_vimfile](fix_vimfile)**: 
* **[flagged_mail](flagged_mail)**: 
* **[foldlines](foldlines)**: 
* **[follow_link](follow_link)**: 
* **[gcal_view](gcal_view)**: 
* **[get](get)**: 
* **[getiso](getiso)**: 
* **[git_add_me](git_add_me)**: 
* **[grok_mail_folder](grok_mail_folder)**: 
* **[help](help)**: 
* **[hex](hex)**: 
* **[hostrename](hostrename)**: Portable host rename tool
* **[html_title](html_title)**: 
* **[html_unescape.sed](html_unescape.sed)**: 
* **[idate](idate)**: 
* **[ifaddr](ifaddr)**: 
* **[includes](includes)**: 
* **[installbuilddeps](installbuilddeps)**: 
* **[ipe2txt.xsl](ipe2txt.xsl)**: 
* **[isobackup](isobackup)**: 
* **[k_dump](k_dump)**: 
* **[k_pubkey](k_pubkey)**: 
* **[libmozrecent.xsl](libmozrecent.xsl)**: 
* **[list_dotfiles](list_dotfiles)**: 
* **[load_monitor](load_monitor)**: 
* **[logconsole](logconsole)**: 
* **[lspam](lspam)**: 
* **[mailman_arcdump](mailman_arcdump)**: 
* **[mailopen](mailopen)**: 
* **[makehtml](makehtml)**: 
* **[markdown2pdf](markdown2pdf)**: 
* **[md2pdf](md2pdf)**: 
* **[microseconds](microseconds)**: 
* **[migrateuser](migrateuser)**: 
* **[milliseconds](milliseconds)**: 
* **[minicombine](minicombine)**: Produces an all-of-the-above blob from variant versions of text files
* **[minidiff](minidiff)**: Produces Git-style output from variant versions of text files
* **[minimerge](minimerge)**: Produces Git-style output from variant versions of text files
* **[mk_ssh_access](mk_ssh_access)**: 
* **[mkhtml](mkhtml)**: 
* **[mklist](mklist)**: 
* **[mkto](mkto)**: 
* **[moz_bookmarks](moz_bookmarks)**: Shows Mozilla bookmarks within a menu
* **[moz_export](moz_export)**: Makes a Mozilla importable .html file from a given bookmark folder
* **[moz_find](moz_find)**: Free-text search on bookmark names or URLs
* **[moz_menus](moz_menus)**: Shows all Mozilla menus
* **[mozrecent_orphans.xsl](mozrecent_orphans.xsl)**: 
* **[mozrecent_saved.xsl](mozrecent_saved.xsl)**: 
* **[mprint](mprint)**: 
* **[mutt_compose_editor](mutt_compose_editor)**: 
* **[mygrep](mygrep)**: 
* **[myip](myip)**: 
* **[myip4](myip4)**: 
* **[myip6](myip6)**: 
* **[mymeminfo](mymeminfo)**: 
* **[myxconsole](myxconsole)**: 
* **[nanoseconds](nanoseconds)**: 
* **[newpkgs](newpkgs)**: 
* **[normdate](normdate)**: 
* **[nsgrep](nsgrep)**: 
* **[oprint](oprint)**: 
* **[pathdequote](pathdequote)**: 
* **[pem-foreach](pem-foreach)**: 
* **[perl_test.cgi](perl_test.cgi)**: 
* **[pfq](pfq)**: 
* **[pgp_verify](pgp_verify)**: 
* **[ps_bytime](ps_bytime)**: 
* **[pvim](pvim)**: 
* **[quoteshrink](quoteshrink)**: 
* **[quotewrap](quotewrap)**: 
* **[r_dump](r_dump)**: 
* **[r_name](r_name)**: 
* **[rdiff](rdiff)**: 
* **[reactivate](reactivate)**: 
* **[recover_swapfiles](recover_swapfiles)**: 
* **[remove-runapp-entry](remove-runapp-entry)**: 
* **[renfiles](renfiles)**: 
* **[replace-file-fragments](replace-file-fragments)**: 
* **[rindex.awk](rindex.awk)**: 
* **[ripname](ripname)**: 
* **[rms_triple](rms_triple)**: 
* **[rnethack](rnethack)**: 
* **[rotate](rotate)**: 
* **[ruby_wrapper](ruby_wrapper)**: 
* **[run-without-xscreensaver](run-without-xscreensaver)**: 
* **[s](s)**: 
* **[s_dump_http](s_dump_http)**: 
* **[s_dump_imap](s_dump_imap)**: 
* **[s_dump_imaps](s_dump_imaps)**: 
* **[s_dump_smtp](s_dump_smtp)**: 
* **[s_verify_http](s_verify_http)**: 
* **[s_verify_imap](s_verify_imap)**: 
* **[s_verify_imaps](s_verify_imaps)**: 
* **[s_verify_smtp](s_verify_smtp)**: 
* **[save_archives](save_archives)**: 
* **[script_interp_versions](script_interp_versions)**: 
* **[seconds](seconds)**: 
* **[show-users](show-users)**: 
* **[show_moz_dl](show_moz_dl)**: 
* **[showcn](showcn)**: 
* **[sizedelta](sizedelta)**: 
* **[sm_attach_total](sm_attach_total)**: 
* **[sm_restore](sm_restore)**: 
* **[sm_save](sm_save)**: 
* **[smooth](smooth)**: 
* **[snackdemo](snackdemo)**: 
* **[sort_addr](sort_addr)**: 
* **[spamfwd](spamfwd)**: 
* **[spell](spell)**: 
* **[splitlist](splitlist)**: 
* **[ssh_fp](ssh_fp)**: 
* **[ssh_fprint](ssh_fprint)**: Show all host key fingerprints & ASCII art
* **[stripcomments](stripcomments)**: 
* **[tfm](tfm)**: 
* **[timestamp](timestamp)**: 
* **[to-do](to-do)**: 
* **[total](total)**: 
* **[uconv](uconv)**: 
* **[unwrap](unwrap)**: 
* **[update](update)**: 
* **[update_index](update_index)**: 
* **[urldequote](urldequote)**: 
* **[vbd_dl](vbd_dl)**: 
* **[vcf2del](vcf2del)**: 
* **[vcf2list](vcf2list)**: 
* **[vcfimport](vcfimport)**: 
* **[vcftweak](vcftweak)**: 
* **[vless](vless)**: 
* **[wcal](wcal)**: 
* **[wrap](wrap)**: 
* **[x](x)**: 
* **[xsudo](xsudo)**: 
* **[xwintitle](xwintitle)**: 
* **[zonedate](zonedate)**: Prints a DNS zone file timestamp
