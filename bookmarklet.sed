#! /bin/sed -f
# bookmarklet.sed (Sed script) -- Convert JavaScript into a bookmarklet

# Delete comments and indents
s@[[:space:]]*//.*@@
s/^[[:space:]]\+//

# Always (even the first line) append to the hold space, so it starts with a newline
H

# Skip to the next line and don't print, unless it's the last line
$ !d

# -- Last line processing --
g
# Strip out Webpack app variable (`var` not supported at top level in bookmarklets)
s/^\(\n\)var [_[:alnum:]]\+;/\1/

s/^\n/javascript:/
# Add a semicolon
s/[^;]$/&; /

# -- Line joining --
# Ensure content from adjacent lines are space-separated
s/\n/ /g

# -- Cleanup --
# Scrub spaces etc.
## s/[[:space:]]\+/%20/g
s/[[:space:]]\+/ /g
s/"/%22/g
s/;%20/;/g

# Scrub multi-line comments
s@/\*[^/]*\*/@@g
