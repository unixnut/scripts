Are you sick of long command lines, or having to change gears in your brain
when switching between projects that use different smooth source control
systems (e.g. Git, Subversion)?

Do you hate the way Git doesn't track files properly, and requires
special options, or an explicit "add" every time, in order to commit
changes to files you've already committed before?  Do you keep
forgetting to pull before committing, to or push afterwards?  Smooth
assumes a collaborative workflow and so does these automatically, but
provides actions that let you skip steps when needed, e.g.
`commit-quick-local`.) It also provides the `stage` action and the `-s`
option for the commit actions, to mimic Git's original behaviour in
cases where it is useful, but only for Git repositories.

Smooth standardises the way source control should work (IMHO) and makes
various actions available using a consistent nomenclature.  This leads
to a less "choppy" workflow and much less typing.  It also allows
actions to be carried out on a work tree without having to change
directory into that work tree.  A single command lets actions be
batch-applied to multiple work trees.

And it provides single-letter aliases for most actions.  (Yes I ended
up using almost the entire alphabet.)  In addition, variants on the
standard actions have their long-form names aliased (usually) to a
short-form name consisting of the initials of the words in the action
name.

| smooth         | Subversion   | git             | Mercurial  | Arch    | darcs |
|----------------|--------------|-----------------|------------|---------|-------|
| `s **i**nit`   | `svn co`     | `git clone`     | `hg clone` | | |
| `s **e**mpty`  | `svnadmin create` | `git init`  | `hg init` | | |
| `s **u**pdate` | `svn update` | `git pull`       | `hg pull -u` | | |
| `s **a**dd`    | `svn add`    | `git add --intent-to-add --all -v`  | `hg add` | | |
| `s sta**g**e`  | N/A          | `git add --all`      | N/A | | |
| `s **gp**` (stage-patch)  | N/A   | `git add --patch --all`  | N/A | | |
| `s **r**emove` | `svn rm`     | `git rm` | `hg remove` | | |
| `s **rf**` (remove-force) | `svn rm --force` | `git rm --force` | `hg remove --force` | | |
| `s **m**ove`   | `svn mv`     | `git mv` | `hg mv` | | |
| `s **w**ho`    | `svn blame`  | `git blame`      | `hg annotate` | | |
| `s **c**ommit` | `svn update ; svn commit` | `git pull ; git commit -a && git push <branch>` (no `-a` if paths given) | `hg pull -u ; hg commit && hg push` | | |
| `s **cq**` (commit-quick) | `svn commit` | `git commit -a && git push <branch>` (no `-a` if paths given) | `hg commit && hg push` | | |
| `s **ca**` (commit-all)   | N/A | `git pull ; git add -A ; git commit` | `hg pull -u ; hg commit --addremove` | | |
| `s **caq**` (commit-all-quick)  | N/A | `git add -A ; git commit` | `hg commit --addremove` | | |
| `s **cl**` (commit-local) | N/A | `git commit -a` (no `-a` if paths given) | `hg pull -u ; hg commit` | | |
| `s **cql**` (commit-quick-local) | N/A  | `git commit -a` (no `-a` if paths given)  | `hg commit` | | |
| `s **q**uery`  | N/A     | `git whatchanged` | `hg outgoing` | | |
| `s **t**ransfer` | N/A | `git push <branch>` | `hg push` | | |
| `s **n**` (new-tag) | N/A | `git_push_tag` | N/A | | |
| `s **nl**` (new-tag-local) | N/A | `git_push_tag -l` | N/A | | |
| `s **d**iff`   | `svn diff`   | `git diff` | `hg diff` | | |
| `s **ds**` (diff-staged) | N/A | `git diff --cached` | N/A | | |
| `s **h**ere`   | `svn info`   | `git_url` | `hg info` | | |
| `s **ss**` (status-short) | `svn status --quiet`  | `git --no-pager diff --name-only` | `hg list` | | |
| `s \[ **s** \]` (status) | `svn status`   | `git status --paginate` | `hg status` | | |
| `s **sl**` (status-long) | `svn status --verbose`   | `git ???` | `hg ???` | | |
| `s **sf**` (status-full) | `svn status --update`   | `git ???` | `hg ???` | | |
| `s **sff**` (status-veryfull) | `svn status -uv` | `git ???` | `hg ???` | | |
| `s **b**` (branch-stat) | N/A  | `git branch -v`      | `hg branches` | | |
| `s **bl**` (branch-stat-long) | N/A  | `git branch -va`      | N/A  | | |
| `s **br**` (branch-stat-remote) | N/A  | `git branch -vr`      | N/A  | | |
| `s **v**isualise`   | `svn ls`     | `git ls-files` | `hg manifest` | | |
| `s **ls**` (log-short) | `svn log --quiet` | `git log --oneline --graph` | `hg log` | | |
| `s **l**og` | `svn log`   | `git log` | `hg log` | | |
| `s **ll**` (log-long)  | `svn log --verbose`   | `git log --stat` | `hg log` | | |
| `s **lf**` (log-full) | N/A   | `git log --patch` | `hg log -p` | | |
| `s **lff**` (log-veryfull) | N/A | `git log --patch --full-diff` | ? | | |
| `s **p**rint-tags`  | N/A | `git show-ref --tags`      | `hg tags` | | |
| `s **od**` (object-dump)  | N/A | `git show`      | `hg ` | | |
| `s **f**orget`   | `svn rm --keep-local`  | `git reset HEAD` | `hg forget` | | |
| `s **fp**` (forget-patch)   | N/A  | `git reset --patch HEAD` | N/A | | |
| `s **j**ump`  | `svn -r`     | `git_smart_jump` | `hg update -r` | | |
| `s **z**` (undo)   | `echo carefully use 'svn revert'`  | `git reset --soft` | `hg rollback` | | |

template: | `s ****`  | `svn `  | `git `      | `hg ` | | |
<br>Unused command shortcuts: `kxy`

Merging and Tagging are deliberately ignored for now.

Thanks to [hg git Rosetta Stone](http://wiki.illumos.org/display/illumos/hg+git+Rosetta+Stone)
