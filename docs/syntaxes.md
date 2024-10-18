# Syntaxes

Melange supports two syntaxes: OCaml syntax (the default) and Reason syntax.
Choice of syntax doesn't change the output of the compiler, but Reason syntax is
designed to be more approachable to JavaScript/TypeScript developers, and it
supports the use of JSX. Most tooling, such as the [OCaml Platform VS Code
extension](https://marketplace.visualstudio.com/items?itemName=ocamllabs.ocaml-platform),
works well with Reason, but some tools aren't completely aware of it—for
example, error messages from the compiler still use OCaml syntax.

## Installation

To install Reason syntax support add `reason` to the `depends` section of the
`<project-name>.opam` file in your project:

```opam{3}
depends: [
  "ocaml"
  "reason" {>= "3.10.0"}
  "dune" {>= "3.9"}
  "melange" {>= "2.0.0"}
  "reason-react" {>= "0.13.0"}
  "reason-react-ppx"
  "opam-check-npm-deps" {with-test}
  "ocaml-lsp-server" {with-test}
  "dot-merlin-reader" {with-test}
  "odoc" {with-doc}
]
```

On the command line, run

```bash
opam install -y . --deps-only
```

Note that reason support is already set up for you in
[melange-opam-template](https://github.com/melange-re/melange-opam-template).

## Editor configuration

To enable format-on-save in VS Code:

1. Make sure you've already installed [OCaml Platform VS Code
extension](https://marketplace.visualstudio.com/items?itemName=ocamllabs.ocaml-platform)
1. Open your [User Settings
JSON file](https://code.visualstudio.com/docs/getstarted/settings#_settingsjson)
and add this snippet:

    ```json
    "[reason]": {
      "editor.formatOnSave": true
    },
    ```
1. In order to control how the Reason formatter breaks up long lines, you might
   also want to add this:

   ```json
   "ocaml.server.extraEnv": {
      "REFMT_PRINT_WIDTH": "120"
    },
    ```
    In the snippet above, the print width is set to 120 characters, but you can
    use any number you prefer.
