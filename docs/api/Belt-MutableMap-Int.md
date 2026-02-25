
# Module `MutableMap.Int`

```ocaml
type key = int
```
```reasonml
type key = int;
```
```ocaml
type 'a t
```
```reasonml
type t('a);
```
```ocaml
val make : unit -> 'a t
```
```reasonml
let make: unit => t('a);
```
```ocaml
val clear : 'a t -> unit
```
```reasonml
let clear: t('a) => unit;
```
```ocaml
val isEmpty : 'a t -> bool
```
```reasonml
let isEmpty: t('a) => bool;
```
```ocaml
val has : 'a t -> key -> bool
```
```reasonml
let has: t('a) => key => bool;
```
```ocaml
val cmpU : 'a t -> 'a t -> ('a -> 'a -> int) Js.Fn.arity2 -> int
```
```reasonml
let cmpU: t('a) => t('a) => Js.Fn.arity2(('a => 'a => int)) => int;
```
```ocaml
val cmp : 'a t -> 'a t -> ('a -> 'a -> int) -> int
```
```reasonml
let cmp: t('a) => t('a) => ('a => 'a => int) => int;
```
`cmp m1 m2 cmp` First compare by size, if size is the same, compare by key, value pair

```ocaml
val eqU : 'a t -> 'a t -> ('a -> 'a -> bool) Js.Fn.arity2 -> bool
```
```reasonml
let eqU: t('a) => t('a) => Js.Fn.arity2(('a => 'a => bool)) => bool;
```
```ocaml
val eq : 'a t -> 'a t -> ('a -> 'a -> bool) -> bool
```
```reasonml
let eq: t('a) => t('a) => ('a => 'a => bool) => bool;
```
`eq m1 m2 cmp`

```ocaml
val forEachU : 'a t -> (key -> 'a -> unit) Js.Fn.arity2 -> unit
```
```reasonml
let forEachU: t('a) => Js.Fn.arity2((key => 'a => unit)) => unit;
```
```ocaml
val forEach : 'a t -> (key -> 'a -> unit) -> unit
```
```reasonml
let forEach: t('a) => (key => 'a => unit) => unit;
```
`forEach m f` applies `f` to all bindings in map `m`. `f` receives the key as first argument, and the associated value as second argument. The application order of `f` is in increasing order.

```ocaml
val reduceU : 'a t -> 'b -> ('b -> key -> 'a -> 'b) Js.Fn.arity3 -> 'b
```
```reasonml
let reduceU: t('a) => 'b => Js.Fn.arity3(('b => key => 'a => 'b)) => 'b;
```
```ocaml
val reduce : 'a t -> 'b -> ('b -> key -> 'a -> 'b) -> 'b
```
```reasonml
let reduce: t('a) => 'b => ('b => key => 'a => 'b) => 'b;
```
`reduce m a f` computes `(f kN dN ... (f k1 d1 a)...)`, where `k1 ... kN` are the keys of all bindings in `m` (in increasing order), and `d1 ... dN` are the associated data.

```ocaml
val everyU : 'a t -> (key -> 'a -> bool) Js.Fn.arity2 -> bool
```
```reasonml
let everyU: t('a) => Js.Fn.arity2((key => 'a => bool)) => bool;
```
```ocaml
val every : 'a t -> (key -> 'a -> bool) -> bool
```
```reasonml
let every: t('a) => (key => 'a => bool) => bool;
```
`every m p` checks if all the bindings of the map satisfy the predicate `p`. The application order of `p` is unspecified.

```ocaml
val someU : 'a t -> (key -> 'a -> bool) Js.Fn.arity2 -> bool
```
```reasonml
let someU: t('a) => Js.Fn.arity2((key => 'a => bool)) => bool;
```
```ocaml
val some : 'a t -> (key -> 'a -> bool) -> bool
```
```reasonml
let some: t('a) => (key => 'a => bool) => bool;
```
`some m p` checks if at least one binding of the map satisfy the predicate `p`. The application order of `p` is unspecified.

```ocaml
val size : 'a t -> int
```
```reasonml
let size: t('a) => int;
```
```ocaml
val toList : 'a t -> (key * 'a) list
```
```reasonml
let toList: t('a) => list((key, 'a));
```
In increasing order

```ocaml
val toArray : 'a t -> (key * 'a) array
```
```reasonml
let toArray: t('a) => array((key, 'a));
```
In increasing order

