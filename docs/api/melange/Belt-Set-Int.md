# Module `Set.Int`
Specalized when value type is `int`, more efficient than the generic type, its compare behavior is fixed using the built-in comparison
This module is [`Belt.Set`](./Belt-Set.md) specialized with value type to be a primitive type. It is more efficient in general, the API is the same with [`Belt.Set`](./Belt-Set.md) except its value type is fixed, and identity is not needed(using the built-in one)
**See** [`Belt.Set`](./Belt-Set.md)
```
type value = int
```
The type of the set elements.
```
type t
```
The type of sets.
```
val empty : t
```
```
val fromArray : value array -> t
```
```
val fromSortedArrayUnsafe : value array -> t
```
```
val isEmpty : t -> bool
```
```
val has : t -> value -> bool
```
```
val add : t -> value -> t
```
`add s x` If `x` was already in `s`, `s` is returned unchanged.
```
val mergeMany : t -> value array -> t
```
```
val remove : t -> value -> t
```
`remove m x` If `x` was not in `m`, `m` is returned reference unchanged.
```
val removeMany : t -> value array -> t
```
```
val union : t -> t -> t
```
```
val intersect : t -> t -> t
```
```
val diff : t -> t -> t
```
```
val subset : t -> t -> bool
```
`subset s1 s2` tests whether the set `s1` is a subset of the set `s2`.
```
val cmp : t -> t -> int
```
Total ordering between sets. Can be used as the ordering function for doing sets of sets.
```
val eq : t -> t -> bool
```
`eq s1 s2` tests whether the sets `s1` and `s2` are equal, that is, contain equal elements.
```
val forEachU : t -> (value -> unit) Js.Fn.arity1 -> unit
```
```
val forEach : t -> (value -> unit) -> unit
```
`forEach s f` applies `f` in turn to all elements of `s`. In increasing order
```
val reduceU : t -> 'a -> ('a -> value -> 'a) Js.Fn.arity2 -> 'a
```
```
val reduce : t -> 'a -> ('a -> value -> 'a) -> 'a
```
Iterate in increasing order.
```
val everyU : t -> (value -> bool) Js.Fn.arity1 -> bool
```
```
val every : t -> (value -> bool) -> bool
```
`every p s` checks if all elements of the set satisfy the predicate `p`. Order unspecified.
```
val someU : t -> (value -> bool) Js.Fn.arity1 -> bool
```
```
val some : t -> (value -> bool) -> bool
```
`some p s` checks if at least one element of the set satisfies the predicate `p`. Oder unspecified.
```
val keepU : t -> (value -> bool) Js.Fn.arity1 -> t
```
```
val keep : t -> (value -> bool) -> t
```
`keep p s` returns the set of all elements in `s` that satisfy predicate `p`.
```
val partitionU : t -> (value -> bool) Js.Fn.arity1 -> t * t
```
```
val partition : t -> (value -> bool) -> t * t
```
`partition p s` returns a pair of sets `(s1, s2)`, where `s1` is the set of all the elements of `s` that satisfy the predicate `p`, and `s2` is the set of all the elements of `s` that do not satisfy `p`.
```
val size : t -> int
```
```
val toList : t -> value list
```
In increasing order
```
val toArray : t -> value array
```
```
val minimum : t -> value option
```
```
val minUndefined : t -> value Js.undefined
```
```
val maximum : t -> value option
```
```
val maxUndefined : t -> value Js.undefined
```
```
val get : t -> value -> value option
```
```
val getUndefined : t -> value -> value Js.undefined
```
```
val getExn : t -> value -> value
```
```
val split : t -> value -> (t * t) * bool
```
`split x s` returns a triple `(l, present, r)`, where `l` is the set of elements of `s` that are strictly less than `x`; `r` is the set of elements of `s` that are strictly greater than `x`; `present` is `false` if `s` contains no element equal to `x`, or `true` if `s` contains an element equal to `x`.
```
val checkInvariantInternal : t -> unit
```
**raise** when invariant is not held