---
title: What's 2024 brought to Melange so far?
date: 2024-04-08
author: Antonio Monteiro
gravatar: 45c2052f50f561b9dc2cae59c777aecd794f57269fa317f9c9c3365c2e00d16f
twitter: '@_anmonteiro'
---

Last year we saw the [first major
release](https://anmonteiro.substack.com/p/melange-10-is-here) of Melange. Over
the course of 2023, what started as disjoint sets of tooling has gradually
evolved into a cohesive development experience within the [OCaml
Platform](https://ocaml.org/docs/platform).

But we're not done yet. In the next few paragraphs, I'll tell you everything
we've shipped so far in the first 3 months of 2024.


---

## Releasing [Melange 3](./announcing-melange-3)

We released Melange 3.0 in February. This release mostly focused on addressing
long-standing deprecations, crashes, error messages and making the Melange
distribution leaner.

One highlight of the Melange 3 release is the support for more versions of
OCaml. Melange 3 supports OCaml 4.14 and 5.1; the next major release will
additionally feature support for OCaml 5.2.

[`reason-react`](https://github.com/reasonml/reason-react) and the Melange
libraries in [`melange-community`](https://github.com/melange-community) were
also updated and released with support for this new Melange major version.

Melange 3 has been running in production at Ahrefs since its release. This is
the largest Melange codebase that we are aware of (on the scale of tens of
libraries with support for `(modes melange)` and `melange.emit` stanzas, across
dozens of apps).


## Emitting [ES6](https://github.com/melange-re/melange/issues/134)

As the great majority of browsers [supports ECMAScript 2015
(ES6)](https://caniuse.com/?search=es6.), we decided to bump the version that
Melange targets. In
[melange#1019](https://github.com/melange-re/melange/pull/1019) and
[melange#1059](https://github.com/melange-re/melange/pull/1059) we changed the
emission of `var` to `let` (and `const`, where possible). `let`'s lexical scope
makes some closure allocations in `for` loops unnecessary, which we promptly
removed in [melange#1020](https://github.com/melange-re/melange/pull/1020).
This change also results in a slight reduction of bundle size as Melange emits
a bit less code.

Starting to emit ES6 also unblocks working on
[melange#342](https://github.com/melange-re/melange/issues/342), which requests
support for tagged [template
literals](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals).
We'll consider adding support for more features in ES6 and later on a
case-per-case basis, if the added expressivity justifies the complexity of the
implementation. Feel free to [open an
issue](https://github.com/melange-re/melange/issues/new) if you feel that
Melange should emit ES6 features that your project requires.


## Identifying Melange exceptions in JavaScript

Until Melange 3, exceptions originating from OCaml code compiled with Melange
are roughly thrown as such:

```js
throw {
  MEL_EXN_ID: "Assert_failure",
  _1: ["x.ml", 42, 8],
  Error: new Error()
};
```

As stated in an [old ReScript
issue](https://github.com/rescript-lang/rescript-compiler/issues/4506), the
encoding above is at odds with user exception monitoring in popular vendors.

We set out to fix this for Melange 4. The next release of Melange includes
[melange#1036](https://github.com/melange-re/melange/pull/1036) and
[melange#1043](https://github.com/melange-re/melange/pull/1043), where we
changed the encoding to throw a dedicated `MelangeError` instance:

```diff
-throw {
+throw new Caml_js_exceptions.MelangeError("Assert_failure", {
  MEL_EXN_ID: "Assert_failure",
  _1: ["x.ml", 42, 8],
- Error: new Error()
-};
+});
```

Besides fixing the immediate issue – vendor SDKs for error monitoring now
understand Melange runtime errors – this change brings a few additional
benefits to users of Melange:

- Detecting an exception originating from Melange-compiled code is now as easy
  as using the JS `instanceof` operator to check if the exception is an
  instance of `Caml_js_exceptions.MelangeError`.
- `MelangeError` adds support for – and polyfills, if necessary – the
  [`cause`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Error/cause)
  property in instances of `Error`, which lets us squeeze out some extra
  [browser support](https://caniuse.com/mdn-javascript_builtins_error_cause).
  - Additionally, this enables even better integrations with 3rd party
    monitoring tools, which will look for JavaScript error details in
    `Error.prototype.cause`.


## `melange.js` keeps getting better

The [Melange 3
announcement](./announcing-melange-3#runtime-stdlib)
touched a bit on the improvements we did in the `Js.*` modules recently. We're
always trying to improve the number of zero-cost bindings to functions in the
JS runtime, and their quality. In next release, we're adding more functions to
cover `Map`, `Set`, `WeakMap`, `WeakSet`, `BigInt` and `Iterator`.

We're also taking advantage of Dune's obscure extension that models libraries
like the OCaml `Stdlib` (`(using experimental_building_ocaml_compiler_with_dune
0.1)` in `dune-project`, the `stdlib` field in `library` stanzas). Here's the
difference between a "stdlib library" and a regular library: a stdlib library's
main module depends on just a subset of the internal modules in the libraries,
while others depend on this main module. Dune doesn't allow regular library
modules to depend on their main module name.

In the next release of Melange, we treat the `Js.*` modules like a "stdlib"
library ([melange#1091](https://github.com/melange-re/melange/pull/1091)):
modules are only accessible through the `Js.*` namespace; as a fortunate
side-effect, we stop exposing `Js__Js_internal`, which could leak into some
error messages, causing unnecessary confusion.


## OCaml 5.2

With OCaml 5.2 around the corner (the first
[beta](https://github.com/ocaml/ocaml/archive/refs/tags/5.2.0-beta1.tar.gz)
was released just a couple weeks ago), we made Melange ready for the upcoming
release. In [melange#1074](https://github.com/melange-re/melange/pull/1074) and
[melange#1078](https://github.com/melange-re/melange/pull/1078) we upgraded
both the Melange core and the Stdlib to the changes in OCaml 5.2. As mentioned
above, we're happy that the next release of Melange will support an even wider
range of OCaml compiler versions, making 5.2 the latest addition to the
supported compiler versions.

## Leveraging Dune's potential

### Making Dune faster

Back in January, [Javi](https://twitter.com/javierwchavarri) found a
performance regression in Dune
([dune#9738](https://github.com/ocaml/dune/issues/9738)) after upgrading to
Dune 3.13. The whole fact-finding process of profiling Dune's performance and
working closely with the team to patch this regression
([dune#9769](https://github.com/ocaml/dune/pull/9769)) ended up being quite the
learning experience.

Once the dust settled, Javi took the time to write a [blog
post](https://tech.ahrefs.com/profiling-dune-builds-a8de589ec268) outlining
some of the tools he used and the steps he used to gather information about
Dune's runtime behavior.


### Improving `dune describe pp`

The command `dune describe pp` prints a given source file after preprocessing.
This is useful to quickly inspect the code generate by a (set of) ppx.

`dune describe pp` didn't, however, support [Dune
dialects](https://dune.readthedocs.io/en/stable/overview.html#term-dialect). I
[found out](https://github.com/ocaml/dune/issues/4470#issuecomment-1135120774)
about this limitation when trying to get the preprocessed output of a ReasonML
file.

We recently set out to fix this problem. In
[dune#10321](https://github.com/ocaml/dune/pull/10321) we made Reason files and
dialects generally work within `dune describe pp`, and we followed up with the
ability to print back the preprocessed output in the same dialect as the given
file ([dune#10322](https://github.com/ocaml/dune/pull/10322),
[dune#10339](https://github.com/ocaml/dune/pull/10339) and
[dune#10340](https://github.com/ocaml/dune/pull/10340)).


### [Virtual libraries](https://dune.readthedocs.io/en/stable/variants.html) in Melange

From Dune's own documentation:

> Virtual libraries correspond to Dune’s ability to compile parameterised
libraries and delay the selection of concrete implementations until linking an
executable.

In the Melange case there's no executable linking going on, but we can still
delay the selection of concrete implementations until JavaScript emission – in
practice, this means programming against the interface of "virtual modules" in
libraries and deferring the dependency on the concrete implementation until the
`melange.emit` stanza.

Or rather, this is _now_ possible after landing
[melange#1067](https://github.com/melange-re/melange/pull/1067) and
[dune#10051](https://github.com/ocaml/dune/pull/10051): in particular, while
Dune support for Melange has shipped with virtual libraries since day one, it
didn't support one of the most useful features that they provide: programming
against the interface of a virtual module.


### Melange rules work within the Dune sandbox

Within the last month, we also fixed a bug where Dune didn't track all Melange
dependencies precisely during the JavaScript emission phase. While the
[originally reported issue](https://github.com/ocaml/dune/issues/9190) saw this
bug manifest when moving modules across directories when `(include_subdirs ..)`
is enabled, the fix we applied in
[dune#10286](https://github.com/ocaml/dune/pull/10286) and
[dune#10297](https://github.com/ocaml/dune/pull/10297) brings with it the
fortunate side-effect of making Melange rules work in the [Dune
sandbox](https://dune.readthedocs.io/en/stable/concepts/sandboxing.html).
We're glad this issue is fixed since it could result in the [Dune
Cache](https://dune.readthedocs.io/en/stable/caching.html) being poisoned,
leading to very confusing results.

To make sure that sandboxing keeps working with Melange, we enabled it by
default in [dune#10312](https://github.com/ocaml/dune/pull/10312) for the
Melange tests in Dune.


## Towards Universal React in OCaml

One of our goals for 2024 is to ship a good developer experience around
"universal libraries" in OCaml, the ability to write a mixed OCaml / Melange
codebase that shares most libraries and modules pertaining to DOM rendering
logic.

[Dave](https://twitter.com/davesnx) wrote
[server-reason-react](https://github.com/ml-in-barcelona/server-reason-react)
for this purpose. He also wrote a [post on his
blog](https://sancho.dev/blog/server-side-rendering-react-in-ocaml) detailing
the motivation behind this approach and what he wants to achieve with
`server-reason-react`.

While React component hydration in native OCaml is a challenge specific to
Melange and React codebases, there are reusable primitives that we needed to
implement in Dune to make it possible. They also unlock a host of new use cases
for Dune that we expect will start getting adoption over time.

Universal libraries are already deployed for a small subset of apps at Ahrefs.
Javi wrote about how Ahrefs is [sharing component
code](https://tech.ahrefs.com/building-react-server-components-in-ocaml-81c276713f19)
for those apps.

This past quarter, we took it a step further. We added support in Dune for
libraries that share the same name, as long as they're defined in different
build contexts ([dune#10222](https://github.com/ocaml/dune/issues/10222)).
Support for libraries with the same name in multiple contexts landed in
[dune#10307](https://github.com/ocaml/dune/pull/10307) and we'll be diving
deeper into what led us to this solution and what it enables in a separate blog
post.

## Community at large

### Bootstrapping Melange projects with `create-melange-app`

In January, [Dillon](https://twitter.com/dillon_mulroy) released v1.0 of
[`create-melange-app`](https://github.com/dmmulroy/create-melange-app), and
we're now recommending it for bootstrapping [new Melange
projects](https://melange.re/v3.0.0/getting-started.html#getting-started-automated-create-melange-app)

`create-melange-app` is a friendly and familiar way to get started with OCaml,
ReasonML, and Melange, geared towards JavaScript and TypeScript developers.

`create-melange-app` quickly became a community favorite after its release,
attracting a number of contributors that are helping make it better.

### Melange Book

[Feihong](https://twitter.com/feihonghsu) keeps making really good progress on
our book [Melange for React Devs](https://react-book.melange.re), a
project-based introduction to Melange for React developers. The newest chapter
on [Cram testing](https://dune.readthedocs.io/en/stable/tests.html#cram-tests)
guides you through the necessary steps for writing tests and snapshotting their
output.

There are more chapters in the pipeline that we'll be releasing incrementally
as they're ready for consumption. We're also gathering feedback on the book; we
invite you to go through it and open issues in the [GitHub
repository](https://github.com/melange-re/melange-for-react-devs) for any
material that deserves rewording.

## Looking forward

As we look forward, towards the next phase of Melange development, I'd like to
take a moment to thank [Ahrefs](https://ahrefs.com), the [OCaml Software
Foundation](https://ocaml-sf.org/) and my [GitHub
sponsors](https://github.com/sponsors/anmonteiro/) for the funding and support,
without which developing Melange wouldn't have been possible over this
sustained period of time.

On a personal note, it fills me with joy to have the opportunity to share the
amazing work that Melange contributors have been putting in. It represents a
stark contrast from not long ago and the Melange project and community are
better for it. Thank you everyone!

As a final note, we thank you for reading through our updates for the first
three months of 2024! As we finish planning our work for the next period, we'll
share updates on what's to come for Melange in the not-so-distant future.

Until then, stay tuned and happy hacking!

