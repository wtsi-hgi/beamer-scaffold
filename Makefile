# MIT License
# Copyright (c) 2015 Genome Research Limited

PROJECT=myPresentation

MAIN=$(PROJECT).tex
SLIDES=$(wildcard slides/*.tex)
OUTPUT=$(PROJECT).pdf
BUILD=build

PREP=./collate.sh
CC=pdflatex
CCFLAGS=-output-directory=$(BUILD) -jobname=$(PROJECT)

# Build PDF output and open it
all: $(OUTPUT)
	open $^

# PDF output dependant on main and slide .tex sources
# n.b., Main source needs preprocessing to include slide sources
$(OUTPUT): $(MAIN) $(SLIDES)
	mkdir $(BUILD); \
	$(PREP) $(MAIN) | $(CC) $(CCFLAGS) && \
	mv $(BUILD)/$@ .

clean:
	rm -rf $(BUILD)/* && \
	rm $(OUTPUT)

.PHONY: all clean
