#!/bin/bash

for a in `find po -name '*.po'`; do
    OUTPUT=`msgfmt --statistics  -o /dev/null $a 2>&1 `
    echo -e "$a:\n\t$OUTPUT"
done
