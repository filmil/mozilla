#!/bin/bash
#
# Makes a list of untranslated messages
STATS_DIR=tools/stats
echo "Making a list of untranslated files..."
grep -i untranslated $STATS_DIR/stats.txt 
