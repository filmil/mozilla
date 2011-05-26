#! /bin/bash
# Merges the NEWPOT.pot file into a new PO (NEWPO.po)
. `dirname $0`/scripts-config.sh
PODIR=$WORKING_DIR/po/sr
POTDIR=$WORKING_DIR/pot/sr
NONPODIR=$WORKING_DIR/non-po/sr

echo Removing:

echo - $PODIR/$1.po
rm -f $PODIR/$1.po

echo - $POTDIR/$1.pot
rm -f $POTDIR/$1.pot

echo - $NONPODIR/$1
rm -f $NONPODIR/$1

