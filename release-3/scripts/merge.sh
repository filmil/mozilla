#! /bin/bash
# Merges the NEWPOT.pot file into a new PO (NEWPO.po)
. `dirname $0`/scripts-config.sh
TEMPLATE_PO=$WORKING_DIR/po/sr

IN_POT=NEWPOT.pot
IN_PO=$TEMPLATE_PO/$1.po
OUT_PO=NEWPO.po

pomerge -i $IN_PO -t $IN_POT -o $OUT_PO
echo "Wrote $OUT_PO"
msgfmt --statistics -v $OUT_PO
