
# Module `Js`

```ocaml
type +'a null
```
```reasonml
type null(+'a);
```
A value of this type can be either `null` or `'a`. This type is the same as type `t` in [`Null`](./Js-Null.md)

```ocaml
type +'a undefined
```
```reasonml
type undefined(+'a);
```
A value of this type can be either `undefined` or `'a`. This type is the same as type `t` in [`Undefined`](./Js-Undefined.md)

```ocaml
type +'a nullable
```
```reasonml
type nullable(+'a);
```
A value of this type can be `undefined`, `null` or `'a`. This type is the same as type `t` n [`Nullable`](./Js-Nullable.md)

```ocaml
type re
```
```reasonml
type re;
```
The type for JavaScript `RegExp`

```ocaml
type 'a dict
```
```reasonml
type dict('a);
```
The type for a simple key-value dictionary abstraction over native JavaScript objects

```ocaml
type 'a iterator
```
```reasonml
type iterator('a);
```
The type for JavaScript iterators

```ocaml
type 'a array_like
```
```reasonml
type array_like('a);
```
The type for array-like objects in JavaScript

```ocaml
type bigint
```
```reasonml
type bigint;
```
The type for JavaScript BigInt

```ocaml
type +'a promise
```
```reasonml
type promise(+'a);
```
The type for JavaScript Promise

