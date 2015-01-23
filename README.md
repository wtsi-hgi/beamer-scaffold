# Beamer Presentation Scaffold

A *really* simple scaffold for Beamer presentations, including a `make`
based build system.

* The main point of entry is `main.tex`. In here, it's intended that you
  set up the presentation title page.
  
* Slides must be `.tex` files within the `slides` directory. They are
  collated automatically by the build system in lexicographical order,
  by filename.

* To build the PDF output, just run `make` in the project root
  directory. The final output, presuming it all worked out, will end up
  here and be opened with `open`.

Note that the PDF will be named `myPresentation.pdf`. If you want a
different filename, set the `PROJECT` environment variable to the `make`
command. For example:

```sh
PROJECT=foobar make
```

# License

[MIT License](LICENSE)

Copyright (c) 2015 Genome Research Limited
