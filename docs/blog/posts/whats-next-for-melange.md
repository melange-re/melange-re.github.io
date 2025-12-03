---
title: What's next for Melange
date: 2023-07-10
author: Antonio Monteiro
gravatar: 45c2052f50f561b9dc2cae59c777aecd794f57269fa317f9c9c3365c2e00d16f
twitter: '@_anmonteiro'
head:
  - - link
    - rel: canonical
      href: https://anmonteiro.substack.com/p/whats-next-for-melange
---

We're quite happy with how far Melange has come -- I previously wrote
about [releasing Melange
1.0](https://anmonteiro.substack.com/p/melange-10-is-here) and a [retrospective
on Q2 2023](https://anmonteiro.substack.com/p/melange-q2-2023-retrospective).

But we're not done yet: there's more in slate for the next quarter. I'll tell
you what we're looking to achieve in Q3 2023.

---

We've decided to call the next Melange version 2.0 -- we plan to make a few
breaking changes. The main goal for this quarter is to release Melange 2.0. We
will focus across a few different axes.

### OCaml (and OCaml Platform) compatibility

Melange integrates with the most popular workflows in the OCaml
ecosystem. [Dune](https://dune.build/) builds Melange
projects. [Merlin](https://github.com/ocaml/merlin) and the [OCaml
LSP](https://github.com/ocaml/ocaml-lsp) power editor
integration. [OCamlformat](https://github.com/ocaml-ppx/ocamlformat) and [Reason](https://github.com/reasonml/reason)'s `refmt` automatically
format code. [dune-release](https://github.com/tarides/dune-release) publishes
Melange libraries and PPX to the [OPAM
repository](https://github.com/ocaml/opam-repository/). [odoc](https://github.com/ocaml/odoc) builds
package documentation.

In Melange 2.0, we will:

- Upgrade the Melange type-checker and standard library to OCaml 5.1:

  - Turn off [Effect Handlers](https://v2.ocaml.org/manual/effects.html) for the
    time being.

  - Provide a compatible [Domain](https://v2.ocaml.org/api/Domain.html) module
    shim.

- Move the Melange internal PPX completely out of the compiler,
  into `melange.ppx`:

- Wrap the `Belt` and `Js` libraries:

  - These currently expose all their internal modules. Dune can wrap them nicely
    under a single top-level module.

- Break out `melange.node`:

  - The Node.js bindings are rarely used. We will require `melange.node` be
    added to the Dune `libraries` field.

### Developer Experience

While Melange already integrates with the OCaml Platform tooling and workflow,
there is space to make the experience of developing Melange projects even
better.

We want to focus on:

- Improving the editing experience:

  - Melange can compile FFI `external`s better, in a way that works better with
    analysis tools such as Merlin.

  - `reason-react-ppx` doesn't faithfully respect the JSX node locations. We
    want to fix that so that "go to definition" works better for Reason JSX.

- Improving the interaction between OPAM and npm:

  - Melange bridges the OPAM and npm ecosystems. Some packages published to OPAM
    depend on npm dependencies at runtime.

  - We want to [explore
    solving](https://github.com/melange-re/melange/issues/629) this issue,
    starting with a tool that checks that the required npm dependencies are
    installed in Melange projects.

- Generating [Source
  Maps](https://docs.google.com/document/d/1U1RGAehQwRypUTovF1KRlpiOFze0b-_2gc6fAH0KY0k/edit?hl=en_US&pli=1&pli=1):

  - Source Maps allow mapping generated code back to the original OCaml / Reason
    source.

  - Among other benefits, source maps allow for better stack traces that map to
    the original lines of code that triggered runtime crashes.

### Documentation and Branding:

We released [melange.re](https://melange.re/) alongside Melange 1.0. The website
contains our initial efforts to document Melange workflows, and it can be
improved upon. Over the next few months, we will:

- Develop unified Melange brand guidelines and apply them to the website.

- Continue documenting Melange workflows:

  - We've already seen some [user
    contributions](https://github.com/melange-re/melange-re.github.io/pulls?q=is%3Apr+is%3Aclosed).
    We're looking to keep improving the Melange documentation in response to
    feedback from Melange users.

### Wrapping up

We have a lot of work ahead of us. The best way to help us is to [try
Melange](https://melange.re/v1.0.0/getting-started/). We'd love to read your
feedback.

I tried to summarize what we'll be up to in the near future. The full [Melange
Roadmap for Q3
2023](https://docs.google.com/document/d/1UhanM28sOAmS3NI4q4BJBeoCX0SdBMqUIq0rofdpOfU/edit) goes
into more detail.

Happy hacking!
