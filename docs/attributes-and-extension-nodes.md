# Melange attributes and extension nodes

## Attributes

These attributes are used to annotate `external` definitions:

- [`mel.get`](#bind-to-object-properties): read JavaScript object properties
  statically by name, using the dot notation `.`
- [`mel.get_index`](#bind-to-object-properties): read a JavaScript object’s
  properties dynamically by using the bracket notation `[]`
- [`mel.module`](#using-functions-from-other-javascript-modules): bind to a
  value from a JavaScript module
- [`mel.new`](#javascript-classes): bind to a JavaScript class constructor
- [`mel.obj`](#using-external-functions): create a JavaScript object
- [`mel.return`](#wrapping-returned-nullable-values): automate conversion from
  nullable values to `Option.t` values
- [`mel.send`](#calling-an-object-method): call a JavaScript object method using
  [pipe first](#pipe-first) convention
- [`mel.send.pipe`](#calling-an-object-method): call a JavaScript object method
  using [pipe last](#pipe-last) convention
- [`mel.set`](#bind-to-object-properties): set JavaScript object properties
  statically by name, using the dot notation `.`
- [`mel.set_index`](#bind-to-object-properties): set JavaScript object
  properties dynamically by using the bracket notation `[]`
- [`mel.scope`](#binding-to-properties-inside-a-module-or-global): reach to
  deeper properties inside a JavaScript object
- [`mel.splice`](#variadic-function-arguments): a deprecated attribute, is an
  alternate form of `mel.variadic`
- [`mel.variadic`](#variadic-function-arguments): bind to a function taking
  variadic arguments from an array

These attributes are used to annotate arguments in `external` definitions:

- [`u`](#binding-to-callbacks): define function arguments as uncurried (manual)
- [`mel.int`](#using-polymorphic-variants-to-bind-to-enums): compile function
  argument to an int
- [`mel.string`](#using-polymorphic-variants-to-bind-to-enums): compile function
  argument to a string
- [`mel.this`](#modeling-this-based-callbacks): bind to `this` based callbacks
- [`mel.uncurry`](#binding-to-callbacks): define function arguments as uncurried
  (automated)
- [`mel.unwrap`](#approach-2-polymorphic-variant-mel-unwrap): unwrap variant
  values

These attributes are used in places like records, fields, arguments, functions,
and more:

- `mel.as`: redefine the name generated in the JavaScript output code. Used in
  [constant function arguments](#constant-values-as-arguments),
  [variants](#conversion-functions), polymorphic variants (either [inlined in
  external functions](#using-polymorphic-variants-to-bind-to-enums) or [in type
  definitions](#polymorphic-variants)) and [record
  fields](#objects-with-static-shape-record-like).
- [`deriving`](#generate-getters-setters-and-constructors): generate getters and
  setters for some types
- [`mel.inline`](#inlining-constant-values): forcefully inline constant values
- [`optional`](#generate-javascript-objects-with-optional-properties):
  translates optional fields in a record to omitted properties in the generated
  JavaScript object (combines with `deriving`)

## Extension nodes

In order to use any of these extension nodes, you will have to add the melange
PPX preprocessor to your project. To do so, add the following to the `dune`
file:

```dune
(library
 (name lib)
 (modes melange)
 (preprocess
   (pps melange.ppx)))
```

The same field `preprocess` can be added to `melange.emit`.

Here is the list of all the extension nodes supported by Melange:

- [`mel.debugger`](#debugger): insert `debugger` statements
- [`mel.external`](#detect-global-variables): read global values
- [`mel.obj`](#using-jst-objects): create JavaScript object literals
- [`mel.raw`](#generate-raw-javascript): write raw JavaScript code
- [`mel.re`](#regular-expressions): insert regular expressions

## Generate raw JavaScript

It is possible to directly write JavaScript code from a Melange file. This is
unsafe, but it can be useful for prototyping or as an escape hatch.

To do it, we will use the `mel.raw`
[extension](https://v2.ocaml.org/manual/extensionnodes.html):

```ocaml
let add = [%mel.raw {|
  function(a, b) {
    console.log("hello from raw JavaScript!");
    return a + b;
  }
|}]

let () = Js.log (add 1 2)
```
```reasonml
let add = [%mel.raw
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

Using <span class="text-ocaml">one percentage sign</span><span
class="text-reasonml">the extension name between square brackets</span>
(`[%mel.raw <string>]`) is useful to define expressions (function bodies, or
other values) where the implementation is directly JavaScript. This is useful as
we can attach the type signature already in the same line, to make our code
safer. For example:

```ocaml
let f : unit -> int = [%mel.raw "function() {return 1}"]
```
```reasonml
let f: unit => int = ([%mel.raw "function() {return 1}"]: unit => int);
```

Using <span class="text-ocaml">two percentage signs (`[%%mel.raw
"xxx"]`)</span><span class="text-reasonml">the extension name without square
brackets (`%mel.raw "xxx"`)</span> is reserved for definitions in a
[structure](https://v2.ocaml.org/manual/moduleexamples.html#s:module:structures)
or [signature](https://v2.ocaml.org/manual/moduleexamples.html#s%3Asignature).

For example:

```ocaml
[%%mel.raw "var a = 1"]
```
```reasonml
[%%mel.raw "var a = 1"];
```

## Debugger

Melange allows you to inject a `debugger;` expression using the `mel.debugger`
extension:

```ocaml
let f x y =
  [%mel.debugger];
  x + y
```
```reasonml
let f = (x, y) => {
  [%mel.debugger];
  x + y;
};
```

Output:

```javascript
function f (x,y) {
  debugger; // JavaScript developer tools will set a breakpoint and stop here
  return x + y | 0;
}
```

## Detect global variables

Melange provides a relatively type safe approach to use globals that might be
defined either in the JavaScript runtime environment: `mel.external`.

`[%mel.external id]` will check if the JavaScript value `id` is `undefined` or
not, and return an `Option.t` value accordingly.

For example:

```ocaml
let () = match [%mel.external __DEV__] with
| Some _ -> Js.log "dev mode"
| None -> Js.log "production mode"
```
```reasonml
let () =
  switch ([%mel.external __DEV__]) {
  | Some(_) => Js.log("dev mode")
  | None => Js.log("production mode")
  };
```

Another example:

```ocaml
let () = match [%mel.external __filename] with
| Some f -> Js.log f
| None -> Js.log "non-node environment"
```
```reasonml
let () =
  switch ([%mel.external __filename]) {
  | Some(f) => Js.log(f)
  | None => Js.log("non-node environment")
  };
```

`[%mel.external id]` makes `id` available as a value of type <code
class="text-ocaml">'a Option.t</code><code
class="text-reasonml">Option.t('a)</code>, meaning its wrapped value is
compatible with any type. If you use the value, it is recommended to annotate it
into a known type first to avoid runtime issues.

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

Melange provides the `mel.inline` attribute to achieve the same goal in
generated JavaScript. Let’s look at an example:

```ocaml
external node_env : string = "NODE_ENV" [@@mel.scope "process", "env"]

let development = "development"
let () = if node_env <> development then Js.log "Only in Production"

let development_inline = "development" [@@mel.inline]
let () = if node_env <> development_inline then Js.log "Only in Production"
```
```reasonml
[@mel.scope ("process", "env")] external node_env: string = "NODE_ENV";

let development = "development";
let () =
  if (node_env != development) {
    Js.log("Only in Production");
  };

[@mel.inline]
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
