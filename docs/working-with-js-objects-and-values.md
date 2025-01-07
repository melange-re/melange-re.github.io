# Working with JavaScript objects and values

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

external john : person = "john" [@@mel.module "MySchool"]
let john_name = john.name
```
```reasonml
type person = {
  name: string,
  friends: array(string),
  age: int,
};

[@mel.module "MySchool"] external john: person = "john";
let john_name = john.name;
```

This is the generated JavaScript:

```js
import * as MySchool from "MySchool";

const john_name = MySchool.john.name;
```

External functions are documented in [a previous
section](./language-concepts.md#external-functions). The `mel.module` attribute
is documented [here](#using-functions-from-other-javascript-modules).

If you want or need to use different field names on the Melange and the
JavaScript sides, you can use the `mel.as` decorator:

```ocaml
type action = {
  type_ : string [@mel.as "type"]
}

let action = { type_ = "ADD_USER" }
```
```reasonml
type action = {
  [@mel.as "type"]
  type_: string,
};

let action = {type_: "ADD_USER"};
```

Which generates the JavaScript code:

```js
const action = {
  type: "ADD_USER"
};
```

This is useful to map to JavaScript attribute names that cannot be expressed in
Melange, for example, where the JavaScript name we want to generate is a
[reserved keyword in OCaml](https://v2.ocaml.org/manual/lex.html#sss:keywords).

It is also possible to map a Melange record to a JavaScript array by passing
indices to the `mel.as` decorator:

```ocaml
type t = {
  foo : int; [@mel.as "0"]
  bar : string; [@mel.as "1"]
}

let value = { foo = 7; bar = "baz" }
```
```reasonml
type t = {
  [@mel.as "0"]
  foo: int,
  [@mel.as "1"]
  bar: string,
};

