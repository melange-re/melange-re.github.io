
# Module `HashSet.String`

Specalized when key type is `string`, more efficient than the generic type

This module is [`Belt.HashSet`](./Belt-HashSet.md) specialized with key type to be a primitive type.

It is more efficient in general, the API is the same with [`Belt.HashSet`](./Belt-HashSet.md) except its key type is fixed, and identity is not needed(using the built-in one)

**See** [`Belt.HashSet`](./Belt-HashSet.md)

```ocaml
type key = string
```
```reasonml
type key = string;
```
```ocaml
type t
```
```reasonml
type t;
```
```ocaml
val make : hintSize:int -> t
```
```reasonml
let make: hintSize:int => t;
```
```ocaml
val clear : t -> unit
```
```reasonml
let clear: t => unit;
```
```ocaml
val isEmpty : t -> bool
```
```reasonml
let isEmpty: t => bool;
```
```ocaml
val add : t -> key -> unit
```
```reasonml
let add: t => key => unit;
```
```ocaml
val copy : t -> t
```
```reasonml
let copy: t => t;
```
```ocaml
val has : t -> key -> bool
```
```reasonml
let has: t => key => bool;
```
```ocaml
val remove : t -> key -> unit
```
```reasonml
let remove: t => key => unit;
```
```ocaml
val forEachU : t -> (key -> unit) Js.Fn.arity1 -> unit
```
```reasonml
let forEachU: t => Js.Fn.arity1((key => unit)) => unit;
```
```ocaml
val forEach : t -> (key -> unit) -> unit
```
```reasonml
let forEach: t => (key => unit) => unit;
```
```ocaml
val reduceU : t -> 'c -> ('c -> key -> 'c) Js.Fn.arity2 -> 'c
```
```reasonml
let reduceU: t => 'c => Js.Fn.arity2(('c => key => 'c)) => 'c;
```
```ocaml
val reduce : t -> 'c -> ('c -> key -> 'c) -> 'c
```
```reasonml
let reduce: t => 'c => ('c => key => 'c) => 'c;
```
```ocaml
val size : t -> int
```
```reasonml
let size: t => int;
```
```ocaml
val logStats : t -> unit
```
```reasonml
let logStats: t => unit;
```
```ocaml
val toArray : t -> key array
```
```reasonml
let toArray: t => array(key);
```
```ocaml
val fromArray : key array -> t
```
```reasonml
let fromArray: array(key) => t;
```
```ocaml
val mergeMany : t -> key array -> unit
```
```reasonml
let mergeMany: t => array(key) => unit;
```
```ocaml
val getBucketHistogram : t -> int array
```
```reasonml
let getBucketHistogram: t => array(int);
```