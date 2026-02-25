
# Module `Map.Dict`

This module seprate identity from data, it is a bit more verboe but slightly more efficient due to the fact that there is no need to pack identity and data back after each operation

**Advanced usage only**

```ocaml
type ('key, 'value, 'id) t
```
```reasonml
type t('key, 'value, 'id);
```
```ocaml
type ('key, 'id) cmp
```
```reasonml
type cmp('key, 'id);
```
```ocaml
val empty : ('k, 'v, 'id) t
```
```reasonml
let empty: t('k, 'v, 'id);
```
```ocaml
val isEmpty : ('k, 'v, 'id) t -> bool
```
```reasonml
let isEmpty: t('k, 'v, 'id) => bool;
```
```ocaml
val has : ('k, 'a, 'id) t -> 'k -> cmp:('k, 'id) cmp -> bool
```
```reasonml
let has: t('k, 'a, 'id) => 'k => cmp:cmp('k, 'id) => bool;
```
```ocaml
val cmpU : 
  ('k, 'v, 'id) t ->
  ('k, 'v, 'id) t ->
  kcmp:('k, 'id) cmp ->
  vcmp:('v -> 'v -> int) Js.Fn.arity2 ->
  int
```
```reasonml
let cmpU: 
  t('k, 'v, 'id) =>
  t('k, 'v, 'id) =>
  kcmp:cmp('k, 'id) =>
  vcmp:Js.Fn.arity2(('v => 'v => int)) =>
  int;
```
```ocaml
val cmp : 
  ('k, 'v, 'id) t ->
  ('k, 'v, 'id) t ->
  kcmp:('k, 'id) cmp ->
  vcmp:('v -> 'v -> int) ->
  int
```
```reasonml
let cmp: 
  t('k, 'v, 'id) =>
  t('k, 'v, 'id) =>
  kcmp:cmp('k, 'id) =>
  vcmp:('v => 'v => int) =>
  int;
```
```ocaml
val eqU : 
  ('k, 'a, 'id) t ->
  ('k, 'a, 'id) t ->
  kcmp:('k, 'id) cmp ->
  veq:('a -> 'a -> bool) Js.Fn.arity2 ->
  bool
```
```reasonml
let eqU: 
  t('k, 'a, 'id) =>
  t('k, 'a, 'id) =>
  kcmp:cmp('k, 'id) =>
  veq:Js.Fn.arity2(('a => 'a => bool)) =>
  bool;
```
```ocaml
val eq : 
  ('k, 'a, 'id) t ->
  ('k, 'a, 'id) t ->
  kcmp:('k, 'id) cmp ->
  veq:('a -> 'a -> bool) ->
  bool
```
```reasonml
let eq: 
  t('k, 'a, 'id) =>
  t('k, 'a, 'id) =>
  kcmp:cmp('k, 'id) =>
  veq:('a => 'a => bool) =>
  bool;
```
`eq m1 m2 cmp` tests whether the maps `m1` and `m2` are equal, that is, contain equal keys and associate them with equal data. `cmp` is the equality predicate used to compare the data associated with the keys.

```ocaml
val findFirstByU : 
  ('k, 'v, 'id) t ->
  ('k -> 'v -> bool) Js.Fn.arity2 ->
  ('k * 'v) option
```
```reasonml
let findFirstByU: 
  t('k, 'v, 'id) =>
  Js.Fn.arity2(('k => 'v => bool)) =>
  option(('k, 'v));
```
```ocaml
val findFirstBy : ('k, 'v, 'id) t -> ('k -> 'v -> bool) -> ('k * 'v) option
```
```reasonml
let findFirstBy: t('k, 'v, 'id) => ('k => 'v => bool) => option(('k, 'v));
```
`findFirstBy m p` uses funcion `f` to find the first key value pair to match predicate `p`.

```ocaml
  let s0 = fromArray ~id:(module IntCmp) [|4,"4";1,"1";2,"2,"3""|];;
  findFirstBy s0 (fun k v -> k = 4 ) = option (4, "4");;
```
```reasonml
let s0 =
  fromArray(
    ~id=(module IntCmp),
    [|(4, "4"), (1, "1"), (2, "2,"(3, ""))|],
  );
findFirstBy(s0, (k, v) => k == 4) == option((4, "4"));
```
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
`forEach m f` applies `f` to all bindings in map `m`. `f` receives the key as first argument, and the associated value as second argument. The bindings are passed to `f` in increasing order with respect to the ordering over the type of the keys.

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
`every m p` checks if all the bindings of the map satisfy the predicate `p`. Order unspecified

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
`some m p` checks if at least one binding of the map satisfy the predicate `p`. Order unspecified

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
In increasing order.

