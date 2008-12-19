## -*- Makefile -*-
########################################################################

include Makefile.inc

.PHONY: all clean pot clean_pot stats initpo
.PHONY: match populate output normalize_convert_codepage copy_to_hg 
.PHONY: find_fixme check_pofilter merge_pofilter commit accept_merge

all: clean normalize_convert_codepage stats 

# Updates the hg repository of the mozilla source code
update_hg:
	( cd $(MOZILLA_SOURCE_DIR) ; \
	  python client.py checkout )

# Use the Mozilla's source dir to make a template directory.
template-symlinks: update_hg
	. scripts/make-locale-links.sh \
		$(MOZILLA_SOURCE_DIR) \
		$(TEMPLATE_SYMLINKS_DIR)

# From the symlinked template directory, make a final template dir.
# This dir will be used as the for the templates.
template: template-symlinks
	. scripts/copy-locale-followsymlinks.sh \
		$(TEMPLATE_SYMLINKS_DIR) \
		$(TEMPLATE_DIR)

# Transfer template.
# SOURCE_DIR = the source directory from Mozilla
# POT_DIR = directory to dump the produced POT files to
pot: template
	@echo "Making the template directory"
	$(MOZ2PO) -i $(SOURCE_DIR) --pot -o $(POT_DIR)
	@echo "Removing non-POT files from the template directory"
	( cd $(POT_DIR) ; 					\
	  find -name '*' -type f | grep -v pot | xargs rm -f; 	\
	  find -name '*html.pot' -type f | xargs rm -f )

# Merges old translations with newly generated POT files
merge_po: pot
	mkdir -p $(MERGED_PO_OUTPUT_DIR)
	$(POMERGE) 				\
	    -t $(POT_DIR) 			\
	    -i $(PO_SOURCE_DIR) 		\
	    -o $(MERGED_PO_OUTPUT_DIR)
	(  cd $(POT_DIR); \
	   for a in `find . -type f -name '*.pot'`; do \
		POTFILE_DIRNAME=`dirname $$a` ;              \
		POTFILE_BASENAME=`basename $$a .pot` ;       \
		POFILE_DIRNAME=../../$(MERGED_PO_OUTPUT_DIR)/$$POTFILE_DIRNAME ; \
		mkdir -p $$POFILE_DIRNAME ; \
		POFILE_NAME=$$POFILE_DIRNAME/$$POTFILE_BASENAME.po ; \
		if [ ! -f $$POFILE_NAME ]; then \
			echo copy: $$a to $$POFILE_NAME ; \
			cp $$a $$POFILE_NAME ;   \
		fi; 				 \
	  done; )

# Accepts the merge results
accept_merge:
	$(CP) -r --delete $(MERGED_PO_OUTPUT_DIR)/ $(PO_SOURCE_DIR)/

# Tests for common mistakes in the translations.
check_pofilter:
	$(POFILTER) $(PO_TRANSLATIONS) $(FAIL_DIR)
	@echo "Files with problems:"
	find $(FAIL_DIR) -name '*.po'

# Merge the files produced with check_pofilter into the mainline PO files
merge_pofilter:
	$(POMERGE) -t $(PO_TRANSLATIONS) -i $(FAIL_DIR) -o $(PO_TRANSLATIONS)
	@echo "Do not forget to check what $(POMERGE) has done"
	@echo "In order to prevent screwups"

# Make a translation using the templates and the available PO files.
$(OUTPUT_DIR):
	$(MKDIR) -p $(OUTPUT_DIR)
	$(MKDIR) -p $(OUTPUT_DIR_FINAL)
	$(PO2MOZ) -i $(PO_TRANSLATIONS) -o $(OUTPUT_DIR_FINAL) -t $(SOURCE_DIR)
	$(CP) -r $(NONPO_DIR)/ $(OUTPUT_DIR_FINAL)/
	. scripts/patch.sh

# Pushes the changes out to the HG repository but does not commit
copy_to_hg: $(OUTPUT_DIR)
	$(CP) -r -f 'Pp .hg' --exclude='*~' --delete  \
		$(OUTPUT_DIR_FINAL)/ $(MOZILLA_CVS)/$(LOCALE_NAME)/

commit: clean normalize_convert_codepage copy_to_hg
	( test -f $(COMMIT_MESSAGE_FILE) \
               || ( echo "No $(COMMIT_MESSAGE_FILE)" ; exit 1) ; \
	MSG=`cat $(COMMIT_MESSAGE_FILE)` ; \
	( $(CD) $(MOZILLA_CVS)/sr ; \
        $(CVS) commit -A -m "$$MSG" ) )
	$(RM) $(COMMIT_MESSAGE_FILE)

# Clean the directory with the POT templates
clean_pot:
	@echo "Cleaning the template directory"
	@if [ -a $(POT_DIR) ]; then 		\
		$(RMDIR) $(POT_DIR);  		\
	fi; 

# Computes file statistics and updates the statistics records.
stats:
	LC_ALL=en_US . $(SCRIPTS_DIR)/stats.sh &> $(STATS_DIR)/stats.txt
	LC_ALL=en_US . $(SCRIPTS_DIR)/untranslated.sh &> $(STATS_DIR)/untranslated.txt

# Checks the current locale agains the original en-US locale
compare_locales: copy_to_hg
	@echo "Comparing locales"
	( cd $(MOZILLA_CVS)/.. ; \
	  $(CPLOC) $(MOZILLA_BROWSER_L10N_INI) $(MOZILLA_CVS) $(LOCALE_NAME) )

# Converts the pages from UTF-8 to CP1251 where appropriate
normalize_convert_codepage: $(OUTPUT_DIR)
	@echo "Trying the conversion from UTF-8 to CP1251"
	$(ICONV) -f UTF-8 -t CP1251 \
            $(OUTPUT_DIR)/sr/browser/updater/updater.ini > /dev/null
	$(ICONV) -f UTF-8 -t CP1251 \
            $(OUTPUT_DIR)/sr/browser/installer/override.properties > /dev/null
	$(ICONV) -f UTF-8 -t CP1251 \
            $(OUTPUT_DIR)/sr/browser/installer/mui.properties > /dev/null
	$(ICONV) -f UTF-8 -t CP1251 \
            $(OUTPUT_DIR)/sr/browser/installer/custom.properties > /dev/null

# Finds all the FIXME strings
find_fixme:
	$(FIND) $(PO_TRANSLATIONS) -name \
            '*' -a ! -name '*.svn*' | \
	    $(XARGS) $(GREP) -n FIXME

# Cleanup of all the generated files and dirs
clean:
	$(RM) *~
	$(RM) -fr $(OUTPUT_DIR) $(ZIPNAME)* NEWPO.po NEWPOT.pot messages.mo
	$(RM) -fr $(FAIL_DIR) $(MERGE_DIR)
