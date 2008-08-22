## -*- Makefile -*-
########################################################################

include Makefile.inc

.PHONY: all clean pot cleanpot stats initpo
.PHONY: match populate output tryconv copytocvs 
.PHONY: fixme pofilter mergeback

all: clean tryconv stats 

# Publish the changes to Mozilla's CVS
# Don't forget to make sure that the file $(CVS_MESSAGE) contains the 
# up-to-date message.
publish: clean tryconv copytocvs 
	( MSG=`cat $(CVS_MSG)` ; \
	  $(CD) $(MOZILLA_CVS) ; \
          $(CVS) commit -m "$$MSG" )

# Copies the processed translation files to the output directory for
# sending to Mozilla
copytocvs:
	$(CP) -R $(OUTPUT_DIR)/* $(MOZILLA_CVS)/

# Tests for common mistakes in the translations.
pofilter:
	$(POFILTER) $(PO_TRANSLATIONS) $(FAIL_DIR)

# Fetches the differences produced by various pofilter applications
# and merges them back into the PO files.
mergeback:
	$(POMERGE) -t $(PO_TRANSLATIONS) -i $(FAIL_DIR) -o $(PO_TRANSLATIONS)
	@echo "Do not forget to check what $(POMERGE) has done"
	@echo "In order to prevent screwups"

# Cleanup of all the generated files and dirs
clean:
	$(RM) *~
	$(RM) -fr $(OUTPUT_DIR) $(ZIPNAME)* NEWPO.po NEWPOT.pot messages.mo
	$(RM) -fr $(FAIL_DIR)

# Finds all the FIXME strings
fixme:
	$(FIND) $(PO_TRANSLATIONS) -name \
            '*' -a ! -name '*.svn*' | \
	    $(XARGS) $(GREP) -n FIXME

# Make a translation using the templates and the available PO files.
$(OUTPUT_DIR):
	$(MKDIR) -p $(OUTPUT_DIR)
	$(PO2MOZ) -i $(PO_TRANSLATIONS) -o $(OUTPUT_DIR_FINAL) -t $(SOURCE_DIR)
	$(CP) $(PO_TRANSLATIONS)/browser/searchplugins/* \
	      $(OUTPUT_DIR_FINAL)/browser/searchplugins
	( cd $(OUTPUT_DIR) ; find -wholename '*.svn' | xargs rm -fr ) 
	. scripts/patch.sh

# Transfer template.
# SOURCE_DIR = the source directory from Mozilla
# POT_DIR = directory to dump the produced POT files to
pot: 
	$(MOZ2PO) -i $(SOURCE_DIR) --pot -o $(POT_DIR)

# Merges old translations with newly generated POT files
mergepo: pot
	$(POMERGE) --progress=names -x CVS -x .svn -t $(POT_DIR) \
	           -i $(PO_SOURCE_DIR) -o $(MERGED_PO_OUTPUT_DIR)
	$(POMIGRATE) $(PO_SOURCE_DIR) $(MERGED_PO_OUTPUT_DIR) $(POT_DIR)

# Clean the directory with the POT templates
cleanpot:
	@echo "Cleaning the template directory"
	@if [ -a $(POT_DIR) ]; then \
		$(RMDIR) $(POT_DIR);  \
	fi; 

# Computes file statistics and updates the statistics records.
stats:
	. $(SCRIPTS_DIR)/stats.sh &> $(STATS_DIR)/stats.txt
	. $(SCRIPTS_DIR)/untranslated.sh &> $(STATS_DIR)/untranslated.txt

# Checks the current locale agains the original en-US locale
compare-locales:
	( cd $(MOZILLA_CVS)/.. ; \
	  $(CPLOC)  $(LOCALE_NAME) )

tryconv: $(OUTPUT_DIR)
	@echo "Trying the conversion from UTF-8 to CP1251"
	$(ICONV) -f UTF-8 -t CP1251 \
            $(OUTPUT_DIR)/sr/browser/updater/updater.ini > /dev/null
	$(ICONV) -f UTF-8 -t CP1251 \
            $(OUTPUT_DIR)/sr/browser/installer/override.properties > /dev/null
	$(ICONV) -f UTF-8 -t CP1251 \
            $(OUTPUT_DIR)/sr/browser/installer/mui.properties > /dev/null
	$(ICONV) -f UTF-8 -t CP1251 \
            $(OUTPUT_DIR)/sr/browser/installer/custom.properties > /dev/null

# Use the Mozilla's source dir to make a template directory.
template-symlinks:
	. scripts/make-locale-links.sh \
		$(MOZILLA_SOURCE_DIR) \
		$(TEMPLATE_SYMLINKS_DIR)

# From the symlinked template directory, make a final template dir.
# This dir will be used as the for the templates.
template: template-symlinks
	. scripts/copy-locale-followsymlinks.sh \
		$(TEMPLATE_SYMLINKS_DIR) \
		$(TEMPLATE_DIR)

