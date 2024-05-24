---
title: Melange 4.0 is here
date: 2024-05-22
author: Antonio Monteiro
gravatar: 45c2052f50f561b9dc2cae59c777aecd794f57269fa317f9c9c3365c2e00d16f
twitter: '@_anmonteiro'
---

Today, we're introducing Melange 4.0, the latest version of our backend for the
OCaml compiler that emits JavaScript.

Melange is now compatible with OCaml 5.2! This release introduces ES6 support,
enhanced JavaScript interoperability, improved error handling, and full support
for Dune virtual libraries. Read on for more details.

---

## Embracing OCaml 5.2

OCaml 5.2 was released just last week. With Melange 4, you can now leverage all
the power and enhancements in this latest OCaml version. We've upgraded the
OCaml type checker and the standard library to match OCaml 5.2's, ensuring you
can select a 5.2-compatible Melange in your projects.

This does **not** mean Melange is only compatible with OCaml 5.2. As previously
mentioned in the [Melange 3
announcement](./announcing-melange-3#multiple-ocaml-version-releases), each
Melange version ships one release for every compiler version that it supports;
for OCaml 5.1, this would correspond to Melange `4.0.0-51`.

## Full Support for Dune Virtual Libraries

Melange now fully supports [Dune virtual
libraries](https://dune.readthedocs.io/en/stable/variants.html), which requires
Dune 3.15.2. There were a few bumps in road when we thought it wouldn't be
possible to support this use case in Melange. We were thankfully proven wrong
([#1067](https://github.com/melange-re/melange/pull/1067)), and we think that
virtual libraries can become an interesting way to write libraries that work
across Melange and native OCaml, sharing a common interface.

## Emitting ES6 and Enhanced JavaScript Interop

In this release, Melange starts emitting ES6, particularly:

- Melange 4.0 emits `let` instead of `var`, and `const` where possible
  ([#1019](https://github.com/melange-re/melange/pull/1019),
  [#1059](https://github.com/melange-re/melange/pull/1059)).
- Emitting `let` allowed us to remove a bit of legacy code related to compiling
  `for` loops, taking advantage of `let`'s lexical scoping.
  ([#1020](https://github.com/melange-re/melange/pull/1020))

In our effort to expand the API surface area for JavaScript interoperability,
we've added new bindings to a few more JavaScript features in the `melange.js`
library (whose main entrypoint is the `Js` module):

- **Js.Bigint**: [#1044](https://github.com/melange-re/melange/pull/1044) added
  bindings to work with `BigInt`;
- The **Js.Set** and **Js.Map** modules now bind to even more methods available
  in these JavaScript data structures
  ([#1047](https://github.com/melange-re/melange/pull/1047),
  [#1101](https://github.com/melange-re/melange/pull/1101)).
- **JS Iterators**: We introduced minimal bindings for JavaScript iterators,
  making it easier to work with iterable objects, which some other modules'
  methods can now return
  ([#1060](https://github.com/melange-re/melange/pull/1060)).
- **WeakMap and WeakSet**: Bindings for these weakly referenced collections
  have also been added
  ([#1058](https://github.com/melange-re/melange/pull/1058)).

## Improved Error Handling and Code Generation

In this release, we've also made significant improvements in how Melange
handles errors and generates JavaScript code:

- Instead of throwing JavaScript objects with Melange exception payloads, we
  now emit a Melange-specific error (`throw new MelangeError(..)`) for more
  consistent error handling
  ([#1036](https://github.com/melange-re/melange/pull/1036)).
  - An interesting corollary to this change is that catching Melange errors
    from external JavaScript only needs to check `instanceof MelangeError`.

## Additional Fixes & Enhancements

- **Slimmer Executable**: We've removed unnecessary internal code from
  `melange-compiler-libs`, making the Melange compiled executable smaller in
  size and faster to build
  ([#1075](https://github.com/melange-re/melange/pull/1075)).
- **Float Operations**: Fixed runtime primitives for `Float.{min,max}` and
  related functions, ensuring more accurate mathematical operations
  ([#1050](https://github.com/melange-re/melange/pull/1050)).
- **Warning 51 (`wrong-tailcall-expectation`)**: Melange 4 ships with support
  for enabling warning 51 and triggering the warning when
  [`[@tailcall]`](https://ocaml.org/manual/5.2/attributes.html#ss:builtin-attributes)
  is used ([#1075](https://github.com/melange-re/melange/pull/1075)).

## Conclusion

The [Melange 4.0
changelog](https://github.com/melange-re/melange/blob/main/Changes.md#400-2024-05-15)
lists all the changes that made it to this release.

Thanks for reading and stay tuned for more updates. Happy hacking!