```ocaml
val toArray : ('k, 'a, 'id) t -> ('k * 'a) array
```
```reasonml
let toArray: t('k, 'a, 'id) => array(('k, 'a));
```
```ocaml
val fromArray : ('k * 'a) array -> cmp:('k, 'id) cmp -> ('k, 'a, 'id) t
```
```reasonml
let fromArray: array(('k, 'a)) => cmp:cmp('k, 'id) => t('k, 'a, 'id);
```
```ocaml
val keysToArray : ('k, 'a, 'id) t -> 'k array
```
```reasonml
let keysToArray: t('k, 'a, 'id) => array('k);
```
```ocaml
val valuesToArray : ('k, 'a, 'id) t -> 'a array
```
```reasonml
let valuesToArray: t('k, 'a, 'id) => array('a);
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
val get : ('k, 'a, 'id) t -> 'k -> cmp:('k, 'id) cmp -> 'a option
```
```reasonml
let get: t('k, 'a, 'id) => 'k => cmp:cmp('k, 'id) => option('a);
```
```ocaml
val getUndefined : 
  ('k, 'a, 'id) t ->
  'k ->
  cmp:('k, 'id) cmp ->
  'a Js.undefined
```
```reasonml
let getUndefined: t('k, 'a, 'id) => 'k => cmp:cmp('k, 'id) => Js.undefined('a);
```
```ocaml
val getWithDefault : ('k, 'a, 'id) t -> 'k -> 'a -> cmp:('k, 'id) cmp -> 'a
```
```reasonml
let getWithDefault: t('k, 'a, 'id) => 'k => 'a => cmp:cmp('k, 'id) => 'a;
```
```ocaml
val getExn : ('k, 'a, 'id) t -> 'k -> cmp:('k, 'id) cmp -> 'a
```
```reasonml
let getExn: t('k, 'a, 'id) => 'k => cmp:cmp('k, 'id) => 'a;
```
```ocaml
val checkInvariantInternal : (_, _, _) t -> unit
```
```reasonml
let checkInvariantInternal: t(_, _, _) => unit;
```
**raise** when invariant is not held

```ocaml
val remove : ('a, 'b, 'id) t -> 'a -> cmp:('a, 'id) cmp -> ('a, 'b, 'id) t
```
```reasonml
let remove: t('a, 'b, 'id) => 'a => cmp:cmp('a, 'id) => t('a, 'b, 'id);
```
`remove m x` returns a map containing the same bindings as `m`, except for `x` which is unbound in the returned map.

```ocaml
val removeMany : 
  ('a, 'b, 'id) t ->
  'a array ->
  cmp:('a, 'id) cmp ->
  ('a, 'b, 'id) t
```
```reasonml
let removeMany: 
  t('a, 'b, 'id) =>
  array('a) =>
  cmp:cmp('a, 'id) =>
  t('a, 'b, 'id);
```
```ocaml
val set : ('a, 'b, 'id) t -> 'a -> 'b -> cmp:('a, 'id) cmp -> ('a, 'b, 'id) t
```
```reasonml
let set: t('a, 'b, 'id) => 'a => 'b => cmp:cmp('a, 'id) => t('a, 'b, 'id);
```
`set m x y` returns a map containing the same bindings as `m`, plus a binding of `x` to `y`. If `x` was already bound in `m`, its previous binding disappears.

