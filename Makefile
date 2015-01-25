# MIT License
# Copyright (c) 2015 Genome Research Limited

# Project name is the basename of the present working directory
TARGET?=$(shell basename $$(pwd))

MAIN=main.tex
INDEX=slideIndex.tex
SLIDES=find -s slides -type f -name "*.tex" -maxdepth 1

BUILD=build
OUTPUT=$(TARGET).pdf

PP=sed "s/.*/\\\input{&}/"
CC=pdflatex
CFLAGS=-output-directory=$(BUILD) -jobname=$(TARGET)
RM=rm -rf

# Build PDF output and open it
all: $(OUTPUT)
	open $^

# PDF output dependant on main and slide .tex sources
# n.b., For more than two passes, replicate the $(CC) line appropriately
$(OUTPUT): $(MAIN) $(INDEX) $(BUILD)
	$(CC) $(CFLAGS) $(MAIN)
	$(CC) $(CFLAGS) $(MAIN)
	mv $(BUILD)/$@ .

# Preprocess slide sources to create index
$(INDEX): $(shell $(SLIDES))
	$(SLIDES) | $(PP) > $@

$(BUILD):
	mkdir $@

clean:
	$(RM) $(BUILD)
	$(RM) $(INDEX)
	$(RM) $(OUTPUT)

.PHONY: all clean
