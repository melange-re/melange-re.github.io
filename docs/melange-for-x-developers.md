# Melange for X developers

If you are familiar with other languages, here you will find sections that
compare Melange to a few of them, so it might help you get up and running
quickly. In particular:

- JavaScript
- TypeScript
- Js\_of\_ocaml
- ReScript

## For JavaScript developers

Melange is a thin layer over [OCaml](https://ocaml.org/), a strongly typed
functional programming language with an emphasis on expressiveness and safety.
Melange’s goal is to help web developers build and maintain JavaScript
applications safely, thanks to OCaml expressive and powerful type system.

Melange allows to build applications using either OCaml syntax or Reason syntax.
If you don’t know which one to choose, we recommend
[Reason](https://reasonml.github.io/en/), as it has been designed with
JavaScript developers in mind.

Reason has first-class support for
[JSX](https://reasonml.github.io/docs/en/jsx), and there are bindings like
[ReasonReact](https://github.com/reasonml/reason-react/) that build on top of
that functionality to provide a great developer experience.

Another advantage is that programs written using Reason syntax are fully
compatible with those written in OCaml syntax.

Here is the cheat sheet with some equivalents between JavaScript and Reason
syntaxes:

### Variable

| JavaScript              | OCaml (Reason syntax)          |
|-------------------------|--------------------------------|
| `const x = 5;`          | `let x = 5;`                   |
| `var x = y;`            | No equivalent                  |
| `let x = 5; x = x + 1;` | `let x = ref(5); x := x^ + 1;` |

### String & Character

| JavaScript             | OCaml (Reason syntax) |
|------------------------|-----------------------|
| `"Hello world!"`       | Same                  |
| `'Hello world!'`       | Strings must use `"`  |
| Characters are strings | `'a'`                 |
| `"hello " + "world"`   | `"hello " ++ "world"` |

### Boolean

| JavaScript                                            | OCaml (Reason syntax)             |
|-------------------------------------------------------|-----------------------------------|
| `true`, `false`                                       | Same                              |
| `!true`                                               | Same                              |
| <code>||</code>, `&&`, `<=`, `>=`, `<`, `>` | Same                              |
| `a === b`, `a !== b`                                  | Same                              |
| No deep equality (recursive compare)                  | `a == b`, `a != b`                |
| `a == b`                                              | No equality with implicit casting |

### Number

| JavaScript  | OCaml (Reason syntax) |
|-------------|-----------------------|
| `3`         | Same \*               |
| `3.1415`    | Same                  |
| `3 + 4`     | Same                  |
| `3.0 + 4.5` | `3.0 +. 4.5`          |
| `5 % 3`     | `5 mod 3`             |

\* JavaScript has no distinction between integer and float.

### Object/Record

| JavaScript          | OCaml (Reason syntax)                   |
|---------------------|-----------------------------------------|
| no static types     | `type point = {x: int, mutable y: int}` |
| `{x: 30, y: 20}`    | Same                                    |
| `point.x`           | Same                                    |
| `point.y = 30;`     | Same                                    |
| `{...point, x: 30}` | Same                                    |

### Array

| JavaScript            | OCaml (Reason syntax)              |
|-----------------------|------------------------------------|
| `[1, 2, 3]`           | <code>\[|1, 2, 3|\]</code> |
| `myArray[1] = 10`     | Same                               |
| `[1, "Bob", true]` \* | `(1, "Bob", true)`                 |
| No immutable list     | `[1, 2, 3]`                        |

\* Tuples can be simulated in JavaScript with arrays, as JavaScript arrays can
contain multiple types of elements.

### Null

| JavaScript          | OCaml (Reason syntax) |
|---------------------|-----------------------|
| `null`, `undefined` | `None` \*             |

\* There are no nulls, nor null bugs in Reason. But it does have [an option
type](https://reasonml.github.io/docs/en/option) for when you actually need
nullability.

### Function

| JavaScript                      | OCaml (Reason syntax)      |
|---------------------------------|----------------------------|
| `arg => retVal`                 | `(arg) => retVal`          |
| `function named(arg) {...}`     | `let named = (arg) => ...` |
| `const f = function(arg) {...}` | `let f = (arg) => ...`     |
| `add(4, add(5, 6))`             | Same                       |

#### Blocks

<table>
  <thead>
    <tr>
      <th>JavaScript</th>
      <th>OCaml (Reason syntax)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
  <pre><code>const myFun = (x, y) => {
  const doubleX = x + x;
  const doubleY = y + y;
  return doubleX + doubleY
};</code></pre>
      </td>
      <td>
  <pre><code>let myFun = (x, y) => {
  let doubleX = x + x;
  let doubleY = y + y;
  doubleX + doubleY
};</code></pre>
      </td>
    </tr>
  </tbody>
</table>

#### Currying

| JavaScript                  | OCaml (Reason syntax)       |
|-----------------------------|-----------------------------|
| `let add = a => b => a + b` | `let add = (a, b) => a + b` |

Both JavaScript and Reason support currying, but Reason currying is **built-in
and optimized to avoid intermediate function allocation and calls**, whenever
possible.

### If-else

| JavaScript            | OCaml (Reason syntax)                                                              |
|-----------------------|------------------------------------------------------------------------------------|
| `if (a) {b} else {c}` | Same \*                                                                            |
| `a ? b : c`           | Same                                                                               |
| `switch`              | `switch` but [super-powered\!](https://reasonml.github.io/docs/en/pattern-matching) |

\* In Reason, conditionals are always expressions. Or in other words: the `else`
branch is not optional.

### Destructuring

| JavaScript                    | OCaml (Reason syntax)                         |
|-------------------------------|-----------------------------------------------|
| `const {a, b} = data`         | `let {a, b} = data`                           |
| `const [a, b] = data`         | <code>let \[|a, b|\] = data</code> \* |
| `const {a: aa, b: bb} = data` | `let {a: aa, b: bb} = data`                   |

\* This will cause the compiler to warn that not all cases are handled, because
`data` could be of length other than 2. Better switch to pattern-matching
instead.

### Loop

| JavaScript                            | OCaml (Reason syntax)          |
|---------------------------------------|--------------------------------|
| `for (let i = 0; i <= 10; i++) {...}` | `for (i in 0 to 10) {...}`     |
| `for (let i = 10; i >= 0; i--) {...}` | `for (i in 10 downto 0) {...}` |
| `while (true) {...}`                  | Same                           |

### JSX

| JavaScript                             | OCaml (Reason syntax)    |
|----------------------------------------|--------------------------|
| `<Foo bar=1 baz="hi" onClick={bla} />` | Same                     |
| `<Foo bar=bar />`                      | `<Foo bar />` \*         |
| `<input checked />`                    | `<input checked=true />` |
| No children spread                     | `<Foo>...children</Foo>` |

\* Note the argument punning when creating elements.

### Exception

| JavaScript                                | OCaml (Reason syntax)                        |
|-------------------------------------------|----------------------------------------------|
| `throw new SomeError(...)`                | `raise(SomeError(...))`                      |
| `try {a} catch (Err) {...} finally {...}` | <code>try (a) { | Err =\> ...}</code> \* |

\* No finally.

### Blocks

In Reason, "sequence expressions" are created with `{}` and evaluate to their
last statement. In JavaScript, this can be simulated via an immediately-invoked
function expression (since function bodies have their own local scope).

<table>
  <thead>
    <tr>
      <th>JavaScript</th>
      <th>OCaml (Reason syntax)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
  <pre><code>let res = (function() {
  const x = 23;
  const y = 34;
  return x + y;
})();</code></pre>
      </td>
      <td>
  <pre><code>let res = {
  let x = 23;
  let y = 34;
  x + y
};</code></pre>
      </td>
    </tr>
  </tbody>
</table>

### Comments

| JavaScript        | OCaml (Reason syntax) |
|-------------------|-----------------------|
| `/* Comment */`   | Same                  |
| `// Line comment` | Same                  |

## For TypeScript developers

The approach to typing applications using Melange differs somewhat from
TypeScript. TypeScript has been designed with a focus on compatibility with
JavaScript, as outlined in its [design
goals](https://github.com/Microsoft/TypeScript/wiki/TypeScript-Design-Goals). On
the other hand, Melange is built upon OCaml, a compiler known for its emphasis
on expressiveness and safety.

These are some of the differences between both.

### Type inference

In TypeScript, the types for the input parameters have to be defined:

```javascript
let sum = (a: number, b: number) => a + b;
```

OCaml can infer types without barely any type annotations. For example, we can
define a function that adds two numbers as:

```ocaml
let add x y = x + y
```
```reasonml
let add = (x, y) => x + y;
```

### Algebraic data types

It is not possible to build an ADT in TypeScript the same way as in OCaml.
[Discriminated
unions](https://www.typescriptlang.org/docs/handbook/typescript-in-5-minutes-func.html#discriminated-unions)
would be the closest analog to them, with libraries like
[ts-pattern](https://github.com/gvergnaud/ts-pattern) as an alternative to the
lack of support for pattern matching in the language.

In OCaml, [algebraic data types
(ADTs)](https://cs3110.github.io/textbook/chapters/data/algebraic_data_types.html)
are a commonly used functionality of the language. They allow you to build your
own types from small blocks. And with [pattern
matching](https://ocaml.org/docs/data-types), it is easy to access this data.

### Nominal typing

In TypeScript, all typing is structural. This means that it is hard sometimes to
establish a boundary or separation between two types that have the same
implementation. For these cases, nominal typing can be emulated using tags:

```js
type Email = string & { readonly __tag: unique symbol };
type City = string & { readonly __tag: unique symbol };
```

In OCaml, nominal typing is fully supported. Some of the core language types
like [records and
variants](https://v2.ocaml.org/manual/coreexamples.html#s%3Atut-recvariants) are
nominal. This means that even if you declare exactly the same type twice,
functions that operate on values from one type will not be compatible with the
other type.

There is also structural typing, used for OCaml
[objects](https://v2.ocaml.org/manual/objectexamples.html) and [polymorphic
variants](https://v2.ocaml.org/manual/polyvariant.html).

### Immutability

TypeScript has two base primitives to work with immutability: `const` and
`readonly`.

The first one is used to prevent variable reference change.

```js
const a = 1;
a = 2; // Error: Cannot assign to 'a' because it is a constant.
```

And the second one is used to make properties immutable.

```js
type A = {
  readonly x: number;
}
const a: A = { x: 1 };
a.x = 12; // Error: Cannot assign to 'x' because it is a read-only property.
```

Nevertheless, there are some problems here. `const` and `readonly` only block
reference changes but do nothing about values. With `const a = [1, 2, 3]` or
`readonly x: number[]`, you can still change the contents of an array.

OCaml provides data types with immutability in mind, like lists, records, or
maps.

### Strictness and soundness

TypeScript you can use types like `any`, or other extensive types like
`Function`. This can be mitigated using the `strict` option in the
`tsconfig.json`. There is no such option in OCaml.

TypeScript may sacrifice soundness for practicality when needed, like mentioned
in [the
handbook](https://www.typescriptlang.org/docs/handbook/type-compatibility.html#a-note-on-soundness).
OCaml implementations provide methods like `Obj.magic` and [the `identity`
primitive](communicate-with-javascript.md#special-identity-external), but they
are more normally discouraged.

### Cheatsheet

The following are some conversions between TypeScript and OCaml idioms, in the
OCaml side we use Reason syntax for familiarity, as mentioned in [section for
JavaScript developers](#for-javascript-developers).

#### Type aliases

| TypeScript             | OCaml (Reason syntax)  |
|------------------------|------------------------|
| `type Email = string;` | `type email = string;` |

#### Abstract types

<table>
  <thead>
    <tr>
      <th>TypeScript</th>
      <th>OCaml (Reason syntax)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
        <pre><code>type Email = string &
{ readonly __tag: unique symbol };</code></pre>
      </td>
      <td>
        <pre><code>/* in interface `rei` file */
type email;
</code></pre>
        <pre><code>/* in implementation `re` file */
type email = string;</code></pre> </td> </tr>
  </tbody>
</table>

#### Union types / Variants

<table>
  <thead>
    <tr>
      <th>TypeScript</th>
      <th>OCaml (Reason syntax)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
        <pre><code>type Result = "Error" | "Success";
</code></pre>
      </td>
      <td>
        <pre><code>type result = Error | Success</code></pre>
      </td>
    </tr>
    <tr>
      <td>
        <pre><code>type Result =
| { type: "Error"; message: string }
| { type: "Success"; n: number };
</code></pre>
      </td>
      <td>
        <pre><code>type result =
| Error of string
| Success of int</code></pre>
      </td>
    </tr>
  </tbody>
</table>

#### Immutability

<table>
  <thead>
    <tr>
      <th>TypeScript</th>
      <th>OCaml (Reason syntax)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
        <pre><code>const a = 1;
type A = { readonly x: number };
type ImmutableA = Readonly<A>;
const arr: ReadonlyArray<number> = [1, 2, 3];
type A = { readonly [x: string]: number };
</code></pre>
      </td>
      <td>Enabled by default</td>
    </tr>
  </tbody>
</table>

#### Currying

<table>
  <thead>
    <tr>
      <th>TypeScript</th>
      <th>OCaml (Reason syntax)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
        <pre><code>type addT = (_: number) => (_: number) => number;
const add: addT = (l) => (r) => l + r;
add(5)(3);
</code></pre>
      </td>
      <td>Enabled by default</td>
    </tr>
  </tbody>
</table>

#### Parametric polymorphism

| TypeScript                             | OCaml (Reason syntax)          |
|----------------------------------------|--------------------------------|
| `type length = <T>(_: T[]) => number;` | `let length: list('a) => int;` |

## For Js\_of\_ocaml developers

There are many similarities between Js\_of\_ocaml and Melange:

- Both compile OCaml to JavaScript.
- Both are available as libraries in the official opam repository.
- Both have access to the OCaml platform developer toolchain: the OCaml LSP
  server, Merlin, and the different editor extensions.
- Both have implemented extensive integration with Dune.

However, while Js\_of\_ocaml transforms OCaml bytecode into JavaScript, Melange
starts the conversion process earlier in the compiler pipeline, as it transforms
the compiler lambda representation into JavaScript.

Js\_of\_ocaml is a project with years of development and evolution behind it,
while Melange [appearance](rationale.md#a-bit-of-history) is relatively recent
in comparison.

These aspects translate into different trade-offs. Compared to Js\_of\_ocaml:

- Melange can be installed in an OCaml 5 opam switch, but the editor integration
  is not working at the time (May 2023).
- Similarly, any OCaml 5 features like effects are currently unsupported in
  Melange.
- Js\_of\_ocaml allows to compile the compiler itself and create "toplevels",
  which is not possible with Melange.
- `Marshal` is well supported in Js\_of\_ocaml, while Melange does not support it.
- Libraries like `Unix` or `Str` are available in Js\_of\_ocaml but not in
  Melange.
- Js\_of\_ocaml supports sourcemaps, which Melange do not support yet (as of May
  2023).

On the upside, in Melange:

- Consuming existing JavaScript packages might be a bit easier in Melange,
  thanks to its compilation model and the extensive availability of mechanisms
  to bind to JavaScript code.
- There is great support for some of the most used JavaScript libraries like
  [ReactJS](https://github.com/reasonml/reason-react/) or GraphQL clients.
- The generated JavaScript bundles are generally smaller.
- The generated JavaScript code is generally more readable.
- Straight-forward integration with modern JavaScript tooling like Webpack,
  NextJS, etc. This is possible thanks to the 1 module \<-\> 1 JavaScript file
  compilation model.

## For ReScript developers

As a project that shares a common ancestry with ReScript, Melange inherits a lot
of its characteristics:

- The compilation model involves compiling a single module into a single
  JavaScript file.
- The libraries provided by ReScript (Belt and Js) are available in Melange too.
- The mechanisms provided for [communicating with JavaScript
  code](communicate-with-javascript.md) are mostly the same.

However, one of Melange’s goals is to maximize compatibility with the OCaml
ecosystem. This goal translates into fundamental differences in how Melange and
ReScript function from the perspective of both library authors and users.

### Package manager

ReScript projects rely exclusively on npm for all packages they depend on.
Melange projects, on the other hand, will use opam for native packages, and npm
for JavaScript ones. Melange package management is explained in detail in [the
dedicated section](package-management.md).

### Build system

ReScript has its own build system, originally based on Ninja.

Melange defers to [Dune](https://dune.build/) for build orchestration, as it is
explained in detail in [the corresponding section](build-system.md). By
integrating with Dune, Melange can benefit from the multiple features provided.
One of the most useful features is first-class supports for monorepos. But there
are multiple others, like virtual libraries, watch mode, or integrations with
tools like [odoc](https://github.com/ocaml/odoc).

The divergences caused by the different build systems have a lot of implications
and nuances that might be too complex to explain in this section, but some of
the specific details have been discussed in [the OCaml
forum](https://discuss.ocaml.org/t/ahrefs-is-now-built-with-melange/12107/3).

### Source-based vs pre-built distribution

While with ReScript every dependency can be downloaded with just npm, Melange
projects will have to use opam and npm. This is a trade-off: on one hand, some
Melange projects might need to include two package configuration files. But on
the other hand they can benefit from opam’s source-based package distribution
model for things like PPXs, linters, or any other OCaml tooling.

In comparison, consuming any OCaml tool in ReScript is more challenging. Since
ReScript lacks a native toolchain, authors of the tools need to provide
pre-built binaries for all the supported systems and architectures. This poses
difficulties for the authors in terms of maintenance, and it can also result in
certain users being unable to access these tools if their systems or
architectures are not included in the pre-built binaries.

### OCaml compiler version

ReScript is compatible with the 4.06 version of the OCaml compiler, while
Melange is compatible with the version 4.14 (as of May 2023).

The (Melange roadmap)\[todo-fix-me.md\] includes a milestone to upgrade to the
latest version of the compiler to the 5.x release line.

### Editor integration

Melange is fully compatible with the [OCaml platform editor
tools](https://ocaml.org/docs/up-and-running#configuring-your-editor), which
makes possible to work in projects that include OCaml and Melange code using the
same editor configuration.

ReScript has its [own set of editor
plugins](https://rescript-lang.org/docs/manual/latest/editor-plugins).

### Feature choice and alignment with OCaml

ReScript’s goal is to model the language to bring it as close to JavaScript as
possible. From the website [introduction
section](https://rescript-lang.org/docs/manual/latest/introduction):

> ReScript looks like JS, acts like JS, and compiles to the highest quality of
> clean, readable and performant JS (...)

New features added to ReScript might close its alignment with JavaScript, but
some of these features can lead to greater divergence from OCaml. As Melange
prioritizes compatibility with OCaml, it avoids incorporating those features
that widen the gap between the two.

Here is a non-exhaustive list of the features that ReScript has added and will
not be supported in Melange:

- The `async` / `await` syntax: similar functionality can be achieved in Melange
  through the usage of [binding
  operators](https://v2.ocaml.org/manual/bindingops.html) (introduced in OCaml
  4.13).
- Optional fields in records, like `type t = { x : int, @optional y : int }`.
- Uncurried by default.

The restriction above only applies to features that compromise compatibility
with OCaml, but otherwise Melange can incorporate bugfixes or new functionality
from ReScript.

On the other hand, as Melange goal is to keep up with the version of the OCaml
compiler, there are features inherited from OCaml that are not supported by
ReScript at the moment (May 2023), for example:

- [Binding operators](https://v2.ocaml.org/manual/bindingops.html) / `let`
  bindings
- Better type errors for some specific cases
- Additions to the stdlib

The whole list of changes added to the OCaml compiler can be checked
[here](https://ocaml.org/releases).

### Syntax

ReScript encourages using [the new
syntax](https://rescript-lang.org/docs/manual/latest/migrate-from-bucklescript-reason)
for any new code. While OCaml syntax might be supported today, its usage is not
documented. Reason syntax is no longer supported.

Melange supports and documents both Reason and OCaml syntaxes. It also includes
a best-effort support for ReScript syntax for backwards compatibility, provided
through the `rescript-syntax` package, available [in opam](todo-fix-me.md). To
build any code written using ReScript syntax, the only requirement is to
download this package, as Melange and Dune will already coordinate to make use
of it when `res` or `resi` files are found.