```ocaml
val updateU : 
  ('a, 'b, 'id) t ->
  'a ->
  ('b option -> 'b option) Js.Fn.arity1 ->
  cmp:('a, 'id) cmp ->
  ('a, 'b, 'id) t
```
```reasonml
let updateU: 
  t('a, 'b, 'id) =>
  'a =>
  Js.Fn.arity1((option('b) => option('b))) =>
  cmp:cmp('a, 'id) =>
  t('a, 'b, 'id);
```
```ocaml
val update : 
  ('a, 'b, 'id) t ->
  'a ->
  ('b option -> 'b option) ->
  cmp:('a, 'id) cmp ->
  ('a, 'b, 'id) t
```
```reasonml
let update: 
  t('a, 'b, 'id) =>
  'a =>
  (option('b) => option('b)) =>
  cmp:cmp('a, 'id) =>
  t('a, 'b, 'id);
```
```ocaml
val mergeU : 
  ('a, 'b, 'id) t ->
  ('a, 'c, 'id) t ->
  ('a -> 'b option -> 'c option -> 'd option) Js.Fn.arity3 ->
  cmp:('a, 'id) cmp ->
  ('a, 'd, 'id) t
```
```reasonml
let mergeU: 
  t('a, 'b, 'id) =>
  t('a, 'c, 'id) =>
  Js.Fn.arity3(('a => option('b) => option('c) => option('d))) =>
  cmp:cmp('a, 'id) =>
  t('a, 'd, 'id);
```
```ocaml
val merge : 
  ('a, 'b, 'id) t ->
  ('a, 'c, 'id) t ->
  ('a -> 'b option -> 'c option -> 'd option) ->
  cmp:('a, 'id) cmp ->
  ('a, 'd, 'id) t
```
```reasonml
let merge: 
  t('a, 'b, 'id) =>
  t('a, 'c, 'id) =>
  ('a => option('b) => option('c) => option('d)) =>
  cmp:cmp('a, 'id) =>
  t('a, 'd, 'id);
```
`merge m1 m2 f` computes a map whose keys is a subset of keys of `m1` and of `m2`. The presence of each such binding, and the corresponding value, is determined with the function `f`.

```ocaml
val mergeMany : 
  ('a, 'b, 'id) t ->
  ('a * 'b) array ->
  cmp:('a, 'id) cmp ->
  ('a, 'b, 'id) t
```
```reasonml
let mergeMany: 
  t('a, 'b, 'id) =>
  array(('a, 'b)) =>
  cmp:cmp('a, 'id) =>
  t('a, 'b, 'id);
```
```ocaml
val keepU : 
  ('k, 'a, 'id) t ->
  ('k -> 'a -> bool) Js.Fn.arity2 ->
  ('k, 'a, 'id) t
```
```reasonml
let keepU: 
  t('k, 'a, 'id) =>
  Js.Fn.arity2(('k => 'a => bool)) =>
  t('k, 'a, 'id);
```
```ocaml
val keep : ('k, 'a, 'id) t -> ('k -> 'a -> bool) -> ('k, 'a, 'id) t
```
```reasonml
let keep: t('k, 'a, 'id) => ('k => 'a => bool) => t('k, 'a, 'id);
```
`keep m p` returns the map with all the bindings in `m` that satisfy predicate `p`.

```ocaml
val partitionU : 
  ('k, 'a, 'id) t ->
  ('k -> 'a -> bool) Js.Fn.arity2 ->
  ('k, 'a, 'id) t * ('k, 'a, 'id) t
```
```reasonml
let partitionU: 
  t('k, 'a, 'id) =>
  Js.Fn.arity2(('k => 'a => bool)) =>
  (t('k, 'a, 'id), t('k, 'a, 'id));
```
```ocaml
val partition : 
  ('k, 'a, 'id) t ->
  ('k -> 'a -> bool) ->
  ('k, 'a, 'id) t * ('k, 'a, 'id) t
```
```reasonml
let partition: 
  t('k, 'a, 'id) =>
  ('k => 'a => bool) =>
  (t('k, 'a, 'id), t('k, 'a, 'id));
```
`partition m p` returns a pair of maps `(m1, m2)`, where `m1` contains all the bindings of `s` that satisfy the predicate `p`, and `m2` is the map with all the bindings of `s` that do not satisfy `p`.

```ocaml
val split : 
  ('a, 'b, 'id) t ->
  'a ->
  cmp:('a, 'id) cmp ->
  (('a, 'b, 'id) t * ('a, 'b, 'id) t) * 'b option
```
```reasonml
let split: 
  t('a, 'b, 'id) =>
  'a =>
  cmp:cmp('a, 'id) =>
  ((t('a, 'b, 'id), t('a, 'b, 'id)), option('b));
```
`split x m` returns a triple `(l, data, r)`, where `l` is the map with all the bindings of `m` whose key is strictly less than `x`; `r` is the map with all the bindings of `m` whose key is strictly greater than `x`; `data` is `None` if `m` contains no binding for `x`, or `Some v` if `m` binds `v` to `x`.

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