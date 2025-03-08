---
title: Announcing Melange 5
date: 2025-03-05
author: Antonio Monteiro
gravatar: 45c2052f50f561b9dc2cae59c777aecd794f57269fa317f9c9c3365c2e00d16f
twitter: '@_anmonteiro'
---

We are excited to announce the release of Melange 5, the compiler for OCaml
that targets JavaScript.

A lot of goodies went into this release! While our focus was mostly on features
that make it easy to express more JavaScript constructs and supporting OCaml
5.3, we also managed to fit additional improvements in the release: better
editor support for Melange `external`s, code generation improvements, and
better compiler output for generated JS. The most notable feature we're
shipping in Melange 5 is support for JavaScript's [dynamic
`import()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/import),
which we'll describe in detail below.

Read on for the highlights.

## Dynamic `import()` without sacrificing type safety

Support for JavaScript's dynamic `import()` is probably what I'm most excited
about in this Melange release. In Melange 5, we're releasing support for
JavaScript's `import()` via a new function in `melange.js`, `Js.import: 'a ->
'a promise`. I gave a small preview of dynamic `import()` during my [Melange
talk](https://www.youtube.com/watch?v=3oCXT-ycHHs) at [Fun OCaml
2024](https://fun-ocaml.com).

`Js.import` is **type-safe** and **build system-compatible**. Let's break it
down:

1. **build system-compatible**: dynamic `import()`s in Melange work with Dune
   out of the box: as usual, you must specify your `(library ..)` dependencies
   in the `dune` file. At compile time, Melange will be aware of the
   dynamically imported module locations to emit the arguments to
   `import("/path/to/module.js)` automatically.
2. **type-safe**: your OCaml code is still aware of its dependencies at
   compile-time, but Melange will skip emitting static JavaScript `import ..`
   declarations if the values are exclusively used through `Js.import(..)`.

### Dynamically `import()`ing OCaml code

The example below makes it clear: we import the entire `Stdlib.Int` module,
specify its type signature, and observe that no static `import`s appear in the
resulting JavaScript:

```js
// dynamic_import_int.re

module type int = (module type of Int);

let _: Js. Promise.t(unit) = {
  Js.import((module Stdlib.Int): (module int))
  |> Js.Promise.then_((module Int: int) =>
      Js.Promise.resolve(Js.log(Int.max))
  );
};
```

```js
// dynamic_import_int.js

import("melange/int.js").then(function (Int) {
  return Promise.resolve((console.log(Int.max), undefined));
});
```

### Dynamically `import()`ing JavaScript from OCaml

One of Melange's primary operating principles is the ability to support
seamless interop with JavaScript constructs. As such, we implemented `import()`
in a way that also allows importing JS modules dynamically: you can call
`Js.import` on JavaScript values declared with `external`. The abstractions
compose nicely here to produce the expected result. Check out this example of
dynamically importing `React.useEffect`:

```js
// dynamically_imported_useEffect.re

[@mel.module "react"]
external useEffect:
([@mel.uncurry] (unit => option(unit => unit))) => unit = "useEffect";

let dynamicallyImportedUseEffect = Js.import(useEffect);
```

And the JS output:

```js
// dynamically_imported_useEffect.js

const dynamicallyImportedUseEffect = import("react").then(function (m) {
  return m.useEffect;
});

export {
  dynamicallyImportedUseEffect,
}
```

## Discriminated unions support: `@mel.as` in variants

This release of Melange includes a major feature that improves the compilation
of variants, including really good support for representing [discriminated
unions](https://www.typescriptlang.org/docs/handbook/typescript-in-5-minutes-func.html#discriminated-unions),
a common pattern to represent polymorphic objects with a discriminator in
JavaScript/TypeScript.

In [melange-re/melange#1189](https://github.com/melange-re/melange/pull/1189),
we introduced support for 2 attributes in OCaml types that define variants:

### `@mel.as`

Specifying `[@mel.as ".."]` changes the variant emission in JavaScript to that
string value.

```js
type t =
  | [@mel.as "World"] Hello;

let t = Hello
```

```js
const t = /* Hello */ "World";
```

### `@mel.tag`

A `@mel.as` variant type combined with `@mel.tag` allows expressing
discriminated unions in an unobtrusive way:

```js
[@mel.tag "kind"]
type t =
  | [@mel.as "Foo"] Foo({ a: string, b: string, })
  | [@mel.as "Bar"] Bar({ c: string, d: string, });

let x = Foo({ a: "a", b: "b", });

let y = Bar({ c: "c", d: "d", });
```

The Reason code above produces the following JavaScript:

```js
const x = {
  kind: /* Foo */ "Foo",
  a: "a",
  b: "b"
};

const y = {
  kind: /* Bar */ "Bar",
  c: "c",
  d: "d"
};
```

In summary:

- `[@mel.tag "kind"]` specifies that each variant containing a payload should
  be tagged with `"kind"`.
- the `[@mel.as ".."]` attribute in each variant type specifies what that
  payload should be for each branch of the variant type.

## `@mel.send` is way, way better

When binding to methods of an object in JavaScript, Melange has historically
supported 2 different ways of achieving the same: `@mel.send` and
`@mel.send.pipe`. The only real reason why 2 constructs existed to do the same
was to support two alternatives for chaining them in OCaml:
[pipe-first](https://melange.re/v5.0.0/language-concepts.html#pipe-first) and
[pipe-last](https://melange.re/v5.0.0/language-concepts.html#pipe-last). But
this always felt like an afterthought, and code using `@mel.send.pipe` never
felt intuitive to look at (e.g. in `external say: unit [@mel.send.pipe: t]`,
one had to mentally place the `t` before `unit`, since the real signature is `t
-> unit`).

In Melange 5, we wanted to remove this weird split and further reduce the
cognitive overhead of writing bindings to call JavaScript methods on an object
or instance.

We're introducing a way to mark the "self" instance argument with
`@mel.this` and recommending only the use of `@mel.send` going forward.
Starting from this release, `@mel.send.pipe` has been deprecated, and will be
removed in the next major release of Melange. Here's an example:

```js
[@mel.send]
external push: (~value: 'a=?, [@mel.this] array('a)) => unit = "push";

let () = push([||], ~value=3);
```

The code above marks the `array('a)` argument as the instance to call the
`push` method, which produces the following JavaScript:

```js
[].push(3);
```

Besides being more versatile, having an explicit marker with `@mel.this` is
also more visually intuitive: when scanning Melange code containing `external`
bindings, it becomes easier to spot which is the "this" argument. This feature
is 100% backwards compatible with `@mel.send`: in the absence of `@mel.this`,
the instance argument defaults to the first one declared in the signature, as
previously supported.

## Additional quality of life improvements

### OCaml 5.3 Compatibility / Stdlib Upgrade

Since [Melange's
inception](https://anmonteiro.com/2021/03/on-ocaml-and-the-js-platform/), one
of its goals has been to keep it up to date with the latest OCaml releases.
[This
release](https://github.com/melange-re/melange/releases/download/5.0.1-53/melange-5.0.1-53.tbz)
brings Melange up to speed with OCaml 5.3, including upgrades to the `Stdlib`
library as well. We're also releasing Melange 5 for OCaml
[4.14](https://github.com/melange-re/melange/releases/download/5.0.1-414/melange-5.0.1-414.tbz),
[5.1](https://github.com/melange-re/melange/releases/download/5.0.1-51/melange-5.0.1-51.tbz)
and
[5.2](https://github.com/melange-re/melange/releases/download/5.0.1-52/melange-5.0.1-52.tbz).

### Melange runtime NPM packages

Starting from this release, we're shipping NPM packages with the precompiled
Melange runtime. This feature, requested by a few users in
[melange#620](https://github.com/melange-re/melange/issues/620) allows to use
Melange without compiling its own runtime and stdlib (essentially, in
combination with `(emit_stdlib false)` in `(melange.emit ..)`).

This can be useful in monorepos that compile multiple Melange applications but,
perhaps most importantly, it enables Melange libraries and packages to be
published without the weight of the full runtime / stdlib.

### Better editor support for Melange `external`s

Melange bindings to JavaScript, specified through `external` declarations, used
to propagate internal information in the [native
payload](https://ocaml.org/manual/5.3/intfc.html#external-declaration). In
practice, hovering over one of these in your editor could end up looking a bit
weird:

![](https://private-user-images.githubusercontent.com/661909/386930735-af1c5c90-2ba7-4813-b4d8-80a4f9a74aae.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDEzOTE4MjIsIm5iZiI6MTc0MTM5MTUyMiwicGF0aCI6Ii82NjE5MDkvMzg2OTMwNzM1LWFmMWM1YzkwLTJiYTctNDgxMy1iNGQ4LTgwYTRmOWE3NGFhZS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMzA3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDMwN1QyMzUyMDJaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0xYTVmNDA3Nzk4MjhlNGEzNjE0MmVkMGVlOTM3NDgzMzM4MzUwYWVlNjJjNmMxMmY1NjU2Mjg4MjM2NGYyYTI0JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.T6wIwTPOmHyWpcCBcJoon1d42nQjMGzqch7P2BbRI3Q)

Since
[melange-re/melange#1222](https://github.com/melange-re/melange/pull/1222),
Melange now propagates this information via internal attributes that only the
Melange compiler recognizes. These don't show up when hovering over
declarations in editors, making the resulting output much less jarring to look
at:

![](https://private-user-images.githubusercontent.com/661909/386930792-1d8f67ac-5e30-4e28-9c28-06bb93c4e400.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDEzOTE4MjIsIm5iZiI6MTc0MTM5MTUyMiwicGF0aCI6Ii82NjE5MDkvMzg2OTMwNzkyLTFkOGY2N2FjLTVlMzAtNGUyOC05YzI4LTA2YmI5M2M0ZTQwMC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMzA3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDMwN1QyMzUyMDJaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0zZWIzYjhkNjU4YTVhZjAzZjcxOWRhMzk1OWZkMzJkNjdiMmM4M2NhYTEwYmM4YTNkYTAxYzc2MGEzOGY0MjlhJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.2XLxUv-Zjc29HK4BqIM5aH4jzSM6lr3RI6iSn4Dgz0Q)

### Prettified JavaScript Output

In Melange 5, we modernized the JavaScript emitter to produce cleaner, more
readable, and better-indented code. Melange 5 generated JS looks remarkably
closer to hand-written JavaScript, with this release enhancing that quality
even further.


## Conclusion

Melange 5 crosses a major milestone for JavaScript expressivity, bringing great
features like idiomatic dynamic `import()`s and support for discriminated
unions. Compatibility with OCaml 5.3 marks Melange's commitment to parity with
the latest OCaml versions. In this latest version, Melange raises the bar for
increasingly prettier JavaScript prettification, and the Melange precompiled
runtime starts to be available on NPM.

Check out the [full
changelog](https://github.com/melange-re/melange/blob/main/Changes.md#500-53-2025-02-09)
for detailed information on all the changes that made it into this release. If
you find any issues or have questions, feel free to open an issue on our
[GitHub issue tracker](https://github.com/melange-re/melange/issues).

This release was sponsored by the generous support of
[Ahrefs](https://ahrefs.com/) and the [OCaml Software
Foundation](https://ocaml-sf.org/).
