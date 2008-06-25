#!/bin/bash

. scripts/library.sh

PARAM_STR="1 2"

num_params 1 2
num_params $PARAM_STR
