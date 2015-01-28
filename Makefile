# MIT License
# Copyright (c) 2015 Genome Research Limited

# Project name is the basename of the present working directory
TARGET   ?= $(shell basename $$(pwd))

# Main LaTeX entry point and generated files
MAIN     ?= main.tex
HANDOUTS  = handouts.tex
INDEX     = slideIndex.tex

# Setup dependencies and slides
DEPS      = $(wildcard setup/*.tex)
SLIDES    = find -s slides -type f -name "*.tex" -maxdepth 1

# Working directories and output file
BUILDDIR  = build
OUTDIR    = output
OUTPUT    = $(OUTDIR)/$(TARGET).pdf

# Sed-based preprocessors for slides and handouts, respectively
PPMAIN    = sed "s/.*/\\\input{&}/"
PPHAND    = sed "1s/{/[handout]&/"

# PDFLaTeX Setup
CC        = pdflatex
CFLAGS    = -output-directory=$(BUILDDIR) -jobname=$(TARGET)

RM        = rm -rf

# Build PDF output and open it
all: $(OUTPUT)
	open $^

# PDF output dependant on main, dependencies and slide .tex sources
# n.b., For more than two passes, replicate the $(CC) line appropriately
$(OUTPUT): $(MAIN) $(DEPS) $(INDEX) $(BUILDDIR) $(OUTDIR)
	$(CC) $(CFLAGS) $(MAIN)
	$(CC) $(CFLAGS) $(MAIN)
	mv $(BUILDDIR)/$(shell basename $@) $@

# Preprocess slide sources to create index
$(INDEX): $(shell $(SLIDES))
	$(SLIDES) | $(PPMAIN) > $@

# To create handouts, we tweak main.tex and do a recursive make
handouts: $(HANDOUTS)
	MAIN=$^ TARGET=$(TARGET).handouts make

# Preprocess main.tex to add the 'handout' option to the document class
$(HANDOUTS): $(MAIN)
	$(PPHAND) $^ > $@

$(BUILDDIR):
	mkdir $@

$(OUTDIR):
	mkdir $@

clean:
	$(RM) $(BUILDDIR)
	$(RM) $(OUTDIR)
	$(RM) $(HANDOUTS)
	$(RM) $(INDEX)

.PHONY: all clean handouts
