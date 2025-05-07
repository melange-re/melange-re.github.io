
# Module `Belt.MutableMap`

[`Belt.MutableMap`](#)

The top level provides generic **mutable** map operations.

It also has two specialized inner modules [`Belt.MutableMap.Int`](./Belt-MutableMap-Int.md) and [`Belt.MutableMap.String`](./Belt-MutableMap-String.md)

```
module Int : sig ... end
```
```
module String : sig ... end
```
A **mutable** sorted map module which allows customize *compare* behavior.

Same as Belt.Map, but mutable.

```
type ('k, 'v, 'id) t
```
```
type ('key, 'id) id =
  (module Belt__.Belt_Id.Comparable
  with type identity = 'id
   and type t = 'key)
```
```
val make : id:('k, 'id) id -> ('k, 'a, 'id) t
```
```
val clear : (_, _, _) t -> unit
```
```
val isEmpty : (_, _, _) t -> bool
```
```
val has : ('k, _, _) t -> 'k -> bool
```
```
val cmpU : 
  ('k, 'a, 'id) t ->
  ('k, 'a, 'id) t ->
  ('a -> 'a -> int) Js.Fn.arity2 ->
  int
```
```
val cmp : ('k, 'a, 'id) t -> ('k, 'a, 'id) t -> ('a -> 'a -> int) -> int
```
`cmp m1 m2 cmp` First compare by size, if size is the same, compare by key, value pair

```
val eqU : 
  ('k, 'a, 'id) t ->
  ('k, 'a, 'id) t ->
  ('a -> 'a -> bool) Js.Fn.arity2 ->
  bool
```
```
val eq : ('k, 'a, 'id) t -> ('k, 'a, 'id) t -> ('a -> 'a -> bool) -> bool
```
`eq m1 m2 eqf` tests whether the maps `m1` and `m2` are equal, that is, contain equal keys and associate them with equal data. `eqf` is the equality predicate used to compare the data associated with the keys.

```
val forEachU : ('k, 'a, 'id) t -> ('k -> 'a -> unit) Js.Fn.arity2 -> unit
```
```
val forEach : ('k, 'a, 'id) t -> ('k -> 'a -> unit) -> unit
```
`forEach m f` applies `f` to all bindings in map `m`. `f` receives the 'k as first argument, and the associated value as second argument. The bindings are passed to `f` in increasing order with respect to the ordering over the type of the keys.

```
val reduceU : 
  ('k, 'a, 'id) t ->
  'b ->
  ('b -> 'k -> 'a -> 'b) Js.Fn.arity3 ->
  'b
```
```
val reduce : ('k, 'a, 'id) t -> 'b -> ('b -> 'k -> 'a -> 'b) -> 'b
```
`reduce m a f` computes `(f kN dN ... (f k1 d1 a)...)`, where `k1 ... kN` are the keys of all bindings in `m` (in increasing order), and `d1 ... dN` are the associated data.

```
val everyU : ('k, 'a, 'id) t -> ('k -> 'a -> bool) Js.Fn.arity2 -> bool
```
```
val every : ('k, 'a, 'id) t -> ('k -> 'a -> bool) -> bool
```
`every m p` checks if all the bindings of the map satisfy the predicate `p`.

```
val someU : ('k, 'a, 'id) t -> ('k -> 'a -> bool) Js.Fn.arity2 -> bool
```
```
val some : ('k, 'a, 'id) t -> ('k -> 'a -> bool) -> bool
```
`some m p` checks if at least one binding of the map satisfy the predicate `p`.

```
val size : ('k, 'a, 'id) t -> int
```
```
val toList : ('k, 'a, 'id) t -> ('k * 'a) list
```
In increasing order

```
val toArray : ('k, 'a, 'id) t -> ('k * 'a) array
```
In increasing order

```
val fromArray : ('k * 'a) array -> id:('k, 'id) id -> ('k, 'a, 'id) t
```
```
val keysToArray : ('k, _, _) t -> 'k array
```
```
val valuesToArray : (_, 'a, _) t -> 'a array
```
```
val minKey : ('k, _, _) t -> 'k option
```
```
val minKeyUndefined : ('k, _, _) t -> 'k Js.undefined
```
```
val maxKey : ('k, _, _) t -> 'k option
```
```
val maxKeyUndefined : ('k, _, _) t -> 'k Js.undefined
```
```
val minimum : ('k, 'a, _) t -> ('k * 'a) option
```
```
val minUndefined : ('k, 'a, _) t -> ('k * 'a) Js.undefined
```
```
val maximum : ('k, 'a, _) t -> ('k * 'a) option
```
```
val maxUndefined : ('k, 'a, _) t -> ('k * 'a) Js.undefined
```
```
val get : ('k, 'a, 'id) t -> 'k -> 'a option
```
```
val getUndefined : ('k, 'a, 'id) t -> 'k -> 'a Js.undefined
```
```
val getWithDefault : ('k, 'a, 'id) t -> 'k -> 'a -> 'a
```
```
val getExn : ('k, 'a, 'id) t -> 'k -> 'a
```
```
val checkInvariantInternal : (_, _, _) t -> unit
```
**raise** when invariant is not held

```
val remove : ('k, 'a, 'id) t -> 'k -> unit
```
`remove m x` do the in-place modification,

```
val removeMany : ('k, 'a, 'id) t -> 'k array -> unit
```
```
val set : ('k, 'a, 'id) t -> 'k -> 'a -> unit
```
`set m x y ` do the in-place modification

```
val updateU : 
  ('k, 'a, 'id) t ->
  'k ->
  ('a option -> 'a option) Js.Fn.arity1 ->
  unit
```
```
val update : ('k, 'a, 'id) t -> 'k -> ('a option -> 'a option) -> unit
```
```
val mergeMany : ('k, 'a, 'id) t -> ('k * 'a) array -> unit
```
```
val mapU : ('k, 'a, 'id) t -> ('a -> 'b) Js.Fn.arity1 -> ('k, 'b, 'id) t
```
```
val map : ('k, 'a, 'id) t -> ('a -> 'b) -> ('k, 'b, 'id) t
```
`map m f` returns a map with same domain as `m`, where the associated value `a` of all bindings of `m` has been replaced by the result of the application of `f` to `a`. The bindings are passed to `f` in increasing order with respect to the ordering over the type of the keys.

```
val mapWithKeyU : 
  ('k, 'a, 'id) t ->
  ('k -> 'a -> 'b) Js.Fn.arity2 ->
  ('k, 'b, 'id) t
```
```
val mapWithKey : ('k, 'a, 'id) t -> ('k -> 'a -> 'b) -> ('k, 'b, 'id) t
```