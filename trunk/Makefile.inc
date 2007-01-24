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


# # Directory configuration
PO_TRANSLATIONS:=po/sr-RS
OUTPUT_DIR:=output
OUTPUT_DIR_FINAL:=$(OUTPUT_DIR)/sr-RS
SOURCE_DIR:=source/sr-RS
POT_DIR:=pot/sr-RS
SCRIPTS_DIR:=scripts
STATS_DIR:=tools/stats
