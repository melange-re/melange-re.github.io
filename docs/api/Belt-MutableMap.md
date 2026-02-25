
# Module `Belt.MutableMap`

[`Belt.MutableMap`](#)

The top level provides generic **mutable** map operations.

It also has two specialized inner modules [`Belt.MutableMap.Int`](./Belt-MutableMap-Int.md) and [`Belt.MutableMap.String`](./Belt-MutableMap-String.md)

```ocaml
module Int : sig ... end
```
```reasonml
module Int: { ... };
```
```ocaml
module String : sig ... end
```
```reasonml
module String: { ... };
```
A **mutable** sorted map module which allows customize *compare* behavior.

Same as Belt.Map, but mutable.

```ocaml
type ('k, 'v, 'id) t
```
```reasonml
type t('k, 'v, 'id);
```
```ocaml
type ('key, 'id) id =
  (module Belt__.Belt_Id.Comparable
  with type identity = 'id
   and type t = 'key)
```
```reasonml
type id('key, 'id) =
  (module Belt__.Belt_Id.Comparable
  with type identity = 'id
   and type t = 'key);
```
```ocaml
val make : id:('k, 'id) id -> ('k, 'a, 'id) t
```
```reasonml
let make: id:id('k, 'id) => t('k, 'a, 'id);
```
```ocaml
val clear : (_, _, _) t -> unit
```
```reasonml
let clear: t(_, _, _) => unit;
```
```ocaml
val isEmpty : (_, _, _) t -> bool
```
```reasonml
let isEmpty: t(_, _, _) => bool;
```
```ocaml
val has : ('k, _, _) t -> 'k -> bool
```
```reasonml
let has: t('k, _, _) => 'k => bool;
```
```ocaml
val cmpU : 
  ('k, 'a, 'id) t ->
  ('k, 'a, 'id) t ->
  ('a -> 'a -> int) Js.Fn.arity2 ->
  int
```
```reasonml
let cmpU: 
  t('k, 'a, 'id) =>
  t('k, 'a, 'id) =>
  Js.Fn.arity2(('a => 'a => int)) =>
  int;
```
```ocaml
val cmp : ('k, 'a, 'id) t -> ('k, 'a, 'id) t -> ('a -> 'a -> int) -> int
```
```reasonml
let cmp: t('k, 'a, 'id) => t('k, 'a, 'id) => ('a => 'a => int) => int;
```
`cmp m1 m2 cmp` First compare by size, if size is the same, compare by key, value pair

```ocaml
val eqU : 
  ('k, 'a, 'id) t ->
  ('k, 'a, 'id) t ->
  ('a -> 'a -> bool) Js.Fn.arity2 ->
  bool
```
```reasonml
let eqU: 
  t('k, 'a, 'id) =>
  t('k, 'a, 'id) =>
  Js.Fn.arity2(('a => 'a => bool)) =>
  bool;
```
```ocaml
val eq : ('k, 'a, 'id) t -> ('k, 'a, 'id) t -> ('a -> 'a -> bool) -> bool
```
```reasonml
let eq: t('k, 'a, 'id) => t('k, 'a, 'id) => ('a => 'a => bool) => bool;
```
`eq m1 m2 eqf` tests whether the maps `m1` and `m2` are equal, that is, contain equal keys and associate them with equal data. `eqf` is the equality predicate used to compare the data associated with the keys.

```ocaml
val forEachU : ('k, 'a, 'id) t -> ('k -> 'a -> unit) Js.Fn.arity2 -> unit
```
```reasonml
let forEachU: t('k, 'a, 'id) => Js.Fn.arity2(('k => 'a => unit)) => unit;
```
```ocaml
val forEach : ('k, 'a, 'id) t -> ('k -> 'a -> unit) -> unit
```
```reasonml
let forEach: t('k, 'a, 'id) => ('k => 'a => unit) => unit;
```
`forEach m f` applies `f` to all bindings in map `m`. `f` receives the 'k as first argument, and the associated value as second argument. The bindings are passed to `f` in increasing order with respect to the ordering over the type of the keys.

```ocaml
val reduceU : 
  ('k, 'a, 'id) t ->
  'b ->
  ('b -> 'k -> 'a -> 'b) Js.Fn.arity3 ->
  'b
```
```reasonml
let reduceU: 
  t('k, 'a, 'id) =>
  'b =>
  Js.Fn.arity3(('b => 'k => 'a => 'b)) =>
  'b;
```
```ocaml
val reduce : ('k, 'a, 'id) t -> 'b -> ('b -> 'k -> 'a -> 'b) -> 'b
```
```reasonml
let reduce: t('k, 'a, 'id) => 'b => ('b => 'k => 'a => 'b) => 'b;
```
`reduce m a f` computes `(f kN dN ... (f k1 d1 a)...)`, where `k1 ... kN` are the keys of all bindings in `m` (in increasing order), and `d1 ... dN` are the associated data.

```ocaml
val everyU : ('k, 'a, 'id) t -> ('k -> 'a -> bool) Js.Fn.arity2 -> bool
```
```reasonml
let everyU: t('k, 'a, 'id) => Js.Fn.arity2(('k => 'a => bool)) => bool;
```
```ocaml
val every : ('k, 'a, 'id) t -> ('k -> 'a -> bool) -> bool
```
```reasonml
let every: t('k, 'a, 'id) => ('k => 'a => bool) => bool;
```
`every m p` checks if all the bindings of the map satisfy the predicate `p`.

```ocaml
val someU : ('k, 'a, 'id) t -> ('k -> 'a -> bool) Js.Fn.arity2 -> bool
```
```reasonml
let someU: t('k, 'a, 'id) => Js.Fn.arity2(('k => 'a => bool)) => bool;
```
```ocaml
val some : ('k, 'a, 'id) t -> ('k -> 'a -> bool) -> bool
```
```reasonml
let some: t('k, 'a, 'id) => ('k => 'a => bool) => bool;
```
`some m p` checks if at least one binding of the map satisfy the predicate `p`.

```ocaml
val size : ('k, 'a, 'id) t -> int
```
```reasonml
let size: t('k, 'a, 'id) => int;
```
```ocaml
val toList : ('k, 'a, 'id) t -> ('k * 'a) list
```
```reasonml
let toList: t('k, 'a, 'id) => list(('k, 'a));
```
In increasing order

```ocaml
val toArray : ('k, 'a, 'id) t -> ('k * 'a) array
```
```reasonml
let toArray: t('k, 'a, 'id) => array(('k, 'a));
```
In increasing order

```ocaml
val fromArray : ('k * 'a) array -> id:('k, 'id) id -> ('k, 'a, 'id) t
```
```reasonml
let fromArray: array(('k, 'a)) => id:id('k, 'id) => t('k, 'a, 'id);
```
```ocaml
val keysToArray : ('k, _, _) t -> 'k array
```
```reasonml
let keysToArray: t('k, _, _) => array('k);
```
```ocaml
val valuesToArray : (_, 'a, _) t -> 'a array
```
```reasonml
let valuesToArray: t(_, 'a, _) => array('a);
```
```ocaml
val minKey : ('k, _, _) t -> 'k option
```
```reasonml
let minKey: t('k, _, _) => option('k);
```
```ocaml
val minKeyUndefined : ('k, _, _) t -> 'k Js.undefined
```
```reasonml
let minKeyUndefined: t('k, _, _) => Js.undefined('k);
```
```ocaml
val maxKey : ('k, _, _) t -> 'k option
```
```reasonml
let maxKey: t('k, _, _) => option('k);
```
```ocaml
val maxKeyUndefined : ('k, _, _) t -> 'k Js.undefined
```
```reasonml
let maxKeyUndefined: t('k, _, _) => Js.undefined('k);
```
```ocaml
val minimum : ('k, 'a, _) t -> ('k * 'a) option
```
```reasonml
let minimum: t('k, 'a, _) => option(('k, 'a));
```
```ocaml
val minUndefined : ('k, 'a, _) t -> ('k * 'a) Js.undefined
```
```reasonml
let minUndefined: t('k, 'a, _) => Js.undefined(('k, 'a));
```
```ocaml
val maximum : ('k, 'a, _) t -> ('k * 'a) option
```
```reasonml
let maximum: t('k, 'a, _) => option(('k, 'a));
```
```ocaml
val maxUndefined : ('k, 'a, _) t -> ('k * 'a) Js.undefined
```
```reasonml
let maxUndefined: t('k, 'a, _) => Js.undefined(('k, 'a));
```
```ocaml
val get : ('k, 'a, 'id) t -> 'k -> 'a option
```
```reasonml
let get: t('k, 'a, 'id) => 'k => option('a);
```
```ocaml
val getUndefined : ('k, 'a, 'id) t -> 'k -> 'a Js.undefined
```
```reasonml
let getUndefined: t('k, 'a, 'id) => 'k => Js.undefined('a);
```
```ocaml
val getWithDefault : ('k, 'a, 'id) t -> 'k -> 'a -> 'a
```
```reasonml
let getWithDefault: t('k, 'a, 'id) => 'k => 'a => 'a;
```
```ocaml
val getExn : ('k, 'a, 'id) t -> 'k -> 'a
```
```reasonml
let getExn: t('k, 'a, 'id) => 'k => 'a;
```
```ocaml
val checkInvariantInternal : (_, _, _) t -> unit
```
```reasonml
let checkInvariantInternal: t(_, _, _) => unit;
```
**raise** when invariant is not held

```ocaml
val remove : ('k, 'a, 'id) t -> 'k -> unit
```
```reasonml
let remove: t('k, 'a, 'id) => 'k => unit;
```
`remove m x` do the in-place modification,

```ocaml
val removeMany : ('k, 'a, 'id) t -> 'k array -> unit
```
```reasonml
let removeMany: t('k, 'a, 'id) => array('k) => unit;
```
```ocaml
val set : ('k, 'a, 'id) t -> 'k -> 'a -> unit
```
```reasonml
let set: t('k, 'a, 'id) => 'k => 'a => unit;
```
`set m x y ` do the in-place modification

```ocaml
val updateU : 
  ('k, 'a, 'id) t ->
  'k ->
  ('a option -> 'a option) Js.Fn.arity1 ->
  unit
```
```reasonml
let updateU: 
  t('k, 'a, 'id) =>
  'k =>
  Js.Fn.arity1((option('a) => option('a))) =>
  unit;
```
```ocaml
val update : ('k, 'a, 'id) t -> 'k -> ('a option -> 'a option) -> unit
```
```reasonml
let update: t('k, 'a, 'id) => 'k => (option('a) => option('a)) => unit;
```
```ocaml
val mergeMany : ('k, 'a, 'id) t -> ('k * 'a) array -> unit
```
```reasonml
let mergeMany: t('k, 'a, 'id) => array(('k, 'a)) => unit;
```
```ocaml
val mapU : ('k, 'a, 'id) t -> ('a -> 'b) Js.Fn.arity1 -> ('k, 'b, 'id) t
```
```reasonml
let mapU: t('k, 'a, 'id) => Js.Fn.arity1(('a => 'b)) => t('k, 'b, 'id);
```
```ocaml
val map : ('k, 'a, 'id) t -> ('a -> 'b) -> ('k, 'b, 'id) t
```
```reasonml
let map: t('k, 'a, 'id) => ('a => 'b) => t('k, 'b, 'id);
```
`map m f` returns a map with same domain as `m`, where the associated value `a` of all bindings of `m` has been replaced by the result of the application of `f` to `a`. The bindings are passed to `f` in increasing order with respect to the ordering over the type of the keys.

```ocaml
val mapWithKeyU : 
  ('k, 'a, 'id) t ->
  ('k -> 'a -> 'b) Js.Fn.arity2 ->
  ('k, 'b, 'id) t
```
```reasonml
let mapWithKeyU: 
  t('k, 'a, 'id) =>
  Js.Fn.arity2(('k => 'a => 'b)) =>
  t('k, 'b, 'id);
```
```ocaml
val mapWithKey : ('k, 'a, 'id) t -> ('k -> 'a -> 'b) -> ('k, 'b, 'id) t
```
```reasonml
let mapWithKey: t('k, 'a, 'id) => ('k => 'a => 'b) => t('k, 'b, 'id);
```