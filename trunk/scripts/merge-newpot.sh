#! /bin/bash
# Merges the NEWPOT.pot file into a new PO (NEWPO.po)
TEMPLATE_LOC=~/personal/l10n/mozilla-cvs/3/template/en-US
TEMPLATE_PO=~/personal/l10n/work/mozilla/trunk/po/sr

IN_POT=NEWPOT.pot
IN_PO=$TEMPLATE_PO/$1.po
OUT_PO=NEWPO.po

pomerge -i $IN_PO -t $IN_POT -o $OUT_PO
echo "Wrote $OUT_PO"
msgfmt --statistics -v $OUT_PO
