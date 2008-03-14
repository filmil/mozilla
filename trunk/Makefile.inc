# -*- Makefile -*-
## Дефиниције програма које користимо
#  Програми за претварање Мозилиних датотека у ПО датотеке и обратно
MOZ2PO:=moz2po
PO2MOZ:=po2moz
POMERGE:=pomerge
MSGMERGE:=msgmerge
#  Брисање датотека
RM:=rm -f
RMDIR:=rm -fr
MKDIR:=mkdir
CD:=cd
CP:=cp
ZIP:=zip
CVS:=cvs
POMIGRATE=pomigrate2

# # Directory configuration
LOCALE_NAME:=sr
ROOT_DIR:=/home/filip/personal/l10n/work/mozilla/trunk
PO_TRANSLATIONS:=po/sr-RS
MOZILLA_CVS:=/home/filip/personal/l10n/mozilla-cvs/3/l10n
OUTPUT_DIR:=output
OUTPUT_DIR_FINAL:=$(OUTPUT_DIR)/sr
MERGED_PO_OUTPUT_DIR:=$(OUTPUT_DIR)/sr-RS
SOURCE_DIR:=$(MOZILLA_CVS)/../template/en-US
PO_SOURCE_DIR:=po/sr-RS
POT_DIR:=pot/sr
SCRIPTS_DIR:=scripts
STATS_DIR:=tools/stats
ZIPNAME:=sr.zip
CVS_MSG:=./CVS_MESSAGE
CPLOC:=compare-locales