
# Module `Js`

```
type +'a null
```
A value of this type can be either `null` or `'a`. This type is the same as type `t` in [`Null`](./Js-Null.md)

```
type +'a undefined
```
A value of this type can be either `undefined` or `'a`. This type is the same as type `t` in [`Undefined`](./Js-Undefined.md)

```
type +'a nullable
```
A value of this type can be `undefined`, `null` or `'a`. This type is the same as type `t` n [`Nullable`](./Js-Nullable.md)

```
type re
```
The type for JavaScript `RegExp`

```
type 'a dict
```
The type for a simple key-value dictionary abstraction over native JavaScript objects

```
type 'a iterator
```
The type for JavaScript iterators

```
type 'a array_like
```
The type for array-like objects in JavaScript

```
type bigint
```
The type for JavaScript BigInt

```
type +'a promise
```
The type for JavaScript Promise

```
type blob
```
The type for JavaScript [Blob](https://developer.mozilla.org/en-US/docs/Web/API/Blob)

```
type file
```
The type for JavaScript [File](https://developer.mozilla.org/en-US/docs/Web/API/File)

```
type arrayBuffer
```
```
type int8Array
```
```
type uint8Array
```
```
type uint8ClampedArray
```
```
type int16Array
```
```
type uint16Array
```
```
type int32Array
```
```
type uint32Array
```
```
type float32Array
```
```
type float64Array
```
```
val toOption : 'a nullable -> 'a option
```
```
val undefinedToOption : 'a undefined -> 'a option
```
```
val nullToOption : 'a null -> 'a option
```
```
val isNullable : 'a nullable -> bool
```
```
val import : 'a -> 'a promise
```
TODO(anmonteiro): document

```
val testAny : 'a -> bool
```
The same as [`isNullable`](./#val-isNullable) except that it is more permissive on the types of input

```
val null : 'a null
```
The same as `empty` in [`Js.Null`](./Js-Null.md) will be compiled as `null`

```
val undefined : 'a undefined
```
The same as `empty` [`Js.Undefined`](./Js-Undefined.md) will be compiled as `undefined`

```
val typeof : 'a -> string
```
`typeof x` will be compiled as `typeof x` in JS Please consider functions in [`Types`](./Js-Types.md) for a type safe way of reflection

```
val log : 'a -> unit
```
A convenience function to log everything

```
val log2 : 'a -> 'b -> unit
```
```
val log3 : 'a -> 'b -> 'c -> unit
```
```
val log4 : 'a -> 'b -> 'c -> 'd -> unit
```
```
val logMany : 'a array -> unit
```
A convenience function to log more than 4 arguments

```
val eqNull : 'a -> 'a null -> bool
```
```
val eqUndefined : 'a -> 'a undefined -> bool
```
```
val eqNullable : 'a -> 'a nullable -> bool
```

##### Operators

```
val unsafe_lt : 'a -> 'a -> bool
```
`unsafe_lt a b` will be compiled as `a < b`. It is marked as unsafe, since it is impossible to give a proper semantics for comparision which applies to any type

```
val unsafe_le : 'a -> 'a -> bool
```
`unsafe_le a b` will be compiled as `a <= b`. See also [`unsafe_lt`](./#val-unsafe_lt)

```
val unsafe_gt : 'a -> 'a -> bool
```
`unsafe_gt a b` will be compiled as `a > b`. See also [`unsafe_lt`](./#val-unsafe_lt)

```
val unsafe_ge : 'a -> 'a -> bool
```
`unsafe_ge a b` will be compiled as `a >= b`. See also [`unsafe_lt`](./#val-unsafe_lt)

Types for JS objects

```
type 'a t
```
This used to be mark a Js object type.

```
module Exn : sig ... end
```
Utilities for dealing with Js exceptions

```
module String : sig ... end
```
Bindings to the functions in `String.prototype`

```
module Null : sig ... end
```
Utility functions on [`null`](./#type-null)

```
module Undefined : sig ... end
```
Utility functions on [`undefined`](./#type-undefined)

```
module Nullable : sig ... end
```
Utility functions on [`nullable`](./#type-nullable)

```
module Array : sig ... end
```
Bindings to the functions in `Array.prototype`

```
module Re : sig ... end
```
Bindings to the functions in `RegExp.prototype`

```
module Promise : sig ... end
```
Bindings to JS `Promise` functions

```
module Date : sig ... end
```
Bindings to the functions in JS's `Date.prototype`

```
module Dict : sig ... end
```
Utility functions to treat a JS object as a dictionary

```
module Global : sig ... end
```
Bindings to functions in the JS global namespace

```
module Json : sig ... end
```
Utility functions to manipulate JSON values

```
module Math : sig ... end
```
Bindings to the functions in the `Math` object

```
module Obj : sig ... end
```
Utility functions on \`Js.t\` JS objects

```
module Typed_array : sig ... end
```
Bindings to the functions in `TypedArray.prototype`

```
module Types : sig ... end
```
Utility functions for runtime reflection on JS types

```
module Float : sig ... end
```
Bindings to functions in JavaScript's `Number` that deal with floats

```
module Int : sig ... end
```
Bindings to functions in JavaScript's `Number` that deal with ints

```
module Bigint : sig ... end
```
Bindings to functions in JavaScript's `BigInt`

```
module Console : sig ... end
```
```
module Set : sig ... end
```
Bindings to functions in `Set`

```
module WeakSet : sig ... end
```
Bindings to functions in `WeakSet`

```
module Map : sig ... end
```
Bindings to functions in `Map`

```
module WeakMap : sig ... end
```
Bindings to functions in `WeakMap`

```
module Iterator : sig ... end
```
Bindings to functions on `Iterator`

```
module Blob : sig ... end
```
Bindings to Blob

```
module File : sig ... end
```
Bindings to File

```
module FormData : sig ... end
```
Bindings to FormData
