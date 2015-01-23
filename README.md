# Beamer Presentation Scaffold

A *really* simple scaffold for Beamer presentations, including a `make`
based build system.

* The main point of entry is `myPresentation.tex`. In here, it's
  intended that you set up the presentation title page. You *can* change
  the name of this file, which affects the project/job name; if you do
  this, you *must* reflect the changes to the `PROJECT` variable in the
  `Makefile`. (It would probably be a good idea to update the
  `.gitignore`, too.)

* Slides must be `.tex` files within the `slides` directory. They are
  collated automatically by the build system in lexicographical order,
  by filename.

* To build the PDF output, just run `make` in the project root
  directory. The final output, presuming it all worked out, will end up
  here and be opened with `open`.

# License

[MIT License](LICENSE)

Copyright (c) 2015 Genome Research Limited
