# Melange documentation site

This repository contains the source for Melange public documentation site.

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

## Publishing

Run `mkdocs gh-deploy`.
