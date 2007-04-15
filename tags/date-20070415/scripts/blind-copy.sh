#!/bin/bash
## Ископирај све датотеке које не могу аутоматски да се обраде
SOURCE_DIR=source/sr-RS
DEST_DIR=po

. scripts/library.sh

echo "Copying non-processable files"
CMDLINE="find $SOURCE_DIR -name '*.txt' -name '*.xml' -name '*.js' -o -name '*.mk' -o -name '*.aff' -o -name '*.diff -o -name '*.rdf' -o -name '*.dic' -o -name '*.css' -o -name '*.js'"
for g in `$CMDLINE`; do
    echo "Blank copying resource: $g" 
    cp $g $DEST_DIR/$g
done
