SHELL = /bin/bash

# Specify the .qmd files
QMD_FILES = $(wildcard *.qmd)

# Specify the targets
HTML_FILES = $(QMD_FILES:.qmd=.html)

# Default target (render all .qmd files)
all: $(HTML_FILES)

# Rule to render all .qmd files
%.html: %.qmd
	quarto render $<

# Rule to render a specific .qmd file or preview it
snowball: snowball.html

snowball.html: snowball.qmd
	quarto render snowball.qmd

preview: snowball.html
	quarto serve snowball.qmd

# Rule to clean
## Rule to clean the data directory
clean-data:
	rm -rf data/*

## Rule to clean the figures directory
clean-figures:
	rm -rf figures/*

## Rule to clean the HTML files
clean-html:
	rm -f $(HTML_FILES)

## General clean rule
clean: clean-data clean-figures clean-html


############# Help targets #############

list_variables:
	@echo
	@echo "#############################################"
	@echo "## Variables ################################"
	@$(MAKE) -pn | grep -A1 "^# makefile"| grep -v "^#\|^--" | sort | uniq
	@echo "#############################################"
	@echo ""

## from https://stackoverflow.com/a/26339924/632423
help:
	@echo
	@echo "#############################################"
	@echo "## Make Targets #############################"
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'
	@echo "#############################################"
	@echo