```ocaml
type blob
```
```reasonml
type blob;
```
The type for JavaScript [Blob](https://developer.mozilla.org/en-US/docs/Web/API/Blob)

```ocaml
type file
```
```reasonml
type file;
```
The type for JavaScript [File](https://developer.mozilla.org/en-US/docs/Web/API/File)

```ocaml
type arrayBuffer
```
```reasonml
type arrayBuffer;
```
```ocaml
type int8Array
```
```reasonml
type int8Array;
```
```ocaml
type uint8Array
```
```reasonml
type uint8Array;
```
```ocaml
type uint8ClampedArray
```
```reasonml
type uint8ClampedArray;
```
```ocaml
type int16Array
```
```reasonml
type int16Array;
```
```ocaml
type uint16Array
```
```reasonml
type uint16Array;
```
```ocaml
type int32Array
```
```reasonml
type int32Array;
```
```ocaml
type uint32Array
```
```reasonml
type uint32Array;
```
```ocaml
type float32Array
```
```reasonml
type float32Array;
```
```ocaml
type float64Array
```
```reasonml
type float64Array;
```
```ocaml
val toOption : 'a nullable -> 'a option
```
```reasonml
let toOption: nullable('a) => option('a);
```
```ocaml
val undefinedToOption : 'a undefined -> 'a option
```
```reasonml
let undefinedToOption: undefined('a) => option('a);
```
```ocaml
val nullToOption : 'a null -> 'a option
```
```reasonml
let nullToOption: null('a) => option('a);
```
```ocaml
val isNullable : 'a nullable -> bool
```
```reasonml
let isNullable: nullable('a) => bool;
```
```ocaml
val import : 'a -> 'a promise
```
```reasonml
let import: 'a => promise('a);
```
TODO(anmonteiro): document

```ocaml
val testAny : 'a -> bool
```
```reasonml
let testAny: 'a => bool;
```
The same as [`isNullable`](./#val-isNullable) except that it is more permissive on the types of input

```ocaml
val null : 'a null
```
```reasonml
let null: null('a);
```
The same as `empty` in [`Js.Null`](./Js-Null.md) will be compiled as `null`

```ocaml
val undefined : 'a undefined
```
```reasonml
let undefined: undefined('a);
```
The same as `empty` [`Js.Undefined`](./Js-Undefined.md) will be compiled as `undefined`

```ocaml
val typeof : 'a -> string
```
```reasonml
let typeof: 'a => string;
```
`typeof x` will be compiled as `typeof x` in JS Please consider functions in [`Types`](./Js-Types.md) for a type safe way of reflection

```ocaml
val log : 'a -> unit
```
```reasonml
let log: 'a => unit;
```
A convenience function to log everything

```ocaml
val log2 : 'a -> 'b -> unit
```
```reasonml
let log2: 'a => 'b => unit;
```
```ocaml
val log3 : 'a -> 'b -> 'c -> unit
```
```reasonml
let log3: 'a => 'b => 'c => unit;
```
```ocaml
val log4 : 'a -> 'b -> 'c -> 'd -> unit
```
```reasonml
let log4: 'a => 'b => 'c => 'd => unit;
```
```ocaml
val logMany : 'a array -> unit
```
```reasonml
let logMany: array('a) => unit;
```
A convenience function to log more than 4 arguments

```ocaml
val eqNull : 'a -> 'a null -> bool
```
```reasonml
let eqNull: 'a => null('a) => bool;
```
```ocaml
val eqUndefined : 'a -> 'a undefined -> bool
```
```reasonml
let eqUndefined: 'a => undefined('a) => bool;
```
```ocaml
val eqNullable : 'a -> 'a nullable -> bool
```
```reasonml
let eqNullable: 'a => nullable('a) => bool;
```

##### Operators

```ocaml
val unsafe_lt : 'a -> 'a -> bool
```
```reasonml
let unsafe_lt: 'a => 'a => bool;
```
`unsafe_lt a b` will be compiled as `a < b`. It is marked as unsafe, since it is impossible to give a proper semantics for comparision which applies to any type

```ocaml
val unsafe_le : 'a -> 'a -> bool
```
```reasonml
let unsafe_le: 'a => 'a => bool;
```
`unsafe_le a b` will be compiled as `a <= b`. See also [`unsafe_lt`](./#val-unsafe_lt)

```ocaml
val unsafe_gt : 'a -> 'a -> bool
```
```reasonml
let unsafe_gt: 'a => 'a => bool;
```
`unsafe_gt a b` will be compiled as `a > b`. See also [`unsafe_lt`](./#val-unsafe_lt)

```ocaml
val unsafe_ge : 'a -> 'a -> bool
```
```reasonml
let unsafe_ge: 'a => 'a => bool;
```
`unsafe_ge a b` will be compiled as `a >= b`. See also [`unsafe_lt`](./#val-unsafe_lt)

Types for JS objects

```ocaml
type 'a t
```
```reasonml
type t('a);
```
This used to be mark a Js object type.

```ocaml
module Exn : sig ... end
```
```reasonml
module Exn: { ... };
```
Utilities for dealing with Js exceptions

```ocaml
module String : sig ... end
```
```reasonml
module String: { ... };
```
Bindings to the functions in `String.prototype`

```ocaml
module Null : sig ... end
```
```reasonml
module Null: { ... };
```
Utility functions on [`null`](./#type-null)

```ocaml
module Undefined : sig ... end
```
```reasonml
module Undefined: { ... };
```
Utility functions on [`undefined`](./#type-undefined)

```ocaml
module Nullable : sig ... end
```
```reasonml
module Nullable: { ... };
```
Utility functions on [`nullable`](./#type-nullable)

```ocaml
module Array : sig ... end
```
```reasonml
module Array: { ... };
```
Bindings to the functions in `Array.prototype`

```ocaml
module Re : sig ... end
```
```reasonml
module Re: { ... };
```
Bindings to the functions in `RegExp.prototype`

```ocaml
module Promise : sig ... end
```
```reasonml
module Promise: { ... };
```
Bindings to JS `Promise` functions

```ocaml
module Date : sig ... end
```
```reasonml
module Date: { ... };
```
Bindings to the functions in JS's `Date.prototype`

```ocaml
module Dict : sig ... end
```
```reasonml
module Dict: { ... };
```
Utility functions to treat a JS object as a dictionary

```ocaml
module Global : sig ... end
```
```reasonml
module Global: { ... };
```
Bindings to functions in the JS global namespace

```ocaml
module Json : sig ... end
```
```reasonml
module Json: { ... };
```
Utility functions to manipulate JSON values

```ocaml
module Math : sig ... end
```
```reasonml
module Math: { ... };
```
Bindings to the functions in the `Math` object

```ocaml
module Obj : sig ... end
```
```reasonml
module Obj: { ... };
```
Utility functions on \`Js.t\` JS objects

```ocaml
module Typed_array : sig ... end
```
```reasonml
module Typed_array: { ... };
```
Bindings to the functions in `TypedArray.prototype`

```ocaml
module Types : sig ... end
```
```reasonml
module Types: { ... };
```
Utility functions for runtime reflection on JS types

```ocaml
module Float : sig ... end
```
```reasonml
module Float: { ... };
```
Bindings to functions in JavaScript's `Number` that deal with floats

```ocaml
module Int : sig ... end
```
```reasonml
module Int: { ... };
```
Bindings to functions in JavaScript's `Number` that deal with ints

```ocaml
module Bigint : sig ... end
```
```reasonml
module Bigint: { ... };
```
Bindings to functions in JavaScript's `BigInt`

```ocaml
module Console : sig ... end
```
```reasonml
module Console: { ... };
```
```ocaml
module Set : sig ... end
```
```reasonml
module Set: { ... };
```
Bindings to functions in `Set`

```ocaml
module WeakSet : sig ... end
```
```reasonml
module WeakSet: { ... };
```
Bindings to functions in `WeakSet`

```ocaml
module Map : sig ... end
```
```reasonml
module Map: { ... };
```
Bindings to functions in `Map`

```ocaml
module WeakMap : sig ... end
```
```reasonml
module WeakMap: { ... };
```
Bindings to functions in `WeakMap`

```ocaml
module Iterator : sig ... end
```
```reasonml
module Iterator: { ... };
```
Bindings to functions on `Iterator`

```ocaml
module Blob : sig ... end
```
```reasonml
module Blob: { ... };
```
Bindings to Blob

```ocaml
module File : sig ... end
```
```reasonml
module File: { ... };
```
Bindings to File

```ocaml
module ReadableStream : sig ... end
```
```reasonml
module ReadableStream: { ... };
```
Bindings to ReadableStream

```ocaml
module FormData : sig ... end
```
```reasonml
module FormData: { ... };
```
Bindings to FormData

```ocaml
module Fetch : sig ... end
```
```reasonml
module Fetch: { ... };
```
Abstract types for Fetch
