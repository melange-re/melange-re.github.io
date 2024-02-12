# Getting started

Get up and running with Melange in no time! Below you will find the two main
ways to get started with Melange:
- (Recommended) With
  [create-melange-app](https://github.com/dmmulroy/create-melange-app)
- Manually, using
  [melange-opam-template](https://github.com/melange-re/melange-opam-template)

## Getting started (recommended): `create-melange-app`

If you are completely new to Melange, we recommend using
[create-melange-app](https://github.com/dmmulroy/create-melange-app) to start a
new project. Just run these commands:

```bash
npm create melange-app@latest
npm run dev
```

## Getting started (manual): `melange-opam-template`

If you are familiar with OCaml, or just prefer manually installing the
toolchain, follow the instructions below.

### Install a package manager

To work with Melange, you need to install a package manager compatible with
OCaml. If you are not sure which one to use, we recommend
[opam](https://opam.ocaml.org/), a source-based package manager for OCaml, but
there are [other alternatives](#alternative-package-managers-experimental)
available.

Instructions for installing opam on different operating systems can be found at
the opam [install page](https://opam.ocaml.org/doc/Install.html), and you can
find [a whole section about it](package-management.md) on this website.

### Get the template

You can clone `melange-opam-template` from [this
link](https://github.com/melange-re/melange-opam-template/generate), and follow
the instructions in the [readme
file](https://github.com/melange-re/melange-opam-template/blob/main/README.md)
to configure the [local opam
switch](https://opam.ocaml.org/blog/opam-local-switches/) and download the
necessary dependencies to build the project.

### Editor integration

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
version of OCaml you are using from the list, such as 5.1.1. Further
instructions for configuration can be found in the [extension
repository](https://github.com/ocamllabs/vscode-ocaml-platform#setting-up-the-extension-for-your-project).

For Emacs and Vim, the configuration may vary depending on the case, and there
are several options available. You can read about them in the [editor setup
page](http://ocamlverse.net/content/editor_setup.html) of the OCamlverse
documentation site.

### Alternative package managers (experimental)

Melange can also be used with other package managers. The following instructions
apply to [Nix](#nix) and [esy](#esy).

#### [Nix](https://nixos.org/)

Melange provides an overlay that can be:

- referenced from a [Nix flake](https://nixos.wiki/wiki/Flakes)
- overlayed onto a `nixpkgs` package set

Make sure [Nix](https://nixos.org/download.html) is installed. The following
`flake.nix` illustrates how to set up a Melange development environment.

```nix
{
  description = "Melange starter";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs";

    # Depend on the Melange flake, which provides the overlay
    melange.url = "github:melange-re/melange";
  };

  outputs = { self, nixpkgs, flake-utils, melange }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system}.appendOverlays [
          # Set the OCaml set of packages to the 5.1 release line
          (self: super: { ocamlPackages = super.ocaml-ng.ocamlPackages_5_1; })
          # Apply the Melange overlay
          melange.overlays.default
        ];
        inherit (pkgs) ocamlPackages;
      in

      {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with ocamlPackages; [
            ocaml
            dune_3
            findlib
            ocaml-lsp
            ocamlPackages.melange
          ];
          buildInputs = [ ocamlPackages.melange ];
        };
      });
}
```

To enter a Melange development shell, run `nix develop -c $SHELL`.

#### [esy](https://esy.sh/)

First, make sure `esy` is
[installed](https://esy.sh/docs/en/getting-started.html#install-esy). `npm i -g
esy` does the trick in most setups.

The following is an example `esy.json` that can help start a Melange project. A
[project template for esy](https://github.com/melange-re/melange-esy-template)
is also available if you prefer to [start from a
template](https://github.com/melange-re/melange-esy-template/generate).

```json
{
  "name": "melange-project",
  "dependencies": {
    "ocaml": "5.1.x",
    "@opam/dune": ">= 3.8.0",
    "@opam/melange": "*"
  },
  "devDependencies": {
    "@opam/ocaml-lsp-server": "*"
  },
  "esy": {
    "build": [
      "dune build @melange"
    ]
  }
}
```

Run:

1. `esy install` to build and make all dependencies available
2. `esy shell` to enter a Melange development environment

