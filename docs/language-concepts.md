# Language concepts

The concepts covered in the following sections are a small subset of the OCaml
language. However, they are essential for understanding how to communicate with
JavaScript, and the features that Melange exposes to do so.

## Extension nodes and attributes

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

### Extension nodes

Extension nodes are blocks that are supposed to be replaced by a specific type
of PPX rewriters called extenders. Extension nodes use the `%` character to be
identified. Extenders will take the extension node and replace it with a valid
OCaml AST (abstract syntax tree).

An example where Melange uses extension nodes to communicate with JavaScript is
to produce "raw" JavaScript inside a Melange program:

```ocaml
[%%mel.raw "var a = 1; var b = 2"]
let add = [%mel.raw "a + b"]
```
```reasonml
[%%mel.raw "var a = 1; var b = 2"];
let add = [%mel.raw "a + b"];
```

Which will generate the following JavaScript code:

```js
var a = 1; var b = 2
var add = a + b
```

The difference between one and two percentage characters is detailed in the
[OCaml documentation](https://v2.ocaml.org/manual/extensionnodes.html).

### Attributes

Attributes are "decorations" applied to specific parts of the code to provide
additional information. In Melange, attributes are used in two ways to enhance
the expressiveness of generating JavaScript code: either reusing existing OCaml
built-in attributes or defining new ones.

#### Reusing OCaml attributes

The first approach is leveraging the existing [OCaml’s built-in
attributes](https://v2.ocaml.org/manual/attributes.html#ss:builtin-attributes)
to be used for JavaScript generation.

One prominent example of OCaml attributes that can be used in Melange projects
is the `unboxed` attribute, which optimizes the compilation of single-field
records and variants with a single tag to their raw values. This is useful when
defining type aliases that we don’t want to mix up, or when binding to
JavaScript code that uses heterogeneous collections. An example of the latter is
discussed in the [variadic function
arguments](/working-with-js-objects-and-values#variadic-function-arguments)
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

#### Defining new attributes

The second approach is introducing new attributes specifically designed for
Melange, such as the [`mel.set`
attribute](/working-with-js-objects-and-values#bind-to-object-properties) used
to bind to properties of JavaScript objects. The complete list of attributes
introduced by Melange can be found [here](/attributes-and-extension-nodes).

Attribute annotations can use one, two or three `@` characters depending on
their placement in the code and which kind of syntax tree node they are
annotating. More information about attributes can be found in the [dedicated
OCaml manual page](https://v2.ocaml.org/manual/attributes.html).

Here are some samples using Melange attributes
[`mel.set`](/working-with-js-objects-and-values#bind-to-object-properties) and
[`mel.as`](/working-with-js-objects-and-values#using-ocaml-records):

```ocaml
type document
external setTitleDom : document -> string -> unit = "title" [@@mel.set]

type t = {
  age : int; [@mel.as "a"]
  name : string; [@mel.as "n"]
}
```
```reasonml
type document;
[@mel.set] external setTitleDom: (document, string) => unit = "title";

type t = {
  [@mel.as "a"]
  age: int,
  [@mel.as "n"]
  name: string,
};
```

To learn more about preprocessors, attributes and extension nodes, check the
[section about PPX
rewriters](https://ocaml.org/docs/metaprogramming#ppx-rewriters) in the OCaml
docs.

## External functions

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

In Melange, externals can be used to [bind to global JavaScript
objects](/working-with-js-objects-and-values#using-global-functions-or-values).
They can also be decorated with certain `[@mel.xxx]` attributes to facilitate
the creation of bindings in specific scenarios. Each one of the [available
attributes](/attributes-and-extension-nodes#attributes) will be further explained
in the next sections.

Once declared, one can use an `external` as a normal value. Melange external
functions are turned into the expected JavaScript values, inlined into their
callers during compilation, and completely erased afterwards. They don’t appear
in the JavaScript output, so there are no costs on bundling size.

**Note**: it is recommended to use external functions and the `[@mel.xxx]`
attributes in the interface files as well, as this allows some optimizations
where the resulting JavaScript values can be directly inlined at the call sites.

### Special identity external

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

## Abstract types

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

external document : document = "document"
external set_title : document -> string -> unit = "title" [@@mel.set]
```
```reasonml
type document;

external document: document = "document";
[@mel.set] external set_title: (document, string) => unit = "title";
```

Subsequent sections delve into the details about the
[`mel.set`](/working-with-js-objects-and-values#bind-to-object-properties) attribute and [how to bind to global
values](/working-with-js-objects-and-values#using-global-functions-or-values) like `document`.

For a comprehensive understanding of abstract types and their usefulness, refer
to the "Encapsulation" section of the [OCaml Cornell
textbook](https://cs3110.github.io/textbook/chapters/modules/encapsulation.html).

## Pipe operators

There are two pipe operators available in Melange:

- A _pipe last_ operator `|>`, available [in
  OCaml](https://v2.ocaml.org/api/Stdlib.html#1_Compositionoperators) and
  inherited in Melange
- A _pipe first_ operator <code class="text-ocaml">\|.</code><code
  class="text-reasonml">\-\></code>, available exclusively in Melange

Let’s see the differences between the two.

### Pipe last

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

<div class="language-text vp-adaptive-theme">
  <pre class="text-ocaml shiki shiki-themes github-light github-dark vp-code"><code>4 |   [ 1; 2; 3 ]
          ^
  Error: This expression has type int but an expression was expected of type
          string</code></pre>
  <pre class="text-reasonml shiki shiki-themes github-light github-dark vp-code"><code>1 |   [ 1, 2, 3 ]
          ^
  Error: This expression has type int but an expression was expected of type
          string</code></pre>
</div>

Note that instead of telling us that we are passing the wrong function in
`List.map` (`String.cat`), the error points to the list itself. This behavior
aligns with the way type inference works, as the compiler infers types from left
to right. Since `[ 1; 2; 3 ] |> List.map String.cat` is equivalent to `List.map
String.cat [ 1; 2; 3 ]`, the type mismatch is detected when the list is type
checked, after `String.cat` has been processed.

With the goal of addressing this kind of limitations, Melange introduces the
pipe first operator <code class="text-ocaml">\|.</code><code
class="text-reasonml">\-\></code>.

### Pipe first

To overcome the constraints mentioned above, Melange introduces the pipe first
operator <code class="text-ocaml">\|.</code><code
class="text-reasonml">\-\></code>.

As its name suggests, the pipe first operator is better suited for functions
where the data is passed as the first argument.

The functions in the <a class="text-ocaml" target="_self"
href="./api/ml/melange/Belt"><code>Belt</code> library</a><a
class="text-reasonml" target="_self"
href="./api/re/melange/Belt"><code>Belt</code> library</a> included with Melange
have been designed with the data-first convention in mind, so they work best
with the pipe first operator.

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

<div class="language-text vp-adaptive-theme">
<pre class="text-ocaml shiki shiki-themes github-light github-dark vp-code"><code>4 |   |. Belt.List.map String.cat
                       ^^^^^^^^^^
Error: This expression has type string -> string -> string
       but an expression was expected of type int -> 'a
       Type string is not compatible with type int</code></pre>
<pre class="text-reasonml shiki shiki-themes github-light github-dark vp-code"><code>2 | let sum_sq = [1, 2, 3]->(Belt.List.map(String.cat))->sum;
                                           ^^^^^^^^^^
Error: This expression has type string -> string -> string
       but an expression was expected of type int -> 'a
       Type string is not compatible with type int</code></pre>
</div>

The error points now to the function passed to `Belt.List.map`, which is more
natural with the way the code is being written.

Melange supports writing bindings to JavaScript using any of the two
conventions, data-first or data-last, as shown in the ["Chaining"
section](/working-with-js-objects-and-values#chaining).

For further details about the differences between the two operators, the
data-first and data-last conventions and the trade-offs between them, one can
refer to [this related blog
post](https://www.javierchavarri.com/data-first-and-data-last-a-comparison/).
