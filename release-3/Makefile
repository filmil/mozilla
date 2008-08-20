## -*- Makefile -*-
########################################################################

include Makefile.inc

.PHONY: all clean pot cleanpot stats  initpo match populate output tryconv copytocvs fixme pofilter pomerge

all: clean tryconv stats 

# Publish the changes to Mozilla's CVS
# Don't forget to make sure that the file $(CVS_MESSAGE) contains the 
# up-to-date message.
publish: clean tryconv copytocvs 
	( MSG=`cat $(CVS_MSG)` ; \
	  $(CD) $(MOZILLA_CVS) ; \
          $(CVS) commit -m "$$MSG" )

copytocvs:
	$(CP) -R $(OUTPUT_DIR)/* $(MOZILLA_CVS)/

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

# Make a translation using the templates and the available PO files.
$(OUTPUT_DIR):
	$(MKDIR) -p $(OUTPUT_DIR)
	$(PO2MOZ) -i $(PO_TRANSLATIONS) -o $(OUTPUT_DIR_FINAL) -t $(SOURCE_DIR)
	$(CP) $(PO_TRANSLATIONS)/browser/searchplugins/* $(OUTPUT_DIR_FINAL)/browser/searchplugins
	( cd $(OUTPUT_DIR) ; find -wholename '*.svn' | xargs rm -fr ) 
	. scripts/patch.sh

$(ZIPNAME): $(OUTPUT_DIR)
	( $(CD) $(OUTPUT_DIR) ; $(ZIP)  -r ../$(ZIPNAME) sr )

# Split the final archive to send to Bugzilla
split: $(ZIPNAME)
	split -b 290k $(ZIPNAME) $(ZIPNAME)-
	@echo Produced files:
	@ls $(ZIPNAME)-*

# Transfer template.
# SOURCE_DIR = the source directory from Mozilla
# POT_DIR = directory to dump the produced POT files to
pot: cleanpot
	$(MOZ2PO) -i $(SOURCE_DIR) --pot -o $(POT_DIR)

cleanpo: 
	$(MOZ2PO) -i $(SOURCE_DIR)  -o $(PO_TRANSLATIONS)

mergepo:
	$(POMERGE) --progress=names -x CVS -x .svn -t $(POT_DIR) -i $(PO_SOURCE_DIR) -o $(MERGED_PO_OUTPUT_DIR)
	$(POMIGRATE) $(PO_SOURCE_DIR) $(MERGED_PO_OUTPUT_DIR) $(POT_DIR)

# Clean the directory with the POT templates
cleanpot:
	@echo "Cleaning the template directory"
	@if [ -a $(POT_DIR) ]; then \
		$(RMDIR) $(POT_DIR);  \
	fi; 

# Make a new PO directory.
# WARNING: Running this goal will overwrite the PO directory.
initpo:
	. $(SCRIPTS_DIR)/initpo.sh

# Finds the source files which match the initial ones by name.
match:
	. $(SCRIPTS_DIR)/match-files.sh

# Populates the script with the already translated files.
populate:
	. $(SCRIPTS_DIR)/populate-po.sh
	. $(SCRIPTS_DIR)/process-double.sh
	. $(SCRIPTS_DIR)/process-copyonly.sh
	. $(SCRIPTS_DIR)/blind-copy.sh

# Computes file statistics and updates the statistics records.
stats:
	. $(SCRIPTS_DIR)/stats.sh &> $(STATS_DIR)/stats.txt
	. $(SCRIPTS_DIR)/untranslated.sh &> $(STATS_DIR)/untranslated.txt
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
	@echo "Trying the conversion from UTF-8 to CP1251"
	$(ICONV) -f UTF-8 -t CP1251 $(OUTPUT_DIR)/sr/browser/updater/updater.ini > /dev/null
	$(ICONV) -f UTF-8 -t CP1251 $(OUTPUT_DIR)/sr/browser/installer/override.properties > /dev/null
	$(ICONV) -f UTF-8 -t CP1251 $(OUTPUT_DIR)/sr/browser/installer/mui.properties > /dev/null
	$(ICONV) -f UTF-8 -t CP1251 $(OUTPUT_DIR)/sr/browser/installer/custom.properties > /dev/null

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

