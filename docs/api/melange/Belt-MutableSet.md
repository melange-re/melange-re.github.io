# Module `Belt.MutableSet`
[`Belt.MutableSet`](#)
The top level provides generic **mutable** set operations.
It also has two specialized inner modules [`Belt.MutableSet.Int`](./Belt-MutableSet-Int.md) and [`Belt.MutableSet.String`](./Belt-MutableSet-String.md)
A *mutable* sorted set module which allows customize *compare* behavior.
Same as Belt.Set, but mutable.
```
module Int : sig ... end
```
Specalized when key type is `int`, more efficient than the generic type
```
module String : sig ... end
```
Specalized when key type is `string`, more efficient than the generic type
```
type ('k, 'id) t
```
```
type ('k, 'id) id =
  (module Belt__.Belt_Id.Comparable
  with type identity = 'id
   and type t = 'k)
```
```
val make : id:('value, 'id) id -> ('value, 'id) t
```
```
val fromArray : 'k array -> id:('k, 'id) id -> ('k, 'id) t
```
```
val fromSortedArrayUnsafe : 
  'value array ->
  id:('value, 'id) id ->
  ('value, 'id) t
```
```
val copy : ('k, 'id) t -> ('k, 'id) t
```
```
val isEmpty : (_, _) t -> bool
```
```
val has : ('value, _) t -> 'value -> bool
```
```
val add : ('value, 'id) t -> 'value -> unit
```
```
val addCheck : ('value, 'id) t -> 'value -> bool
```
```
val mergeMany : ('value, 'id) t -> 'value array -> unit
```
```
val remove : ('value, 'id) t -> 'value -> unit
```
```
val removeCheck : ('value, 'id) t -> 'value -> bool
```
```
val removeMany : ('value, 'id) t -> 'value array -> unit
```
```
val union : ('value, 'id) t -> ('value, 'id) t -> ('value, 'id) t
```
```
val intersect : ('value, 'id) t -> ('value, 'id) t -> ('value, 'id) t
```
```
val diff : ('value, 'id) t -> ('value, 'id) t -> ('value, 'id) t
```
```
val subset : ('value, 'id) t -> ('value, 'id) t -> bool
```
```
val cmp : ('value, 'id) t -> ('value, 'id) t -> int
```
```
val eq : ('value, 'id) t -> ('value, 'id) t -> bool
```
```
val forEachU : ('value, 'id) t -> ('value -> unit) Js.Fn.arity1 -> unit
```
```
val forEach : ('value, 'id) t -> ('value -> unit) -> unit
```
`forEach m f` applies `f` in turn to all elements of `m`. In increasing order
```
val reduceU : ('value, 'id) t -> 'a -> ('a -> 'value -> 'a) Js.Fn.arity2 -> 'a
```
```
val reduce : ('value, 'id) t -> 'a -> ('a -> 'value -> 'a) -> 'a
```
In increasing order.
```
val everyU : ('value, 'id) t -> ('value -> bool) Js.Fn.arity1 -> bool
```
```
val every : ('value, 'id) t -> ('value -> bool) -> bool
```
`every s p` checks if all elements of the set satisfy the predicate `p`. Order unspecified
```
val someU : ('value, 'id) t -> ('value -> bool) Js.Fn.arity1 -> bool
```
```
val some : ('value, 'id) t -> ('value -> bool) -> bool
```
`some p s` checks if at least one element of the set satisfies the predicate `p`.
```
val keepU : ('value, 'id) t -> ('value -> bool) Js.Fn.arity1 -> ('value, 'id) t
```
```
val keep : ('value, 'id) t -> ('value -> bool) -> ('value, 'id) t
```
`keep s p` returns the set of all elements in `s` that satisfy predicate `p`.
```
val partitionU : 
  ('value, 'id) t ->
  ('value -> bool) Js.Fn.arity1 ->
  ('value, 'id) t * ('value, 'id) t
```
```
val partition : 
  ('value, 'id) t ->
  ('value -> bool) ->
  ('value, 'id) t * ('value, 'id) t
```
`partition p s` returns a pair of sets `(s1, s2)`, where `s1` is the set of all the elements of `s` that satisfy the predicate `p`, and `s2` is the set of all the elements of `s` that do not satisfy `p`.
```
val size : ('value, 'id) t -> int
```
```
val toList : ('value, 'id) t -> 'value list
```
In increasing order
```
val toArray : ('value, 'id) t -> 'value array
```
In increasing order
```
val minimum : ('value, 'id) t -> 'value option
```
```
val minUndefined : ('value, 'id) t -> 'value Js.undefined
```
```
val maximum : ('value, 'id) t -> 'value option
```
```
val maxUndefined : ('value, 'id) t -> 'value Js.undefined
```
```
val get : ('value, 'id) t -> 'value -> 'value option
```
```
val getUndefined : ('value, 'id) t -> 'value -> 'value Js.undefined
```
```
val getExn : ('value, 'id) t -> 'value -> 'value
```
```
val split : 
  ('value, 'id) t ->
  'value ->
  (('value, 'id) t * ('value, 'id) t) * bool
```
`split s x` returns a triple `((l, r), present)`, where `l` is the set of elements of `s` that are strictly less than `x`; `r` is the set of elements of `s` that are strictly greater than `x`; `present` is `false` if `s` contains no element equal to `x`, or `true` if `s` contains an element equal to `x`. `l,r` are freshly made, no sharing with `s`
```
val checkInvariantInternal : (_, _) t -> unit
```
**raise** when invariant is not held