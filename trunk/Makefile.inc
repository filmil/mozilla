# -*- Makefile -*-
MOZ2PO:=moz2po --progress=names
PO2MOZ:=po2moz --progress=names
POMERGE:=pomerge --progress=names
MSGMERGE:=msgmerge
RM:=rm -f
RMDIR:=rm -fr
MKDIR:=mkdir
CD:=cd
CP:=cp
ZIP:=zip
CVS:=cvs
POMIGRATE:=pomigrate2
ICONV:=iconv
GREP:=grep
FIND:=find
XARGS:=xargs
POFILTER:=pofilter -t unchanged

# # Directory configuration
LOCALE_NAME:=sr
ROOT_DIR:=/home/filip/personal/l10n/work/mozilla/trunk
PO_TRANSLATIONS:=po/sr
MOZILLA_CVS:=/home/filip/personal/l10n/mozilla-cvs/3/l10n
OUTPUT_DIR:=output
OUTPUT_DIR_FINAL:=$(OUTPUT_DIR)/sr
MERGED_PO_OUTPUT_DIR:=$(OUTPUT_DIR)/sr
SOURCE_DIR:=$(MOZILLA_CVS)/../template/en-US
PO_SOURCE_DIR:=po/sr
POT_DIR:=pot/sr
SCRIPTS_DIR:=scripts
STATS_DIR:=tools/stats
ZIPNAME:=sr.zip
CVS_MSG:=./CVS_MESSAGE
CPLOC:=compare-locales
FAIL_DIR:=fail-po

