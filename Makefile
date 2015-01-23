# MIT License
# Copyright (c) 2015 Genome Research Limited

# Project name is the basename of the present working directory
PROJECT?=$(shell basename $$(pwd))

MAIN=main.tex
INDEX=slideIndex.tex
SLIDES=find -s slides -type f -name "*.tex" -maxdepth 1

BUILD=build
OUTPUT=$(PROJECT).pdf

PP=sed "s/.*/\\\input{&}/"
CC=pdflatex
CCFLAGS=-output-directory=$(BUILD) -jobname=$(PROJECT)

# Build PDF output and open it
all: $(OUTPUT)
	open $^

# PDF output dependant on main and slide .tex sources
# n.b., For multiple passes, replicate the $(CC) line appropriately
$(OUTPUT): $(MAIN) $(INDEX) $(BUILD)
	$(CC) $(CCFLAGS) $(MAIN) && \
	mv $(BUILD)/$@ .

# Preprocess slide sources to create index
$(INDEX): $(shell $(SLIDES))
	$(SLIDES) | $(PP) > $@

$(BUILD):
	mkdir $@

clean:
	rm -rf $(BUILD)
	rm -f $(INDEX)
	rm -f $(OUTPUT)

.PHONY: all clean
