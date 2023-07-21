# Installation

## Prerequisites

- You are running a Unix system
  - Windows users are encouraged to install [Windows Subsystem for
Linux](https://learn.microsoft.com/en-us/windows/wsl/)
- You have a recent version of, and know how to use:
  - [Node.js](https://nodejs.org/)
  - [git](https://git-scm.com/)
  - [Visual Studio Code](https://code.visualstudio.com/)

## Opam

We need opam, the OCaml Package Manager. There are many ways to install it
depending on your platform, but let's go with the simplest method:

    bash -c "sh <(curl -fsSL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)"
    opam init
    eval $(opam env)

While `opam init` is running, it will prompt you with something like "Do you
want opam to modify ~/.profile?". Type `y` to agree.

## Melange opam template

Let's make sure that everything works by downloading and running
[melange-opam-template](https://github.com/melange-re/melange-opam-template).

    git clone https://github.com/melange-re/melange-opam-template
    cd melange-opam-template
    make init
    make build
    make serve

While `make init` you can consider grabbing some coffee or other beverage, as it
might take a while the first time. The last command, `make serve`, should open a
tab in your default browser which points to http://localhost:8081/ and shows
you a typical "Hello World" page.

## OCaml Platform Visual Studio Code Extension

Open the Extensions tab in Visual Studio Code and search for "ocaml". Install
the [OCaml
Platform](https://marketplace.visualstudio.com/items?itemName=ocamllabs.ocaml-platform)
extension from OCaml Labs. To verify that the extension worked, open the
melange-opam-template we downloaded in the last step in Visual Code. Code should
be syntax highlighted, and you should see type annotations when you hover over
variables. Now open your User Settings JSON file and add this:

```json
"[reason]": {
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "ocamllabs.ocaml-platform"
}
```
