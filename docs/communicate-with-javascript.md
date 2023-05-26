# Communicate with JavaScript

Melange interoperates very well with JavaScript, and provides a wide array of
features to consume foreign JavaScript code. To learn about these techniques, we
will first go through the language concepts that they build upon, then we will
see how types in Melange map to JavaScript runtime types. Finally, we will
provide a variety of use cases with examples to show how to communicate to and
from JavaScript.

## Language concepts

The concepts covered in the following sections are a small subset of the OCaml
language. However, they are essential for understanding how to communicate with
JavaScript, and the features that Melange exposes to do so.

### Attributes and extension nodes

In order to interact with JavaScript, Melange needs to extend the language to
provide blocks that express these interactions.

One approach could be to introduce new syntactic constructs (keywords and such)
to do so, for example:

```text
javascript add : int -> int -> int = {|function(x,y){
  return x + y
}|}
```

But this would break compatibility with OCaml, which is one of the main goals of
Melange.

Fortunately, OCaml provides mechanisms to extend its language without breaking
compatibility with the parser or the language. These mechanisms are composed by
two parts:
- First, some syntax additions to define parts of the code that will be extended
  or replaced
- Second, compile-time OCaml native programs called [PPX
  rewriters](https://ocaml.org/docs/metaprogramming), that will read the syntax
  additions defined above and proceed to extend or replace them

The syntax additions come in two flavors, called [extension
nodes](https://v2.ocaml.org/manual/extensionnodes.html) and
[attributes](https://v2.ocaml.org/manual/attributes.html).

#### Extension nodes

Extension nodes are blocks that are supposed to be replaced by a specific type
of PPX rewriters called extenders. Extension nodes use the `%` character to be
identified. Extenders will take the extension node and replace it with a valid
OCaml AST (abstract syntax tree).

An example where Melange uses extension nodes to communicate with JavaScript is
to produce "raw" JavaScript inside a Melange program:

```ocaml
[%%bs.raw "var a = 1; var b = 2"]
let add = [%bs.raw "a + b"]
```
```reasonml
%bs.raw
"var a = 1; var b = 2";
let add = [%bs.raw "a + b"];
```

Which will generate the following JavaScript code:

```js
var a = 1; var b = 2
var add = a + b
```

The difference between one and two percentage characters is detailed in the
[OCaml documentation](https://v2.ocaml.org/manual/extensionnodes.html).

#### Attributes

Attributes are "decorations" applied to specific parts of the code to provide
additional information. In Melange, attributes are used in two ways to enhance
the expressiveness of generating JavaScript code: either reusing existing OCaml
built-in attributes or defining new ones.

##### Reusing OCaml attributes

The first approach is leveraging the existing [OCaml’s built-in
attributes](https://v2.ocaml.org/manual/attributes.html#ss:builtin-attributes)
to be used for JavaScript generation.

One prominent example of OCaml attributes that can be used in Melange projects
is the `unboxed` attribute, which optimizes the compilation of single-field
records and variants with a single tag to their raw values. This is useful when
defining type aliases that we don’t want to mix up, or when binding to
JavaScript code that uses heterogeneous collections. An example of the latter is
discussed in the [variadic function arguments](#variadic-function-arguments)
section.

For instance:

```ocaml
type name =
  | Name of string [@@unboxed]
let student_name = Name "alice"
```
```reasonml
[@unboxed]
type name =
  | Name(string);
let student_name = Name("alice");
```

Compiles into:

```js
var student_name = "alice";
```

Other OCaml pre-built attributes like `alert` or `deprecated` can be used with
Melange as well.

##### Defining new attributes

The second approach is introducing new attributes specifically designed for
Melange, such as the [`bs.val`
attribute](#bind-to-global-javascript-functions-or-values) used to bind to
global JavaScript values. The complete list of attributes introduced by Melange
can be found [here](#list-of-attributes-and-extension-nodes).

Attribute annotations can use one, two or three `@` characters depending on
their placement in the code and which kind of syntax tree node they are
annotating. More information about attributes can be found in the [dedicated
OCaml manual page](https://v2.ocaml.org/manual/attributes.html).

Here are some samples using Melange attributes
[`bs.val`](#bind-to-global-javascript-functions-or-values) and
[`bs.as`](#using-ocaml-records):

```ocaml
external clearTimeout : timeoutId -> unit = "clearTimeout" [@@bs.val]

type t = {
  age : int; [@bs.as "a"]
  name : string; [@bs.as "n"]
}
```
```reasonml
[@bs.val] external clearTimeout: timeoutId => unit = "clearTimeout";

type t = {
  [@bs.as "a"]
  age: int,
  [@bs.as "n"]
  name: string,
};
```

To learn more about preprocessors, attributes and extension nodes, check the
[section about PPX
rewriters](https://ocaml.org/docs/metaprogramming#ppx-rewriters) in the OCaml
docs.

### External functions

Most of the system that Melange exposes to communicate with JavaScript is built
on top of an OCaml language construct called `external`.

`external` is a keyword for declaring a value in OCaml that will [interface with
C code](https://v2.ocaml.org/manual/intfc.html):

```ocaml
external my_c_function : int -> string = "someCFunctionName"
```
```reasonml
external my_c_function: int => string = "someCFunctionName";
```

It is like a `let` binding, except that the body of an external is a string.
That string has a specific meaning depending on the context. For native OCaml,
it usually refers to a C function with that name. For Melange, it refers to the
functions or values that exist in the runtime JavaScript code, and will be used
from Melange.

Melange externals are always decorated with certain `[@bs.xxx]` attributes. Each
one of the [available attributes](#list-of-attributes-and-extension-nodes) will
be further explained in the next sections.

Once declared, one can use an `external` as a normal value. Melange external
functions are turned into the expected JavaScript values, inlined into their
callers during compilation, and completely erased afterwards. They don’t appear
in the JavaScript output, so there are no costs on bundling size.

**Note**: it is recommended to use external functions and the `[@bs.xxx]`
attributes in the interface files as well, as this allows some optimizations
where the resulting JavaScript values can be directly inlined at the call sites.

#### Special identity external

One external worth mentioning is the following one:

```ocaml
type foo = string
type bar = int
external danger_zone : foo -> bar = "%identity"
```
```reasonml
type foo = string;
type bar = int;
external danger_zone: foo => bar = "%identity";
```

This is a final escape hatch which does nothing but convert from the type `foo`
to `bar`. In the following sections, if you ever fail to write an `external`,
you can fall back to using this one. But try not to.

### Abstract types

In the subsequent sections, you will come across examples of bindings where a
type is defined without being assigned to a value. Here is an example:

```ocaml
type document
```
```reasonml
type document;
```

These types are referred to as "abstract types" and are commonly used together
with external functions that define operations over values when communicating
with JavaScript.

Abstract types enable defining types for specific values originating from
JavaScript while omitting unnecessary details. An illustration is the `document`
type mentioned earlier, which has several
[properties](https://developer.mozilla.org/en-US/docs/Web/API/Document). By
using abstract types, one can focus solely on the required aspects of the
`document` value that the Melange program requires, rather than defining all its
properties. Consider the following example:

```ocaml
type document

external document : document = "document" [@@bs.val]
external set_title : document -> string -> unit = "title" [@@bs.set]
```
```reasonml
type document;

[@bs.val] external document: document = "document";
[@bs.set] external set_title: (document, string) => unit = "title";
```

Subsequent sections delve into the details of the
[`bs.val`](#bind-to-global-javascript-functions-or-values) and
[`bs.set`](#bind-to-object-properties) attributes.

For a comprehensive understanding of abstract types and their usefulness, refer
to the "Encapsulation" section of the [OCaml Cornell
textbook](https://cs3110.github.io/textbook/chapters/modules/encapsulation.html).

### Pipe operators

There are two pipe operators available in Melange:

- A _pipe last_ operator `|>`, available [in
  OCaml](https://v2.ocaml.org/api/Stdlib.html#1_Compositionoperators) and
  inherited in Melange
  
- A _pipe first_ operator <code class="text-ocaml">\|.</code><code
  class="text-reasonml">\-\></code>, available exclusively in Melange

Let’s see the differences between the two.

#### Pipe last

Since version 4.01, OCaml includes a reverse application or "pipe" (`|>`)
operator, an infix operator that applies the result from the previous expression
the next function. As a backend for OCaml, Melange inherits this operator.

The pipe operator could be implemented like this (the real implementation is a
bit
[different](https://github.com/ocaml/ocaml/blob/d9547617e8b14119beacafaa2546cbebfac1bfe5/stdlib/stdlib.ml#L48)):

```ocaml
let ( |> ) f g = g f
```
```reasonml
let (|>) = (f, g) => g(f);
```

This operator is useful when multiple functions are applied to some value in
sequence, with the output of each function becoming the input of the next (a
_pipeline_).

For example, assuming we have a function `square` defined as:

```ocaml
let square x = x * x
```
```reasonml
let square = x => x * x;
```

We are using it like:

```ocaml
let ten = succ (square 3)
```
```reasonml
let ten = succ(square(3));
```

The pipe operator allows to write the computation for `ten` in left-to-right
order, as [it has left
associativity](https://v2.ocaml.org/manual/expr.html#ss:precedence-and-associativity):

```ocaml
let ten = 3 |> square |> succ
```
```reasonml
let ten = 3 |> square |> succ;
```

When working with functions that can take multiple arguments, the pipe operator
works best when the functions take the data we are processing as the last
argument. For example:

```ocaml
let sum = List.fold_left ( + ) 0

let sum_sq =
  [ 1; 2; 3 ]
  |> List.map square (* [1; 4; 9] *)
  |> sum             (* 1 + 4 + 9 *)
```
```reasonml
let sum = List.fold_left((+), 0);

let sum_sq =
  [1, 2, 3]
  |> List.map(square)  /* [1; 4; 9] */
  |> sum; /* 1 + 4 + 9 */
```

The above example can be written concisely because the `List.map` function in
the [OCaml standard library](https://v2.ocaml.org/api/Stdlib.List.html) takes
the list as the second argument. This convention is sometimes referred to as
"data-last", and is widely adopted in the OCaml ecosystem. Data-last and the
pipe operator `|>` work great with currying, so they are a great fit for the
language.

However, there are some limitations when using data-last when it comes to error
handling. In the given example, if we mistakenly used the wrong function:

```ocaml
let sum_sq =
  [ 1; 2; 3 ]
  |> List.map String.cat
  |> sum
```
```reasonml
let sum_sq = [1, 2, 3] |> List.map(String.cat) |> sum;
```

The compiler would rightfully raise an error:

<pre class="text-ocaml"><code class="language-text hljs plaintext">4 |   [ 1; 2; 3 ]
        ^
Error: This expression has type int but an expression was expected of type
         string</code></pre>
<pre class="text-reasonml"><code class="language-text hljs plaintext">1 |   [ 1, 2, 3 ]
        ^
Error: This expression has type int but an expression was expected of type
         string</code></pre>

Note that instead of telling us that we are passing the wrong function in
`List.map` (`String.cat`), the error points to the list itself. This behavior
aligns with the way type inference works, as the compiler infers types from left
to right. Since `[ 1; 2; 3 ] |> List.map String.cat` is equivalent to `List.map
String.cat [ 1; 2; 3 ]`, the type mismatch is detected when the list is type
checked, after `String.cat` has been processed.

With the goal of addressing this kind of limitations, Melange introduces the
pipe first operator <code class="text-ocaml">\|.</code><code
class="text-reasonml">\-\></code>.

#### Pipe first

To overcome the constraints mentioned above and enable the generation of more
performant JavaScript code, Melange introduces the pipe first operator <code
class="text-ocaml">\|.</code><code class="text-reasonml">\-\></code>.

Unlike the pipe last operator, the pipe first operator is not defined as an
infix operator. Instead, it is a purely syntactic transformation. This means
that the parser will convert <code class="text-ocaml">f \|. g</code><code
class="text-reasonml">f-\>g</code> into `g f` without any runtime performance
impact.

As its name suggests, the pipe first operator is better suited for functions
where the data is passed as the first argument.

The functions in the [`Belt` library](todo-fix-me.md) included with Melange have
been designed with the data-first convention in mind, so they work best with the
pipe first operator.

For example, we can rewrite the example above using `Belt.List.map` and the pipe
first operator:

```ocaml
let sum_sq =
  [ 1; 2; 3 ]
  |. Belt.List.map square
  |. sum
```
```reasonml
let sum_sq = [1, 2, 3]->(Belt.List.map(square))->sum;
```

We can see the difference on the error we get if the wrong function is passed to
`Belt.List.map`:

```ocaml
let sum_sq =
  [ 1; 2; 3 ]
  |. Belt.List.map String.cat
  |. sum
```
```reasonml
let sum_sq = [1, 2, 3]->(Belt.List.map(String.cat))->sum;
```

The compiler will show this error message:

<pre class="text-ocaml"><code class="language-text hljs plaintext">4 |   |. Belt.List.map String.cat
                       ^^^^^^^^^^
Error: This expression has type string -> string -> string
       but an expression was expected of type int -> 'a
       Type string is not compatible with type int</code></pre>
<pre class="text-reasonml"><code class="language-text hljs plaintext">2 | let sum_sq = [1, 2, 3]->(Belt.List.map(String.cat))->sum;
                                           ^^^^^^^^^^
Error: This expression has type string -> string -> string
       but an expression was expected of type int -> 'a
       Type string is not compatible with type int</code></pre>

The error points now to the function passed to `Belt.List.map`, which is more
natural with the way the code is being written.

Melange supports writing bindings to JavaScript using any of the two
conventions, data-first or data-last, as shown in the ["Chaining"
section](#chaining).

For further details about the differences between the two operators, the
data-first and data-last conventions and the trade-offs between them, one can
refer to [this related blog
post](https://www.javierchavarri.com/data-first-and-data-last-a-comparison/).

## Data types and runtime representation

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
| [Js.Nullable.t](todo-fix-me.md) | `null` / `undefined` |
| [Js.Re.t](todo-fix-me.md) | [`RegExp`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp) |
| Option.t `None` | `undefined` |
| Option.t <code class="text-ocaml">Some( Some .. Some (None))</code><code class="text-reasonml">Some(Some( .. Some(None)))</code> | internal representation |
| <p>foo</p> | `2` |
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

### Shared types

The following are types that can be shared between Melange and JavaScript almost
"as is". Specific caveats are mentioned on the sections where they apply.

#### Strings

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
the [`Stdlib.String` module](todo-fix-me.md). The bindings to the native
JavaScript functions to work with strings are in the [`Js.String`
module](todo-fix-me.md).

#### Floating-point numbers

OCaml floats are [IEEE
754](https://en.wikipedia.org/wiki/Double-precision_floating-point_format#IEEE_754_double-precision_binary_floating-point_format:_binary64)
with a 53-bit mantissa and exponents from -1022 to 1023. This happens to be the
same encoding as [JavaScript
numbers](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number#number_encoding),
so values of these types can be used transparently between Melange code and
JavaScript code. The Melange standard library provides a [`Stdlib.Float`
module](todo-fix-me.md). The bindings to the JavaScript APIs that manipulate
float values can be found in the [`Js.Float`](todo-fix-me.md) module.

#### Integers

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

The Melange standard library provides a [`Stdlib.Int` module](todo-fix-me.md).
The bindings to work with JavaScript integers are in the
[`Js.Int`](todo-fix-me.md) module.

#### Arrays

Melange arrays compile to JavaScript arrays. But note that unlike JavaScript
arrays, all the values in a Melange array need to have the same type.

Another difference is that OCaml arrays are fixed-sized, but on Melange side
this constraint is relaxed. You can change an array’s length using functions
like `Js.Array.push`, available in the bindings to the JavaScript APIs in
[`Js.Array`](todo-fix-me.md).

Melange standard library also has a module to work with arrays, available in
`Stdlib.Array`(todo-fix-me.md) module.

#### Tuples

OCaml tuples are compiled to JavaScript arrays. This is convenient when writing
bindings that will use a JavaScript array with heterogeneous values, but that
happens to have a fixed length.

As a real world example of this can be found in
[ReasonReact](https://github.com/reasonml/reason-react/), the Melange bindings
for [React](https://react.dev/). In these bindings, component effects
dependencies are represented as OCaml tuples, so they get compiled cleanly to
JavaScript arrays by Melange.

For example, some code like this:

```ocaml
let () = React.useEffect2 (fun () -> None) (foo, bar)
```
```reasonml
let () = React.useEffect2(() => None, (foo, bar));
```

Will produce:

```javascript
React.useEffect(function () {}, [foo, bar]);
```

#### Booleans

Values of type `bool` compile to JavaScript booleans.

#### Records

Melange records map directly to JavaScript objects. If the record fields include
non-shared data types (like variants), these values should be transformed
separately, and not be directly used in JavaScript.

Extensive documentation about interfacing with JavaScript objects using records
can be found in [the section below](#bind-to-js-object).

#### Regular expressions

Regular expressions created using the `%bs.re` extension node compile to their
JavaScript counterpart.

For example:

```ocaml
let r = [%bs.re "/b/g"]
```
```reasonml
let r = [%bs.re "/b/g"];
```

Will compile to:

```js
var r = /b/g;
```

A regular expression like the above is of type `Js.Re.t`. The
[`Js.Re`](todo-fix-me.md) module provides the bindings to the JavaScript
functions that operate over regular expressions.

## Non-shared data types

The following types differ too much between Melange and JavaScript, so while
they can always be manipulated from JavaScript, it is recommended to transform
them before doing so.

- Variants and polymorphic variants: Better transform them into readable
  JavaScript values before manipulating them from JavaScript, Melange provides
  [some helpers](#generate-getters-setters-and-constructors) to do so.
- Exceptions
- Option (a variant type): Better use the `Js.Nullable.fromOption` and
  `Js.Nullable.toOption` functions in the [`Js.Nullable` module](todo-fix-me.md)
  to transform them into either `null` or `undefined` values.
- List (also a variant type): use `Array.of_list` and `Array.to_list` in the
  [`Array` module](todo-fix-me.md).
- Character
- Int64
- Lazy values

## List of attributes and extension nodes

> **_NOTE:_** All these attributes and extension nodes are prefixed with `bs.`
> for backwards compatibility. They will be updated to `mel.` in the future.

**Attributes:**

These attributes are used to annotate `external` definitions:

- [`bs.get`](#bind-to-object-properties): read JavaScript object properties
  statically by name, using the dot notation `.`
- [`bs.get_index`](#bind-to-object-properties): read a JavaScript object’s
  properties dynamically by using the bracket notation `[]`
- [`bs.module`](#using-functions-from-other-javascript-modules): bind to a value
  from a JavaScript module
- [`bs.new`](#javascript-classes): bind to a JavaScript class constructor
- [`bs.obj`](#using-external-functions): create a JavaScript object
- [`bs.return`](#wrapping-returned-nullable-values): automate conversion from
  nullable values to `Option.t` values
- [`bs.send`](#calling-an-object-method): call a JavaScript object method using
  [pipe first](todo-fix-me.md) convention
- [`bs.send.pipe`](#calling-an-object-method): call a JavaScript object method
  using [pipe last](todo-fix-me.md) convention
- [`bs.set`](#bind-to-object-properties): set JavaScript object properties
  statically by name, using the dot notation `.`
- [`bs.set_index`](#bind-to-object-properties): set JavaScript object properties
  dynamically by using the bracket notation `[]`
- [`bs.scope`](#binding-to-properties-inside-a-module-or-global): reach to
  deeper properties inside a JavaScript object
- [`bs.val`](#bind-to-global-javascript-functions-or-values): bind to global
  JavaScript functions or other values
- [`bs.variadic`](#variadic-function-arguments): bind to a function taking
  variadic arguments from an array

These attributes are used to annotate arguments in `external` definitions:

- [`bs`](#binding-to-callbacks): define function arguments as uncurried (manual)
- [`bs.int`](#using-polymorphic-variants-to-bind-to-enums): compile function
  argument to an int
- [`bs.string`](#using-polymorphic-variants-to-bind-to-enums): compile function
  argument to a string
- [`bs.this`](#modeling-this-based-callbacks): bind to `this` based callbacks
- [`bs.uncurry`](#binding-to-callbacks): define function arguments as uncurried
  (automated)
- [`bs.unwrap`](#approach-2-polymorphic-variant-bsunwrap): unwrap variant values

These attributes are used in places like records, fields, arguments, functions,
and more:

- `bs.as`: redefine the name generated in the JavaScript output code. Used in
  [constant function arguments](#constant-values-as-arguments),
  [variants](#conversion-functions), polymorphic variants (either [inlined in
  external functions](#using-polymorphic-variants-to-bind-to-enums) or [in type
  definitions](#polymorphic-variants)) and [record
  fields](#objects-with-static-shape-record-like).
- [`bs.deriving`](#generate-getters-setters-and-constructors): generate getters
  and setters for some types
- [`bs.inline`](#inlining-constant-values): forcefully inline constant values
- [`bs.optional`](#convert-records-into-abstract-types): omit fields in a record
  (combines with `bs.deriving`)

**Extension nodes:**

In order to use any of these extension nodes, you will have to add the melange
PPX preprocessor to your project. To do so, add the following to the `dune`
file:

```text
(library
 (name lib)
 (modes melange)
 (preprocess
   (pps melange.ppx)))
```

The same field `preprocess` can be added to `melange.emit`.

Here is the list of all the extension nodes supported by Melange:

- [`bs.debugger`](#debugger): insert `debugger` statements
- [`bs.external`](#detect-global-variables): read global values
- [`bs.obj`](#using-jst-objects): create JavaScript object literals
- [`bs.raw`](#generate-raw-javascript): write raw JavaScript code
- [`bs.re`](#regular-expressions): insert regular expressions

## Generate raw JavaScript

It is possible to directly write JavaScript code from a Melange file. This is
unsafe, but it can be useful for prototyping or as an escape hatch.

To do it, we will use the `bs.raw`
[extension](https://v2.ocaml.org/manual/extensionnodes.html):

```ocaml
let add = [%bs.raw {|
  function(a, b) {
    console.log("hello from raw JavaScript!");
    return a + b;
  }
|}]

let () = Js.log (add 1 2)
```
```reasonml
let add = [%bs.raw
  {|
  function(a, b) {
    console.log("hello from raw JavaScript!");
    return a + b;
  }
|}
];

let () = Js.log(add(1, 2));
```

The `{||}` strings are called ["quoted
strings"](https://ocaml.org/manual/lex.html#quoted-string-id). They are similar
to JavaScript’s template literals, in the sense that they are multi-line, and
there is no need to escape characters inside the string.

Using one percentage sign (`[%bs.raw <string>]`) is useful to define expressions
(function bodies, or other values) where the implementation is directly
JavaScript. This is useful as we can attach the type signature already in the
same line, to make our code safer. For example:

```ocaml
[%%bs.raw "var a = 1"]

let f : unit -> int = [%bs.raw "function() {return 1}"]
```
```reasonml
%bs.raw
"var a = 1";

let f: unit => int = ([%bs.raw "function() {return 1}"]: unit => int);
```

Using two percentage signs (`[%%bs.raw <string>]`) is reserved for definitions
in a
[structure](https://v2.ocaml.org/manual/moduleexamples.html#s:module:structures)
or [signature](https://v2.ocaml.org/manual/moduleexamples.html#s%3Asignature).

For example:

```ocaml
[%%bs.raw "var a = 1"]
```
```reasonml
%bs.raw
"var a = 1";
```

## Debugger

Melange allows to inject a `debugger;` expression using the `bs.debugger`
extension:

```ocaml
let f x y =
  [%bs.debugger];
  x + y
```
```reasonml
let f = (x, y) => {
  [%bs.debugger];
  x + y;
};
```

Output:

```javascript
function f (x,y) {
  debugger; // JavaScript developer tools will set a breakpoint and stop here
  x + y;
}
```

## Detect global variables

Melange provides a relatively type safe approach to use globals that might be
defined either in the JavaScript runtime environment: `bs.external`.

`[%bs.external id]` will check if the JavaScript value `id` is `undefined` or
not, and return an `Option.t` value accordingly.

For example:

```ocaml
let () = match [%bs.external __DEV__] with
| Some _ -> Js.log "dev mode"
| None -> Js.log "production mode"
```
```reasonml
let () =
  switch ([%bs.external __DEV__]) {
  | Some(_) => Js.log("dev mode")
  | None => Js.log("production mode")
  };
```

Another example:

```ocaml
let () = match [%bs.external __filename] with
| Some f -> Js.log f
| None -> Js.log "non-node environment"
```
```reasonml
let () =
  switch ([%bs.external __filename]) {
  | Some(f) => Js.log(f)
  | None => Js.log("non-node environment")
  };
```

## Inlining constant values

Some JavaScript idioms require special constants to be inlined since they serve
as de-facto directives for bundlers. A common example is `process.env.NODE_ENV`:

```js
if (process.env.NODE_ENV !== "production") {
  // Development-only code
}
```

becomes:

```js
if ("development" !== "production") {
  // Development-only code
}
```

In this case, bundlers such as Webpack can tell that the `if` statement always
evaluates to a specific branch and eliminate the others.

Melange provides the `bs.inline` attribute to achieve the same goal in generated
JavaScript. Let’s look at an example:

```ocaml
external node_env : string = "NODE_ENV" [@@bs.val] [@@bs.scope "process", "env"]

let development = "development"
let () = if node_env <> development then Js.log "Only in Production"

let development_inline = "development" [@@bs.inline]
let () = if node_env <> development_inline then Js.log "Only in Production"
```
```reasonml
[@bs.val] [@bs.scope ("process", "env")]
external node_env: string = "NODE_ENV";

let development = "development";
let () =
  if (node_env != development) {
    Js.log("Only in Production");
  };

[@bs.inline]
let development_inline = "development";
let () =
  if (node_env != development_inline) {
    Js.log("Only in Production");
  };
```

As we can see in the generated JavaScript presented below:

- the `development` variable is emitted
    - it gets used as a variable `process.env.NODE_ENV !== development` in the
      `if` statement
- the `development_inline` variable isn’t present in the final output
    - its value is inlined in the `if` statement: `process.env.NODE_ENV !==
      "development"`

```js
var development = "development";

if (process.env.NODE_ENV !== development) {
  console.log("Only in Production");
}

if (process.env.NODE_ENV !== "development") {
  console.log("Only in Production");
}
```

## Bind to JavaScript objects

JavaScript objects are used in a variety of use cases:

- As a fixed shape
  [record](https://en.wikipedia.org/wiki/Record_\(computer_science\)).
- As a map or dictionary.
- As a class.
- As a module to import/export.

Melange separates the binding methods for JavaScript objects based on these four
use cases. This section documents the first three. Binding to JavaScript module
objects is described in the ["Using functions from other JavaScript
modules"](#using-functions-from-other-javascript-modules) section.

<!-- TODO: mention scope here too? -->

### Objects with static shape (record-like)

#### Using OCaml records

If your JavaScript object has fixed fields, then it’s conceptually like an
[OCaml
record](https://v2.ocaml.org/manual/coreexamples.html#s%3Atut-recvariants).
Since Melange compiles records into JavaScript objects, the most common way to
bind to JavaScript objects is using records.

```ocaml
type person = {
  name : string;
  friends : string array;
  age : int;
}

external john : person = "john" [@@bs.module "MySchool"]
let john_name = john.name
```
```reasonml
type person = {
  name: string,
  friends: array(string),
  age: int,
};

[@bs.module "MySchool"] external john: person = "john";
let john_name = john.name;
```

This is the generated JavaScript:

```js
var MySchool = require("MySchool");

var john_name = MySchool.john.name;
```

External functions are documented in [a previous section](#external-functions).
The `bs.module` attribute is documented
[here](#using-functions-from-other-javascript-modules).

If you want or need to use different field names on the Melange and the
JavaScript sides, you can use the `bs.as` decorator:

```ocaml
type action = {
  type_ : string [@bs.as "type"]
}

let action = { type_ = "ADD_USER" }
```
```reasonml
type action = {
  [@bs.as "type"]
  type_: string,
};

let action = {type_: "ADD_USER"};
```

Which generates the JavaScript code:

```js
var action = {
  type: "ADD_USER"
};
```

This is useful to map to JavaScript attribute names that cannot be expressed in
Melange, for example, where the JavaScript name we want to generate is a
[reserved keyword](https://v2.ocaml.org/manual/lex.html#sss:keywords).

It is also possible to map a Melange record to a JavaScript array by passing
indices to the `bs.as` decorator:

```ocaml
type t = {
  foo : int; [@bs.as "0"]
  bar : string; [@bs.as "1"]
}

let value = { foo = 7; bar = "baz" }
```
```reasonml
type t = {
  [@bs.as "0"]
  foo: int,
  [@bs.as "1"]
  bar: string,
};

let value = {foo: 7, bar: "baz"};
```

And its JavaScript generated code:

```js
var value = [
  7,
  "baz"
];
```

#### Using `Js.t` objects

Alternatively to records, Melange offers another type that can be used to
produce JavaScript objects. This type is `'a Js.t`, where `'a` is an [OCaml
object](https://v2.ocaml.org/manual/objectexamples.html).

The advantage of objects versus records is that no type declaration is needed in
advance, which can be helpful for prototyping or quickly generating JavaScript
object literals.

Melange provides some ways to create `Js.t` object values, as well as accessing
the properties inside them. To create values, the `[%bs.obj]` extension is used,
and the `##` infix operator allows to read from the object properties:

```ocaml
let john = [%bs.obj { name = "john"; age = 99 }]
let t = john##name
```
```reasonml
let john = {"name": "john", "age": 99};
let t = john##name;
```

Which generates:

```js
var john = {
  name: "john",
  age: 99
};

var t = john.name;
```

Note that object types allow for some flexibility that the record types do not
have. For example, an object type can be coerced to another with fewer values or
methods, while it is impossible to coerce a record type to another one with
fewer fields. So different object types that share some methods can be mixed in
a data structure where only their common methods are visible.

To give an example, one can create a function that operates in all the object
types that include a field `name` that is of type string, e.g.:

```ocaml
let name_extended obj = obj##name ^ " wayne"

let one = name_extended [%bs.obj { name = "john"; age = 99 }]
let two = name_extended [%bs.obj { name = "jane"; address = "1 infinite loop" }]
```
```reasonml
let name_extended = obj => obj##name ++ " wayne";

let one = name_extended({"name": "john", "age": 99});
let two = name_extended({"name": "jane", "address": "1 infinite loop"});
```

To read more about objects and polymorphism we recommend checking the [OCaml
docs](https://ocaml.org/docs/objects) or the [OCaml
manual](https://v2.ocaml.org/manual/objectexamples.html).

#### Using external functions

We have already explored one approach for creating JavaScript object literals by
using [`Js.t` values and the `bs.obj` extension](#using-jst-objects).

Melange additionally offers the `bs.obj` attribute, which can be used in
combination with external functions to create JavaScript objects. When these
functions are called, they generate objects with fields corresponding to the
labeled arguments of the function.

If any of these labeled arguments are defined as optional and omitted during
function application, the resulting JavaScript object will exclude the
corresponding fields. This allows to create runtime objects and control whether
optional keys are emitted at runtime.

For example, assuming we need to bind to a JavaScript object like this:

```js
var homeRoute = {
  type: "GET",
  path: "/",
  action: () => console.log("Home"),
  // options: ...
};
```

The first three fields are required and the `options` field is optional. You can
declare a binding function like:

```ocaml
external route :
  _type:string ->
  path:string ->
  action:(string list -> unit) ->
  ?options:< .. > ->
  unit ->
  _ = ""
  [@@bs.obj]
```
```reasonml
[@bs.obj]
external route:
  (
    ~_type: string,
    ~path: string,
    ~action: list(string) => unit,
    ~options: {..}=?,
    unit
  ) =>
  _;
```

Note that the empty string at the end of the function is used to make it
syntactically valid. The value of this string is ignored by the compiler.

Since there is an optional argument `options`, an additional unlabeled argument
of type `unit` is included after it. It allows to omit the optional argument on
function application. More information about labeled optional arguments can be
found in the [OCaml
manual](https://v2.ocaml.org/manual/lablexamples.html#s:optional-arguments).

The return type of the function should be left unspecified using the wildcard
type `_`. Melange will automatically infer the type of the resulting JavaScript
object.

In the route function, the `_type` argument starts with an underscore. When
binding to JavaScript objects with fields that are reserved keywords in OCaml,
Melange allows the use of an underscore prefix for the labeled arguments. The
resulting JavaScript object will have the underscore removed from the field
names. This is only required for the `bs.obj` attribute, while for other cases,
the `bs.as` attribute can be used to rename fields.

If we call the function like this:

```ocaml
let homeRoute = route ~_type:"GET" ~path:"/" ~action:(fun _ -> Js.log "Home") ()
```
```reasonml
let homeRoute =
  route(~_type="GET", ~path="/", ~action=_ => Js.log("Home"), ());
```

We get the following JavaScript, which does not include the `options` field
since its argument wasn’t present:

```javascript
var homeRoute = {
  type: "GET",
  path: "/",
  action: (function (param) {
      console.log("Home");
    })
};
```

#### Bind to object properties

If you need to bind only to the property of a JavaScript object, you can use
`bs.get` and `bs.set` to access it using the dot notation `.`:

```ocaml
(* Abstract type for the `document` value *)
type document

external document : document = "document" [@@bs.val]

external set_title : document -> string -> unit = "title" [@@bs.set]
external get_title : document -> string = "title" [@@bs.get]

let current = get_title document
let () = set_title document "melange"
```
```reasonml
/* Abstract type for the `document` value */
type document;

[@bs.val] external document: document = "document";

[@bs.set] external set_title: (document, string) => unit = "title";
[@bs.get] external get_title: document => string = "title";

let current = get_title(document);
let () = set_title(document, "melange");
```

This generates:

```javascript
var current = document.title;
document.title = "melange";
```

Alternatively, if some dynamism is required on the way the property is accessed,
you can use `bs.get_index` and `bs.set_index` to access it using the bracket
notation `[]`:

```ocaml
type t
external create : int -> t = "Int32Array" [@@bs.new]
external get : t -> int -> int = "get" [@@bs.get_index]
external set : t -> int -> int -> unit = "set" [@@bs.set_index]

let () =
  let i32arr = (create 3) in
  set i32arr 0 42;
  Js.log (get i32arr 0)
```
```reasonml
type t;
[@bs.new] external create: int => t = "Int32Array";
[@bs.get_index] external get: (t, int) => int = "get";
[@bs.set_index] external set: (t, int, int) => unit = "set";

let () = {
  let i32arr = create(3);
  set(i32arr, 0, 42);
  Js.log(get(i32arr, 0));
};
```

Which generates:

```js
var i32arr = new Int32Array(3);
i32arr[0] = 42;
console.log(i32arr[0]);
```

### Objects with dynamic shape (dictionary-like)

Sometimes JavaScript objects are used as dictionaries. In these cases:

- All values stored in the object belong to the same type
- Key-value pairs can be added or removed at runtime

For this particular use case of JavaScript objects, Melange exposes a specific
type `Js.Dict.t`. The values and functions to work with values of this type are
defined in the [`Js.Dict`](todo-fix-me.md) module, with operations like `get`,
`set`, etc.

Values of the type `Js.Dict.t` compile to JavaScript objects.

### JavaScript classes

JavaScript classes are special kinds of objects. To interact with classes,
Melange exposes `bs.new` to emulate e.g. `new Date()`:

```ocaml
type t
external create_date : unit -> t = "Date" [@@bs.new]
let date = create_date ()
```
```reasonml
type t;
[@bs.new] external create_date: unit => t = "Date";
let date = create_date();
```

Which generates:

```js
var date = new Date();
```

You can chain `bs.new` and `bs.module` if the JavaScript class you want to work
with is in a separate JavaScript module:

```ocaml
type t
external book : unit -> t = "Book" [@@bs.new] [@@bs.module]
let myBook = book ()
```
```reasonml
type t;
[@bs.new] [@bs.module] external book: unit => t = "Book";
let myBook = book();
```

Which generates:

```js
var Book = require("Book");
var myBook = new Book();
```

## Bind to global JavaScript functions or values

Binding to a JavaScript function makes use of `external`, like with objects. If
we want to bind to a function available globally, Melange offers the `bs.val`
attribute:

```ocaml
(* Abstract type for `timeoutId` *)
type timeoutId
external setTimeout : (unit -> unit) -> int -> timeoutId = "setTimeout"
  [@@bs.val]
external clearTimeout : timeoutId -> unit = "clearTimeout" [@@bs.val]

let id = setTimeout (fun () -> Js.log "hello") 100
let () = clearTimeout id
```
```reasonml
/* Abstract type for `timeoutId` */
type timeoutId;
[@bs.val] external setTimeout: (unit => unit, int) => timeoutId = "setTimeout";
[@bs.val] external clearTimeout: timeoutId => unit = "clearTimeout";

let id = setTimeout(() => Js.log("hello"), 100);
let () = clearTimeout(id);
```

> **_NOTE:_** The bindings to `setTimeout` and `clearTimeout` are shown here for
> learning purposes, but they are already available in the
> [`Js.Global`](todo-fix-me.md) module.

Generates:

```javascript
var id = setTimeout(function (param) {
  console.log("hello");
}, 100);

clearTimeout(id);
```

Global bindings can also be applied to values:

```ocaml
(* Abstract type for `document` *)
type document

external document : document = "document" [@@bs.val]
let document = document
```
```reasonml
/* Abstract type for `document` */
type document;

[@bs.val] external document: document = "document";
let document = document;
```

Which generates:

```javascript
var doc = document;
```

### Using functions from other JavaScript modules

`bs.module` is like the `bs.val` attribute, but it accepts a string with the
name of the module, or the relative path to it.

```ocaml
external dirname : string -> string = "dirname" [@@bs.module "path"]
let root = dirname "/User/github"
```
```reasonml
[@bs.module "path"] external dirname: string => string = "dirname";
let root = dirname("/User/github");
```

Generates:

```js
var Path = require("path");
var root = Path.dirname("/User/github");
```

### Binding to properties inside a module or global

For cases when we need to create bindings for a property within a module or a
global JavaScript object, Melange provides the `bs.scope` attribute.

For example, if we want to write some bindings for a specific property
`commands` from [the `vscode`
package](https://code.visualstudio.com/api/references/vscode-api#commands), we
can do:

```ocaml
type param
external executeCommands : string -> param array -> unit = ""
  [@@bs.scope "commands"] [@@bs.module "vscode"] [@@bs.splice]

let f a b c = executeCommands "hi" [| a; b; c |]
```
```reasonml
type param;
[@bs.scope "commands"] [@bs.module "vscode"] [@bs.splice]
external executeCommands: (string, array(param)) => unit;

let f = (a, b, c) => executeCommands("hi", [|a, b, c|]);
```

Which compiles to:

```javascript
var Vscode = require("vscode");

function f(a, b, c) {
  Vscode.commands.executeCommands("hi", a, b, c);
}
```

The `bs.scope` attribute can take multiple arguments as payload, in case we want
to reach deeper into the object from the module we are importing.

For example:

```ocaml
type t

external back : t = "back"
  [@@bs.module "expo-camera"] [@@bs.scope "Camera", "Constants", "Type"]

let camera_type_back = back
```
```reasonml
type t;

[@bs.module "expo-camera"] [@bs.scope ("Camera", "Constants", "Type")]
external back: t = "back";

let camera_type_back = back;
```

Which generates:

```javascript
var ExpoCamera = require("expo-camera");

var camera_type_back = ExpoCamera.Camera.Constants.Type.back;
```

It can also be used in combination with other attributes besides `bs.module`,
like `bs.val`:

```ocaml
external imul : int -> int -> int = "imul" [@@bs.val] [@@bs.scope "Math"]

let res = imul 1 2
```
```reasonml
[@bs.val] [@bs.scope "Math"] external imul: (int, int) => int = "imul";

let res = imul(1, 2);
```

Which produces:

```javascript
var res = Math.imul(1, 2);
```

Or it can be used together with `bs.new`:

```ocaml
type t

external create : unit -> t = "GUI"
  [@@bs.new] [@@bs.scope "default"] [@@bs.module "dat.gui"]

let gui = create ()
```
```reasonml
type t;

[@bs.new] [@bs.scope "default"] [@bs.module "dat.gui"]
external create: unit => t = "GUI";

let gui = create();
```

Which generates:


```javascript
var DatGui = require("dat.gui");

var gui = new (DatGui.default.GUI)();
```

### Labeled arguments

OCaml has [labeled arguments](https://v2.ocaml.org/manual/lablexamples.html),
which can also be optional, and work with `external` as well.

Labeled arguments can be useful to provide more information about the arguments
of a JavaScript function that is called from Melange.

Let’s say we have the following JavaScript function, that we want to call from
Melange:

```js
// MyGame.js

function draw(x, y, border) {
  // let’s assume `border` is optional and defaults to false
}
draw(10, 20)
draw(20, 20, true)
```

When writing Melange bindings, we can add labeled arguments to make things more
clear:

```ocaml
external draw : x:int -> y:int -> ?border:bool -> unit -> unit = "draw"
  [@@module "MyGame"]

let () = draw ~x:10 ~y:20 ~border:true ()
let () = draw ~x:10 ~y:20 ()
```
```reasonml
[@module "MyGame"]
external draw: (~x: int, ~y: int, ~border: bool=?, unit) => unit = "draw";

let () = draw(~x=10, ~y=20, ~border=true, ());
let () = draw(~x=10, ~y=20, ());
```

Generates:

```js
var MyGame = require("MyGame");

MyGame.draw(10, 20, true);
MyGame.draw(10, 20, undefined);
```

The generated JavaScript function is the same, but now the usage in Melange is
much clearer.

**Note**: in this particular case, a final param of type unit, `()` must be
added after `border`, since `border` is an optional argument at the last
position. Not having the last param `unit` would lead to a warning, which is
explained in detail [in the OCaml
documentation](https://ocaml.org/docs/labels#warning-this-optional-argument-cannot-be-erased).

Note that you can freely reorder the labeled arguments when applying the
function on the Melange side. The generated code will maintain the original
order that was used when declaring the function:

```ocaml
external draw : x:int -> y:int -> ?border:bool -> unit -> unit = "draw"
  [@@module "MyGame"]
let () = draw ~x:10 ~y:20 ()
let () = draw ~y:20 ~x:10 ()
```
```reasonml
[@module "MyGame"]
external draw: (~x: int, ~y: int, ~border: bool=?, unit) => unit = "draw";
let () = draw(~x=10, ~y=20, ());
let () = draw(~y=20, ~x=10, ());
```

Generates:

```js
var MyGame = require("MyGame");

MyGame.draw(10, 20, undefined);
MyGame.draw(10, 20, undefined);
```

### Calling an object method

If we need to call a JavaScript method, Melange provides the attribute
`bs.send`:

```ocaml
(* Abstract type for the `document` global *)
type document

external document : document = "document" [@@bs.val]
external get_by_id : document -> string -> Dom.element = "getElementById"
  [@@bs.send]

let el = get_by_id document "my-id"
```
```reasonml
/* Abstract type for the `document` global */
type document;

[@bs.val] external document: document = "document";
[@bs.send]
external get_by_id: (document, string) => Dom.element = "getElementById";

let el = get_by_id(document, "my-id");
```

Generates:

```js
var el = document.getElementById("my-id");
```

When using `bs.send`, the first argument will be the object that holds the
property with the function we want to call. This combines well with the pipe
first operator <code class="text-ocaml">\|.</code><code
class="text-reasonml">\-\></code>, see the ["Chaining"](#chaining) section
below.

If we want to design our bindings to be used with OCaml pipe last operator `|>`,
there is an alternate `bs.send.pipe` attribute. Let’s rewrite the example above
using it:

```ocaml
(* Abstract type for the `document` global *)
type document

external document : document = "document" [@@bs.val]
external get_by_id : string -> Dom.element = "getElementById"
  [@@bs.send.pipe: document]

let el = get_by_id "my-id" document
```
```reasonml
/* Abstract type for the `document` global */
type document;

[@bs.val] external document: document = "document";
[@bs.send.pipe: document]
external get_by_id: string => Dom.element = "getElementById";

let el = get_by_id("my-id", document);
```

Generates the same code as `bs.send`:

```js
var el = document.getElementById("my-id");
```

#### Chaining

It is common to find this kind of API in JavaScript: `foo().bar().baz()`. This
kind of API can be designed with Melange externals. Depending on which
convention we want to use, there are two attributes available:

- For a data-first convention, the `bs.send` attribute, in combination with [the
  pipe first operator](#pipe-first) <code class="text-ocaml">\|.</code><code
  class="text-reasonml">\-\></code>
- For a data-last convention, the `bs.send.pipe` attribute, in combination with
  OCaml [pipe last operator](#pipe-last) `|>`.

Let’s see first an example of chaining using data-first convention with the pipe
first operator <code class="text-ocaml">\|.</code><code
class="text-reasonml">\-\></code>:

```ocaml
(* Abstract type for the `document` global *)
type document

external document : document = "document" [@@bs.val]
external get_by_id : document -> string -> Dom.element = "getElementById"
  [@@bs.send]
external get_by_classname : Dom.element -> string -> Dom.element
  = "getElementsByClassName"
  [@@bs.send]

let el = document |. get_by_id "my-id" |. get_by_classname "my-class"
```
```reasonml
/* Abstract type for the `document` global */
type document;

[@bs.val] external document: document = "document";
[@bs.send]
external get_by_id: (document, string) => Dom.element = "getElementById";
[@bs.send]
external get_by_classname: (Dom.element, string) => Dom.element =
  "getElementsByClassName";

let el = document->(get_by_id("my-id"))->(get_by_classname("my-class"));
```

Will generate:

```javascript
var el = document.getElementById("my-id").getElementsByClassName("my-class");
```

Now with pipe last operator `|>`:

```ocaml
(* Abstract type for the `document` global *)
type document

external document : document = "document" [@@bs.val]
external get_by_id : string -> Dom.element = "getElementById"
  [@@bs.send.pipe: document]
external get_by_classname : string -> Dom.element = "getElementsByClassName"
  [@@bs.send.pipe: Dom.element]

let el = document |> get_by_id "my-id" |> get_by_classname "my-class"
```
```reasonml
/* Abstract type for the `document` global */
type document;

[@bs.val] external document: document = "document";
[@bs.send.pipe: document]
external get_by_id: string => Dom.element = "getElementById";
[@bs.send.pipe: Dom.element]
external get_by_classname: string => Dom.element = "getElementsByClassName";

let el = document |> get_by_id("my-id") |> get_by_classname("my-class");
```

Will generate the same JavaScript as the pipe first version:

```javascript
var el = document.getElementById("my-id").getElementsByClassName("my-class");
```

### Variadic function arguments

Sometimes JavaScript functions take an arbitrary amount of arguments. For these
cases, Melange provides the `bs.variadic` attribute, which can be attached to
the `external` declaration. However, there is one caveat: all the variadic
arguments need to belong to the same type.

```ocaml
external join : string array -> string = "join"
  [@@bs.module "path"] [@@bs.splice]
let v = join [| "a"; "b" |]
```
```reasonml
[@bs.module "path"] [@bs.splice]
external join: array(string) => string = "join";
let v = join([|"a", "b"|]);
```

Generates:

```js
var Path = require("path");
var v = Path.join("a", "b");
```

If more dynamism is needed, there is a way to inject elements with different
types in the array and still have Melange compile to JavaScript values that are
not wrapped using the OCaml
[`unboxed`](https://v2.ocaml.org/manual/attributes.html) attribute, which was
mentioned [in the OCaml attributes section](#reusing-ocaml-attributes):

```ocaml
type hide = Hide : 'a -> hide [@@unboxed]

external join : hide array -> string = "join" [@@bs.module "path"] [@@bs.splice]

let v = join [| Hide "a"; Hide 2 |]
```
```reasonml
[@unboxed]
type hide =
  | Hide('a): hide;

[@bs.module "path"] [@bs.splice]
external join: array(hide) => string = "join";

let v = join([|Hide("a"), Hide(2)|]);
```

Compiles to:

```javascript
var Path = require("path");

var v = Path.join("a", 2);
```

### Bind to a polymorphic function

Some JavaScript libraries will define functions where the arguments can vary on
both type and shape. There are two approaches to bind to those, depending on how
dynamic they are.

#### Approach 1: Multiple external functions

If it is possible to enumerate the many forms an overloaded JavaScript function
can take, a flexible approach is to bind to each form individually:

```ocaml
external drawCat : unit -> unit = "draw" [@@bs.module "MyGame"]
external drawDog : giveName:string -> unit = "draw" [@@bs.module "MyGame"]
external draw : string -> useRandomAnimal:bool -> unit = "draw"
  [@@bs.module "MyGame"]
```
```reasonml
[@bs.module "MyGame"] external drawCat: unit => unit = "draw";
[@bs.module "MyGame"] external drawDog: (~giveName: string) => unit = "draw";
[@bs.module "MyGame"]
external draw: (string, ~useRandomAnimal: bool) => unit = "draw";
```

Note how all three externals bind to the same JavaScript function, `draw`.

#### Approach 2: Polymorphic variant + `bs.unwrap`

In some cases, the function has a constant number of arguments but the type of
the argument can vary. For cases like this, we can model the argument as a
variant and use the `bs.unwrap` attribute in the external.

Let’s say we want to bind to the following JavaScript function:

```js
function padLeft(value, padding) {
  if (typeof padding === "number") {
    return Array(padding + 1).join(" ") + value;
  }
  if (typeof padding === "string") {
    return padding + value;
  }
  throw new Error(`Expected string or number, got '${padding}'.`);
}
```

As the `padding` argument can be either a number or a string, we can use
`bs.unwrap` to define it. It is important to note that `bs.unwrap` imposes
certain requirements on the type it is applied to:

- It needs to be a [polymorphic
  variant](https://v2.ocaml.org/manual/polyvariant.html)
- Its definition needs to be inlined
- Each variant tag needs to have an argument
- The variant type can not be opened (can’t use `>`)

```ocaml
external padLeft:
  string
  -> ([ `Str of string
      | `Int of int
      ] [@bs.unwrap])
  -> string
  = "padLeft" [@@bs.val]

let _ = padLeft "Hello World" (`Int 4)
let _ = padLeft "Hello World" (`Str "Message from Melange: ")
```
```reasonml
[@bs.val]
external padLeft:
  (string, [@bs.unwrap] [ | `Str(string) | `Int(int)]) => string =
  "padLeft";

let _ = padLeft("Hello World", `Int(4));
let _ = padLeft("Hello World", `Str("Message from Melange: "));
```

Which produces the following JavaScript:

```js
padLeft("Hello World", 4);
padLeft("Hello World", "Message from Melange: ");
```

As we saw in the [Non-shared data types](#non-shared-data-types) section, we
should rather avoid passing variants directly to the JavaScript side. By using
`bs.unwrap` we get the best of both worlds: from Melange we can use variants,
while JavaScript gets the raw values inside them.

### Using polymorphic variants to bind to enums

Some JavaScript APIs take a limited subset of values as input. For example,
Node’s `fs.readFileSync` second argument can only take a few given string
values: `"ascii"`, `"utf8"`, etc. Some other functions can take values from a
few given integers, like the `createStatusBarItem` function in VS Code API,
which can take an `alignment` parameter that can only be [`1` or
`2`](https://github.com/Microsoft/vscode/blob/2362ec665c84a1519162b50c36ed4f29d1e20f62/src/vs/vscode.d.ts#L4098-L4109).

One could still type these parameters as just `string` or `int`, but this would
not prevent consumers of the external function from calling it using values that
are unsupported by the JavaScript function. Let’s see how we can use polymorphic
variants to avoid runtime errors.

If the values are strings, we can use the `bs.string` attribute:

```ocaml
external read_file_sync :
  name:string -> ([ `utf8 | `ascii ][@bs.string]) -> string = "readFileSync"
  [@@bs.module "fs"]

let _ = read_file_sync ~name:"xx.txt" `ascii
```
```reasonml
[@bs.module "fs"]
external read_file_sync:
  (~name: string, [@bs.string] [ | `utf8 | `ascii]) => string =
  "readFileSync";

let _ = read_file_sync(~name="xx.txt", `ascii);
```

Which generates:

```js
var Fs = require("fs");
Fs.readFileSync("xx.txt", "ascii");
```

This technique can be combined with the `bs.as` attribute to modify the strings
produced from the polymorphic variant values. For example:

```ocaml
type document
type style

external document : document = "document" [@@bs.val]
external get_by_id : document -> string -> Dom.element = "getElementById"
  [@@bs.send]
external style : Dom.element -> style = "style" [@@bs.get]
external transition_timing_function :
  style ->
  [ `ease
  | `easeIn [@bs.as "ease-in"]
  | `easeOut [@bs.as "ease-out"]
  | `easeInOut [@bs.as "ease-in-out"]
  | `linear
  ] ->
  unit = "transitionTimingFunction"
  [@@bs.set]

let element_style = style (get_by_id document "my-id")
let () = transition_timing_function element_style `easeIn
```
```reasonml
type document;
type style;

[@bs.val] external document: document = "document";
[@bs.send]
external get_by_id: (document, string) => Dom.element = "getElementById";
[@bs.get] external style: Dom.element => style = "style";
[@bs.set]
external transition_timing_function:
  (
    style,
    [
      | `ease
      | [@bs.as "ease-in"] `easeIn
      | [@bs.as "ease-out"] `easeOut
      | [@bs.as "ease-in-out"] `easeInOut
      | `linear
    ]
  ) =>
  unit =
  "transitionTimingFunction";

let element_style = style(get_by_id(document, "my-id"));
let () = transition_timing_function(element_style, `easeIn);
```

This will generate:

```javascript
var element_style = document.getElementById("my-id").style;

element_style.transitionTimingFunction = "ease-in";
```

Aside from producing string values, Melange also offers `bs.int` to produce
integer values. `bs.int` can also be combined with `bs.as`:

```ocaml
external test_int_type :
  ([ `on_closed | `on_open [@bs.as 20] | `in_bin ][@bs.int]) -> int
  = "testIntType"
  [@@bs.val]

let value = test_int_type `on_open
```
```reasonml
[@bs.val]
external test_int_type:
  ([@bs.int] [ | `on_closed | [@bs.as 20] `on_open | `in_bin]) => int =
  "testIntType";

let value = test_int_type(`on_open);
```

In this example, `on_closed` will be encoded as 0, `on_open` will be 20 due to
the attribute `bs.as` and `in_bin` will be 21, because if no `bs.as` annotation
is provided for a variant tag, the compiler continues assigning values counting
up from the previous one.

This code generates:

```js
var value = testIntType(20);
```

### Using polymorphic variants to bind to event listeners

Polymorphic variants can also be used to wrap event listeners, or any other kind
of callback, for example:

```ocaml
type readline

external on :
  readline ->
  ([ `close of unit -> unit | `line of string -> unit ][@bs.string]) ->
  readline = "on"
  [@@bs.send]

let register rl =
  rl |. on (`close (fun event -> ())) |. on (`line (fun line -> Js.log line))
```
```reasonml
type readline;

[@bs.send]
external on:
  (
    readline,
    [@bs.string] [ | `close(unit => unit) | `line(string => unit)]
  ) =>
  readline =
  "on";

let register = rl =>
  rl->(on(`close(event => ())))->(on(`line(line => Js.log(line))));
```

This generates:

```js
function register(rl) {
  return rl
    .on("close", function($$event) {})
    .on("line", function(line) {
      console.log(line);
    });
}
```

### Constant values as arguments

Sometimes we want to call a JavaScript function and make sure one of the
arguments is always constant. For this, the `[@bs.as]` attribute can be combined
with the wildcard pattern `_`:

```ocaml
external process_on_exit : (_[@bs.as "exit"]) -> (int -> unit) -> unit
  = "process.on"
  [@@bs.val]

let () =
  process_on_exit (fun exit_code ->
    Js.log ("error code: " ^ string_of_int exit_code))
```
```reasonml
[@bs.val]
external process_on_exit: ([@bs.as "exit"] _, int => unit) => unit =
  "process.on";

let () =
  process_on_exit(exit_code =>
    Js.log("error code: " ++ string_of_int(exit_code))
  );
```

This generates:

```js
process.on("exit", function (exitCode) {
  console.log("error code: " + exitCode.toString());
});
```

The `bs.as "exit"` and the wildcard `_` pattern together will tell Melange to
compile the first argument of the JavaScript function to the string `"exit"`.

You can also use any JSON literal by passing a quoted string to `bs.as`: `bs.as
{json|true|json}` or `bs.as {json|{"name": "John"}|json}`.

### Binding to callbacks

In OCaml, all functions have arity 1. This means that if you define a function
like this:

```ocaml
let add x y = x + y
```
```reasonml
let add = (x, y) => x + y;
```

Its type will be `int -> int -> int`. This means that one can partially apply
`add` by calling `add 1`, which will return another function expecting the
second argument of the addition. This kind of functions are called "curried"
functions, more information about currying in OCaml can be found in [this
chapter](https://cs3110.github.io/textbook/chapters/hop/currying.html) of the
"OCaml Programming: Correct + Efficient + Beautiful" book.

This is incompatible with how function calling conventions work in JavaScript,
where all function calls always apply all the arguments. To continue the
example, let’s say we have an `add` function implemented in JavaScript, similar
to the one above:

```javascript
var add = function (a, b) {
    return a + b;
};
```

If we call `add(1)`, the function will be totally applied, with `b` having
`undefined` value. And as JavaScript will try to add `1` with `undefined`, we
will get `NaN` as a result.

To illustrate this difference and how it affects Melange bindings, let’s say we
want to write bindings for a JavaScript function like this:

```javascript
function map (a, b, f){
  var i = Math.min(a.length, b.length);
  var c = new Array(i);
  for(var j = 0; j < i; ++j){
    c[j] = f(a[i],b[i])
  }
  return c ;
}
```

A naive external function declaration could be as below:

```ocaml
external map : 'a array -> 'b array -> ('a -> 'b -> 'c) -> 'c array = "map"
  [@@bs.val]
```
```reasonml
[@bs.val]
external map: (array('a), array('b), ('a, 'b) => 'c) => array('c) = "map";
```

Unfortunately, this is not completely correct. The issue is in the callback
function, with type `'a -> 'b -> 'c`. This means that `map` will expect a
function like `add` described above. But as we said, in OCaml, having two
arguments means just to have two functions that take one argument.

Let’s rewrite `add` to make the problem a bit more clear:

```ocaml
let add x = let partial y = x + y in partial
```
```reasonml
let add = x => {
  let partial = y => x + y;
  partial;
};
```

This will be compiled to:

```javascript
function add(x) {
  return (function (y) {
    return x + y | 0;
  });
}
```

Now if we ever used our external function `map` with our `add` function by
calling `map arr1 arr2 add` it would not work as expected. JavaScript function
application does not work the same as in OCaml, so the function call in the
`map` implementation, `f(a[i],b[i])`, would be applied over the outer JavaScript
function `add`, which only takes one argument `x`, and `b[i]` would be just
discarded. The value returned from the operation would not be the addition of
the two numbers, but rather the inner anonymous callback.

To solve this mismatch between OCaml and JavaScript functions and their
application, Melange provides a special attribute `@bs` that can be used with
external functions.

In the example above:

```ocaml
external map : 'a array -> 'b array -> (('a -> 'b -> 'c)[@bs]) -> 'c array
  = "map"
  [@@bs.val]
```
```reasonml
[@bs.val]
external map: (array('a), array('b), (. 'a, 'b) => 'c) => array('c) = "map";
```

Here `('a -> 'b -> 'c [@bs])` will be interpreted as having arity 2, in general,
`'a0 -> 'a1 ...​ 'aN -> 'b0 [@bs]` is the same as `'a0 -> 'a1 ...​ 'aN -> 'b0`
except the former’s arity is guaranteed to be N while the latter is unknown.

If we try now to call `map` using `add`:

```ocaml
let add x y = x + y
let _ = map [||] [||] add
```
```reasonml
let add = (x, y) => x + y;
let _ = map([||], [||], add);
```
We will get an error:

```text
let _ = map [||] [||] add
                      ^^^
This expression has type int -> int -> int
but an expression was expected of type ('a -> 'b -> 'c) Js.Fn.arity2
```

To solve this, we add `@bs` in the function definition as well:

```ocaml
let add = fun [@bs] x y -> x + y
```
```reasonml
let add = (. x, y) => x + y;
```

Annotating function definitions can be quite cumbersome when writing a lot of
externals.

To work around the verbosity, Melange offers another attribute called
`bs.uncurry`.

Let’s see how we could use it in the previous example. We just need to replace
`bs` with `bs.uncurry`:

```ocaml
external map :
  'a array -> 'b array -> (('a -> 'b -> 'c)[@bs.uncurry]) -> 'c array = "map"
  [@@bs.val]
```
```reasonml
[@bs.val]
external map:
  (array('a), array('b), [@bs.uncurry] (('a, 'b) => 'c)) => array('c) =
  "map";
```

Now if we try to call `map` with a regular `add` function:

```ocaml
let add x y = x + y
let _ = map [||] [||] add
```
```reasonml
let add = (x, y) => x + y;
let _ = map([||], [||], add);
```

Everything works fine now, without having to attach any attributes to `add`.

The main difference between `bs` and `bs.uncurry` is that the latter only works
with externals. `bs.uncurry` is the recommended option to use for bindings,
while `bs` remains useful for those use cases where performance is crucial and
we want the JavaScript functions generated from OCaml ones to not be applied
partially.

### Modeling `this`\-based Callbacks

Many JavaScript libraries have callbacks which rely on the [`this`
keyword](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/this),
for example:

```js
x.onload = function(v) {
  console.log(this.response + v)
}
```

Inside the `x.onload` callback, `this` would be pointing to `x`. It would not be
correct to declare `x.onload` of type `unit -> unit`. Instead, Melange
introduces a special attribute, `bs.this`, which allows to type `x` as this:

```ocaml
type x
external x : x = "x" [@@bs.val]
external set_onload : x -> ((x -> int -> unit)[@bs.this]) -> unit = "onload"
  [@@bs.set]
external resp : x -> int = "response" [@@bs.get]
let _ =
  set_onload x
    begin
      fun [@bs.this] o v -> Js.log (resp o + v)
    end
```
```reasonml
type x;
[@bs.val] external x: x = "x";
[@bs.set]
external set_onload: (x, [@bs.this] ((x, int) => unit)) => unit = "onload";
[@bs.get] external resp: x => int = "response";
let _ = set_onload(x, [@bs.this] (o, v) => Js.log(resp(o) + v));
```

Which generates:

```javascript
x.onload = function (v) {
  var o = this;
  console.log((o.response + v) | 0);
};
```

Note that the first argument will be reserved for `this`.

### Wrapping returned nullable values

For JavaScript functions that return a value that can be `undefined` or `null`,
Melange provides `bs.return`. Using this attribute will have Melange generated
code automatically convert the value returned by the function to an `option`
type that can be used safely from Melange side, avoiding the need to use manual
conversion functions like `Js.Nullable.toOption` and such.

```ocaml
type element
type document
external get_by_id : document -> string -> element option = "getElementById"
  [@@bs.send] [@@bs.return nullable]

let test document =
  let elem = get_by_id document "header" in
  match elem with
  | None -> 1
  | Some _element -> 2
```
```reasonml
type element;
type document;
[@bs.send] [@bs.return nullable]
external get_by_id: (document, string) => option(element) = "getElementById";

let test = document => {
  let elem = get_by_id(document, "header");
  switch (elem) {
  | None => 1
  | Some(_element) => 2
  };
};
```

Which generates:

```js
function test($$document) {
  var elem = $$document.getElementById("header");
  if (elem == null) {
    return 1;
  } else {
    return 2;
  }
}
```

The `bs.return` attribute takes an attribute payload, as seen with `[@@bs.return
nullable]` above. Currently 4 directives are supported: `null_to_opt`,
`undefined_to_opt`, `nullable` and `identity`.

`nullable` is encouraged, as it will convert from `null` and `undefined` to
`option` type.

<!-- When the return type is unit: the compiler will append its return value with an OCaml unit literal to make sure it does return unit. Its main purpose is to make the user consume FFI in idiomatic OCaml code, the cost is very very small and the compiler will do smart optimizations to remove it when the returned value is not used (mostly likely). -->

`identity` will make sure that compiler will do nothing about the returned
value. It is rarely used, but introduced here for debugging purposes.

## Generate getters, setters and constructors

As we saw in a [previous section](#non-shared-data-types), there are some types
in Melange that compile to values that are not easy to manipulate from
JavaScript. To facilitate the communication from JavaScript code with values of
these types, Melange includes an attribute `bs.deriving` that helps generating
conversion functions, as well as functions to create values from these types. In
particular, for variants and polymorphic variants.

Additionally, `bs.deriving` can be used with record types, to generate setters
and getters as well as creation functions.

### Variants

#### Creating values

Use `@bs.deriving accessors` on a variant type to create constructor values for
each branch.

```ocaml
type action =
  | Click
  | Submit of string
  | Cancel
[@@bs.deriving accessors]
```
```reasonml
[@bs.deriving accessors]
type action =
  | Click
  | Submit(string)
  | Cancel;
```

Melange will generate one `let` definition for each variant tag, implemented as
follows:

- For variant tags with payloads, it will be a function that takes the payload
  value as a parameter.
- For variant tags without payloads, it will be a constant with the runtime
  value of the tag.

Given the `action` type definition above, annotated with `bs.deriving`, Melange
will generate something similar to the following code:

```ocaml
type action =
  | Click
  | Submit of string
  | Cancel

let click = (Click : action)
let submit param = (Submit param : action)
let cancel = (Cancel : action)
```
```reasonml
type action =
  | Click
  | Submit(string)
  | Cancel;

let click: action = Click;
let submit = (param): action => Submit(param);
let cancel: action = Cancel;
```

Which will result in the following JavaScript code after compilation:

```javascript
function submit(param_0) {
  return /* Submit */{
          _0: param_0
        };
}

var click = /* Click */0;

var cancel = /* Cancel */1;
```

Note the generated definitions are lower-cased, and they can be safely used from
JavaScript code. For example, if the above JavaScript generated code was located
in a `generators.js` file, the definitions can be used like this:

```javascript
const generators = require('./generators.js');

const hello = generators.submit("Hello");
const click = generators.click;
```

#### Conversion functions

Use `@bs.deriving jsConverter` on a variant type to create converter functions
that allow to transform back and forth between JavaScript integers and Melange
variant values.

There are a few differences with `@bs.deriving accessors`:

- `jsConverter` works with the `bs.as` attribute, while `accessors` does not
- `jsConverter` does not support variant tags with payload, while `accessors`
  does
- `jsConverter` generates functions to transform values back and forth, while
  `accessors` generates functions to create values

Let’s see a version of the previous example, adapted to work with `jsConverter`
given the constraints above:

```ocaml
type action =
  | Click
  | Submit [@bs.as 3]
  | Cancel
[@@bs.deriving jsConverter]
```
```reasonml
[@bs.deriving jsConverter]
type action =
  | Click
  | [@bs.as 3] Submit
  | Cancel;
```

This will generate a couple of functions with the following types:

```ocaml
val actionToJs : action -> int

val actionFromJs : int -> action option
```
```reasonml
external actionToJs: action => int = ;

external actionFromJs: int => option(action) = ;
```

`actionToJs` returns integers from values of `action` type. It will start with 0
for `Click`, 3 for `Submit` (because it was annotated with `bs.as`), and then 4
for `Cancel`, in the same way that we described when [using `bs.int` with
polymorphic variants](#using-polymorphic-variants-to-bind-to-enums).

`actionFromJs` returns a value of type `option`, because not every integer can
be converted into a variant tag of the `action` type.

##### Hide runtime types

For extra type safety, we can hide the runtime representation of variants
(`int`) from the generated functions, by using `{ jsConverter = newType }`
payload with `@bs.deriving`:

```ocaml
type action =
  | Click
  | Submit [@bs.as 3]
  | Cancel
[@@bs.deriving { jsConverter = newType }]
```
```reasonml
[@bs.deriving {jsConverter: newType}]
type action =
  | Click
  | [@bs.as 3] Submit
  | Cancel;
```

This feature relies on [abstract types](#abstract-types) to hide the JavaScript
runtime representation. It will generate functions with the following types:

```ocaml
val actionToJs : action -> abs_action

val actionFromJs : abs_action -> action
```
```reasonml
external actionToJs: action => abs_action = ;

external actionFromJs: abs_action => action = ;
```

In the case of `actionFromJs`, the return value, unlike the previous case, is
not an option type. This is an example of "correct by construction": the only
way to create an `abs_action` is by calling the `actionToJs` function.

### Polymorphic variants

The `@bs.deriving jsConverter` attribute is applicable to polymorphic variants
as well.

> **_NOTE:_** Similarly to variants, the `@bs.deriving jsConverter` attribute
> cannot be used when the polymorphic variant tags have payloads. Refer to the
> [section on runtime representation](#data-types-and-runtime-representation) to
> learn more about how polymorphic variants are represented in JavaScript.

Let’s see an example:

```ocaml
type action =
  [ `Click
  | `Submit [@bs.as "submit"]
  | `Cancel
  ]
[@@bs.deriving jsConverter]
```
```reasonml
[@bs.deriving jsConverter]
type action = [ | `Click | [@bs.as "submit"] `Submit | `Cancel];
```

Akin to the variant example, the following two functions will be generated:

```ocaml
val actionToJs : action -> string

val actionFromJs : string -> action option
```
```reasonml
external actionToJs: action => string = ;

external actionFromJs: string => option(action) = ;
```

The `{ jsConverter = newType }` payload can also be used with polymorphic
variants.

### Records

#### Accessing fields

Use `@bs.deriving accessors` on a record type to create accessor functions for
its record field names.

```ocaml
type pet = { name : string } [@@bs.deriving accessors]

let pets = [| { name = "Brutus" }; { name = "Mochi" } |]

let () = pets |. Belt.Array.map name |. Js.Array2.joinWith "&" |. Js.log
```
```reasonml
[@bs.deriving accessors]
type pet = {name: string};

let pets = [|{name: "Brutus"}, {name: "Mochi"}|];

let () = pets->(Belt.Array.map(name))->(Js.Array2.joinWith("&"))->Js.log;
```

Melange will generate a function for each field defined in the record. In this
case, a function `name` that allows to get that field from any record of type
`pet`:

```ocaml
let name (param : pet) = param.name
```
```reasonml
let name = (param: pet) => param.name;
```

Considering all the above, the produced JavaScript will be:

```js
function name(param) {
  return param.name;
}

var pets = [
  {
    name: "Brutus"
  },
  {
    name: "Mochi"
  }
];

console.log(Belt_Array.map(pets, name).join("&"));
```

#### Convert records into abstract types

When binding to JavaScript objects, it is generally recommended to use records
since Melange precisely uses objects as their runtime representation. This
approach was discussed in the section about [binding to JavaScript
objects](#bind-to-javascript-objects).

But there’s a specific case where records may not be enough: when we want to
emit a JavaScript object where some of the keys might be present or absent.

For instance, consider the following record:

```ocaml
type person = {
  name : string;
  age : int option;
}
```
```reasonml
type person = {
  name: string,
  age: option(int),
};
```

An example of this use-case would be expecting `{ name = "John"; age = None }`
to generate a JavaScript such as `{name: "Carl"}`, where the `age` key doesn’t
appear.

The `@bs.deriving abstract` attribute exists to solve this problem. When present
in a record type, `@bs.deriving abstract` makes the record definition abstract
and generates the following functions instead:

- A constructor function for creating values of the type
- Getters and setters for accessing the record fields

`@bs.deriving abstract` effectively models a record-shaped JavaScript object
exclusively through a set of (generated) functions derived from attribute
annotations on the OCaml type definition.

Let’s see an example. Considering this Melange code:

```ocaml
type person = {
  name : string;
  age : int; [@bs.optional]
}
[@@bs.deriving abstract]
```
```reasonml
[@bs.deriving abstract]
type person = {
  name: string,
  [@bs.optional]
  age: int,
};
```

Melange will make the `person` type abstract and generate constructor, getter
and setter functions. In our example, the OCaml signature would look like this
after preprocessing:

```ocaml
type person

val person : name:string -> ?age:int -> unit -> person

val nameGet : person -> string

val ageGet : person -> int option
```
```reasonml
type person;

external person: (~name: string, ~age: int=?, unit) => person = ;

external nameGet: person => string = ;

external ageGet: person => option(int) = ;
```

The `person` function can be used to create values of `person`. It is the only
possible way to create values of this type, since Melange makes it abstract.
Using literals like `{ name = "Alice"; age = None }` directly doesn’t type
check.

Here is an example of how we can use it:

```ocaml
let alice = person ~name:"Alice" ~age:20 ()
let bob = person ~name:"Bob" ()
```
```reasonml
let alice = person(~name="Alice", ~age=20, ());
let bob = person(~name="Bob", ());
```

This will generate the following JavaScript code. Note how there is no
JavaScript runtime overhead:

```js
var alice = {
  name: "Alice",
  age: 20
};

var bob = {
  name: "Bob"
};
```

The `person` function uses labeled arguments to represent record fields. Because
there is an optional argument `age`, it takes a last argument of type `unit`.
This non-labeled argument allows to omit the optional argument on function
application. Further details about optional labeled arguments can be found in
[the corresponding section of the OCaml
manual](https://v2.ocaml.org/manual/lablexamples.html#s:optional-arguments).

The functions `nameGet` and `ageGet` are accessors for each record field:

```ocaml
let twenty = ageGet alice

let bob = nameGet bob
```
```reasonml
let twenty = ageGet(alice);

let bob = nameGet(bob);
```

This generates:

```javascript
var twenty = alice.age;

var bob = bob.name;
```

The functions are named by appending `Get` to the field names of the record to
prevent potential clashes with other values within the module. If shorter names
are preferred for the getter functions, there is an alternate `{ abstract =
light }` payload that can be passed to `bs.deriving`:

```ocaml
type person = {
  name : string;
  age : int;
}
[@@bs.deriving { abstract = light }]

let alice = person ~name:"Alice" ~age:20
let aliceName = name alice
```
```reasonml
[@bs.deriving {abstract: light}]
type person = {
  name: string,
  age: int,
};

let alice = person(~name="Alice", ~age=20);
let aliceName = name(alice);
```

Which generates:

```javascript
var alice = {
  name: "Alice",
  age: 20
};

var aliceName = alice.name;
```

In this example, the getter functions share the same names as the object fields.
Another distinction from the previous example is that the `person` constructor
function no longer requires the final `unit` argument since we have excluded the
optional field in this case.

> **_NOTE:_** The `bs.as` attribute can still be applied to record fields when
> the record type is annotated with `bs.deriving`, allowing for the renaming of
> fields in the resulting JavaScript objects, as demonstrated in the section
> about [binding to objects with static
> shape](#objects-with-static-shape-record-like). However, the option to pass
> indices to the `bs.as` decorator (like `[@bs.as "0"]`) to change the runtime
> representation to an array is not available when using `bs.deriving`.

##### Compatibility with OCaml features

The `@bs.deriving abstract` attribute and its lightweight variant can be used
with [mutable
fields](https://v2.ocaml.org/manual/coreexamples.html#s:imperative-features) and
[private types](https://v2.ocaml.org/manual/privatetypes.html), which are
features inherited by Melange from OCaml.

When the record type has mutable fields, Melange will generate setter functions
for them. For example:

```ocaml
type person = {
  name : string;
  mutable age : int;
}
[@@bs.deriving abstract]

let alice = person ~name:"Alice" ~age:20 

let () = ageSet alice 21
```
```reasonml
[@bs.deriving abstract]
type person = {
  name: string,
  mutable age: int,
};

let alice = person(~name="Alice", ~age=20);

let () = ageSet(alice, 21);
```

This will generate:

```javascript
var alice = {
  name: "Alice",
  age: 20
};

alice.age = 21;
```

If the `mutable` keyword is omitted from the interface file, Melange will not
include the setter function in the module signature, preventing other modules
from mutating any values from the type.

Private types can be used to prevent Melange from creating the constructor
function. For example, if we define `person` type as private:

```ocaml
type person = private {
  name : string;
  age : int;
}
[@@bs.deriving abstract]
```
```reasonml
[@bs.deriving abstract]
type person =
  pri {
    name: string,
    age: int,
  };
```

The accessors `nameGet` and `ageGet` will still be generated, but not the
constructor `person`. This is useful when binding to JavaScript objects while
preventing any Melange code from creating values of such type.

## Use Melange code from JavaScript

As mentioned in the [build system
section](build-system.md#commonjs-or-es6-modules), Melange allows to produce
both CommonJS and ES6 modules. In any of both cases, there is nothing special to
do to use your Melange-generated JavaScript code from any hand-written
JavaScript file.

The following definition:

```ocaml
let print name = "Hello" ^ name
```
```reasonml
let print = name => "Hello" ++ name;
```

Will generate this JavaScript code, when using CommonJS (the default):

```js
function print(name) {
  return "Hello" + name;
}

exports.print = print;
```

When using ES6 (through the `(module_systems es6)` field in `melange.emit`) this
code will be generated:

```js
function print(name) {
  return "Hello" + name;
}

export {
  print ,
}
```

So one can use either `require` or `import` (depending on the modules system of
choice) to import the `print` value in a JavaScript file.

### Default ES6 values

One special case occur when working with JavaScript imports in ES6 modules that
look like this:

```js
import ten from 'numbers.js';
```

This import expects `numbers.js` to have a default export, like:

```js
export default ten = 10;
```

To emulate this kind of exports from Melange, one just needs to define a
`default` value.

For example, in a file named <code class="text-ocaml">numbers.ml</code><code
class="text-reasonml">numbers.re</code>:

```ocaml
let default = 10
```
```reasonml
let default = 10;
```

That way, Melange will set the value on the `default` export so it can be
consumed as default import on the JavaScript side.
