#!/bin/bash

## Налази одговарајућу датотеку
# $1 -- име кореног директоријума
# $2 -- име датотеке
find_matching() {
    RET=""
    BASE=`basename $2`
    for g in `find $1 -name $BASE`; do
	RET=$RET"$g "
    done
    echo $RET
}

num_params () {
    echo $#
}

make_nonexistent_dir () {
    DIR=`dirname $1`
    echo "Making dir: " $DIR
    mkdir -p $DIR
}
