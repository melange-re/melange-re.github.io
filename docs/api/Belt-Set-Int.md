
# Module `Set.Int`

Specalized when value type is `int`, more efficient than the generic type, its compare behavior is fixed using the built-in comparison

This module is [`Belt.Set`](./Belt-Set.md) specialized with value type to be a primitive type. It is more efficient in general, the API is the same with [`Belt.Set`](./Belt-Set.md) except its value type is fixed, and identity is not needed(using the built-in one)

**See** [`Belt.Set`](./Belt-Set.md)

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
val empty : t
```
```reasonml
let empty: t;
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
val add : t -> value -> t
```
```reasonml
let add: t => value => t;
```
`add s x` If `x` was already in `s`, `s` is returned unchanged.

```ocaml
val mergeMany : t -> value array -> t
```
```reasonml
let mergeMany: t => array(value) => t;
```
```ocaml
val remove : t -> value -> t
```
```reasonml
let remove: t => value => t;
```
`remove m x` If `x` was not in `m`, `m` is returned reference unchanged.

```ocaml
val removeMany : t -> value array -> t
```
```reasonml
let removeMany: t => array(value) => t;
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
`subset s1 s2` tests whether the set `s1` is a subset of the set `s2`.

```ocaml
val cmp : t -> t -> int
```
```reasonml
let cmp: t => t => int;
```
Total ordering between sets. Can be used as the ordering function for doing sets of sets.

```ocaml
val eq : t -> t -> bool
```
```reasonml
let eq: t => t => bool;
```
`eq s1 s2` tests whether the sets `s1` and `s2` are equal, that is, contain equal elements.

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
`forEach s f` applies `f` in turn to all elements of `s`. In increasing order

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
`keep p s` returns the set of all elements in `s` that satisfy predicate `p`.

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
`partition p s` returns a pair of sets `(s1, s2)`, where `s1` is the set of all the elements of `s` that satisfy the predicate `p`, and `s2` is the set of all the elements of `s` that do not satisfy `p`.

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
In increasing order

```ocaml
val toArray : t -> value array
```
```reasonml
let toArray: t => array(value);
```
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
`split x s` returns a triple `(l, present, r)`, where `l` is the set of elements of `s` that are strictly less than `x`; `r` is the set of elements of `s` that are strictly greater than `x`; `present` is `false` if `s` contains no element equal to `x`, or `true` if `s` contains an element equal to `x`.

```ocaml
val checkInvariantInternal : t -> unit
```
```reasonml
let checkInvariantInternal: t => unit;
```
**raise** when invariant is not held
