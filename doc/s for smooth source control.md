Are you sick of long command lines, or having to change gears in your brain
when switching between projects that use different smooth source control
systems (e.g. Git, Subversion)?

| smooth         | Subversion   | git             | Mercurial  | Arch    | darcs |
| `s **i**nit`   | `svn co`     | `git clone`     | `hg clone` | | |
| `s **e**mpty`  | `svnadmin create` | `git init`  | `hg init` | | |
| `s **u**pdate` | `svn update` | `git pull`       | `hg pull -u` | | |
| `s **a**dd` (track) | `svn add`    | N/A              | `hg add` | | |
| `s **r**emove`   | `svn rm`     | `git rm` | `hg remove` | | |
| `s **m**ove`   | `svn mv`     | `git mv` | `hg mv` | | |
| `s **w**ho`  | `svn blame`  | `git blame`      | `hg annotate` | | |
| `s **c**ommit` | `svn commit` | `git commit -a && git push <branch>` (no `-a` if paths given) | `hg commit && hg push` | | |
| `s **cl**` (commit-local) | N/A | `git commit -a` (no `-a` if paths given) | `hg commit` | | |
| `s **q**uery`  | N/A     | `git whatchanged` | `hg outgoing` | | |
| `s **t**ransfer` | N/A | `git push <branch>` | `hg push` | | |
| `s **d**iff`   | `svn diff`   | `git diff` | `hg diff` | | |
| `s **dp**` (diff-pending) | N/A | `git diff --cached` | N/A | | |
| `s **ss**` (status-short) | `svn status --quiet`  | `git diff --name-only` | `hg list` | | |
| `s \[ **s** \]` (status) | `svn status`   | `git status` | `hg status` | | |
| `s **sl**` (status-long) | `svn status --verbose`   | `git ???` | `hg ???` | | |
| `s **sf**` (status-full) | `svn status --update`   | `git ???` | `hg ???` | | |
| `s **sff**` (status-veryfull) | `svn status -uv` | `git ???` | `hg ???` | | |
| `s **v**isualise`   | `svn ???`     | `git ls-files` | `hg manifest` | | |
| `s **ls**` (log-short) | `svn log --quiet` | `git log --oneline --graph` | `hg log` | | |
| `s **l**og` | `svn log`   | `git log` | `hg log` | | |
| `s **ll**` (log-long)  | `svn log --verbose`   | `git log --stat` | `hg log` | | |
| `s **lf**` (log-full) | N/A   | `git log --patch` | `hg log -p` | | |
| `s **lff**` (log-veryfull) | N/A | `git log --patch --full-diff` | ? | | |
| `s **f**orget`   | `svn ???`  | `git reset` | `hg forget` | | |
| `s **j**ump`  | `svn -r`     | `git checkout` | `hg update -r` | | |
| `s **z**` (undo)   | `svn ???`     | `git reset --soft` | `hg rollback` | | |

template: | `s ****`  | `svn `  | `git `      | `hg ` | | |
Unused command shortcuts: `bghknopxy`

Merging and Tagging are deliberately ignored for mow.

Thanks to [hg git Rosetta Stone](http://wiki.illumos.org/display/illumos/hg+git+Rosetta+Stone)
