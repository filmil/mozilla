# -*- Makefile -*-
MOZ2PO:=moz2po
PO2MOZ:=po2moz
POMERGE:=pomerge
MSGMERGE:=msgmerge
RM:=rm -f
RMDIR:=rm -fr
MKDIR:=mkdir
CD:=cd
CP:=rsync
ZIP:=zip
# Use Mercurial for version control
CVS:=hg
POMIGRATE:=pomigrate2
ICONV:=iconv
GREP:=grep
FIND:=find
XARGS:=xargs
POFILTER:=pofilter -t unchanged
CPLOC:=compare-locales

# # Directory configuration
LOCALE_NAME:=sr
L10N_BASE_DIR:=/home/filip/personal/l10n/mozilla/ff-3.2
OUTPUT_DIR:=output
MERGE_DIR:=merge
SCRIPTS_DIR:=scripts
PO_TRANSLATIONS:=po/$(LOCALE_NAME)
MOZILLA_SOURCE_DIR:=$(L10N_BASE_DIR)/comm-central
MOZILLA_BROWSER_L10N_INI:=$(MOZILLA_SOURCE_DIR)/mozilla/browser/locales/l10n.ini
TEMPLATE_SYMLINKS_DIR:=$(L10N_BASE_DIR)/template-symlinks
TEMPLATE_DIR:=$(L10N_BASE_DIR)/template
MOZILLA_CVS:=$(L10N_BASE_DIR)/l10n
OUTPUT_DIR_FINAL:=$(OUTPUT_DIR)/$(LOCALE_NAME)
MERGED_PO_OUTPUT_DIR:=$(MERGE_DIR)/$(LOCALE_NAME)
SOURCE_DIR:=$(TEMPLATE_DIR)/en-US
PO_SOURCE_DIR:=po/$(LOCALE_NAME)
POT_DIR:=pot/$(LOCALE_NAME)
STATS_DIR:=tools/stats
ZIPNAME:=$(LOCALE_NAME).zip

# The file that contains the commit message
COMMIT_MESSAGE_FILE:=./COMMIT_MESSAGE
FAIL_DIR:=fail-po

# The directory where non-po files are stored
NONPO_DIR:=non-po/$(LOCALE_NAME)
