# MIT License
# Copyright (c) 2015 Genome Research Limited

# Project name is the basename of the present working directory
TARGET   ?= $(shell basename $$(pwd))

# Working directories and output file
BUILDDIR  = build
OUTDIR    = output
OUTPUT    = $(OUTDIR)/$(TARGET).pdf

# Main LaTeX entry point and generated files
MAIN     ?= main.tex
HANDOUTS  = handouts.tex
INDEX     = slideIndex.tex
AUXFILE   = $(BUILDDIR)/$(TARGET).aux

# Setup dependencies and slides
DEPS      = $(wildcard setup/*.tex) setup/references.bib
SLIDES    = find -s slides -type f -name "*.tex" -maxdepth 1

# Sed-based preprocessors for slides and handouts, respectively
PPMAIN    = sed "s/.*/\\\input{&}/"
PPHAND    = sed "1s/{/[handout]&/"

# PDFLaTeX and BibTeX Setup
CC        = pdflatex
CFLAGS    = -output-directory=$(BUILDDIR) -jobname=$(TARGET)
RC        = bibtex

OPEN     ?= open
RM        = rm -rf

# Build PDF output and open it
all: $(OUTPUT)
	$(OPEN) $^

# PDF output dependant on main, dependencies and slide .tex sources
# n.b., Adjust the passes as required
$(OUTPUT): $(MAIN) $(DEPS) $(INDEX) $(BUILDDIR) $(OUTDIR)
	$(CC) $(CFLAGS) $(MAIN)
	$(RC) $(AUXFILE)
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
