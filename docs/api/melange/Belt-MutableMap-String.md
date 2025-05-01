# Module `MutableMap.String`
```
type key = string
```
```
type 'a t
```
```
val make : unit -> 'a t
```
```
val clear : 'a t -> unit
```
```
val isEmpty : 'a t -> bool
```
```
val has : 'a t -> key -> bool
```
```
val cmpU : 'a t -> 'a t -> ('a -> 'a -> int) Js.Fn.arity2 -> int
```
```
val cmp : 'a t -> 'a t -> ('a -> 'a -> int) -> int
```
`cmp m1 m2 cmp` First compare by size, if size is the same, compare by key, value pair
```
val eqU : 'a t -> 'a t -> ('a -> 'a -> bool) Js.Fn.arity2 -> bool
```
```
val eq : 'a t -> 'a t -> ('a -> 'a -> bool) -> bool
```
`eq m1 m2 cmp`
```
val forEachU : 'a t -> (key -> 'a -> unit) Js.Fn.arity2 -> unit
```
```
val forEach : 'a t -> (key -> 'a -> unit) -> unit
```
`forEach m f` applies `f` to all bindings in map `m`. `f` receives the key as first argument, and the associated value as second argument. The application order of `f` is in increasing order.
```
val reduceU : 'a t -> 'b -> ('b -> key -> 'a -> 'b) Js.Fn.arity3 -> 'b
```
```
val reduce : 'a t -> 'b -> ('b -> key -> 'a -> 'b) -> 'b
```
`reduce m a f` computes `(f kN dN ... (f k1 d1 a)...)`, where `k1 ... kN` are the keys of all bindings in `m` (in increasing order), and `d1 ... dN` are the associated data.
```
val everyU : 'a t -> (key -> 'a -> bool) Js.Fn.arity2 -> bool
```
```
val every : 'a t -> (key -> 'a -> bool) -> bool
```
`every m p` checks if all the bindings of the map satisfy the predicate `p`. The application order of `p` is unspecified.
```
val someU : 'a t -> (key -> 'a -> bool) Js.Fn.arity2 -> bool
```
```
val some : 'a t -> (key -> 'a -> bool) -> bool
```
`some m p` checks if at least one binding of the map satisfy the predicate `p`. The application order of `p` is unspecified.
```
val size : 'a t -> int
```
```
val toList : 'a t -> (key * 'a) list
```
In increasing order
```
val toArray : 'a t -> (key * 'a) array
```
In increasing order
```
val fromArray : (key * 'a) array -> 'a t
```
```
val keysToArray : 'a t -> key array
```
```
val valuesToArray : 'a t -> 'a array
```
```
val minKey : _ t -> key option
```
```
val minKeyUndefined : _ t -> key Js.undefined
```
```
val maxKey : _ t -> key option
```
```
val maxKeyUndefined : _ t -> key Js.undefined
```
```
val minimum : 'a t -> (key * 'a) option
```
```
val minUndefined : 'a t -> (key * 'a) Js.undefined
```
```
val maximum : 'a t -> (key * 'a) option
```
```
val maxUndefined : 'a t -> (key * 'a) Js.undefined
```
```
val get : 'a t -> key -> 'a option
```
```
val getUndefined : 'a t -> key -> 'a Js.undefined
```
```
val getWithDefault : 'a t -> key -> 'a -> 'a
```
```
val getExn : 'a t -> key -> 'a
```
```
val checkInvariantInternal : _ t -> unit
```
**raise** when invariant is not held
```
val remove : 'a t -> key -> unit
```
`remove m x` do the in-place modification
```
val removeMany : 'a t -> key array -> unit
```
```
val set : 'a t -> key -> 'a -> unit
```
`set m x y` do the in-place modification, return `m` for chaining. If `x` was already bound in `m`, its previous binding disappears.
```
val updateU : 'a t -> key -> ('a option -> 'a option) Js.Fn.arity1 -> unit
```
```
val update : 'a t -> key -> ('a option -> 'a option) -> unit
```
```
val mapU : 'a t -> ('a -> 'b) Js.Fn.arity1 -> 'b t
```
```
val map : 'a t -> ('a -> 'b) -> 'b t
```
`map m f` returns a map with same domain as `m`, where the associated value `a` of all bindings of `m` has been replaced by the result of the application of `f` to `a`. The bindings are passed to `f` in increasing order with respect to the ordering over the type of the keys.
```
val mapWithKeyU : 'a t -> (key -> 'a -> 'b) Js.Fn.arity2 -> 'b t
```
```
val mapWithKey : 'a t -> (key -> 'a -> 'b) -> 'b t
```