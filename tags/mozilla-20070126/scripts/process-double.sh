#!/bin/bash
## Обради дупле
DICT=dictionary/thunderbird.po
SOURCE_DIR=source/sr-RS
TRANS_DIR=source/locale-ff
DEST_DIR=po/sr-RS

INPUT_LIST=in/multiple.out

. scripts/library.sh

if [ -a $DEST_DIR ] ; then
    echo "Dir $DEST_DIR does not exist. Making it."
    mkdir $DEST_DIR
fi

TMPFILE=`mktemp /tmp/process-double-XXXXXX`

process_double_file () {
    echo src: $1  dest: $2
    moz2po -o $TMPFILE -t $1 -i $2
    make_nonexistent_dir po/$1.po
    msgmerge --compendium=$DICT $TMPFILE $TMPFILE > po/$1.po
}

echo "Processing doubly mentioned files"
cat $INPUT_LIST | while read line ; do
    process_double_file $line
done

rm $TMPFILE
