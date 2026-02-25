
# Module `Map.Int`

Specalized when key type is `int`, more efficient than the generic type, its compare behavior is fixed using the built-in comparison

```ocaml
type key = int
```
```reasonml
type key = int;
```
```ocaml
type 'value t
```
```reasonml
type t('value);
```
The type of maps from type `key` to type `'value`.

```ocaml
val empty : 'v t
```
```reasonml
let empty: t('v);
```
```ocaml
val isEmpty : 'v t -> bool
```
```reasonml
let isEmpty: t('v) => bool;
```
```ocaml
val has : 'v t -> key -> bool
```
```reasonml
let has: t('v) => key => bool;
```
```ocaml
val cmpU : 'v t -> 'v t -> ('v -> 'v -> int) Js.Fn.arity2 -> int
```
```reasonml
let cmpU: t('v) => t('v) => Js.Fn.arity2(('v => 'v => int)) => int;
```
```ocaml
val cmp : 'v t -> 'v t -> ('v -> 'v -> int) -> int
```
```reasonml
let cmp: t('v) => t('v) => ('v => 'v => int) => int;
```
```ocaml
val eqU : 'v t -> 'v t -> ('v -> 'v -> bool) Js.Fn.arity2 -> bool
```
```reasonml
let eqU: t('v) => t('v) => Js.Fn.arity2(('v => 'v => bool)) => bool;
```
```ocaml
val eq : 'v t -> 'v t -> ('v -> 'v -> bool) -> bool
```
```reasonml
let eq: t('v) => t('v) => ('v => 'v => bool) => bool;
```
`eq m1 m2` tests whether the maps `m1` and `m2` are equal, that is, contain equal keys and associate them with equal data.

```ocaml
val findFirstByU : 
  'v t ->
  (key -> 'v -> bool) Js.Fn.arity2 ->
  (key * 'v) option
```
```reasonml
let findFirstByU: 
  t('v) =>
  Js.Fn.arity2((key => 'v => bool)) =>
  option((key, 'v));
```
```ocaml
val findFirstBy : 'v t -> (key -> 'v -> bool) -> (key * 'v) option
```
```reasonml
let findFirstBy: t('v) => (key => 'v => bool) => option((key, 'v));
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
val forEachU : 'v t -> (key -> 'v -> unit) Js.Fn.arity2 -> unit
```
```reasonml
let forEachU: t('v) => Js.Fn.arity2((key => 'v => unit)) => unit;
```
```ocaml
val forEach : 'v t -> (key -> 'v -> unit) -> unit
```
```reasonml
let forEach: t('v) => (key => 'v => unit) => unit;
```
`forEach m f` applies `f` to all bindings in map `m`. `f` receives the key as first argument, and the associated value as second argument. The bindings are passed to `f` in increasing order with respect to the ordering over the type of the keys.

```ocaml
val reduceU : 'v t -> 'v2 -> ('v2 -> key -> 'v -> 'v2) Js.Fn.arity3 -> 'v2
```
```reasonml
let reduceU: t('v) => 'v2 => Js.Fn.arity3(('v2 => key => 'v => 'v2)) => 'v2;
```
```ocaml
val reduce : 'v t -> 'v2 -> ('v2 -> key -> 'v -> 'v2) -> 'v2
```
```reasonml
let reduce: t('v) => 'v2 => ('v2 => key => 'v => 'v2) => 'v2;
```
`reduce m a f` computes `(f kN dN ... (f k1 d1 a)...)`, where `k1 ... kN` are the keys of all bindings in `m` (in increasing order), and `d1 ... dN` are the associated data.

```ocaml
val everyU : 'v t -> (key -> 'v -> bool) Js.Fn.arity2 -> bool
```
```reasonml
let everyU: t('v) => Js.Fn.arity2((key => 'v => bool)) => bool;
```
```ocaml
val every : 'v t -> (key -> 'v -> bool) -> bool
```
```reasonml
let every: t('v) => (key => 'v => bool) => bool;
```
`every m p` checks if all the bindings of the map satisfy the predicate `p`. Order unspecified

```ocaml
val someU : 'v t -> (key -> 'v -> bool) Js.Fn.arity2 -> bool
```
```reasonml
let someU: t('v) => Js.Fn.arity2((key => 'v => bool)) => bool;
```
```ocaml
val some : 'v t -> (key -> 'v -> bool) -> bool
```
```reasonml
let some: t('v) => (key => 'v => bool) => bool;
```
`some m p` checks if at least one binding of the map satisfy the predicate `p`. Order unspecified

```ocaml
val size : 'v t -> int
```
```reasonml
let size: t('v) => int;
```
```ocaml
val toList : 'v t -> (key * 'v) list
```
```reasonml
let toList: t('v) => list((key, 'v));
```
In increasing order.

```ocaml
val toArray : 'v t -> (key * 'v) array
```
```reasonml
let toArray: t('v) => array((key, 'v));
```
```ocaml
val fromArray : (key * 'v) array -> 'v t
```
```reasonml
let fromArray: array((key, 'v)) => t('v);
```
```ocaml
val keysToArray : 'v t -> key array
```
```reasonml
let keysToArray: t('v) => array(key);
```
```ocaml
val valuesToArray : 'v t -> 'v array
```
```reasonml
let valuesToArray: t('v) => array('v);
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
val minimum : 'v t -> (key * 'v) option
```
```reasonml
let minimum: t('v) => option((key, 'v));
```
```ocaml
val minUndefined : 'v t -> (key * 'v) Js.undefined
```
```reasonml
let minUndefined: t('v) => Js.undefined((key, 'v));
```
```ocaml
val maximum : 'v t -> (key * 'v) option
```
```reasonml
let maximum: t('v) => option((key, 'v));
```
```ocaml
val maxUndefined : 'v t -> (key * 'v) Js.undefined
```
```reasonml
let maxUndefined: t('v) => Js.undefined((key, 'v));
```
```ocaml
val get : 'v t -> key -> 'v option
```
```reasonml
let get: t('v) => key => option('v);
```
```ocaml
val getUndefined : 'v t -> key -> 'v Js.undefined
```
```reasonml
let getUndefined: t('v) => key => Js.undefined('v);
```
```ocaml
val getWithDefault : 'v t -> key -> 'v -> 'v
```
```reasonml
let getWithDefault: t('v) => key => 'v => 'v;
```
```ocaml
val getExn : 'v t -> key -> 'v
```
```reasonml
let getExn: t('v) => key => 'v;
```
```ocaml
val checkInvariantInternal : _ t -> unit
```
```reasonml
let checkInvariantInternal: t(_) => unit;
```
**raise** when invariant is not held

