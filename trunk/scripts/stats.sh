#!/bin/bash

for a in `find po -name '*.po'`; do
    msgfmt -v -c $a
done
