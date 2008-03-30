#! /bin/bash
# Merges the NEWPOT.pot file into a new PO (NEWPO.po)
TEMPLATE_LOC=~/personal/l10n/mozilla-cvs/3/template/en-US
TEMPLATE_PO=~/personal/l10n/work/mozilla/trunk/po/sr
TEMPLATE_POT=~/personal/l10n/work/mozilla/trunk/pot/sr

IN_POT=NEWPOT.pot
IN_PO=NEWPO.po

OUT_PO=$TEMPLATE_PO/$1.po
OUT_POT=$TEMPLATE_POT/$1.pot

cp $IN_POT $OUT_POT
echo "Copying $IN_POT -> $OUT_POT"
cp $IN_PO $OUT_PO
echo "Copying $IN_PO -> $OUT_PO"
echo "Removing $IN_PO, $IN_POT"
rm $IN_PO $IN_POT


