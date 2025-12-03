---
title: 'Introducing Melange 2.0'
date: 2023-09-20
author: Antonio Monteiro
gravatar: 45c2052f50f561b9dc2cae59c777aecd794f57269fa317f9c9c3365c2e00d16f
twitter: '@_anmonteiro'
head:
  - - link
    - rel: canonical
      href: https://anmonteiro.substack.com/p/introducing-melange-20
---

Today, the Melange team is excited to introduce Melange 2.0. This iteration
brings an upgrade to the OCaml 5.1 type checker, along with increased
compatibility with the OCaml Platform. Melange 2.0 unifies the compiler
attributes and libraries under the Melange brand and it improves developer
experience across the ecosystem. We're also publishing a few battle-tested
libraries to [OPAM](https://github.com/ocaml/opam-repository).

---

Everything we have included in this release has been designed to enhance your
experience writing Reason / OCaml for modern JS workflows. Here's a
comprehensive look at what's new.

## **What's New in Melange 2.0?**

### OCaml 5

[OCaml 5.1](https://discuss.ocaml.org/t/ocaml-5-1-0-released/13021) has just
been released. Melange 2.0 has been upgraded to use the newly released OCaml 5.1
type checker and compiler libs. As the OCaml community starts to upgrade to the
newest version of OCaml, Melange will be co-installable in your OPAM switch.

While the Melange type checker has been upgraded to the 5.x release line,
Melange doesn't yet include support for [effect
handlers](https://v2.ocaml.org/manual/effects.html) and some of the multicore
OCaml primitives. Stay tuned for future updates on this.

### The reign of `melange.ppx`

The compiler frontend transformations related to
the [FFI](https://en.wikipedia.org/wiki/Foreign_function_interface), [extensions](https://melange.re/v2.0.0/communicate-with-javascript/#list-of-attributes-and-extension-nodes) and [derivers](https://melange.re/v2.0.0/communicate-with-javascript/#generate-getters-setters-and-constructors) have
been fully extracted from the compiler to the Melange PPX. Going forward, it's
likely you'll need to preprocess most Melange code with `melange.ppx`.

### Wrapping the Melange Core Libraries

In this release, we wrapped the Melange runtime and core libraries. Each library
exposes only a single top-level module, avoiding namespace pollution. The only
modules exposed by Melange are now:

- The `Js` module contains utilities to interact with JavaScript standard APIs.
  Modules such as `Js_string` now only accessible via `Js.String`.

- The `Belt` library contains utilities inherited from BuckleScript. Its
  sub-modules similarly nested under `Belt`, e.g. you'll use `Belt.List` instead
  of `Belt_List`.

- Melange 2.0 exposes only a single `Stdlib` module, where previously it was
  leaking e.g. `Stdlib__String`, etc.

- **New libraries**: The `Node` module has been extracted to a
  new `melange.node` library. Similarly, `Dom` is now only accessible via
  the `melange.dom` library. Both libraries are released with the Melange
  distribution, but not included by default; they can be added to the
  Dune `(libraries ...)` field.

### Enforcing the Melange brand

`bs.*` [attributes](https://melange.re/v2.0.0/communicate-with-javascript/#attributes) have
been deprecated in this release in favor of `mel.*`.
The [uncurried](https://melange.re/v2.0.0/communicate-with-javascript/#binding-to-callbacks) `[@bs]` attribute
is now simply `[@u]`. The next major Melange release will be removing them
entirely. `%bs.*` [extension
nodes](https://melange.re/v2.0.0/communicate-with-javascript/#extension-nodes) have,
however, been replaced with `%mel.* `due to limitations
in [ppxlib](https://github.com/ocaml-ppx/ppxlib). This is a breaking change.

### Development experience

We've done significant work making Melange easier to use in this release:

1.  Attributes like `[@{bs,mel}.val]` have been deprecated as they're redundant
    in the Melange FFI.

2.  We're introducing more ways of using `@mel.as` in:

    1.  `let`[ bindings](https://github.com/melange-re/melange/pull/714) to
        allow exporting otherwise invalid OCaml identifiers;

    2.  `external`[ polymorphic
        variants](https://github.com/melange-re/melange/pull/722) without
        needing to use `[@mel.{string,int}]`;

    3.  [inline records](https://github.com/melange-re/melange/pull/732) in both
        regular and extensible variants and custom exceptions.

### Ecosystem

- With this release, we're starting to publish some widely used libraries from
  the `melange-community` and `ahrefs` organizations. Be on the lookout for new
  Melange-ready releases popping up in the [OPAM
  repository](https://github.com/ocaml/opam-repository) in the next few
  days. [Reason 3.10](https://github.com/ocaml/opam-repository/pull/24396) is
  also a companion release to Melange 2.0.

- The new `reason-react` releases greatly increase developer experience
  by [improving the editor
  integration](https://github.com/reasonml/reason-react/pull/748). React props
  and children now point to the correct source code locations, making React
  components much easier to track in your editor.

- We've also released an OPAM
  plugin, [check-npm-deps](https://github.com/jchavarri/opam-check-npm-deps/).
  This tool checks whether the NPM dependencies in your `node_modules` folder
  match what libraries released to OPAM need. `check-npm-deps` is currently in
  preview and we're looking for your feedback on how we can evolve it.

## **Support & Sponsorship**

This release was made possible with the continued support of:

- [Ahrefs](https://ahrefs.com/?utm_source=anmonteiro&utm_medium=email&utm_campaign=melange-hits-v10),
  who have been supporting Melange development since October 2022, having
  fully [migrated their codebase to
  Melange](https://tech.ahrefs.com/ahrefs-is-now-built-with-melange-b14f5ec56df4?utm_source=anmonteiro&utm_medium=email&utm_campaign=melange-hits-v10) and
  making the work towards [Melange
  1.0](https://anmonteiro.substack.com/p/melange-10-is-here) possible.

- The [OCaml Software
  Foundation](https://ocaml-sf.org/?utm_source=anmonteiro&utm_medium=email&utm_campaign=melange-hits-v10),
  who has previously [committed
  funding](https://twitter.com/_anmonteiro/status/1589044352479035393?utm_source=anmonteiro&utm_medium=email&utm_campaign=melange-hits-v10) for
  the Melange project in October 2022, and renewed it for another half-year
  ending in August 2023.

- [My (Antonio)
  sponsors](https://github.com/sponsors/anmonteiro/?utm_source=anmonteiro&utm_medium=email&utm_campaign=melange-hits-v10) on
  GitHub, both past and present.

### Parting thoughts

The goal of Melange is to provide a robust and evolving toolchain that matches
the dynamic nature of modern JS development. Melange 2.0 is a testament to that
commitment. In this release, we've shipped the majority of our [Q3
roadmap](https://docs.google.com/document/d/1UhanM28sOAmS3NI4q4BJBeoCX0SdBMqUIq0rofdpOfU).
Dive in, explore the new features, and let us know your feedback.

Consult the [full change
log](https://github.com/melange-re/melange/blob/main/Changes.md#200-2023-09-13) and
the [migration guide from
1.0](https://melange.re/v2.0.0/how-to-guides/#to-v2-from-v1) for a more detailed
look at all the changes that went into this packed release.

If you or your company are interested in seeing what Melange can do for your
JavaScript needs, feel free to get in touch. We'd love to hear from you.

Happy hacking!

Antonio & the Melange team
