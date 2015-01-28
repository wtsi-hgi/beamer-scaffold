# MIT License
# Copyright (c) 2015 Genome Research Limited

# Project name is the basename of the present working directory
TARGET?=$(shell basename $$(pwd))

MAIN?=main.tex
HANDOUTS=handouts.tex
DEPS=frontMatter.tex
INDEX=slideIndex.tex
SLIDES=find -s slides -type f -name "*.tex" -maxdepth 1

BUILD=build
OUTPUT=$(TARGET).pdf

PPMAIN=sed "s/.*/\\\input{&}/"
PPHAND=sed "1s/{/[handout]&/"
CC=pdflatex
CFLAGS=-output-directory=$(BUILD) -jobname=$(TARGET)
RM=rm -rf

# Build PDF output and open it
all: $(OUTPUT)
	open $^

# PDF output dependant on main and slide .tex sources
# n.b., For more than two passes, replicate the $(CC) line appropriately
$(OUTPUT): $(MAIN) $(DEPS) $(INDEX) $(BUILD)
	$(CC) $(CFLAGS) $(MAIN)
	$(CC) $(CFLAGS) $(MAIN)
	mv $(BUILD)/$@ .

# Preprocess slide sources to create index
$(INDEX): $(shell $(SLIDES))
	$(SLIDES) | $(PPMAIN) > $@

# To create handouts, we tweak main.tex and do a recursive make
handouts: $(HANDOUTS)
	MAIN=$^ TARGET=$(TARGET).handouts make

# Preprocess main.tex to add the 'handout' option
$(HANDOUTS): $(MAIN)
	$(PPHAND) $^ > $@

$(BUILD):
	mkdir $@

clean:
	$(RM) $(BUILD)
	$(RM) $(HANDOUTS)
	$(RM) $(INDEX)
	$(RM) *.pdf

.PHONY: all clean handouts
