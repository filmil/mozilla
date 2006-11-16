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