```ocaml
val fromArray : (key * 'a) array -> 'a t
```
```reasonml
let fromArray: array((key, 'a)) => t('a);
```
```ocaml
val keysToArray : 'a t -> key array
```
```reasonml
let keysToArray: t('a) => array(key);
```
```ocaml
val valuesToArray : 'a t -> 'a array
```
```reasonml
let valuesToArray: t('a) => array('a);
```
```ocaml
val minKey : _ t -> key option
```
```reasonml
let minKey: t(_) => option(key);
```
```ocaml
val minKeyUndefined : _ t -> key Js.undefined
```
```reasonml
let minKeyUndefined: t(_) => Js.undefined(key);
```
```ocaml
val maxKey : _ t -> key option
```
```reasonml
let maxKey: t(_) => option(key);
```
```ocaml
val maxKeyUndefined : _ t -> key Js.undefined
```
```reasonml
let maxKeyUndefined: t(_) => Js.undefined(key);
```
```ocaml
val minimum : 'a t -> (key * 'a) option
```
```reasonml
let minimum: t('a) => option((key, 'a));
```
```ocaml
val minUndefined : 'a t -> (key * 'a) Js.undefined
```
```reasonml
let minUndefined: t('a) => Js.undefined((key, 'a));
```
```ocaml
val maximum : 'a t -> (key * 'a) option
```
```reasonml
let maximum: t('a) => option((key, 'a));
```
```ocaml
val maxUndefined : 'a t -> (key * 'a) Js.undefined
```
```reasonml
let maxUndefined: t('a) => Js.undefined((key, 'a));
```
```ocaml
val get : 'a t -> key -> 'a option
```
```reasonml
let get: t('a) => key => option('a);
```
```ocaml
val getUndefined : 'a t -> key -> 'a Js.undefined
```
```reasonml
let getUndefined: t('a) => key => Js.undefined('a);
```
```ocaml
val getWithDefault : 'a t -> key -> 'a -> 'a
```
```reasonml
let getWithDefault: t('a) => key => 'a => 'a;
```
```ocaml
val getExn : 'a t -> key -> 'a
```
```reasonml
let getExn: t('a) => key => 'a;
```
```ocaml
val checkInvariantInternal : _ t -> unit
```
```reasonml
let checkInvariantInternal: t(_) => unit;
```
**raise** when invariant is not held

```ocaml
val remove : 'a t -> key -> unit
```
```reasonml
let remove: t('a) => key => unit;
```
`remove m x` do the in-place modification

```ocaml
val removeMany : 'a t -> key array -> unit
```
```reasonml
let removeMany: t('a) => array(key) => unit;
```
```ocaml
val set : 'a t -> key -> 'a -> unit
```
```reasonml
let set: t('a) => key => 'a => unit;
```
`set m x y` do the in-place modification, return `m` for chaining. If `x` was already bound in `m`, its previous binding disappears.

```ocaml
val updateU : 'a t -> key -> ('a option -> 'a option) Js.Fn.arity1 -> unit
```
```reasonml
let updateU: t('a) => key => Js.Fn.arity1((option('a) => option('a))) => unit;
```
```ocaml
val update : 'a t -> key -> ('a option -> 'a option) -> unit
```
```reasonml
let update: t('a) => key => (option('a) => option('a)) => unit;
```
```ocaml
val mapU : 'a t -> ('a -> 'b) Js.Fn.arity1 -> 'b t
```
```reasonml
let mapU: t('a) => Js.Fn.arity1(('a => 'b)) => t('b);
```
```ocaml
val map : 'a t -> ('a -> 'b) -> 'b t
```
```reasonml
let map: t('a) => ('a => 'b) => t('b);
```
`map m f` returns a map with same domain as `m`, where the associated value `a` of all bindings of `m` has been replaced by the result of the application of `f` to `a`. The bindings are passed to `f` in increasing order with respect to the ordering over the type of the keys.

```ocaml
val mapWithKeyU : 'a t -> (key -> 'a -> 'b) Js.Fn.arity2 -> 'b t
```
```reasonml
let mapWithKeyU: t('a) => Js.Fn.arity2((key => 'a => 'b)) => t('b);
```
```ocaml
val mapWithKey : 'a t -> (key -> 'a -> 'b) -> 'b t
```
```reasonml
let mapWithKey: t('a) => (key => 'a => 'b) => t('b);
```