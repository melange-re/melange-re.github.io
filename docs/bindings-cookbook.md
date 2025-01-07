# Bindings cookbook

## Globals

### `window`: global variable

```ocaml
external window : Dom.window = "window"
```
```reasonml
external window: Dom.window = "window";
```

See the [Using global functions or
values](./working-with-js-objects-and-values.md#using-global-functions-or-values)
section for more information.

### `window?`: does global variable exist

```ocaml
let _ = match [%mel.external window] with
| Some _ -> "window exists"
| None -> "window does not exist"
```
```reasonml
let _ =
  switch ([%mel.external window]) {
  | Some(_) => "window exists"
  | None => "window does not exist"
  };
```

See the [Detect global
variables](./attributes-and-extension-nodes.md#detect-global-variables) section
for more information.

### `Math.PI`: variable in global module

```ocaml
external pi : float = "PI" [@@mel.scope "Math"]
```
```reasonml
[@mel.scope "Math"] external pi: float = "PI";
```

See the [Binding to properties inside a module or
global](./working-with-js-objects-and-values.md#binding-to-properties-inside-a-module-or-global)
section for more information.

### `console.log`: function in global module

```ocaml
external log : 'a -> unit = "log" [@@mel.scope "console"]
```
```reasonml
[@mel.scope "console"] external log: 'a => unit = "log";
```

See the [Binding to properties inside a module or
global](./working-with-js-objects-and-values.md#binding-to-properties-inside-a-module-or-global)
section for more information.

## Modules

### `const path = require('path'); path.join('a', 'b')`: function in CommonJS/ES6 module

```ocaml
external join : string -> string -> string = "join" [@@mel.module "path"]
let dir = join "a" "b"
```
```reasonml
[@mel.module "path"] external join: (string, string) => string = "join";
let dir = join("a", "b");
```

See the [Using functions from other JavaScript
modules](./working-with-js-objects-and-values.md#using-functions-from-other-javascript-modules)
section for more information.

### `const foo = require('foo'); foo(1)`: import entire module as a value

```ocaml
external foo : int -> unit = "foo" [@@mel.module]
let () = foo 1
```
```reasonml
[@mel.module] external foo: int => unit = "foo";
let () = foo(1);
```

See the [Using functions from other JavaScript
modules](./working-with-js-objects-and-values.md#using-functions-from-other-javascript-modules)
section for more information.

### `import foo from 'foo'; foo(1)`: import ES6 module default export

```ocaml
external foo : int -> unit = "default" [@@mel.module "foo"]
let () = foo 1
```
```reasonml
[@mel.module "foo"] external foo: int => unit = "default";
let () = foo(1);
```

See the [Using functions from other JavaScript
modules](./working-with-js-objects-and-values.md#using-functions-from-other-javascript-modules)
section for more information.

### `const foo = require('foo'); foo.bar.baz()`: function scoped inside an object in a module

```ocaml
module Foo = struct
  module Bar = struct
    external baz : unit -> unit = "baz" [@@mel.module "foo"] [@@mel.scope "bar"]
  end
end

let () = Foo.Bar.baz ()
```
```reasonml
module Foo = {
  module Bar = {
    [@mel.module "foo"] [@mel.scope "bar"] external baz: unit => unit = "baz";
  };
};

let () = Foo.Bar.baz();
```

It is not necessary to nest the binding inside OCaml modules, but mirroring the
structure of the JavaScript module layout makes the binding more discoverable.

See the [Binding to properties inside a module or
global](./working-with-js-objects-and-values.md#binding-to-properties-inside-a-module-or-global)
section for more information.

## Functions

### `const dir = path.join('a', 'b', ...)`: function with rest args

```ocaml
external join : string array -> string = "join" [@@mel.module "path"] [@@mel.variadic]
let dir = join [| "a"; "b" |]
```
```reasonml
[@mel.module "path"] [@mel.variadic]
external join: array(string) => string = "join";
let dir = join([|"a", "b"|]);
```

See the [Variadic function
arguments](./working-with-js-objects-and-values.md#variadic-function-arguments)
section for more information.

### `const nums = range(start, stop, step)`: call a function with named arguments for readability

```ocaml
external range : start:int -> stop:int -> step:int -> int array = "range"
let nums = range ~start:1 ~stop:10 ~step:2
```
```reasonml
external range: (~start: int, ~stop: int, ~step: int) => array(int) = "range";
let nums = range(~start=1, ~stop=10, ~step=2);
```

### `foo('hello'); foo(true)`: overloaded function

```ocaml
external fooString : string -> unit = "foo"
external fooBool : bool -> unit = "foo"

let () = fooString ""
let () = fooBool true
```
```reasonml
external fooString: string => unit = "foo";
external fooBool: bool => unit = "foo";

let () = fooString("");
let () = fooBool(true);
```

Melange allows specifying the name on the OCaml side and the name on the
JavaScript side (in quotes) separately, so it's possible to bind multiple times
to the same function with different names and signatures. This allows binding to
complex JavaScript functions with polymorphic behaviour.

### `const nums = range(start, stop, [step])`: optional final argument(s)

```ocaml
external range : start:int -> stop:int -> ?step:int -> unit -> int array
  = "range"

let nums = range ~start:1 ~stop:10 ()
```
```reasonml
external range: (~start: int, ~stop: int, ~step: int=?, unit) => array(int) =
  "range";

let nums = range(~start=1, ~stop=10, ());
```

When an OCaml function takes an optional parameter, it needs a positional
parameter at the end of the parameter list to help the compiler understand when
function application is finished and when the function can actually execute. This
might seem cumbersome, but it is necessary in order to have out-of-the-box curried
parameters, named parameters, and optional parameters available in the language.

### `mkdir('src/main', {recursive: true})`: options object argument

```ocaml
type mkdirOptions

external mkdirOptions : ?recursive:bool -> unit -> mkdirOptions = "" [@@mel.obj]
external mkdir : string -> ?options:mkdirOptions -> unit -> unit = "mkdir"

let () = mkdir "src" ()
let () = mkdir "src/main" ~options:(mkdirOptions ~recursive:true ()) ()
```
```reasonml
type mkdirOptions;

[@mel.obj] external mkdirOptions: (~recursive: bool=?, unit) => mkdirOptions;
external mkdir: (string, ~options: mkdirOptions=?, unit) => unit = "mkdir";

let () = mkdir("src", ());
let () = mkdir("src/main", ~options=mkdirOptions(~recursive=true, ()), ());
```

See the [Objects with static shape (record-like): Using external
functions](./working-with-js-objects-and-values.md#using-external-functions)
section for more information.

### `forEach(start, stop, item => console.log(item))`: model a callback

```ocaml
external forEach :
  start:int -> stop:int -> ((int -> unit)[@mel.uncurry]) -> unit = "forEach"

let () = forEach ~start:1 ~stop:10 Js.log
```
```reasonml
external forEach:
  (~start: int, ~stop: int, [@mel.uncurry] (int => unit)) => unit =
  "forEach";

let () = forEach(~start=1, ~stop=10, Js.log);
```

When binding to functions with callbacks, you'll want to ensure that the
callbacks are uncurried. `[@mel.uncurry]` is the recommended way of doing that.
However, in some circumstances you may be forced to use the static uncurried
function syntax. See the [Binding to
callbacks](./working-with-js-objects-and-values.md#binding-to-callbacks) section
for more information.

## Objects

### `const person = {id: 1, name: 'Alice'}`: create an object

For quick creation of objects (e.g. prototyping), one can create a `Js.t` object
literal directly:

```ocaml
let person = [%mel.obj { id = 1; name = "Alice" }]
```
```reasonml
let person = {
  "id": 1,
  "name": "Alice",
};
```

See the [Using `Js.t`
objects](./working-with-js-objects-and-values.md#using-js-t-objects) section for
more information.

Alternatively, for greater type accuracy, one can create a record type and a
value:

```ocaml
type person = { id : int; name : string }
let person = { id = 1; name = "Alice" }
```
```reasonml
type person = {
  id: int,
  name: string,
};
let person = {
  id: 1,
  name: "Alice",
};
```

See the [Using OCaml
records](./working-with-js-objects-and-values.md#using-ocaml-records) section
for more information.

### `person.name`: get a prop

<!--#prelude#
let person = [%mel.obj { name = "john"; age = 99 }]
-->
```ocaml
let name = person##name
```
```reasonml
let name = person##name;
```

Alternatively, if `person` value is of record type as mentioned in the section
above:

<!--#prelude#
type person = { id : int; name : string }
let person = { id = 1; name = "Alice" }
-->
```ocaml
let name = person.name
```
```reasonml
let name = person.name;
```

### `person.id = 0`: set a prop

<!--#prelude#
type person = { id : int; name : string }
let person = { id = 1; name = "Alice" }
-->
```ocaml
external set_id : person -> int -> unit = "id" [@@mel.set]

let () = set_id person 0
```
```reasonml
[@mel.set] external set_id: (person, int) => unit = "id";

let () = set_id(person, 0);
```

### `const {id, name} = person`: object with destructuring

```ocaml
type person = { id : int; name : string }

let person = { id = 1; name = "Alice" }
let { id; name } = person
```
```reasonml
type person = {
  id: int,
  name: string,
};

let person = {
  id: 1,
  name: "Alice",
};
let {id, name} = person;
```

## Classes and OOP

In Melange it is idiomatic to bind to class properties and methods as functions
which take the instance as just a normal function argument. So e.g., instead of

```js
const foo = new Foo();
foo.bar();
```

You will write:

<!--#prelude#
module Foo = struct
  type t
  external make : unit -> t = "Foo" [@@mel.new]
  external bar : t -> unit = "bar" [@@mel.get]
end
-->
```ocaml
let foo = Foo.make ()
let () = Foo.bar foo
```
```reasonml
let foo = Foo.make();
let () = Foo.bar(foo);
```

Note that many of the techniques shown in the [Functions](#functions) section
are applicable to the instance members shown below.

### `const foo = new Foo()`: call a class constructor

```ocaml
module Foo = struct
  type t
  external make : unit -> t = "Foo" [@@mel.new]
end

let foo = Foo.make ()
```
```reasonml
module Foo = {
  type t;
  [@mel.new] external make: unit => t = "Foo";
};

let foo = Foo.make();
```

Note the abstract type `t`, which we have revisited already in [its
corresponding](./language-concepts.md#abstract-types) section.

A Melange function binding doesn't have the context that it's binding to a
JavaScript class like `Foo`, so you will want to explicitly put it inside a
corresponding module `Foo` to denote the class it belongs to. In other words,
model JavaScript classes as OCaml modules.

See the [JavaScript
classes](./working-with-js-objects-and-values.md#javascript-classes) section for
more information.

### `const bar = foo.bar`: get an instance property

```ocaml
module Foo = struct
  type t
  external make : unit -> t = "Foo" [@@mel.new]
  external bar : t -> int = "bar" [@@mel.get]
end

let foo = Foo.make ()
let bar = Foo.bar foo
```
```reasonml
module Foo = {
  type t;
  [@mel.new] external make: unit => t = "Foo";
  [@mel.get] external bar: t => int = "bar";
};

let foo = Foo.make();
let bar = Foo.bar(foo);
```

See the [Binding to object
properties](./working-with-js-objects-and-values.md#bind-to-object-properties)
section for more information.

### `foo.bar = 1`: set an instance property

```ocaml
module Foo = struct
  type t
  external make : unit -> t = "Foo" [@@mel.new]
  external setBar : t -> int -> unit = "bar" [@@mel.set]
end

let foo = Foo.make ()
let () = Foo.setBar foo 1
```
```reasonml
module Foo = {
  type t;
  [@mel.new] external make: unit => t = "Foo";
  [@mel.set] external setBar: (t, int) => unit = "bar";
};

let foo = Foo.make();
let () = Foo.setBar(foo, 1);
```

### `foo.meth()`: call a nullary instance method

```ocaml
module Foo = struct
  type t

  external make : unit -> t = "Foo" [@@mel.new]
  external meth : t -> unit = "meth" [@@mel.send]
end

let foo = Foo.make ()
let () = Foo.meth foo
```
```reasonml
module Foo = {
  type t;

  [@mel.new] external make: unit => t = "Foo";
  [@mel.send] external meth: t => unit = "meth";
};

let foo = Foo.make();
let () = Foo.meth(foo);
```

See the [Calling an object
method](./working-with-js-objects-and-values.md#calling-an-object-method)
section for more information.

### `const newStr = str.replace(substr, newSubstr)`: non-mutating instance method

```ocaml
external replace : substr:string -> newSubstr:string -> string = "replace"
[@@mel.send.pipe: string]

let str = "goodbye world"
let substr = "goodbye"
let newSubstr = "hello"
let newStr = replace ~substr ~newSubstr str
```
```reasonml
[@mel.send.pipe: string]
external replace: (~substr: string, ~newSubstr: string) => string = "replace";

let str = "goodbye world";
let substr = "goodbye";
let newSubstr = "hello";
let newStr = replace(~substr, ~newSubstr, str);
```

`mel.send.pipe` injects a parameter of the given type (in this case `string`) as
the final positional parameter of the binding. In other words, it creates the
binding with the real signature <code class="text-ocaml">substr:string -\>
newSubstr:string -\> string -\> string</code><code
class="text-reasonml">(~substr: string, ~newSubstr: string, string) =\>
string</code>. This is handy for non-mutating functions as they traditionally
take the instance as the final parameter.

It is not strictly necessary to use named arguments in this binding, but it
helps readability with multiple arguments, especially if some have the same
type.

Also note that it is not strictly need to use `mel.send.pipe`, one can use
`mel.send` everywhere.

See the [Calling an object
method](./working-with-js-objects-and-values.md#calling-an-object-method)
section for more information.

### `arr.sort(compareFunction)`: mutating instance method

<!--#prelude#let arr = [|2|]-->
```ocaml
external sort : 'a array -> (('a -> 'a -> int)[@mel.uncurry]) -> 'a array
  = "sort"
[@@mel.send]

let _ = sort arr compare
```
```reasonml
[@mel.send]
external sort: (array('a), [@mel.uncurry] (('a, 'a) => int)) => array('a) =
  "sort";

let _ = sort(arr, compare);
```

For a mutating method, it's traditional to pass the instance argument first.

Note: `compare` is a function provided by the standard library, which fits the
defined interface of JavaScript's comparator function.

## Null and undefined

### `foo.bar === undefined`: check for undefined

```ocaml
module Foo = struct
  type t
  external bar : t -> int option = "bar" [@@mel.get]
end

external foo : Foo.t = "foo"

let _result = match Foo.bar foo with Some _ -> 1 | None -> 0
```
```reasonml
module Foo = {
  type t;
  [@mel.get] external bar: t => option(int) = "bar";
};

external foo: Foo.t = "foo";

let _result =
  switch (Foo.bar(foo)) {
  | Some(_) => 1
  | None => 0
  };
```

If you know some value may be `undefined` (but not `null`, see next section),
and if you know its type is monomorphic (i.e. not generic), then you can model
it directly as an `Option.t` type.

See the [Non-shared data
types](./data-types-and-runtime-rep.md#non-shared-data-types) section for more
information.

### `foo.bar == null`: check for null or undefined

```ocaml
module Foo = struct
  type t
  external bar : t -> t option = "bar" [@@mel.get] [@@mel.return nullable]
end

external foo : Foo.t = "foo"

let _result = match Foo.bar foo with Some _ -> 1 | None -> 0
```
```reasonml
module Foo = {
  type t;
  [@mel.get] [@mel.return nullable] external bar: t => option(t) = "bar";
};

external foo: Foo.t = "foo";

let _result =
  switch (Foo.bar(foo)) {
  | Some(_) => 1
  | None => 0
  };
```

If you know the value is 'nullable' (i.e. could be `null` or `undefined`), or if
the value could be polymorphic, then `mel.return nullable` is appropriate to
use.

Note that this attribute requires the return type of the binding to be an
`option` type as well.

See the [Wrapping returned nullable
values](./working-with-js-objects-and-values.md#wrapping-returned-nullable-values)
section for more information.
