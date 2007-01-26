#!/bin/bash
## Тражи датотеке са не-јединственим именом

SOURCE_DIR=$1
DEST_DIR=$2

. scripts/library.sh

UNIQUE=""
NONE=""
MORE=""

for f in `find $SOURCE_DIR ! -wholename '*.svn*' -type f -name '*'`; do
    MATCH=`find_matching $DEST_DIR $f`
    NUMPARA=`num_params $MATCH`
    
    case $NUMPARA in
	0) ;;
	1) ;;
        *) echo "$f $MATCH" ;;
    esac
done


