## Датотека за прављење пакета за локализацију
########################################################################
## 
## Овај скрипт садржи упутства за:
##
## 1. Увоз датотека за превођење из Мозилиног складишта и конверзију у
##    ПО формат;
## 2. Спајање нових датотека са старим и производњу дограђених
##    датотека са преводима
## 3. Конверзију превода у формат прихватљив за Мозилу
##

include Makefile.inc

.PHONY: all clean pot cleanpot stats  initpo match populate output tryconv copytocvs fixme pofilter pomerge

all: clean tryconv stats 

# Слање измена у Мозилин ЦВС
#publish: clean tryconv copytocvs 
#	( MSG=`cat $(CVS_MSG)` ; \
#	  $(CD) $(MOZILLA_CVS) ; \
#          $(CVS) -z3 commit -m "$$MSG" )

#copytocvs:
#	$(CP) -R $(OUTPUT_DIR)/* $(MOZILLA_CVS)/

# Tests for common mistakes in the translation
pofilter:
	$(POFILTER) $(PO_TRANSLATIONS) $(FAIL_DIR)

pomerge:
	$(POMERGE) -t $(PO_TRANSLATIONS) -i $(FAIL_DIR) -o $(PO_TRANSLATIONS)
	@echo "Do not forget to check what $(POMERGE) has done"
	@echo "In order to prevent screwups"

# Cleanup of all the generated files and dirs
clean:
	$(RM) *~
	$(RM) -fr $(OUTPUT_DIR) $(ZIPNAME)* NEWPO.po NEWPOT.pot messages.mo
	$(RM) -fr $(FAIL_DIR)

# Finds all the FIXME strings in files
fixme:
	$(FIND) $(PO_TRANSLATIONS) -name '*' -a ! -name '*.svn*' | $(XARGS) $(GREP) -n FIXME

# Прављење превода од образаца и ПО датотека
$(OUTPUT_DIR):
	$(MKDIR) -p $(OUTPUT_DIR)
	$(PO2MOZ) -i $(PO_TRANSLATIONS) -o $(OUTPUT_DIR_FINAL) -t $(SOURCE_DIR)
	$(CP) $(PO_TRANSLATIONS)/browser/searchplugins/* $(OUTPUT_DIR_FINAL)/browser/searchplugins
	( cd $(OUTPUT_DIR) ; find -wholename '*.svn' | xargs rm -fr ) 

$(ZIPNAME): $(OUTPUT_DIR)
	( $(CD) $(OUTPUT_DIR) ; $(ZIP)  -r ../$(ZIPNAME) sr )

# Деоба завршне архиве на делове који могу да се поставе у Багзилу (Bugzilla)
split: $(ZIPNAME)
	split -b 290k $(ZIPNAME) $(ZIPNAME)-
	@echo Produced files:
	@ls $(ZIPNAME)-*

# Прављење образаца за пренос.
# SOURCE_DIR = изворни директоријум из Мозиле
# POT_DIR = директоријум у кога се извозе ПОТ датотеке добијене из изворног
pot: cleanpot
	$(MOZ2PO) -i $(SOURCE_DIR) --pot -o $(POT_DIR)

cleanpo: 
	$(MOZ2PO) -i $(SOURCE_DIR)  -o $(PO_TRANSLATIONS)

# На жалост, помиграте не узима у обзир датотеке које нису .по
# А померге се збуњује око неких заглавља.
# Користимо зато ОБА, да бисмо извукли све по датотеке и све помоћне датотеке
mergepo:
	$(POMERGE) --progress=names -x CVS -x .svn -t $(POT_DIR) -i $(PO_SOURCE_DIR) -o $(MERGED_PO_OUTPUT_DIR)
	$(POMIGRATE) $(PO_SOURCE_DIR) $(MERGED_PO_OUTPUT_DIR) $(POT_DIR)

# Чишћење директоријума са обрасцима (ПОТ)
cleanpot:
	@echo "Cleaning the template directory"
	@if [ -a $(POT_DIR) ]; then \
		$(RMDIR) $(POT_DIR);  \
	fi; 

# Прављење новог директоријума 
# ПАЖЊА: Не покретати овај циљ јер ће да пребрише сав превод који смо урадили!
# 
# УБР, чак и ако покренете није страшно јер чувамо и старе верзије
# превода, али не треба правити посао без посла.
initpo:
	. $(SCRIPTS_DIR)/initpo.sh

# Проналази изворне датотеке које одговарају полазној по имену
match:
	. $(SCRIPTS_DIR)/match-files.sh


# Прави први списак датотека, са убаченим преводима
populate:
	. $(SCRIPTS_DIR)/populate-po.sh
	. $(SCRIPTS_DIR)/process-double.sh
	. $(SCRIPTS_DIR)/process-copyonly.sh
	. $(SCRIPTS_DIR)/blind-copy.sh

# Computes file statistics and updates the statistics file
stats:
	. $(SCRIPTS_DIR)/stats.sh &> $(STATS_DIR)/stats.txt
	$(GREP) -i untranslated $(STATS_DIR)/stats.txt &> $(STATS_DIR)/untranslated.txt

check:
	@echo Files in pot/
	@find $(POT_DIR) ! -wholename '*\.svn*' | wc -l
	@echo Files in po/source/
	@find po/source ! -wholename '*\.svn*' | wc -l
	@echo Files in $(PO_TRANSLATIONS)/
	@find $(PO_TRANSLATIONS) ! -wholename '*\.svn*' | wc -l

compare-locales:
	( cd $(MOZILLA_CVS)/.. ; \
	  $(CPLOC)  $(LOCALE_NAME) )

tryconv: $(OUTPUT_DIR)
	@echo "Try the conversion from UTF-8 to CP1251"
	$(ICONV) -f UTF-8 -t CP1251 $(OUTPUT_DIR)/sr/mail/updater/updater.ini > /dev/null
	$(ICONV) -f UTF-8 -t CP1251 $(OUTPUT_DIR)/sr/browser/updater/updater.ini > /dev/null
	$(ICONV) -f UTF-8 -t CP1251 $(OUTPUT_DIR)/sr/mail/installer/override.properties > /dev/null
	$(ICONV) -f UTF-8 -t CP1251 $(OUTPUT_DIR)/sr/browser/installer/override.properties > /dev/null
	$(ICONV) -f UTF-8 -t CP1251 $(OUTPUT_DIR)/sr/mail/installer/mui.properties > /dev/null
	$(ICONV) -f UTF-8 -t CP1251 $(OUTPUT_DIR)/sr/browser/installer/mui.properties > /dev/null
	$(ICONV) -f UTF-8 -t CP1251 $(OUTPUT_DIR)/sr/mail/chrome/messenger/custom.properties > /dev/null
	$(ICONV) -f UTF-8 -t CP1251 $(OUTPUT_DIR)/sr/mail/installer/custom.properties > /dev/null
	$(ICONV) -f UTF-8 -t CP1251 $(OUTPUT_DIR)/sr/browser/installer/custom.properties > /dev/null






