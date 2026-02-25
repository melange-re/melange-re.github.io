
# Module `MutableSet.Int`

Specalized when key type is `int`, more efficient than the generic type

This module is [`Belt.MutableSet`](./Belt-MutableSet.md) specialized with key type to be a primitive type.

It is more efficient in general, the API is the same with [`Belt.MutableSet`](./Belt-MutableSet.md) except its key type is fixed, and identity is not needed(using the built-in one)

**See** [`Belt.MutableSet`](./Belt-MutableSet.md)

```ocaml
type value = int
```
```reasonml
type value = int;
```
The type of the set elements.

```ocaml
type t
```
```reasonml
type t;
```
The type of sets.

```ocaml
val make : unit -> t
```
```reasonml
let make: unit => t;
```
```ocaml
val fromArray : value array -> t
```
```reasonml
let fromArray: array(value) => t;
```
```ocaml
val fromSortedArrayUnsafe : value array -> t
```
```reasonml
let fromSortedArrayUnsafe: array(value) => t;
```
```ocaml
val copy : t -> t
```
```reasonml
let copy: t => t;
```
```ocaml
val isEmpty : t -> bool
```
```reasonml
let isEmpty: t => bool;
```
```ocaml
val has : t -> value -> bool
```
```reasonml
let has: t => value => bool;
```
```ocaml
val add : t -> value -> unit
```
```reasonml
let add: t => value => unit;
```
```ocaml
val addCheck : t -> value -> bool
```
```reasonml
let addCheck: t => value => bool;
```
```ocaml
val mergeMany : t -> value array -> unit
```
```reasonml
let mergeMany: t => array(value) => unit;
```
```ocaml
val remove : t -> value -> unit
```
```reasonml
let remove: t => value => unit;
```
```ocaml
val removeCheck : t -> value -> bool
```
```reasonml
let removeCheck: t => value => bool;
```
```ocaml
val removeMany : t -> value array -> unit
```
```reasonml
let removeMany: t => array(value) => unit;
```
```ocaml
val union : t -> t -> t
```
```reasonml
let union: t => t => t;
```
```ocaml
val intersect : t -> t -> t
```
```reasonml
let intersect: t => t => t;
```
```ocaml
val diff : t -> t -> t
```
```reasonml
let diff: t => t => t;
```
```ocaml
val subset : t -> t -> bool
```
```reasonml
let subset: t => t => bool;
```
```ocaml
val cmp : t -> t -> int
```
```reasonml
let cmp: t => t => int;
```
```ocaml
val eq : t -> t -> bool
```
```reasonml
let eq: t => t => bool;
```
```ocaml
val forEachU : t -> (value -> unit) Js.Fn.arity1 -> unit
```
```reasonml
let forEachU: t => Js.Fn.arity1((value => unit)) => unit;
```
```ocaml
val forEach : t -> (value -> unit) -> unit
```
```reasonml
let forEach: t => (value => unit) => unit;
```
In increasing order

```ocaml
val reduceU : t -> 'a -> ('a -> value -> 'a) Js.Fn.arity2 -> 'a
```
```reasonml
let reduceU: t => 'a => Js.Fn.arity2(('a => value => 'a)) => 'a;
```
```ocaml
val reduce : t -> 'a -> ('a -> value -> 'a) -> 'a
```
```reasonml
let reduce: t => 'a => ('a => value => 'a) => 'a;
```
Iterate in increasing order.

```ocaml
val everyU : t -> (value -> bool) Js.Fn.arity1 -> bool
```
```reasonml
let everyU: t => Js.Fn.arity1((value => bool)) => bool;
```
```ocaml
val every : t -> (value -> bool) -> bool
```
```reasonml
let every: t => (value => bool) => bool;
```
`every p s` checks if all elements of the set satisfy the predicate `p`. Order unspecified.

```ocaml
val someU : t -> (value -> bool) Js.Fn.arity1 -> bool
```
```reasonml
let someU: t => Js.Fn.arity1((value => bool)) => bool;
```
```ocaml
val some : t -> (value -> bool) -> bool
```
```reasonml
let some: t => (value => bool) => bool;
```
`some p s` checks if at least one element of the set satisfies the predicate `p`. Oder unspecified.

```ocaml
val keepU : t -> (value -> bool) Js.Fn.arity1 -> t
```
```reasonml
let keepU: t => Js.Fn.arity1((value => bool)) => t;
```
```ocaml
val keep : t -> (value -> bool) -> t
```
```reasonml
let keep: t => (value => bool) => t;
```
`keep s p` returns a fresh copy of the set of all elements in `s` that satisfy predicate `p`.

```ocaml
val partitionU : t -> (value -> bool) Js.Fn.arity1 -> t * t
```
```reasonml
let partitionU: t => Js.Fn.arity1((value => bool)) => (t, t);
```
```ocaml
val partition : t -> (value -> bool) -> t * t
```
```reasonml
let partition: t => (value => bool) => (t, t);
```
`partition s p` returns a fresh copy pair of sets `(s1, s2)`, where `s1` is the set of all the elements of `s` that satisfy the predicate `p`, and `s2` is the set of all the elements of `s` that do not satisfy `p`.

```ocaml
val size : t -> int
```
```reasonml
let size: t => int;
```
```ocaml
val toList : t -> value list
```
```reasonml
let toList: t => list(value);
```
In increasing order with respect

```ocaml
val toArray : t -> value array
```
```reasonml
let toArray: t => array(value);
```
In increasing order with respect

```ocaml
val minimum : t -> value option
```
```reasonml
let minimum: t => option(value);
```
```ocaml
val minUndefined : t -> value Js.undefined
```
```reasonml
let minUndefined: t => Js.undefined(value);
```
```ocaml
val maximum : t -> value option
```
```reasonml
let maximum: t => option(value);
```
```ocaml
val maxUndefined : t -> value Js.undefined
```
```reasonml
let maxUndefined: t => Js.undefined(value);
```
```ocaml
val get : t -> value -> value option
```
```reasonml
let get: t => value => option(value);
```
```ocaml
val getUndefined : t -> value -> value Js.undefined
```
```reasonml
let getUndefined: t => value => Js.undefined(value);
```
```ocaml
val getExn : t -> value -> value
```
```reasonml
let getExn: t => value => value;
```
```ocaml
val split : t -> value -> (t * t) * bool
```
```reasonml
let split: t => value => ((t, t), bool);
```
`split s key` return a fresh copy of each

```ocaml
val checkInvariantInternal : t -> unit
```
```reasonml
let checkInvariantInternal: t => unit;
```
**raise** when invariant is not held
