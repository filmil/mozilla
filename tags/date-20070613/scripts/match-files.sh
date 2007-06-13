#!/bin/bash
## Тражи датотеке у старом преводу Фајерфокса које одговарају новим
## датотекама и исписује. 

SOURCE_DIR=$1
DEST_DIR=$2

. scripts/library.sh

for f in `find $SOURCE_DIR -type f -name '*' ! -wholename '*.svn*'`; do
    echo -n "$f: "
    echo `find_matching $DEST_DIR $f`
done