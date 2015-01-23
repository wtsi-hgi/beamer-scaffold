#!/bin/sh

# MIT License
# Copyright (c) 2015 Genome Research Limited

SLIDES=$(find -s slides -type f -name "*.tex" -maxdepth 1)
TEX=""

# Create LaTeX to import slide files from directory
for SLIDE in $SLIDES; do
  if [ -n "$TEX" ]; then
    TEX="$TEX\\
  "
  fi
  TEX="$TEX\\\\input{$SLIDE}"
done

# Substitute %%SLIDE%% for slide imports
cat $1 | sed "s+%%SLIDES%%+$TEX+"
