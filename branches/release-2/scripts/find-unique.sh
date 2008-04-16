#!/bin/bash
## Тражи датотеке са јединственим именом

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
	0) NONE=$NONE"$f " ;;
	1) UNIQUE=$UNIQUE"$f " ;;
        *) MORE=$MORE"$f " ;;
    esac
done

echo "None:"
echo $NONE
echo
echo "One:"
echo $UNIQUE
echo
echo "More:"
echo $MORE

