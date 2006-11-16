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

if [ -a $DEST_DIR ] ; then
    echo "Dir $DEST_DIR does not exist. Making it."
    mkdir $DEST_DIR
fi

TMPFILE=`mktemp /tmp/populate-po-XXXXXX`

make_nonexistent_dir () {
    DIR=`dirname $1`
    echo "Making dir: " $DIR
    mkdir -p $DIR
}

for f in `find $SOURCE_DIR ! -name '*.css' ! -name '*.dic' ! -name '*.rdf' ! -wholename '*.svn*' -type f -name '*'`; do
    MATCH=`find_matching $TRANS_DIR $f`
    NUMPARA=`num_params $MATCH`
    
    case $NUMPARA in
	0) echo "Copying $f to $DEST_DIR/$f.po"
	    moz2po -o $TMPFILE -i $f
	    make_nonexistent_dir po/$f.po
	    msgmerge --compendium=$DICT $TMPFILE $TMPFILE > po/$f.po
	    ;;
	1) echo "Merging $f with: $MATCH"
	    moz2po -o $TMPFILE -t $f -i $MATCH
	    make_nonexistent_dir po/$f.po
	    msgmerge --compendium=$DICT $TMPFILE $TMPFILE > po/$f.po
	    ;;
	2) echo "Skipping: $f"
    esac
done

CMDLINE="find $SOURCE_DIR -name '*.rdf' -o -name '*.dic' -o -name '*.css' -o -name '*.js'"
for g in `$CMDLINE`; do
    echo "Blank copying resource: $g" 
    cp $g $SRC_DIR/$g
done

rm $TMPFILE