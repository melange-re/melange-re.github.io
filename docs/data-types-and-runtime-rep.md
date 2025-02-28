# Data types and runtime representation

This is how each Melange type is converted into JavaScript values:

| Melange | JavaScript |
|---------------------|---------------|
| int | number |
| nativeint | number |
| int32 | number |
| float | number |
| string | string |
| array | array |
| tuple `(3, 4)` | array `[3, 4]` |
| bool | boolean |
| <a class="text-ocaml" target="_self" href="./api/ml/melange/Js/Nullable">Js.Nullable.t</a><a class="text-reasonml" target="_self" href="./api/re/melange/Js/Nullable">Js.Nullable.t</a> | `null` / `undefined` |
| <a class="text-ocaml" target="_self" href="./api/ml/melange/Js/Re">Js.Re.t</a><a class="text-reasonml" target="_self" href="./api/re/melange/Js/Re">Js.Re.t</a> | [`RegExp`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp) |
| option `None` | `undefined` |
| option <code class="text-ocaml">Some( Some .. Some (None))</code><code class="text-reasonml">Some(Some( .. Some(None)))</code> | internal representation |
| option <code class="text-ocaml">Some 2</code><code class="text-reasonml">Some(2)</code> | `2` |
| record <code class="text-ocaml">{x = 1; y = 2}</code><code class="text-reasonml">{x: 1; y: 2}</code> | object `{x: 1, y: 2}` |
| int64 | array of 2 elements `[high, low]` high is signed, low unsigned |
| char | `'a'` -\> `97` (ascii code) |
| bytes | number array |
| list `[]` | `0` |
| list <code class="text-ocaml">\[ x; y \]</code><code class="text-reasonml">\[x, y\]</code> | `{ hd: x, tl: { hd: y, tl: 0 } }` |
| variant | See below |
| polymorphic variant | See below |

Variants with a single non-nullary constructor:

```ocaml
type tree = Leaf | Node of int * tree * tree
(* Leaf -> 0 *)
(* Node(7, Leaf, Leaf) -> { _0: 7, _1: 0, _2: 0 } *)
```
```reasonml
type tree =
  | Leaf
  | Node(int, tree, tree);
/* Leaf -> 0 */
/* Node(7, Leaf, Leaf) -> { _0: 7, _1: 0, _2: 0 } */
```

Variants with more than one non-nullary constructor:

```ocaml
type t = A of string | B of int
(* A("foo") -> { TAG: 0, _0: "Foo" } *)
(* B(2) -> { TAG: 1, _0: 2 } *)
```
```reasonml
type t =
  | A(string)
  | B(int);
/* A("foo") -> { TAG: 0, _0: "Foo" } */
/* B(2) -> { TAG: 1, _0: 2 } */
```

Polymorphic variants:

```ocaml
let u = `Foo (* "Foo" *)
let v = `Foo(2) (* { NAME: "Foo", VAL: "2" } *)
```
```reasonml
let u = `Foo; /* "Foo" */
let v = `Foo(2); /* { NAME: "Foo", VAL: "2" } */
```

