# Getting started

<p class="centered">Get up and running with Melange in no time!</p>

---

## Install a package manager

To work with Melange, you need to install a package manager compatible with
OCaml. If you are not sure which one to use, we recommend
[opam](https://opam.ocaml.org/), a source-based package manager for OCaml, but
there are [other alternatives](#alternative-package-managers-experimental)
available.

Instructions for installing opam on different operating systems can be found at
the opam [install page](https://opam.ocaml.org/doc/Install.html), and you can
find [a whole section about it](./learn#package-management) on this website.

## Template

The easiest way to get started with Melange is by using the
[melange-opam-template](https://github.com/melange-re/melange-opam-template).
You can clone it from [this
link](https://github.com/melange-re/melange-opam-template/generate), and follow
the instructions in the [readme
file](https://github.com/melange-re/melange-opam-template/blob/main/README.md)
to configure the [local opam
switch](https://opam.ocaml.org/blog/opam-local-switches/) and download the
necessary dependencies to build the project.

## Editor integration

One of the goals of Melange is to remain compatible with OCaml. One of the major
benefits of this compatibility is that developers working on Melange projects
can use the same editor tooling as they would for OCaml.

OCaml developer tooling has been built, tested, and refined over the years, with
plugins available for many editors. The most actively maintained plugins are for
Visual Studio Code, Emacs, and Vim.

For Visual Studio Code, install the [OCaml Platform Visual Studio Code
extension](https://marketplace.visualstudio.com/items?itemName=ocamllabs.ocaml-platform)
from the Visual Studio Marketplace. When you load an OCaml source file for the
first time, you may be prompted to select the toolchain to use. Select the
version of OCaml you are using from the list, such as 4.14.1. Further
instructions for configuration can be found in the [extension
repository](https://github.com/ocamllabs/vscode-ocaml-platform#setting-up-the-extension-for-your-project).

For Emacs and Vim, the configuration may vary depending on the case, and there
are several options available. You can read about them in the [editor setup
page](http://ocamlverse.net/content/editor_setup.html) of the OCamlverse
documentation site.

> **_NOTE:_** Melange editor integration currently only works with 4.14.x, even
> though it can compile melange projects on other OCaml switches.

## Alternative package managers (experimental)

Although the recommended setup for Melange projects is with opam, Melange can
also be used with other package managers, such as [esy](https://esy.sh/) and
[Nix](https://github.com/NixOS/nix). There is also a [Melange project template
for esy](https://github.com/melange-re/melange-esy-template) available, similar
in spirit to the Melange opam template mentioned above.
