# Beamer Presentation Scaffold

A *really* simple scaffold for Beamer presentations, including a `make`
based build system.

* The main point of entry for your presentation is `main.tex`. However,
  you shouldn't have to mess with this.

* Your presentation's title page set up (title, author, etc.) is defined
  in `setup/frontMatter.tex`: Edit this appropriately.

* If you have any addition preamble requirements -- packages, commands,
  whatever -- they can be defined in `setup/preamble.tex`.
  
* Slides must be `.tex` files within the `slides` directory. They are
  collated automatically by the build system in lexicographical order,
  by filename.

* A BibTeX reference database is defined in `setup/references.bib` and
  a reference slide (`setup/referencesSlide.tex`) is automatically
  inserted at the end of the presentation: Tweak these as you see fit.
  If you don't make any citations, probably best to comment all this out
  to stop the compilation passes from complaining!

* To build the PDF output, just run `make` in the project root
  directory. The final output, presuming it all worked out, will end up
  in the `output` directory and be opened with `open`. (If `open` is not
  available on your platform, set the `OPEN` environment variable to
  `make`.)

* To build PDF handouts (i.e., the slides in their final state, without
  transitions), run `make handouts`. The final output will end up in the
  `output` directory, with `handouts` appended to the filename.

Note that the PDF will have the same name as the basename of the present
working directory, affixed with `.pdf`. If you want a different
filename, set the `TARGET` environment variable to the `make` command.
For example:

```sh
TARGET=foobar make
```

`make` will do several compilation passes: LaTeX, BibTeX, then two more
LaTeX. This is usually enough to generate the desired output, but should
you need to alter this, these are basically hardcoded into the output
rule, so you can change it there. (This could probably be done a lot
better, but this way is much easier!)

## `slide` Environment

A new environment is defined which creates a new frame with a title
under a subsubsection of the same name. The purpose of this is to
correctly generate the breadcrumbs used by the Beamer theme.

For example:

```latex
\begin{slide}[My Slide]
  Hello, World!
\end{slide}
```

# License

[MIT License](LICENSE)

Copyright (c) 2015 Genome Research Limited
