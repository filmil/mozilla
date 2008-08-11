#!/bin/bash
# Copies a directory recursivelly, following the symlinks along the way.
# I.e. copying actual files instead of symlinks.
#
# Usage:
#    copy-locale-followsymlinks.sh source_dir destination_dir
#
# $1 source_dir
# $2 destination_dir
mkdir -p $2
cp -RL $1/* $2