let value = {
  foo: 7,
  bar: "baz",
};
```

And its JavaScript generated code:

```js
const value = [
  7,
  "baz"
];
```

#### Using `Js.t` objects

Alternatively to records, Melange offers another type that can be used to
produce JavaScript objects. This type is <code class="text-ocaml">'a
Js.t</code><code class="text-reasonml">Js.t('a)</code>, where `'a` is an [OCaml
object](https://v2.ocaml.org/manual/objectexamples.html).

The advantage of objects versus records is that no type declaration is needed in
advance, which can be helpful for prototyping or quickly generating JavaScript
object literals.

Melange provides some ways to create `Js.t` object values, as well as accessing
the properties inside them.

- To create values, use the <span class="text-ocaml">`[%mel.obj]` extension
  enclosing a record</span><span class="text-reasonml">`{ "key1": value1,
  "key2": value2, ... }` syntax (note that the names of keys must be surrounded
  by double quotes)</span>
- To access object properties, use the `##` infix operator.

```ocaml
let john = [%mel.obj { name = "john"; age = 99 }]
let t = john##name
```
```reasonml
let john = {
  "name": "john",
  "age": 99,
};
let t = john##name;
```

Which generates:

```js
const john = {
  name: "john",
  age: 99
};

const t = john.name;
```

Note that object types allow for some flexibility that record types do not have.
For example, an object type can be coerced to another with fewer values or
methods, while it is impossible to coerce a record type to another one with
fewer fields. So different object types that share some methods can be mixed in
a data structure where only their common methods are visible.

To give an example, one can create a function that operates on all the object
types that include a field `name` that is of type string, e.g.:

```ocaml
let name_extended obj = obj##name ^ " wayne"

let one = name_extended [%mel.obj { name = "john"; age = 99 }]
let two = name_extended [%mel.obj { name = "jane"; address = "1 infinite loop" }]
```
```reasonml
let name_extended = obj => obj##name ++ " wayne";

let one =
  name_extended({
    "name": "john",
    "age": 99,
  });
let two =
  name_extended({
    "name": "jane",
    "address": "1 infinite loop",
  });
```

To read more about objects and polymorphism we recommend checking the [OCaml
docs](https://ocaml.org/docs/objects) or the [OCaml
manual](https://v2.ocaml.org/manual/objectexamples.html).

#### Using external functions

We have already explored one approach for creating JavaScript object literals by
using [`Js.t` values and the `mel.obj` extension](#using-js-t-objects).

Melange additionally offers the `mel.obj` attribute, which can be used in
combination with external functions to create JavaScript objects. When these
functions are called, they generate objects with fields corresponding to the
labeled arguments of the function.

If any of these labeled arguments are defined as optional and omitted during
function application, the resulting JavaScript object will exclude the
corresponding fields. This allows to create runtime objects and control whether
optional keys are emitted at runtime.

For example, assuming we need to bind to a JavaScript object like this:

```js
let place = {
  name: "Boring, Oregon"
  type: "city",
  greeting: () => console.log("Howdy"),
  // attractions: ...
};
```

The first three fields are required and the `attractions` field is optional. You
can declare a binding function like this:

```ocaml
external makePlace :
  name:string ->
  _type:string ->
  greeting:(unit -> unit) ->
  ?attractions:string array ->
  unit ->
  _ = ""
[@@mel.obj]
```
```reasonml
[@mel.obj]
external makePlace:
  (
    ~name: string,
    ~_type: string,
    ~greeting: unit => unit,
    ~attractions: array(string)=?,
    unit
  ) =>
  _;
```

Since there is an optional argument `attractions`, an additional unlabeled
argument of type `unit` is included after it. It allows to omit the optional
argument on function application. More information about labeled optional
arguments can be found in the [OCaml
manual](https://v2.ocaml.org/manual/lablexamples.html#s:optional-arguments).

The return type of the function should be left unspecified using the wildcard
type `_`. Melange will automatically infer the type of the resulting JavaScript
object.

In the `makePlace` function, the `_type` argument starts with an underscore.
When binding to JavaScript objects with fields that are reserved keywords in
OCaml, Melange allows the use of an underscore prefix for the labeled arguments.
The resulting JavaScript object will have the underscore removed from the field
names. This is only required for the `mel.obj` attribute, while for other cases,
the `mel.as` attribute can be used to rename fields.

If we call the function like this:

<!--#prelude#
external makePlace :
  name:string ->
  _type:string ->
  greeting:(unit -> unit) ->
  ?attractions:string array ->
  unit ->
  _ = ""
[@@mel.obj]
-->
```ocaml
let place1 =
  makePlace ~name:"Boring, Oregon" ~_type:"city"
    ~greeting:(fun () -> Js.log "Howdy")
    ()

let place2 =
  makePlace ~name:"Singapore" ~_type:"city state"
    ~greeting:(fun () -> Js.log "Hello lah")
    ~attractions:[| "Buddha Tooth"; "Baba House"; "Night Safari" |]
    ()
```
```reasonml
let place1 =
  makePlace(
    ~name="Boring, Oregon",
    ~_type="city",
    ~greeting=() => Js.log("Howdy"),
    (),
  );

let place2 =
  makePlace(
    ~name="Singapore",
    ~_type="city state",
    ~greeting=() => Js.log("Hello lah"),
    ~attractions=[|"Buddha Tooth", "Baba House", "Night Safari"|],
    (),
  );
```

We get the following JavaScript:

```js
const place1 = {
  name: "Boring",
  type: "city",
  greeting: (function (param) {
      console.log("Howdy");
    })
};

const place2 = {
  name: "Singapore",
  type: "city state",
  greeting: (function (param) {
      console.log("Hello lah");
    }),
  attractions: [
    "Buddha Tooth",
    "Baba House",
    "Night Safari"
  ]
};
```

Not that `place1` object doesn't include the `attractions` field since its
argument wasn’t present.

#### Bind to object properties

If you need to bind only to the property of a JavaScript object, you can use
`mel.get` and `mel.set` to access it using the dot notation `.`:

```ocaml
(* Abstract type for the `document` value *)
type document

external document : document = "document"

external set_title : document -> string -> unit = "title" [@@mel.set]
external get_title : document -> string = "title" [@@mel.get]

let current = get_title document
let () = set_title document "melange"
```
```reasonml
/* Abstract type for the `document` value */
type document;

external document: document = "document";

[@mel.set] external set_title: (document, string) => unit = "title";
[@mel.get] external get_title: document => string = "title";

let current = get_title(document);
let () = set_title(document, "melange");
```

This generates:

```js
const current = document.title;
document.title = "melange";
```

Alternatively, if some dynamism is required on the way the property is accessed,
you can use `mel.get_index` and `mel.set_index` to access it using the bracket
notation `[]`:

```ocaml
type t
external create : int -> t = "Int32Array" [@@mel.new]
external get : t -> int -> int = "" [@@mel.get_index]
external set : t -> int -> int -> unit = "" [@@mel.set_index]

let () =
  let i32arr = (create 3) in
  set i32arr 0 42;
  Js.log (get i32arr 0)
```
```reasonml
type t;
[@mel.new] external create: int => t = "Int32Array";
[@mel.get_index] external get: (t, int) => int;
[@mel.set_index] external set: (t, int, int) => unit;

let () = {
  let i32arr = create(3);
  set(i32arr, 0, 42);
  Js.log(get(i32arr, 0));
};
```

Which generates:

```js
const i32arr = new Int32Array(3);
i32arr[0] = 42;
console.log(i32arr[0]);
```

### Objects with dynamic shape (dictionary-like)

Sometimes JavaScript objects are used as dictionaries. In these cases:

- All values stored in the object belong to the same type
- Key-value pairs can be added or removed at runtime

For this particular use case of JavaScript objects, Melange exposes a specific
type `Js.Dict.t`. The values and functions to work with values of this type are
defined in the <a class="text-ocaml" target="_self"
href="./api/ml/melange/Js/Dict"><code>Js.Dict</code> module</a><a
class="text-reasonml" target="_self"
href="./api/re/melange/Js/Dict"><code>Js.Dict</code> module</a>, with operations
like `get`, `set`, etc.

Values of the type `Js.Dict.t` compile to JavaScript objects.

### JavaScript classes

JavaScript classes are special kinds of objects. To interact with classes,
Melange exposes `mel.new` to emulate e.g. `new Date()`:

```ocaml
type t
external create_date : unit -> t = "Date" [@@mel.new]
let date = create_date ()
```
```reasonml
type t;
[@mel.new] external create_date: unit => t = "Date";
let date = create_date();
```

Which generates:

```js
const date = new Date();
```

You can chain `mel.new` and `mel.module` if the JavaScript class you want to
work with is in a separate JavaScript module:

```ocaml
type t
external book : unit -> t = "Book" [@@mel.new] [@@mel.module]
let myBook = book ()
```
```reasonml
type t;
[@mel.new] [@mel.module] external book: unit => t = "Book";
let myBook = book();
```

Which generates:

```js
import * as Book from "Book";
const myBook = new Book();
```

## Bind to JavaScript functions or values

### Using global functions or values

Binding to a JavaScript function available globally makes use of `external`,
like with objects. But unlike objects, there is no need to add any attributes:

```ocaml
(* Abstract type for `timeoutId` *)
type timeoutId
external setTimeout : (unit -> unit) -> int -> timeoutId = "setTimeout"
external clearTimeout : timeoutId -> unit = "clearTimeout"

let id = setTimeout (fun () -> Js.log "hello") 100
let () = clearTimeout id
```
```reasonml
/* Abstract type for `timeoutId` */
type timeoutId;
external setTimeout: (unit => unit, int) => timeoutId = "setTimeout";
external clearTimeout: timeoutId => unit = "clearTimeout";

let id = setTimeout(() => Js.log("hello"), 100);
let () = clearTimeout(id);
```

> **_NOTE:_** The bindings to `setTimeout` and `clearTimeout` are shown here for
> learning purposes, but they are already available in the <a class="text-ocaml"
> target="_self" href="./api/ml/melange/Js/Global"><code>Js.Global</code>
> module</a><a class="text-reasonml" target="_self"
> href="./api/re/melange/Js/Global"><code>Js.Global</code> module</a>.

Generates:

```js
const id = setTimeout((function (param) {
  console.log("hello");
}), 100);

clearTimeout(id);
```

Global bindings can also be applied to values:

```ocaml
(* Abstract type for `document` *)
type document

external document : document = "document"
let doc = document
```
```reasonml
/* Abstract type for `document` */
type document;

external document: document = "document";
let doc = document;
```

Which generates:

```js
const doc = document;
```

### Using functions from other JavaScript modules

`mel.module` allows to bind to values that belong to another JavaScript module.
It accepts a string with the name of the module, or the relative path to it.

```ocaml
external dirname : string -> string = "dirname" [@@mel.module "path"]
let root = dirname "/User/github"
```
```reasonml
[@mel.module "path"] external dirname: string => string = "dirname";
let root = dirname("/User/github");
```

Generates:

```js
import * as Path from "path";
const root = Path.dirname("/User/github");
```

### Binding to properties inside a module or global

For cases when we need to create bindings for a property within a module or a
global JavaScript object, Melange provides the `mel.scope` attribute.

For example, if we want to write some bindings for a specific property
`commands` from [the `vscode`
package](https://code.visualstudio.com/api/references/vscode-api#commands), we
can do:

```ocaml
type param
external executeCommands : string -> param array -> unit = "executeCommands"
  [@@mel.scope "commands"] [@@mel.module "vscode"] [@@mel.variadic]

let f a b c = executeCommands "hi" [| a; b; c |]
```
```reasonml
type param;
[@mel.scope "commands"] [@mel.module "vscode"] [@mel.variadic]
external executeCommands: (string, array(param)) => unit = "executeCommands";

let f = (a, b, c) => executeCommands("hi", [|a, b, c|]);
```

Which compiles to:

```js
import * as Vscode from "vscode";

function f(a, b, c) {
  Vscode.commands.executeCommands("hi", a, b, c);
}
```

The `mel.scope` attribute can take multiple arguments as payload, in case we
want to reach deeper into the object from the module we are importing.

For example:

```ocaml
type t

external back : t = "back"
  [@@mel.module "expo-camera"] [@@mel.scope "Camera", "Constants", "Type"]

let camera_type_back = back
```
```reasonml
type t;

[@mel.module "expo-camera"] [@mel.scope ("Camera", "Constants", "Type")]
external back: t = "back";

let camera_type_back = back;
```

Which generates:

```js
import * as ExpoCamera from "expo-camera";

const camera_type_back = ExpoCamera.Camera.Constants.Type.back;
```

It can be used without `mel.module` to create scoped bindings to global values:

```ocaml
external imul : int -> int -> int = "imul" [@@mel.scope "Math"]

let res = imul 1 2
```
```reasonml
[@mel.scope "Math"] external imul: (int, int) => int = "imul";

let res = imul(1, 2);
```

Which produces:

```js
const res = Math.imul(1, 2);
```

Or it can be used together with `mel.new`:

```ocaml
type t

external create : unit -> t = "GUI"
  [@@mel.new] [@@mel.scope "default"] [@@mel.module "dat.gui"]

let gui = create ()
```
```reasonml
type t;

[@mel.new] [@mel.scope "default"] [@mel.module "dat.gui"]
external create: unit => t = "GUI";

let gui = create();
```

Which generates:


```js
import * as DatGui from "dat.gui";

const gui = new (DatGui.default.GUI)();
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
  [@@mel.module "MyGame"]

let () = draw ~x:10 ~y:20 ~border:true ()
let () = draw ~x:10 ~y:20 ()
```
```reasonml
[@mel.module "MyGame"]
external draw: (~x: int, ~y: int, ~border: bool=?, unit) => unit = "draw";

let () = draw(~x=10, ~y=20, ~border=true, ());
let () = draw(~x=10, ~y=20, ());
```

Generates:

```js
import * as MyGame from "MyGame";

MyGame.draw(10, 20, true);
MyGame.draw(10, 20, undefined);
```

The generated JavaScript function is the same, but now the usage in Melange is
much clearer.

> **Note**: in this particular case, a final param of type unit, `()` must be
> added after `border`, since `border` is an optional argument at the last
> position. Not having the last param `unit` would lead to a warning, which is
> explained in detail [in the OCaml
> documentation](https://ocaml.org/docs/labels#warning-this-optional-argument-cannot-be-erased).

Note that you can freely reorder the labeled arguments when applying the
function on the Melange side. The generated code will maintain the original
order that was used when declaring the function:

```ocaml
external draw : x:int -> y:int -> ?border:bool -> unit -> unit = "draw"
  [@@mel.module "MyGame"]
let () = draw ~x:10 ~y:20 ()
let () = draw ~y:20 ~x:10 ()
```
```reasonml
[@mel.module "MyGame"]
external draw: (~x: int, ~y: int, ~border: bool=?, unit) => unit = "draw";
let () = draw(~x=10, ~y=20, ());
let () = draw(~y=20, ~x=10, ());
```

Generates:

```js
import * as MyGame from "MyGame";

MyGame.draw(10, 20, undefined);
MyGame.draw(10, 20, undefined);
```

### Calling an object method

If we need to call a JavaScript method, Melange provides the attribute
`mel.send`.

> In the following snippets, we will be referring to a type `Dom.element`, which
> is provided within the library `melange.dom`. You can add it to your project
> by including `(libraries melange.dom)` to your `dune` file:

```ocaml
(* Abstract type for the `document` global *)
type document

external document : document = "document"
external get_by_id : document -> string -> Dom.element = "getElementById"
  [@@mel.send]

let el = get_by_id document "my-id"
```
```reasonml
/* Abstract type for the `document` global */
type document;

external document: document = "document";
[@mel.send]
external get_by_id: (document, string) => Dom.element = "getElementById";

let el = get_by_id(document, "my-id");
```

Generates:

```js
const el = document.getElementById("my-id");
```

When using `mel.send`, the first argument will be the object that holds the
property with the function we want to call. This combines well with the pipe
first operator <code class="text-ocaml">\|.</code><code
class="text-reasonml">\-\></code>, see the ["Chaining"](#chaining) section
below.

If we want to design our bindings to be used with OCaml pipe last operator `|>`,
there is an alternate `mel.send.pipe` attribute. Let’s rewrite the example above
using it:

```ocaml
(* Abstract type for the `document` global *)
type document

external document : document = "document"
external get_by_id : string -> Dom.element = "getElementById"
  [@@mel.send.pipe: document]

let el = get_by_id "my-id" document
```
```reasonml
/* Abstract type for the `document` global */
type document;

external document: document = "document";
[@mel.send.pipe: document]
external get_by_id: string => Dom.element = "getElementById";

let el = get_by_id("my-id", document);
```

Generates the same code as `mel.send`:

```js
const el = document.getElementById("my-id");
```

#### Chaining

It is common to find this kind of API in JavaScript: `foo().bar().baz()`. This
kind of API can be designed with Melange externals. Depending on which
convention we want to use, there are two attributes available:

- For a data-first convention, the `mel.send` attribute, in combination with
  [the pipe first operator](./language-concepts.md#pipe-first) <code
  class="text-ocaml">\|.</code><code class="text-reasonml">\-\></code>
- For a data-last convention, the `mel.send.pipe` attribute, in combination with
  OCaml [pipe last operator](./language-concepts.md#pipe-last) `|>`.

Let’s see first an example of chaining using data-first convention with the pipe
first operator <code class="text-ocaml">\|.</code><code
class="text-reasonml">\-\></code>:

```ocaml
(* Abstract type for the `document` global *)
type document

external document : document = "document"
external get_by_id : document -> string -> Dom.element = "getElementById"
  [@@mel.send]
external get_by_classname : Dom.element -> string -> Dom.element
  = "getElementsByClassName"
  [@@mel.send]

let el = document |. get_by_id "my-id" |. get_by_classname "my-class"
```
```reasonml
/* Abstract type for the `document` global */
type document;

external document: document = "document";
[@mel.send]
external get_by_id: (document, string) => Dom.element = "getElementById";
[@mel.send]
external get_by_classname: (Dom.element, string) => Dom.element =
  "getElementsByClassName";

let el = document->(get_by_id("my-id"))->(get_by_classname("my-class"));
```

Will generate:

```js
const el = document.getElementById("my-id").getElementsByClassName("my-class");
```

Now with pipe last operator `|>`:

```ocaml
(* Abstract type for the `document` global *)
type document

external document : document = "document"
external get_by_id : string -> Dom.element = "getElementById"
  [@@mel.send.pipe: document]
external get_by_classname : string -> Dom.element = "getElementsByClassName"
  [@@mel.send.pipe: Dom.element]

let el = document |> get_by_id "my-id" |> get_by_classname "my-class"
```
```reasonml
/* Abstract type for the `document` global */
type document;

external document: document = "document";
[@mel.send.pipe: document]
external get_by_id: string => Dom.element = "getElementById";
[@mel.send.pipe: Dom.element]
external get_by_classname: string => Dom.element = "getElementsByClassName";

let el = document |> get_by_id("my-id") |> get_by_classname("my-class");
```

Will generate the same JavaScript as the pipe first version:

```js
const el = document.getElementById("my-id").getElementsByClassName("my-class");
```

### Variadic function arguments

Sometimes JavaScript functions take an arbitrary amount of arguments. For these
cases, Melange provides the `mel.variadic` attribute, which can be attached to
the `external` declaration. However, there is one caveat: all the variadic
arguments need to belong to the same type.

```ocaml
external join : string array -> string = "join"
  [@@mel.module "path"] [@@mel.variadic]
let v = join [| "a"; "b" |]
```
```reasonml
[@mel.module "path"] [@mel.variadic]
external join: array(string) => string = "join";
let v = join([|"a", "b"|]);
```

Generates:

```js
import * as Path from "path";
const v = Path.join("a", "b");
```

If more dynamism is needed, there is a way to inject elements with different
types in the array and still have Melange compile to JavaScript values that are
not wrapped using the OCaml
[`unboxed`](https://v2.ocaml.org/manual/attributes.html) attribute, which was
mentioned [in the OCaml attributes
section](/language-concepts#reusing-ocaml-attributes):

```ocaml
type hide = Hide : 'a -> hide [@@unboxed]

external join : hide array -> string = "join" [@@mel.module "path"] [@@mel.variadic]

let v = join [| Hide "a"; Hide 2 |]
```
```reasonml
[@unboxed]
type hide =
  | Hide('a): hide;

[@mel.module "path"] [@mel.variadic]
external join: array(hide) => string = "join";

let v = join([|Hide("a"), Hide(2)|]);
```

Compiles to:

```js
import * as Path from "path";
const v = Path.join("a", 2);
```

### Bind to a polymorphic function

Some JavaScript libraries will define functions where the arguments can vary on
both type and shape. There are two approaches to bind to those, depending on how
dynamic they are.

#### Approach 1: Multiple external functions

If it is possible to enumerate the many forms an overloaded JavaScript function
can take, a flexible approach is to bind to each form individually:

```ocaml
external drawCat : unit -> unit = "draw" [@@mel.module "MyGame"]
external drawDog : giveName:string -> unit = "draw" [@@mel.module "MyGame"]
external draw : string -> useRandomAnimal:bool -> unit = "draw"
  [@@mel.module "MyGame"]
```
```reasonml
[@mel.module "MyGame"] external drawCat: unit => unit = "draw";
[@mel.module "MyGame"] external drawDog: (~giveName: string) => unit = "draw";
[@mel.module "MyGame"]
external draw: (string, ~useRandomAnimal: bool) => unit = "draw";
```

Note how all three externals bind to the same JavaScript function, `draw`.

#### Approach 2: Polymorphic variant + `mel.unwrap`

In some cases, the function has a constant number of arguments but the type of
the argument can vary. For cases like this, we can model the argument as a
variant and use the `mel.unwrap` attribute in the external.

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
`mel.unwrap` to define it. It is important to note that `mel.unwrap` imposes
certain requirements on the type it is applied to:

- It needs to be a [polymorphic
  variant](https://v2.ocaml.org/manual/polyvariant.html)
- Its definition needs to be inlined
- Each variant tag needs to have an argument
- The variant type cannot be opened ([can’t use
  `>`](http://reasonmlhub.com/exploring-reasonml/ch_polymorphic-variants.html#upper-and-lower-bounds-for-polymorphic-variants))

```ocaml
external padLeft:
  string
  -> ([ `Str of string
      | `Int of int
      ] [@mel.unwrap])
  -> string
  = "padLeft"

let s1 = padLeft "Hello World" (`Int 4)
let s2 = padLeft "Hello World" (`Str "Message from Melange: ")
```
```reasonml
external padLeft:
  (
    string,
    [@mel.unwrap] [
      | `Str(string)
      | `Int(int)
    ]
  ) =>
  string =
  "padLeft";

let s1 = padLeft("Hello World", `Int(4));
let s2 = padLeft("Hello World", `Str("Message from Melange: "));
```

Which produces the following JavaScript:

```js
const s1 = padLeft("Hello World", 4);
const s2 = padLeft("Hello World", "Message from Melange: ");
```

As we saw in the [Non-shared data
types](./data-types-and-runtime-rep.md#non-shared-data-types) section, we should
avoid passing variants directly to the JavaScript side. By using `mel.unwrap` we
get the best of both worlds: from Melange we can use variants, while JavaScript
gets the raw values inside them.

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

If the values are strings, we can directly use polymorphic variants:

```ocaml
external read_file_sync :
  path:string -> ([ `utf8 | `ascii ]) -> string = "readFileSync"
  [@@mel.module "fs"]

let text = read_file_sync ~path:"xx.txt" `ascii
```
```reasonml
[@mel.module "fs"]
external read_file_sync:
  (
    ~path: string,
    [
      | `utf8
      | `ascii
    ]
  ) =>
  string =
  "readFileSync";

let text = read_file_sync(~path="xx.txt", `ascii);
```

Which generates:

```js
import * as Fs from "fs";
const text = Fs.readFileSync("xx.txt", "ascii");
```

This technique can be combined with the `mel.as` attribute to modify the strings
produced from the polymorphic variant values. For example:

```ocaml
type document
type style

external document : document = "document"
external get_by_id : document -> string -> Dom.element = "getElementById"
[@@mel.send]
external style : Dom.element -> style = "style" [@@mel.get]
external set_transition_timing_function :
  style ->
  ([ `ease
   | `easeIn [@mel.as "ease-in"]
   | `easeOut [@mel.as "ease-out"]
   | `easeInOut [@mel.as "ease-in-out"]
   | `linear ]
  [@mel.string]) ->
  unit = "transitionTimingFunction"
[@@mel.set]

let element_style = style (get_by_id document "my-id")
let () = set_transition_timing_function element_style `easeIn
```
```reasonml
type document;
type style;

external document: document = "document";
[@mel.send]
external get_by_id: (document, string) => Dom.element = "getElementById";
[@mel.get] external style: Dom.element => style = "style";
[@mel.set]
external set_transition_timing_function:
  (
    style,
    [@mel.string] [
      | `ease
      | [@mel.as "ease-in"] `easeIn
      | [@mel.as "ease-out"] `easeOut
      | [@mel.as "ease-in-out"] `easeInOut
      | `linear
    ]
  ) =>
  unit =
  "transitionTimingFunction";

let element_style = style(get_by_id(document, "my-id"));
let () = set_transition_timing_function(element_style, `easeIn);
```

This will generate:

```js
const element_style = document.getElementById("my-id").style;

element_style.transitionTimingFunction = "ease-in";
```

Aside from producing string values, Melange also offers `mel.int` to produce
integer values. `mel.int` can also be combined with `mel.as`:

```ocaml
external test_int_type :
  ([ `on_closed | `on_open [@mel.as 20] | `in_bin ][@mel.int]) -> int
  = "testIntType"

let value1 = test_int_type `on_closed
let value2 = test_int_type `on_open
let value3 = test_int_type `in_bin
```
```reasonml
external test_int_type:
  (
  [@mel.int]
  [
    | `on_closed
    | [@mel.as 20] `on_open
    | `in_bin
  ]
  ) =>
  int =
  "testIntType";

let value1 = test_int_type(`on_closed);
let value2 = test_int_type(`on_open);
let value3 = test_int_type(`in_bin);
```

In this example, `on_closed` will be encoded as 0, `on_open` will be 20 due to
the attribute `mel.as` and `in_bin` will be 21, because if no `mel.as`
annotation is provided for a variant tag, the compiler continues assigning
values counting up from the previous one.

This code generates:

```js
const value1 = testIntType(0);
const value2 = testIntType(20);
const value3 = testIntType(21);
```

### Using polymorphic variants to bind to event listeners

Polymorphic variants can also be used to wrap event listeners, or any other kind
of callback, for example:

```ocaml
type readline

external on :
  readline ->
  ([ `close of unit -> unit | `line of string -> unit ][@mel.string]) ->
  readline = "on"
  [@@mel.send]

let register rl =
  rl |. on (`close (fun _event -> ())) |. on (`line (fun line -> Js.log line))
```
```reasonml
type readline;

[@mel.send]
external on:
  (
    readline,
    [@mel.string] [
      | `close(unit => unit)
      | `line(string => unit)
    ]
  ) =>
  readline =
  "on";

let register = rl =>
  rl->(on(`close(_event => ())))->(on(`line(line => Js.log(line))));
```

This generates:

```js
function register(rl) {
  return rl
    .on("close", function(_event) {})
    .on("line", function(line) {
      console.log(line);
    });
}
```

### Constant values as arguments

Sometimes we want to call a JavaScript function and make sure one of the
arguments is always constant. For this, the `[@mel.as]` attribute can be
combined with the wildcard pattern `_`:

```ocaml
external process_on_exit : (_[@mel.as "exit"]) -> (int -> unit) -> unit
  = "process.on"

let () =
  process_on_exit (fun exit_code ->
    Js.log ("error code: " ^ string_of_int exit_code))
```
```reasonml
external process_on_exit: ([@mel.as "exit"] _, int => unit) => unit =
  "process.on";

let () =
  process_on_exit(exit_code =>
    Js.log("error code: " ++ string_of_int(exit_code))
  );
```

This generates:

```js
process.on("exit", (function (exit_code) {
  console.log("error code: " + String(exit_code));
}));
```

The `mel.as "exit"` and the wildcard `_` pattern together will tell Melange to
compile the first argument of the JavaScript function to the string `"exit"`.

You can also use any JSON literal by passing a quoted string to `mel.as`:
`mel.as {json|true|json}` or `mel.as {json|{"name": "John"}|json}`.

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
second argument of the addition. This kind of function is called a "curried"
function. More information about currying in OCaml can be found in [this
chapter](https://cs3110.github.io/textbook/chapters/hop/currying.html) of the
"OCaml Programming: Correct + Efficient + Beautiful" book.

This is incompatible with how function calling conventions work in JavaScript,
where all function calls always apply all the arguments. To continue the
example, let’s say we have an `add` function implemented in JavaScript, similar
to the one above:

```js
const add = function (a, b) {
    return a + b;
};
```

If we call `add(1)`, the function will be totally applied, with `b` having
`undefined` value. And as JavaScript will try to add `1` with `undefined`, we
will get `NaN` as a result.

To illustrate this difference and how it affects Melange bindings, let’s say we
want to write bindings for a JavaScript function like this:

```js
function map (a, b, f){
  const i = Math.min(a.length, b.length);
  const c = new Array(i);
  for(let j = 0; j < i; ++j){
    c[j] = f(a[i],b[i])
  }
  return c ;
}
```

A naive external function declaration could be as below:

```ocaml
external map : 'a array -> 'b array -> ('a -> 'b -> 'c) -> 'c array = "map"
```
```reasonml
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

```js
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
application, Melange provides a special attribute `@u` that can be used to
annotate external functions that need to be "uncurried".

<span class="text-reasonml">In Reason syntax, this attribute does not need to be
written explicitly, as it is deeply integrated with the Reason parser. To
specify some function type as "uncurried", one just needs to add the dot
character `.` to the function type. For example, `(. 'a, 'b) => 'c` instead of
`('a, 'b) => 'c`.</span>

In the example above:

```ocaml
external map : 'a array -> 'b array -> (('a -> 'b -> 'c)[@u]) -> 'c array
  = "map"
```
```reasonml
external map: (array('a), array('b), (. 'a, 'b) => 'c) => array('c) = "map";
```

Here <span class="text-ocaml">`('a -> 'b -> 'c [@u])`</span><span
class="text-reasonml">`(. 'a, 'b) => 'c`</span>will be interpreted as having
arity 2. In general, <span class="text-ocaml">`'a0 -> 'a1 ...​ 'aN -> 'b0 [@u]`
is the same as `'a0 -> 'a1 ...​ 'aN -> 'b0`</span><span class="text-reasonml">`.
'a0, 'a1, ...​ 'aN => 'b0` is the same as `'a0, 'a1, ...​ 'aN => 'b0`</span>
except the former’s arity is guaranteed to be N while the latter is unknown.

If we try now to call `map` using `add`:

<!--#prelude#
(* not expected to type check *)
external map : 'a array -> 'b array -> (('a -> 'b -> 'c)[@u]) -> 'c array = "map"
-->
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

To solve this, we add <span class="text-ocaml">`@u`</span><span
class="text-reasonml">`.`</span> in the function definition as well:

```ocaml
let add = fun [@u] x y -> x + y
```
```reasonml
let add = (. x, y) => x + y;
```

Annotating function definitions can be quite cumbersome when writing a lot of
externals.

To work around the verbosity, Melange offers another attribute called
`mel.uncurry`.

Let’s see how we could use it in the previous example. We just need to replace
`u` with `mel.uncurry`:

```ocaml
external map :
  'a array -> 'b array -> (('a -> 'b -> 'c)[@mel.uncurry]) -> 'c array = "map"
```
```reasonml
external map:
  (array('a), array('b), [@mel.uncurry] (('a, 'b) => 'c)) => array('c) =
  "map";
```

Now if we try to call `map` with a regular `add` function:

<!--#prelude#
external map : 'a array -> 'b array -> (('a -> 'b -> 'c)[@mel.uncurry]) -> 'c array = "map"
-->
```ocaml
let add x y = x + y
let _ = map [||] [||] add
```
```reasonml
let add = (x, y) => x + y;
let _ = map([||], [||], add);
```

Everything works fine now, without having to attach any attributes to `add`.

The main difference between `u` and `mel.uncurry` is that the latter only works
with externals. `mel.uncurry` is the recommended option to use for bindings,
while `u` remains useful for those use cases where performance is crucial and we
want the JavaScript functions generated from OCaml ones to not be applied
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
introduces a special attribute, `mel.this`, which allows to type `x` as this:

```ocaml
type x
external x : x = "x"
external set_onload : x -> ((x -> int -> unit)[@mel.this]) -> unit = "onload"
  [@@mel.set]
external resp : x -> int = "response" [@@mel.get]
let () =
  set_onload x
    begin
      fun [@mel.this] o v -> Js.log (resp o + v)
    end
```
```reasonml
type x;
external x: x = "x";
[@mel.set]
external set_onload: (x, [@mel.this] ((x, int) => unit)) => unit = "onload";
[@mel.get] external resp: x => int = "response";
let () = set_onload(x, [@mel.this] (o, v) => Js.log(resp(o) + v));
```

Which generates:

```js
x.onload = (function (v) {
  let o = this ;
  console.log(o.response + v | 0);
});
```

Note that the first argument will be reserved for `this`.

### Wrapping returned nullable values

JavaScript models `null` and `undefined` differently, whereas it can be useful
to treat both as <span class="text-ocaml">`'a option`</span><span
class="text-reasonml">`option('a)`</span> in Melange.

Melange understands the `mel.return` attribute in externals to model how
nullable return types should be wrapped at the bindings boundary. An `external`
value with `mel.return` converts the return value to an `option` type, avoiding
the need for extra wrapping / unwrapping with functions such as
`Js.Nullable.toOption`.

```ocaml
type element
type document
external get_by_id : document -> string -> element option = "getElementById"
  [@@mel.send] [@@mel.return nullable]

let test document =
  let elem = get_by_id document "header" in
  match elem with
  | None -> 1
  | Some _element -> 2
```
```reasonml
type element;
type document;
[@mel.send] [@mel.return nullable]
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
  const elem = $$document.getElementById("header");
  if (elem == null) {
    return 1;
  } else {
    return 2;
  }
}
```

The `mel.return` attribute takes an attribute payload, as seen with <span
class="text-ocaml">`[@@mel.return nullable]`</span><span
class="text-reasonml">`[@mel.return nullable]`</span> above. Currently 4
directives are supported: `null_to_opt`, `undefined_to_opt`, `nullable` and
`identity`.

`nullable` is encouraged, as it will convert from `null` and `undefined` to
`option` type.

<!-- When the return type is unit: the compiler will append its return value with an OCaml unit literal to make sure it does return unit. Its main purpose is to make the user consume FFI in idiomatic OCaml code, the cost is very very small and the compiler will do smart optimizations to remove it when the returned value is not used (mostly likely). -->

`identity` will make sure that compiler will do nothing about the returned
value. It is rarely used, but introduced here for debugging purposes.
