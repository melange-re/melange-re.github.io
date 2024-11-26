# Advanced JavaScript interoperability

## Generate getters, setters and constructors

As we saw in a [previous section](#non-shared-data-types), there are some types
in Melange that compile to values that are not easy to manipulate from
JavaScript. To facilitate the communication from JavaScript code with values of
these types, Melange includes an attribute `deriving` that helps generating
conversion functions, as well as functions to create values from these types. In
particular, for variants and polymorphic variants.

Additionally, `deriving` can be used with record types, to generate setters and
getters as well as creation functions.

### Variants

#### Creating values

Use `@deriving accessors` on a variant type to create constructor values for
each branch.

```ocaml
type action =
  | Click
  | Submit of string
  | Cancel
[@@deriving accessors]
```
```reasonml
[@deriving accessors]
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

Given the `action` type definition above, annotated with `deriving`, Melange
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

Use `@deriving jsConverter` on a variant type to create converter functions that
allow to transform back and forth between JavaScript integers and Melange
variant values.

There are a few differences with `@deriving accessors`:

- `jsConverter` works with the `mel.as` attribute, while `accessors` does not
- `jsConverter` does not support variant tags with payload, while `accessors`
  does
- `jsConverter` generates functions to transform values back and forth, while
  `accessors` generates functions to create values

Let’s see a version of the previous example, adapted to work with `jsConverter`
given the constraints above:

```ocaml
type action =
  | Click
  | Submit [@mel.as 3]
  | Cancel
[@@deriving jsConverter]
```
```reasonml
[@deriving jsConverter]
type action =
  | Click
  | [@mel.as 3] Submit
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
for `Click`, 3 for `Submit` (because it was annotated with `mel.as`), and then 4
for `Cancel`, in the same way that we described when [using `mel.int` with
polymorphic variants](#using-polymorphic-variants-to-bind-to-enums).

`actionFromJs` returns a value of type `option`, because not every integer can
be converted into a variant tag of the `action` type.

##### Hide runtime types

For extra type safety, we can hide the runtime representation of variants
(`int`) from the generated functions, by using `jsConverter { newType }` payload
with `@deriving`:

```ocaml
type action =
  | Click
  | Submit [@mel.as 3]
  | Cancel
[@@deriving jsConverter { newType }]
```
```reasonml
[@deriving jsConverter({newType: newType})]
type action =
  | Click
  | [@mel.as 3] Submit
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

The `@deriving jsConverter` attribute is applicable to polymorphic variants as
well.

> **_NOTE:_** Similarly to variants, the `@deriving jsConverter` attribute
> cannot be used when the polymorphic variant tags have payloads. Refer to the
> [section on runtime representation](#data-types-and-runtime-representation) to
> learn more about how polymorphic variants are represented in JavaScript.

Let’s see an example:

```ocaml
type action =
  [ `Click
  | `Submit [@mel.as "submit"]
  | `Cancel
  ]
[@@deriving jsConverter]
```
```reasonml
[@deriving jsConverter]
type action = [ | `Click | [@mel.as "submit"] `Submit | `Cancel];
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

The `jsConverter { newType }` payload can also be used with polymorphic
variants.

### Records

#### Accessing fields

Use `@deriving accessors` on a record type to create accessor functions for its
record field names.

```ocaml
type pet = { name : string } [@@deriving accessors]

let pets = [| { name = "Brutus" }; { name = "Mochi" } |]

let () = pets |. Belt.Array.map name |. Js.Array.join ~sep:"&" |. Js.log
```
```reasonml
[@deriving accessors]
type pet = {name: string};

let pets = [|{name: "Brutus"}, {name: "Mochi"}|];

let () = pets->(Belt.Array.map(name))->(Js.Array.join(~sep="&"))->Js.log;
```

Melange will generate a function for each field defined in the record. In this
case, a function `name` that allows to get that field from any record of type
`pet`:

<!--#prelude#type pet = { name : string } [@@deriving accessors]-->
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

#### Generate JavaScript objects with optional properties

In some occasions, we might want to emit a JavaScript object where some of the
keys can be conditionally present or absent.

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
to generate a JavaScript object such as `{name: "Carl"}`, where the `age` key
doesn’t appear.

The `@deriving jsProperties` attribute exists to solve this problem. When
present in a record type, `@deriving jsProperties` generates a constructor
function for creating values of the type, where the fields marked with
`[@mel.optional]` will be fully removed from the generated JavaScript object
when their value is `None`.

Let’s see an example. Considering this Melange code:

```ocaml
type person = {
  name : string;
  age : int option; [@mel.optional]
}
[@@deriving jsProperties]
```
```reasonml
[@deriving jsProperties]
type person = {
  name: string,
  [@mel.optional]
  age: option(int),
};
```

Melange will generate a constructor to create values of this type. In our
example, the OCaml signature would look like this after preprocessing:

```ocaml
type person

val person : name:string -> ?age:int -> unit -> person
```
```reasonml
type person;

external person: (~name: string, ~age: int=?, unit) => person = ;
```

The `person` function can be used to create values of `person`. It is the only
possible way to create values of this type, since Melange makes it abstract.
Using literals like `{ name = "Alice"; age = None }` directly doesn’t type
check.

Here is an example of how we can use it:

<!--#prelude#
type person = {
  name : string;
  age : int option; [@mel.optional]
}
[@@deriving jsDeriving]
-->
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

#### Generating getters and setters

In case we need both getters and setters for a record, we can use `deriving
getSet` to have them generated for free.

If we take a record like this:

```ocaml
type person = {
  name : string;
  age : int option; [@mel.optional]
}
[@@deriving getSet]
```
```reasonml
[@deriving getSet]
type person = {
  name: string,
  [@mel.optional]
  age: option(int),
};
```

The `deriving` attribute can combine multiple derivers, for example we can
combine `jsProperties` with `getSet`:

```ocaml
type person = {
  name : string;
  age : int option; [@mel.optional]
}
[@@deriving jsProperties, getSet]
```
```reasonml
[@deriving (jsProperties, getSet)]
type person = {
  name: string,
  [@mel.optional]
  age: option(int),
};
```

When using `getSet`, Melange will create functions `nameGet` and `ageGet`, as
accessors for each record field.

<!--#prelude#
type person = {
  name : string;
  age : int option; [@mel.optional]
}
[@@deriving jsProperties, getSet]
let alice = person ~name:"Alice" ~age:20 ()
let bob = person ~name:"Bob" ()
-->
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
are preferred for the getter functions, there is an alternate <code
class="text-ocaml">getSet { light }</code><code
class="text-reasonml">getSet({light: light})</code> payload that can be passed
to `deriving`:

```ocaml
type person = {
  name : string;
  age : int;
}
[@@deriving jsProperties, getSet { light }]

let alice = person ~name:"Alice" ~age:20
let aliceName = name alice
```
```reasonml
[@deriving (jsProperties, getSet({light: light}))]
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

> **_NOTE:_** The `mel.as` attribute can still be applied to record fields when
> the record type is annotated with `deriving`, allowing for the renaming of
> fields in the resulting JavaScript objects, as demonstrated in the section
> about [binding to objects with static
> shape](#objects-with-static-shape-record-like). However, the option to pass
> indices to the `mel.as` decorator (like `[@mel.as "0"]`) to change the runtime
> representation to an array is not available when using `deriving`.

##### Compatibility with OCaml features

The `@deriving getSet` attribute and its lightweight variant can be used with
[mutable
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
[@@deriving getSet]

let alice = person ~name:"Alice" ~age:20

let () = ageSet alice 21
```
```reasonml
[@deriving getSet]
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
[@@deriving getSet]
```
```reasonml
[@deriving getSet]
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
both CommonJS and ES6 modules. In both cases, using Melange-generated JavaScript
code from any hand-written JavaScript file works as expected.

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

So one can use either `require` or `import` (depending on the module system of
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
