# Getting started

<p class="centered">Get up and running with Melange in no time!</p>

---

## Install opam

To work with Melange, you need to install [opam](https://opam.ocaml.org/), a
source-based package manager for OCaml. Instructions for installing opam on
different operating systems can be found at the opam [install
page](https://opam.ocaml.org/doc/Install.html).

## Template

The easiest way to get started with Melange is by using the
[melange-opam-template](https://github.com/melange-re/melange-opam-template).
Follow the instructions in the [readme
file](https://github.com/melange-re/melange-opam-template/blob/main/README.md)
to configure the [local opam
switch](https://opam.ocaml.org/blog/opam-local-switches/) and download the
necessary dependencies to build the project.

## Editor integration

Melange has plugins for many editors, but the most actively maintained are for
Visual Studio Code, Emacs, and Vim.

For Visual Studio Code, install the [OCaml Platform Visual Studio Code
extension](https://marketplace.visualstudio.com/items?itemName=ocamllabs.ocaml-platform)
from the Visual Studio Marketplace. When you load an OCaml source file for the
first time, you may be prompted to select the toolchain in use. Select the
version of OCaml you are using from the list, such as 4.14.1. Further
instructions for configuration can be found in the [extension
repository](https://github.com/ocamllabs/vscode-ocaml-platform#setting-up-the-extension-for-your-project).

For Emacs and Vim, the configuration may vary depending on the case, and there
are several options available. You can read about them in the [editor setup
page](http://ocamlverse.net/content/editor_setup.html) of the OCamlverse
documentation site.

## Alternative package managers (experimental)

Although the recommended setup for Melange projects is with opam, Melange can
also be used with other package managers, such as [esy](https://esy.sh/) and
[Nix](https://github.com/NixOS/nix). There is also a [Melange project template
for esy](https://github.com/melange-re/melange-esy-template) available, similar
in spirit to the Melange opam template mentioned above.
