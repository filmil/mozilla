#! /bin/bash
echo "Initializing the translation directory from POT and compendium"
if [ -a po/sr-RS ]; then 
	rm -fr po/sr-RS; 
fi; 
cd pot
COMPENDIUM=--compendium=../dictionary/thunderbird.po
for a in `find -name *.pot`; do 
    FNAME=`basename $a`
    OUTFILE=../po/`echo $a | sed -e s/\.pot/\.po/`
    DIR=../po/`echo $a | sed -e s/$FNAME//`
    mkdir -p $DIR
    echo "Making $OUTFILE"
    msgmerge -v $COMPENDIUM $a $a > $OUTFILE
done
