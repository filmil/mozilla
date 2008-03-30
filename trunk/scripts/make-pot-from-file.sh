#! /bin/bash 
#
# Gets a file name, and makes a POT file in the working directory.
# The first argument is the full file name relative to the base
# directory of the l10n tree.
TEMPLATE_LOC=~/personal/l10n/mozilla-cvs/3/template/en-US
SOURCE_FILE=$1
OUT_FILE=NEWPOT.pot
SOURCE=$TEMPLATE_LOC/$SOURCE_FILE

moz2po --input $SOURCE --pot -o $OUT_FILE
echo "Wrote $OUT_FILE"



