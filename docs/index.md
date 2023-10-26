# Melange

<div id="home-subtitle">OCaml for JavaScript developers</div>

---

Melange is a backend for the OCaml compiler that emits JavaScript. Melange
strives to provide the best integration with both the OCaml and JavaScript
ecosystems. To know more about it start by reading the [introductory
tutorial](getting-started.md), then check the [Learn](learn.md) section for more
information.

<!-- Temporarily disabled in readthedocs mode
<div class="text-center">
<a href="getting-started" class="btn btn-primary" role="button">Getting Started</a>
<a href="learn" class="btn btn-primary" role="button">Learn</a>
</div>
-->

<div class="jumbotron">
<h2 class="display-4 text-center">Features</h2>
<div class="row">
  <div class="col-sm-6">
    <div class="card">
      <div class="card-body">
        <h3 class="card-title">A Solid Type System</h3>
        <p class="card-text">
            Melange leverages OCaml's powerful type system to catch more bugs at
            compile time. Large, complex codebases become easy to maintain and
            refactor.
        </p>
      </div>
    </div>
  </div>
  <div class="col-sm-6">
    <div class="card">
      <div class="card-body">
        <h3 class="card-title">First-Class Editor and Tooling</h3>
        <p class="card-text">
            Melange fully utilizes the power of
            <a href="https://ocaml.org/docs/platform">the OCaml Platform</a>
            to provide integrations with editors such as VSCode, Vim, or Emacs,
            with features like type inspection, autocomplete, and more. It also
            has first-class integration with <a
            href="https://dune.build/">Dune</a>, OCaml's most used build system.
        </p>
      </div>
    </div>
  </div>
</div>

<div class="row">
  <div class="col-sm-6">
    <div class="card">
      <div class="card-body">
        <h3 class="card-title">JavaScript Integration</h3>
        <p class="card-text">
            Whether you want to use existing JavaScript packages from NPM, or
            use your own JavaScript libraries in your projects, Melange has you
            covered. With an expressive bindings language, and an ergonomic
            compilation model, Melange can help you build robust applications
            that leverage functionality from the JavaScript ecosystem.
        </p>
      </div>
    </div>
  </div>
  <div class="col-sm-6">
    <div class="card">
      <div class="card-body">
        <h3 class="card-title">Stable and Industry Backed</h3>
        <p class="card-text">
            Melange builds on top of decades of type system research, compiler
            engineering and tooling development to provide a polished
            developer experience. Companies like Ahrefs use Melange daily to
            deploy web applications for their users.
        </p>
      </div>
    </div>
  </div>
</div>
</div>

## What is Melange

Melange is a set of tools that come together to generate and interoperate with modern JavaScript:

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

- The [playground](./playground): This is a browser-based version of the
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
  the [Reason syntax](reasonml.github.io/), with full support for React
  applications through the Melange bindings library
  [ReasonReact](https://reasonml.github.io/reason-react/).

- Editor integration: Melange is fully compatible with the [OCaml editor
  tools](https://ocaml.org/docs/set-up-editor), and also with code formatters
  like [ocamlformat](https://github.com/ocaml-ppx/ocamlformat) and
  [refmt](https://github.com/reasonml/reason/tree/d47e613b736cc25629aabc1c8ef91795e265eacb/src/refmt).
