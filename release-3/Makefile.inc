# -*- Makefile -*-
MOZ2PO:=moz2po --progress=names
PO2MOZ:=po2moz --progress=names
POMERGE:=pomerge --progress=names --errorlevel=traceback
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
L10N_BASE_DIR:=/home/filip/personal/l10n/mozilla/all-3.0.x
PO_TRANSLATIONS:=po/$(LOCALE_NAME)
MOZILLA_SOURCE_DIR:=$(L10N_BASE_DIR)/mozilla
TEMPLATE_SYMLINKS_DIR:=$(L10N_BASE_DIR)/template-symlinks
TEMPLATE_DIR:=$(L10N_BASE_DIR)/template
MOZILLA_CVS:=$(L10N_BASE_DIR)/l10n
OUTPUT_DIR:=output
OUTPUT_DIR_FINAL:=$(OUTPUT_DIR)/$(LOCALE_NAME)
MERGED_PO_OUTPUT_DIR:=$(OUTPUT_DIR)/$(LOCALE_NAME)
SOURCE_DIR:=$(TEMPLATE_DIR)/en-US
PO_SOURCE_DIR:=po/$(LOCALE_NAME)
POT_DIR:=pot/$(LOCALE_NAME)
SCRIPTS_DIR:=scripts
STATS_DIR:=tools/stats
ZIPNAME:=$(LOCALE_NAME).zip
CVS_MSG:=./CVS_MESSAGE
CPLOC:=compare-locales
FAIL_DIR:=fail-po

