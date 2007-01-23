## Датотека за прављење важних ствари за локализацију

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
#
.PHONY: all clean pot cleanpot stats stats initpo match populate

all: stats

# Чишћење генерисаних датотека
clean:
	$(RM) *~
	$(RM) -r output

# Прављење превода од образаца и ПО датотека
trans:
	$(MKDIR) -p output
	$(PO2MOZ) -i po/sr-RS -o output/sr-RS -t source/sr-RS

# Прављење образаца за пренос
pot: cleanpot
	$(MOZ2PO) -i source/sr-RS --pot -o pot/sr-RS

cleanpo: 
	$(MOZ2PO) -i source/sr-RS  -o po/sr-RS

mergepop:
	$(POMERGE) -t pot/sr-RS -i po/source/sr-RS -o po/sr-RS

# Чишћење директоријума са обрасцима (ПОТ)
cleanpot:
	@echo "Cleaning the template directory"
	@if [ -a pot/sr-RS ]; then \
		$(RMDIR) pot/sr-RS;  \
	fi; 

# Прављење новог директоријума 
# ПАЖЊА: Не покретати овај циљ јер ће да пребрише сав превод који смо урадили!
# 
# УБР, чак и ако покренете није страшно јер чувамо и старе верзије
# превода, али не треба правити посао без посла.
initpo:
	. scripts/initpo.sh

# Проналази изворне датотеке које одговарају полазној по имену
match:
	. scripts/match-files.sh


# Прави први списак датотека, са убаченим преводима
populate:
	. scripts/populate-po.sh
	. scripts/process-double.sh
	. scripts/process-copyonly.sh
	. scripts/blind-copy.sh

# Рачуна статистике датотека и уписује у статс.тхт
stats:
	. scripts/stats.sh &> stats/stats.txt

check:
	@echo Files in pot/
	@find pot/sr-RS ! -wholename '*\.svn*' | wc -l
	@echo Files in po/source/
	@find po/source ! -wholename '*\.svn*' | wc -l
	@echo Files in po/sr-RS/
	@find po/sr-RS ! -wholename '*\.svn*' | wc -l

