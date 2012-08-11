#!/bin/sh
# This script can be used to implement syntax highlighting in the cgit
# tree-view by refering to this file with the source-filter or repo.source-
# filter options in cgitrc.
#
# This script requires a shell supporting the ${var##pattern} syntax.
# It is supported by at least dash and bash, however busybox environments
# might have to use an external call to sed instead.
#
# Note: the highlight command (http://www.andre-simon.de/) uses css for syntax
# highlighting, so you'll probably want something like the following included
# in your css file (generated by highlight 2.4.8 and adapted for cgit):
#
# table.blob .num  { color:#2928ff; }
# table.blob .esc  { color:#ff00ff; }
# table.blob .str  { color:#ff0000; }
# table.blob .dstr { color:#818100; }
# table.blob .slc  { color:#838183; font-style:italic; }
# table.blob .com  { color:#838183; font-style:italic; }
# table.blob .dir  { color:#008200; }
# table.blob .sym  { color:#000000; }
# table.blob .kwa  { color:#000000; font-weight:bold; }
# table.blob .kwb  { color:#830000; }
# table.blob .kwc  { color:#000000; font-weight:bold; }
# table.blob .kwd  { color:#010181; }
#
# The following environment variables can be used to retrieve the configuration
# of the repository for which this script is called:
# CGIT_REPO_URL        ( = repo.url       setting )
# CGIT_REPO_NAME       ( = repo.name      setting )
# CGIT_REPO_PATH       ( = repo.path      setting )
# CGIT_REPO_OWNER      ( = repo.owner     setting )
# CGIT_REPO_DEFBRANCH  ( = repo.defbranch setting )
# CGIT_REPO_SECTION    ( = section        setting )
# CGIT_REPO_CLONE_URL  ( = repo.clone-url setting )
#

# store filename and extension in local vars
BASENAME="$1"
EXTENSION="${BASENAME##*.}"

# map Makefile and Makefile.* to .mk
[ "${BASENAME%%.*}" = "Makefile" ] && EXTENSION=mk

exec highlight --force -f -I -S $EXTENSION 2>/dev/null