```ocaml
val remove : 'v t -> key -> 'v t
```
```reasonml
let remove: t('v) => key => t('v);
```
`remove m x` returns a map containing the same bindings as `m`, except for `x` which is unbound in the returned map.

```ocaml
val removeMany : 'v t -> key array -> 'v t
```
```reasonml
let removeMany: t('v) => array(key) => t('v);
```
```ocaml
val set : 'v t -> key -> 'v -> 'v t
```
```reasonml
let set: t('v) => key => 'v => t('v);
```
`set m x y` returns a map containing the same bindings as `m`, plus a binding of `x` to `y`. If `x` was already bound in `m`, its previous binding disappears.

```ocaml
val updateU : 'v t -> key -> ('v option -> 'v option) Js.Fn.arity1 -> 'v t
```
```reasonml
let updateU: t('v) => key => Js.Fn.arity1((option('v) => option('v))) => t('v);
```
```ocaml
val update : 'v t -> key -> ('v option -> 'v option) -> 'v t
```
```reasonml
let update: t('v) => key => (option('v) => option('v)) => t('v);
```
```ocaml
val mergeU : 
  'v t ->
  'v2 t ->
  (key -> 'v option -> 'v2 option -> 'c option) Js.Fn.arity3 ->
  'c t
```
```reasonml
let mergeU: 
  t('v) =>
  t('v2) =>
  Js.Fn.arity3((key => option('v) => option('v2) => option('c))) =>
  t('c);
```
```ocaml
val merge : 
  'v t ->
  'v2 t ->
  (key -> 'v option -> 'v2 option -> 'c option) ->
  'c t
```
```reasonml
let merge: 
  t('v) =>
  t('v2) =>
  (key => option('v) => option('v2) => option('c)) =>
  t('c);
```
`merge m1 m2 f` computes a map whose keys is a subset of keys of `m1` and of `m2`. The presence of each such binding, and the corresponding value, is determined with the function `f`.

```ocaml
val mergeMany : 'v t -> (key * 'v) array -> 'v t
```
```reasonml
let mergeMany: t('v) => array((key, 'v)) => t('v);
```
```ocaml
val keepU : 'v t -> (key -> 'v -> bool) Js.Fn.arity2 -> 'v t
```
```reasonml
let keepU: t('v) => Js.Fn.arity2((key => 'v => bool)) => t('v);
```
```ocaml
val keep : 'v t -> (key -> 'v -> bool) -> 'v t
```
```reasonml
let keep: t('v) => (key => 'v => bool) => t('v);
```
`keep m p` returns the map with all the bindings in `m` that satisfy predicate `p`.

```ocaml
val partitionU : 'v t -> (key -> 'v -> bool) Js.Fn.arity2 -> 'v t * 'v t
```
```reasonml
let partitionU: t('v) => Js.Fn.arity2((key => 'v => bool)) => (t('v), t('v));
```
```ocaml
val partition : 'v t -> (key -> 'v -> bool) -> 'v t * 'v t
```
```reasonml
let partition: t('v) => (key => 'v => bool) => (t('v), t('v));
```
`partition m p` returns a pair of maps `(m1, m2)`, where `m1` contains all the bindings of `s` that satisfy the predicate `p`, and `m2` is the map with all the bindings of `s` that do not satisfy `p`.

```ocaml
val split : key -> 'v t -> 'v t * 'v option * 'v t
```
```reasonml
let split: key => t('v) => (t('v), option('v), t('v));
```
`split x m` returns a triple `(l, data, r)`, where `l` is the map with all the bindings of `m` whose key is strictly less than `x`; `r` is the map with all the bindings of `m` whose key is strictly greater than `x`; `data` is `None` if `m` contains no binding for `x`, or `Some v` if `m` binds `v` to `x`.

```ocaml
val mapU : 'v t -> ('v -> 'v2) Js.Fn.arity1 -> 'v2 t
```
```reasonml
let mapU: t('v) => Js.Fn.arity1(('v => 'v2)) => t('v2);
```
```ocaml
val map : 'v t -> ('v -> 'v2) -> 'v2 t
```
```reasonml
let map: t('v) => ('v => 'v2) => t('v2);
```
`map m f` returns a map with same domain as `m`, where the associated value `a` of all bindings of `m` has been replaced by the result of the application of `f` to `a`. The bindings are passed to `f` in increasing order with respect to the ordering over the type of the keys.

```ocaml
val mapWithKeyU : 'v t -> (key -> 'v -> 'v2) Js.Fn.arity2 -> 'v2 t
```
```reasonml
let mapWithKeyU: t('v) => Js.Fn.arity2((key => 'v => 'v2)) => t('v2);
```
```ocaml
val mapWithKey : 'v t -> (key -> 'v -> 'v2) -> 'v2 t
```
```reasonml
let mapWithKey: t('v) => (key => 'v => 'v2) => t('v2);
```