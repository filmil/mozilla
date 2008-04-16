#!/bin/bash
## Обрађује датотеке које само треба да буду ископиране
DICT=dictionary/thunderbird.po
SOURCE_DIR=source/sr-RS
TRANS_DIR=source/locale-ff
DEST_DIR=po/sr-RS

INPUT_LIST=in/copyonly.out

. scripts/library.sh

if [ -a $DEST_DIR ] ; then
    echo "Dir $DEST_DIR does not exist. Making it."
    mkdir $DEST_DIR
fi

TMPFILE=`mktemp /tmp/process-copyonly-XXXXXX`

process_copy_only () {
    echo src: $1
    moz2po -o $TMPFILE -i $1
    make_nonexistent_dir po/$1.po
    msgmerge --compendium=$DICT $TMPFILE $TMPFILE > po/$1.po
}

echo "Processing copy only files"
cat $INPUT_LIST | while read line ; do
    process_copy_only $line
done

rm $TMPFILE
