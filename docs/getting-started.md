# Getting started

Get up and running with Melange in no time!

---

## Install opam

In order to work with Melange, you will have to install
[opam](https://opam.ocaml.org/), a source-based package manager for OCaml.
Instructions to install opam for the different operating systems can be found at
https://opam.ocaml.org/doc/Install.html.

## Template

A sample Melange project with basic functionality can be found on [this GitHub
repository](https://github.com/melange-re/melange-opam-template).

Follow the
[readme](https://github.com/melange-re/melange-opam-template/blob/main/README.md)
instructions to configure the [local opam
switch](https://opam.ocaml.org/blog/opam-local-switches/) and download the
required dependencies to build the project.

## Editor integration

Melange has plugins for many editors, but the most actively maintained are for
Visual Studio Code, Emacs, and Vim.

For Visual Studio Code, install the [OCaml Platform Visual Studio Code
extension](https://marketplace.visualstudio.com/items?itemName=ocamllabs.ocaml-platform)
from the Visual Studio Marketplace.

Upon first loading an OCaml source file, you may be prompted to select the
toolchain in use. Pick the version of OCaml you are using, e.g., 4.14.1 from the
list. Further instructions about configuration can be found on the [extension
repository](https://github.com/ocamllabs/vscode-ocaml-platform#setting-up-the-extension-for-your-project).

For Emacs and Vim, the configuration might vary depending on the case, and there
are a few options available. You can read about them in the [editor setup
page](http://ocamlverse.net/content/editor_setup.html) of the OCamlverse
documentation site.

## Alternative package managers (experimental)

The recommended setup for Melange projects is with opam. However, Melange can
also be used with other package managers: [esy](https://esy.sh/) and
[Nix](https://github.com/NixOS/nix).

A [Melange project template for
esy](https://github.com/melange-re/melange-esy-template) is also available, in a
similar spirit of the Melange opam template mentioned above.
