#!/bin/bash
##  Увози преводе!

# Почиње од свих датотека у изворном директоријуму. 
# За сваку проба да нађе одговарајућу датотеку у преводу фајерфокса
# Ако не нађе, датотека се само пребацује у ПО и копира на одговарајуће место.
# Ако нађе, датотека се спаја са постојећим преводом и копира.
# У оба случајева се користи и Громоптицин речник. 

DICT=dictionary/thunderbird.po

SOURCE_DIR=source/sr-RS
TRANS_DIR=source/locale-ff

DEST_DIR=po/sr-RS

. scripts/library.sh

if [ -a $DEST_DIR ] ;
    echo "Dir $DEST_DIR does not exist. Making it."
    mkdir $DEST_DIR
fi

TMPFILE=`mktemp /tmp/populate-po-XXXXXX`

for f in `find $SOURCE_DIR ! -wholename '*.svn*' -type f -name '*'`; do
    MATCH=`find_matching $TRANS_DIR $f`
    NUMPARA=`num_params $MATCH`
    
    case $NUMPARA in
	0) echo "Copying $f to $DEST_DIR/$f.po"
	    moz2po -o $TMPFILE -i $f
	    msgmerge --compendium=$DICT $TMPFILE $TMPFILE > $DEST_DIR/$f.po
	    ;;
	1) echo "Merging $f with: $TRANS_DIR/$MATCH"
	    moz2po -o $TMPFILE -t $SRC_DIR/$f -i $TRANS_DIR/$MATCH
	    msgmerge --compendium=$DICT $TMPFILE $TMPFILE > $DEST_DIR/$f.po
	    ;;
	2) echo "Skipping: $f"
    esac
done

rm $TMPFILE