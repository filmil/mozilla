#!/bin/bash

for a in `find po -name '*.po'`; do
    OUTPUT=`msgfmt --statistics  -o /dev/null $a`
    echo "$a: $OUTPUT"
done