Let’s see now some of these types in detail. We will first describe the [shared
types](#shared-types), which have a transparent representation as JavaScript
values, and then go through the [non-shared types](#non-shared-data-types), that
have more complex runtime representations.

> **_NOTE:_** Relying on the non-shared data types runtime representations by
> reading or writing them manually from JavaScript code that communicates with
> Melange code might lead to runtime errors, as these representations might
> change in the future.

## Shared types

The following are types that can be shared between Melange and JavaScript almost
"as is". Specific caveats are mentioned on the sections where they apply.

### Strings

JavaScript strings are immutable sequences of UTF-16 encoded Unicode text. OCaml
strings are immutable sequences of bytes and nowadays assumed to be UTF-8
encoded text when interpreted as textual content. This is problematic when
interacting with JavaScript code, because if one tries to use some unicode
characters, like:

```ocaml
let () = Js.log "你好"
```
```reasonml
let () = Js.log("你好");
```

It will lead to some cryptic console output. To rectify this, Melange allows to
define [quoted string
literals](https://v2.ocaml.org/manual/lex.html#sss:stringliterals) using the
`js` identifier, for example:

```ocaml
let () = Js.log {js|你好，
世界|js}
```
```reasonml
let () = Js.log({js|你好，
世界|js});
```

For convenience, Melange exposes another special quoted string identifier: `j`.
It is similar to JavaScript’ string interpolation, but for variables only (not
arbitrary expressions):

```ocaml
let world = {j|世界|j}
let helloWorld = {j|你好，$world|j}
```
```reasonml
let world = {j|世界|j};
let helloWorld = {j|你好，$world|j};
```

You can surround the interpolation variable in parentheses too: `{j|你
好，$(world)|j}`.

To work with strings, the Melange standard library provides some utilities in
the <a class="text-ocaml" target="_self"
href="./api/ml/melange/Stdlib/String"><code>Stdlib.String</code> module</a><a
class="text-reasonml" target="_self"
href="./api/re/melange/Stdlib/String"><code>Stdlib.String</code> module</a>. The
bindings to the native JavaScript functions to work with strings are in the <a
class="text-ocaml" target="_self"
href="./api/ml/melange/Js/String"><code>Js.String</code> module</a><a
class="text-reasonml" target="_self"
href="./api/re/melange/Js/String"><code>Js.String</code> module</a>.

### Floating-point numbers

OCaml floats are [IEEE
754](https://en.wikipedia.org/wiki/Double-precision_floating-point_format#IEEE_754_double-precision_binary_floating-point_format:_binary64)
with a 53-bit mantissa and exponents from -1022 to 1023. This happens to be the
same encoding as [JavaScript
numbers](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number#number_encoding),
so values of these types can be used transparently between Melange code and
JavaScript code. The Melange standard library provides a <a class="text-ocaml"
target="_self" href="./api/ml/melange/Stdlib/Float"><code>Stdlib.Float</code>
module</a><a class="text-reasonml" target="_self"
href="./api/re/melange/Stdlib/Float"><code>Stdlib.Float</code> module</a>. The
bindings to the JavaScript APIs that manipulate float values can be found in the
<a class="text-ocaml" target="_self"
href="./api/ml/melange/Js/Float"><code>Js.Float</code> module</a><a
class="text-reasonml" target="_self"
href="./api/re/melange/Js/Float"><code>Js.Float</code> module</a>.

### Integers

In Melange, integers are limited to 32 bits due to the [fixed-width
conversion](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number#fixed-width_number_conversion)
of bitwise operations in JavaScript. While Melange integers compile to
JavaScript numbers, treating them interchangeably can result in unexpected
behavior due to differences in precision. Even though bitwise operations in
JavaScript are constrained to 32 bits, integers themselves are represented using
the same floating-point format [as
numbers](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number#number_encoding),
allowing for a larger range of representable integers in JavaScript compared to
Melange. When dealing with large numbers, it is advisable to use floats instead.
For instance, floats are used in bindings like `Js.Date`.

The Melange standard library provides a <a class="text-ocaml" target="_self"
href="./api/ml/melange/Stdlib/Int"><code>Stdlib.Int</code> module</a><a
class="text-reasonml" target="_self"
href="./api/re/melange/Stdlib/Int"><code>Stdlib.Int</code> module</a>. The
bindings to work with JavaScript integers are in the <a class="text-ocaml"
target="_self" href="./api/ml/melange/Js/Int"><code>Js.Int</code> module</a><a
class="text-reasonml" target="_self"
href="./api/re/melange/Js/Int"><code>Js.Int</code> module</a>.

### Arrays

Melange arrays compile to JavaScript arrays. But note that unlike JavaScript
arrays, all the values in a Melange array need to have the same type.

Another difference is that OCaml arrays are fixed-sized, but on Melange side
this constraint is relaxed. You can change an array’s length using functions
like `Js.Array.push`, available in the bindings to the JavaScript APIs in the <a
class="text-ocaml" target="_self"
href="./api/ml/melange/Js/Array"><code>Js.Array</code> module</a><a
class="text-reasonml" target="_self"
href="./api/re/melange/Js/Array"><code>Js.Array</code> module</a>.

Melange standard library also has a module to work with arrays, available in the
<a class="text-ocaml" target="_self"
href="./api/ml/melange/Stdlib/Array"><code>Stdlib.Array</code> module</a><a
class="text-reasonml" target="_self"
href="./api/re/melange/Stdlib/Array"><code>Stdlib.Array</code> module</a>.

### Tuples

OCaml tuples are compiled to JavaScript arrays. This is convenient when writing
bindings that will use a JavaScript array with heterogeneous values, but that
happens to have a fixed length.

As a real world example of this can be found in
[ReasonReact](https://github.com/reasonml/reason-react/), the Melange bindings
for [React](https://react.dev/). In these bindings, component effects
dependencies are represented as OCaml tuples, so they get compiled cleanly to
JavaScript arrays by Melange.

For example, some code like this:

<!--#prelude#
let foo, bar = 1, 2
module React = struct let useEffect2 _ _ = () end
-->
```ocaml
let () = React.useEffect2 (fun () -> None) (foo, bar)
```
```reasonml
let () = React.useEffect2(() => None, (foo, bar));
```

Will produce:

```js
React.useEffect(function () {}, [foo, bar]);
```

### Booleans

Values of type `bool` compile to JavaScript booleans.

### Records

Melange records map directly to JavaScript objects. If the record fields include
non-shared data types (like variants), these values should be transformed
separately, and not be directly used in JavaScript.

Extensive documentation about interfacing with JavaScript objects using records
can be found in [the section
below](./working-with-js-objects-and-values.md#bind-to-js-object).

### Regular expressions

Regular expressions created using the `%mel.re` extension node compile to their
JavaScript counterpart.

For example:

```ocaml
let r = [%mel.re "/b/g"]
```
```reasonml
let r = [%mel.re "/b/g"];
```

Will compile to:

```js
var r = /b/g;
```

A regular expression like the above is of type `Js.Re.t`. The <a
class="text-ocaml" target="_self"
href="./api/ml/melange/Js/Re"><code>Js.Re</code> module</a><a
class="text-reasonml" target="_self"
href="./api/re/melange/Js/Re"><code>Js.Re</code> module</a> provides the
bindings to the JavaScript functions that operate over regular expressions.

## Non-shared data types

The following types differ too much between Melange and JavaScript, so while
they can always be manipulated from JavaScript, it is recommended to transform
them before doing so.

- Variants and polymorphic variants: Better transform them into readable
  JavaScript values before manipulating them from JavaScript, Melange provides
  [some
  helpers](./advanced-js-interop.md#generate-getters-setters-and-constructors)
  to do so.
- Exceptions
- Option (a variant type): Better use the `Js.Nullable.fromOption` and
  `Js.Nullable.toOption` functions in the <a class="text-ocaml" target="_self"
  href="./api/ml/melange/Js/Nullable"><code>Js.Nullable</code> module</a><a
  class="text-reasonml" target="_self"
  href="./api/re/melange/Js/Nullable"><code>Js.Nullable</code> module</a> to
  transform them into either `null` or `undefined` values.
- List (also a variant type): use `Array.of_list` and `Array.to_list` in the <a
  class="text-ocaml" target="_self"
  href="./api/ml/melange/Stdlib/Array"><code>Stdlib.Array</code> module</a><a
  class="text-reasonml" target="_self"
  href="./api/re/melange/Stdlib/Array"><code>Stdlib.Array</code> module</a>.
- Character
- Int64
- Lazy values
