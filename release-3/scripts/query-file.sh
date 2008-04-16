#!/bin/sh

DEST_DIR=$1

. scripts/library.sh

echo `find_matching $DEST_DIR $2`
