# Melange documentation site

This repository contains the source for Melange public documentation site.

If you are looking for Melange source instead, it can be found in
https://github.com/melange-re/melange.

> **Warning** At the moment, this is a **work in progress**, opened to the
> public. The content and technology used to build the website are being
> developed and the website itself is not hosted yet on its final domain.

## Working locally

After cloning the repository, install:
- [mkdocs](https://www.mkdocs.org/getting-started/)
- Install the [print site
  plugin](https://github.com/timvink/mkdocs-print-site-plugin): `pip3 install
  mkdocs-print-site-plugin`

Then run `mkdocs serve .` from the folder where the repository lives.

### (Optional) Tooling for docs generation

Optionally, to run some of the tools to auto-generate parts of the
documentation, you will need an opam switch with the required dependencies. To
set it up, run:

```
make init
```

## Writing code snippets

All code snippets should be written in OCaml syntax. A development-time script
is available to automatically generate Reason syntax snippets from the OCaml
ones. Before runnning this script, you will need to set up an opam switch.
Instructions can be found in the ["Tooling for docs
generation"](#optional-tooling-for-docs-generation) section.

To run the script:

```
dune build @re
```

To promote any changes to the original `md` file, one can run:

```
dune build @re --auto-promote
```

## Publishing

Publishing is done automatically from `master`. To publish manually, run `mkdocs
gh-deploy`.
