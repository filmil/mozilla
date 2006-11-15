## Датотека за прављење важних ствари за локализацију

## Дефиниције програма које користимо
#  Програми за претварање Мозилиних датотека у ПО датотеке и обратно
MOZ2PO:=moz2po
PO2MOZ:=po2moz

#  Брисање датотека
RM:=rm -f
RMDIR:=rm -fr

#
.PHONY: clean pot cleanpot

# Чишћење генерисаних датотека
clean:
	$(RM) *~

# Прављење образаца за пренос
pot: cleanpot
	$(MOZ2PO) -i source/sr-RS --pot -o pot/sr-RS

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
	@echo "Initializing the translation directory"
	@if [ -a po/sr-RS ]; then \
		$(RMDIR) po/sr-RS; \
	fi
	$(MOZ2PO) -i source/sr-RS -o po/sr-RS
