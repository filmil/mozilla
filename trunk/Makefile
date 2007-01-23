## Датотека за прављење важних ствари за локализацију

include Makefile.inc

.PHONY: all clean pot cleanpot stats  initpo match populate

all: stats

# Чишћење генерисаних датотека
clean:
	$(RM) *~
	$(RM) -r $(OUTPUT_DIR)

# Прављење превода од образаца и ПО датотека
trans:
	$(MKDIR) -p $(OUTPUT_DIR)
	$(PO2MOZ) -i $(PO_TRANSLATIONS) -o $(OUTPUT_DIR_FINAL) -t $(SOURCE_DIR)

# Прављење образаца за пренос
pot: cleanpot
	$(MOZ2PO) -i $(SOURCE_DIR) --pot -o $(POT_DIR)

cleanpo: 
	$(MOZ2PO) -i $(SOURCE_DIR)  -o $(PO_TRANSLATIONS)

mergepop:
	$(POMERGE) -t $(POT_DIR) -i po/$(SOURCE_DIR) -o $(PO_TRANSLATIONS)

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

# Рачуна статистике датотека и уписује у статс.тхт
stats:
	. $(SCRIPTS_DIR)/stats.sh &> $(STATS_DIR)/stats.txt

check:
	@echo Files in pot/
	@find $(POT_DIR) ! -wholename '*\.svn*' | wc -l
	@echo Files in po/source/
	@find po/source ! -wholename '*\.svn*' | wc -l
	@echo Files in $(PO_TRANSLATIONS)/
	@find $(PO_TRANSLATIONS) ! -wholename '*\.svn*' | wc -l

