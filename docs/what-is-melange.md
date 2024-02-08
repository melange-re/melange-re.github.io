# What is Melange

Melange is a set of tools that come together to generate and interoperate with
modern JavaScript:

- The [compiler libraries](https://github.com/melange-re/melange-compiler-libs):
  These libraries are a fork of the [OCaml compiler
  libraries](https://v2.ocaml.org/api/compilerlibref/Compiler_libs.html) with
  adaptations for generating lean JavaScript code, as opposed to bytecode or
  assembly.

- The compiler (`melc`): This executable takes OCaml code as input and is
  responsible for generating JavaScript. It relies on the Melange compiler
  libraries.

- The
  [runtime](https://github.com/melange-re/melange/tree/c5bf086511ed4830018e67ca63df86045dbe356d/jscomp/runtime):
  This is a small code component essential for running JavaScript programs
  produced by the compiler.

- The [standard libraries](./api.md): Melange includes a set of foundational
  elements such as data structures, functions, and bindings to JavaScript APIs,
  all aimed at helping developers accelerate app development.

- The preprocessor (`melange.ppx`): This is a
  [meta-programming](https://ocaml.org/docs/metaprogramming) tool designed to
  preprocess Melange programs, simplifying code generation for common use cases
  like generating bindings or code from types.

- The [playground](./playground/){target="_self"}: This is a browser-based version of the
  compiler, enabling users to experiment with and share Melange code snippets
  and small programs.

In addition to these core components, there is an ongoing effort to integrate
Melange into the broader OCaml Platform and other tools and libraries within the
OCaml ecosystem:

- A [build system](./build-system.md): [Dune](https://dune.readthedocs.io), a
  prominent OCaml build system, provides seamless support for Melange.

- A [package manager](./package-management.md): Melange seamlessly integrates
  with [opam](https://opam.ocaml.org/), OCaml's default package manager.

- A package repository: Melange libraries and tools are published in the [main
  public package repository](https://opam.ocaml.org/packages/) for opam.

- Syntaxes: Melange empowers users to optionally write their applications using
  the [Reason syntax](https://reasonml.github.io/), with full support for React
  applications through the Melange bindings library
  [ReasonReact](https://reasonml.github.io/reason-react/).

- Editor integration: Melange is fully compatible with the [OCaml editor
  tools](https://ocaml.org/docs/set-up-editor), and also with code formatters
  like [ocamlformat](https://github.com/ocaml-ppx/ocamlformat) and
  [refmt](https://github.com/reasonml/reason/tree/d47e613b736cc25629aabc1c8ef91795e265eacb/src/refmt).
