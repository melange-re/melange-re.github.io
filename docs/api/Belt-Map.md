
# Module `Belt.Map`

[`Belt.Map`](#),

The top level provides generic **immutable** map operations.

It also has three specialized inner modules [`Belt.Map.Int`](./Belt-Map-Int.md), [`Belt.Map.String`](./Belt-Map-String.md) and

[`Belt.Map.Dict`](./Belt-Map-Dict.md): This module separates data from function which is more verbose but slightly more efficient

A *immutable* sorted map module which allows customize *compare* behavior.

The implementation uses balanced binary trees, and therefore searching and insertion take time logarithmic in the size of the map.

For more info on this module's usage of identity, \`make\` and others, please see the top level documentation of Belt, **A special encoding for collection safety**.

Example usage:

```ocaml
 module PairComparator = Belt.Id.MakeComparable(struct
   type t = int * int
   let cmp (a0, a1) (b0, b1) =
     match Pervasives.compare a0 b0 with
     | 0 -> Pervasives.compare a1 b1
     | c -> c
 end)

 let myMap = Belt.Map.make ~id:(module PairComparator)
 let myMap2 = Belt.Map.set myMap (1, 2) "myValue"
```
```reasonml
module PairComparator =
  Belt.Id.MakeComparable({
    type t = (int, int);
    let cmp = ((a0, a1), (b0, b1)) =>
      switch (Pervasives.compare(a0, b0)) {
      | 0 => Pervasives.compare(a1, b1)
      | c => c
      };
  });

let myMap = Belt.Map.make(~id=(module PairComparator));
let myMap2 = Belt.Map.set(myMap, (1, 2), "myValue");
```
The API documentation below will assume a predeclared comparator module for integers, IntCmp

```ocaml
module Int : sig ... end
```
```reasonml
module Int: { ... };
```
Specalized when key type is `int`, more efficient than the generic type, its compare behavior is fixed using the built-in comparison

```ocaml
module String : sig ... end
```
```reasonml
module String: { ... };
```
specalized when key type is `string`, more efficient than the generic type, its compare behavior is fixed using the built-in comparison

```ocaml
module Dict : sig ... end
```
```reasonml
module Dict: { ... };
```
This module seprate identity from data, it is a bit more verboe but slightly more efficient due to the fact that there is no need to pack identity and data back after each operation

```ocaml
type ('key, 'value, 'identity) t
```
```reasonml
type t('key, 'value, 'identity);
```
<code class="text-ocaml">('key, 'identity) t</code><code class="text-reasonml">t('key, 'identity)</code>

`'key` is the field type

`'value` is the element type

`'identity` the identity of the collection

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
The identity needed for making an empty map

```ocaml
val make : id:('k, 'id) id -> ('k, 'v, 'id) t
```
```reasonml
let make: id:id('k, 'id) => t('k, 'v, 'id);
```
`make ~id` creates a new map by taking in the comparator

```ocaml
  let m = Belt.Map.make ~id:(module IntCmp)
```
```reasonml
let m = Belt.Map.make(~id=(module IntCmp));
```
```ocaml
val isEmpty : (_, _, _) t -> bool
```
```reasonml
let isEmpty: t(_, _, _) => bool;
```
`isEmpty m` checks whether a map m is empty

```ocaml
  isEmpty (fromArray [|1,"1"|] ~id:(module IntCmp)) = false
```
```reasonml
isEmpty(fromArray([|(1, "1")|], ~id=(module IntCmp))) == false;
```
```ocaml
val has : ('k, 'v, 'id) t -> 'k -> bool
```
```reasonml
let has: t('k, 'v, 'id) => 'k => bool;
```
`has m k` checks whether m has the key k

```ocaml
  has (fromArray [|1,"1"|] ~id:(module IntCmp)) 1 = true
```
```reasonml
has(fromArray([|(1, "1")|], ~id=(module IntCmp)), 1) == true;
```
```ocaml
val cmpU : 
  ('k, 'v, 'id) t ->
  ('k, 'v, 'id) t ->
  ('v -> 'v -> int) Js.Fn.arity2 ->
  int
```
```reasonml
let cmpU: 
  t('k, 'v, 'id) =>
  t('k, 'v, 'id) =>
  Js.Fn.arity2(('v => 'v => int)) =>
  int;
```
```ocaml
val cmp : ('k, 'v, 'id) t -> ('k, 'v, 'id) t -> ('v -> 'v -> int) -> int
```
```reasonml
let cmp: t('k, 'v, 'id) => t('k, 'v, 'id) => ('v => 'v => int) => int;
```
`cmp m0 m1 vcmp`

Total ordering of map given total ordering of value function.

It will compare size first and each element following the order one by one.

```ocaml
val eqU : 
  ('k, 'v, 'id) t ->
  ('k, 'v, 'id) t ->
  ('v -> 'v -> bool) Js.Fn.arity2 ->
  bool
```
```reasonml
let eqU: 
  t('k, 'v, 'id) =>
  t('k, 'v, 'id) =>
  Js.Fn.arity2(('v => 'v => bool)) =>
  bool;
```
```ocaml
val eq : ('k, 'v, 'id) t -> ('k, 'v, 'id) t -> ('v -> 'v -> bool) -> bool
```
```reasonml
let eq: t('k, 'v, 'id) => t('k, 'v, 'id) => ('v => 'v => bool) => bool;
```
`eq m1 m2 veq` tests whether the maps `m1` and `m2` are equal, that is, contain equal keys and associate them with equal data. `veq` is the equality predicate used to compare the data associated with the keys.

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
val forEachU : ('k, 'v, 'id) t -> ('k -> 'v -> unit) Js.Fn.arity2 -> unit
```
```reasonml
let forEachU: t('k, 'v, 'id) => Js.Fn.arity2(('k => 'v => unit)) => unit;
```
```ocaml
val forEach : ('k, 'v, 'id) t -> ('k -> 'v -> unit) -> unit
```
```reasonml
let forEach: t('k, 'v, 'id) => ('k => 'v => unit) => unit;
```
`forEach m f` applies `f` to all bindings in map `m`. `f` receives the 'k as first argument, and the associated value as second argument. The bindings are passed to `f` in increasing order with respect to the ordering over the type of the keys.

```ocaml
  let s0 = fromArray ~id:(module IntCmp) [|4,"4";1,"1";2,"2,"3""|];;
  let acc = ref [] ;;
  forEach s0 (fun k v -> acc := (k,v) :: !acc);;

  !acc = [4,"4"; 3,"3"; 2,"2"; 1,"1"]
```
```reasonml
let s0 =
  fromArray(
    ~id=(module IntCmp),
    [|(4, "4"), (1, "1"), (2, "2,"(3, ""))|],
  );
let acc = ref([]);
forEach(s0, (k, v) => acc := [(k, v), ...acc^]);

acc^ == [(4, "4"), (3, "3"), (2, "2"), (1, "1")];
```
```ocaml
val reduceU : 
  ('k, 'v, 'id) t ->
  'acc ->
  ('acc -> 'k -> 'v -> 'acc) Js.Fn.arity3 ->
  'acc
```
```reasonml
let reduceU: 
  t('k, 'v, 'id) =>
  'acc =>
  Js.Fn.arity3(('acc => 'k => 'v => 'acc)) =>
  'acc;
```
```ocaml
val reduce : ('k, 'v, 'id) t -> 'acc -> ('acc -> 'k -> 'v -> 'acc) -> 'acc
```
```reasonml
let reduce: t('k, 'v, 'id) => 'acc => ('acc => 'k => 'v => 'acc) => 'acc;
```
`reduce m a f` computes `(f kN dN ... (f k1 d1 a)...)`, where `k1 ... kN` are the keys of all bindings in `m` (in increasing order), and `d1 ... dN` are the associated data.

```ocaml
  let s0 = fromArray ~id:(module IntCmp) [|4,"4";1,"1";2,"2,"3""|];;
  reduce s0 [] (fun acc k v -> (k,v) acc ) = [4,"4";3,"3";2,"2";1,"1"];;
```
```reasonml
let s0 =
  fromArray(
    ~id=(module IntCmp),
    [|(4, "4"), (1, "1"), (2, "2,"(3, ""))|],
  );
reduce(s0, [], (acc, k, v) => (k, v)(acc))
== [(4, "4"), (3, "3"), (2, "2"), (1, "1")];
```
```ocaml
val everyU : ('k, 'v, 'id) t -> ('k -> 'v -> bool) Js.Fn.arity2 -> bool
```
```reasonml
let everyU: t('k, 'v, 'id) => Js.Fn.arity2(('k => 'v => bool)) => bool;
```
```ocaml
val every : ('k, 'v, 'id) t -> ('k -> 'v -> bool) -> bool
```
```reasonml
let every: t('k, 'v, 'id) => ('k => 'v => bool) => bool;
```
`every m p` checks if all the bindings of the map satisfy the predicate `p`. Order unspecified

```ocaml
val someU : ('k, 'v, 'id) t -> ('k -> 'v -> bool) Js.Fn.arity2 -> bool
```
```reasonml
let someU: t('k, 'v, 'id) => Js.Fn.arity2(('k => 'v => bool)) => bool;
```
```ocaml
val some : ('k, 'v, 'id) t -> ('k -> 'v -> bool) -> bool
```
```reasonml
let some: t('k, 'v, 'id) => ('k => 'v => bool) => bool;
```
`some m p` checks if at least one binding of the map satisfy the predicate `p`. Order unspecified

```ocaml
val size : ('k, 'v, 'id) t -> int
```
```reasonml
let size: t('k, 'v, 'id) => int;
```
`size s`

```ocaml
  size (fromArray [2,"2"; 2,"1"; 3,"3"] ~id:(module IntCmp)) = 2 ;;
```
```reasonml
size(fromArray([(2, "2"), (2, "1"), (3, "3")], ~id=(module IntCmp))) == 2;
```
```ocaml
val toArray : ('k, 'v, 'id) t -> ('k * 'v) array
```
```reasonml
let toArray: t('k, 'v, 'id) => array(('k, 'v));
```
`toArray s`

```ocaml
  toArray (fromArray [2,"2"; 1,"1"; 3,"3"] ~id:(module IntCmp)) = [1,"1";2,"2";3,"3"]
```
```reasonml
toArray(fromArray([(2, "2"), (1, "1"), (3, "3")], ~id=(module IntCmp)))
== [(1, "1"), (2, "2"), (3, "3")];
```
```ocaml
val toList : ('k, 'v, 'id) t -> ('k * 'v) list
```
```reasonml
let toList: t('k, 'v, 'id) => list(('k, 'v));
```
In increasing order

**See** [`toArray`](./#val-toArray)

```ocaml
val fromArray : ('k * 'v) array -> id:('k, 'id) id -> ('k, 'v, 'id) t
```
```reasonml
let fromArray: array(('k, 'v)) => id:id('k, 'id) => t('k, 'v, 'id);
```
`fromArray kvs ~id`

```ocaml
  toArray (fromArray [2,"2"; 1,"1"; 3,"3"] ~id:(module IntCmp)) = [1,"1";2,"2";3,"3"]
```
```reasonml
toArray(fromArray([(2, "2"), (1, "1"), (3, "3")], ~id=(module IntCmp)))
== [(1, "1"), (2, "2"), (3, "3")];
```
```ocaml
val keysToArray : ('k, 'v, 'id) t -> 'k array
```
```reasonml
let keysToArray: t('k, 'v, 'id) => array('k);
```
`keysToArray s`

```ocaml
  keysToArray (fromArray [2,"2"; 1,"1"; 3,"3"] ~id:(module IntCmp)) =
  [|1;2;3|];;
```
```reasonml
keysToArray(
  fromArray([(2, "2"), (1, "1"), (3, "3")], ~id=(module IntCmp)),
)
== [|1, 2, 3|];
```
```ocaml
val valuesToArray : ('k, 'v, 'id) t -> 'v array
```
```reasonml
let valuesToArray: t('k, 'v, 'id) => array('v);
```
`valuesToArray s`

```ocaml
  valuesToArray (fromArray [2,"2"; 1,"1"; 3,"3"] ~id:(module IntCmp)) =
  [|"1";"2";"3"|];;
```
```reasonml
valuesToArray(
  fromArray([(2, "2"), (1, "1"), (3, "3")], ~id=(module IntCmp)),
)
== [|"1", "2", "3"|];
```
```ocaml
val minKey : ('k, _, _) t -> 'k option
```
```reasonml
let minKey: t('k, _, _) => option('k);
```
`minKey s`

returns the minimum key, None if not exist
```ocaml
val minKeyUndefined : ('k, _, _) t -> 'k Js.undefined
```
```reasonml
let minKeyUndefined: t('k, _, _) => Js.undefined('k);
```
**See** [`minKey`](./#val-minKey)

```ocaml
val maxKey : ('k, _, _) t -> 'k option
```
```reasonml
let maxKey: t('k, _, _) => option('k);
```
`maxKey s`

returns the maximum key, None if not exist
```ocaml
val maxKeyUndefined : ('k, _, _) t -> 'k Js.undefined
```
```reasonml
let maxKeyUndefined: t('k, _, _) => Js.undefined('k);
```
**See** [`maxKey`](./#val-maxKey)

```ocaml
val minimum : ('k, 'v, _) t -> ('k * 'v) option
```
```reasonml
let minimum: t('k, 'v, _) => option(('k, 'v));
```
`minimum s`

returns the minimum key value pair, None if not exist
```ocaml
val minUndefined : ('k, 'v, _) t -> ('k * 'v) Js.undefined
```
```reasonml
let minUndefined: t('k, 'v, _) => Js.undefined(('k, 'v));
```
**See** [`minimum`](./#val-minimum)

```ocaml
val maximum : ('k, 'v, _) t -> ('k * 'v) option
```
```reasonml
let maximum: t('k, 'v, _) => option(('k, 'v));
```
`maximum s`

returns the maximum key value pair, None if not exist
```ocaml
val maxUndefined : ('k, 'v, _) t -> ('k * 'v) Js.undefined
```
```reasonml
let maxUndefined: t('k, 'v, _) => Js.undefined(('k, 'v));
```
**See** [`maximum`](./#val-maximum)

```ocaml
val get : ('k, 'v, 'id) t -> 'k -> 'v option
```
```reasonml
let get: t('k, 'v, 'id) => 'k => option('v);
```
`get s k`

```ocaml
  get (fromArray [2,"2"; 1,"1"; 3,"3"] ~id:(module IntCmp)) 2 =
  Some "2";;
  get (fromArray [2,"2"; 1,"1"; 3,"3"] ~id:(module IntCmp)) 2 =
  None;;
```
```reasonml
get(fromArray([(2, "2"), (1, "1"), (3, "3")], ~id=(module IntCmp)), 2)
== Some("2");
get(fromArray([(2, "2"), (1, "1"), (3, "3")], ~id=(module IntCmp)), 2)
== None;
```
```ocaml
val getUndefined : ('k, 'v, 'id) t -> 'k -> 'v Js.undefined
```
```reasonml
let getUndefined: t('k, 'v, 'id) => 'k => Js.undefined('v);
```
**See** [`get`](./#val-get)

returns undefined when not found
```ocaml
val getWithDefault : ('k, 'v, 'id) t -> 'k -> 'v -> 'v
```
```reasonml
let getWithDefault: t('k, 'v, 'id) => 'k => 'v => 'v;
```
`getWithDefault s k default`

**See** [`get`](./#val-get)

returns default when k is not found
```ocaml
val getExn : ('k, 'v, 'id) t -> 'k -> 'v
```
```reasonml
let getExn: t('k, 'v, 'id) => 'k => 'v;
```
`getExn s k`

**See** [`getExn`](./#val-getExn)

**raise** when `k` not exist

```ocaml
val remove : ('k, 'v, 'id) t -> 'k -> ('k, 'v, 'id) t
```
```reasonml
let remove: t('k, 'v, 'id) => 'k => t('k, 'v, 'id);
```
`remove m x` when `x` is not in `m`, `m` is returned reference unchanged.

```ocaml
  let s0 =  (fromArray [2,"2"; 1,"1"; 3,"3"] ~id:(module IntCmp));;

  let s1 = remove s0 1;;
  let s2 = remove s1 1;;
  s1 == s2 ;;
  keysToArray s1 = [|2;3|];;
```
```reasonml
let s0 = fromArray([(2, "2"), (1, "1"), (3, "3")], ~id=(module IntCmp));

let s1 = remove(s0, 1);
let s2 = remove(s1, 1);
s1 === s2;
keysToArray(s1) == [|2, 3|];
```
```ocaml
val removeMany : ('k, 'v, 'id) t -> 'k array -> ('k, 'v, 'id) t
```
```reasonml
let removeMany: t('k, 'v, 'id) => array('k) => t('k, 'v, 'id);
```
`removeMany s xs`

Removing each of `xs` to `s`, note unlike [`remove`](./#val-remove), the reference of return value might be changed even if none in `xs` exists `s`

```ocaml
val set : ('k, 'v, 'id) t -> 'k -> 'v -> ('k, 'v, 'id) t
```
```reasonml
let set: t('k, 'v, 'id) => 'k => 'v => t('k, 'v, 'id);
```
`set m x y ` returns a map containing the same bindings as `m`, with a new binding of `x` to `y`. If `x` was already bound in `m`, its previous binding disappears.

```ocaml
  let s0 =  (fromArray [2,"2"; 1,"1"; 3,"3"] ~id:(module IntCmp));;

  let s1 = set s0 2 "3";;

  valuesToArray s1 =  ["1";"3";"3"];;
```
```reasonml
let s0 = fromArray([(2, "2"), (1, "1"), (3, "3")], ~id=(module IntCmp));

let s1 = set(s0, 2, "3");

valuesToArray(s1) == ["1", "3", "3"];
```
```ocaml
val updateU : 
  ('k, 'v, 'id) t ->
  'k ->
  ('v option -> 'v option) Js.Fn.arity1 ->
  ('k, 'v, 'id) t
```
```reasonml
let updateU: 
  t('k, 'v, 'id) =>
  'k =>
  Js.Fn.arity1((option('v) => option('v))) =>
  t('k, 'v, 'id);
```
```ocaml
val update : 
  ('k, 'v, 'id) t ->
  'k ->
  ('v option -> 'v option) ->
  ('k, 'v, 'id) t
```
```reasonml
let update: 
  t('k, 'v, 'id) =>
  'k =>
  (option('v) => option('v)) =>
  t('k, 'v, 'id);
```
`update m x f` returns a map containing the same bindings as `m`, except for the binding of `x`. Depending on the value of `y` where `y` is `f (get x m)`, the binding of `x` is added, removed or updated. If `y` is `None`, the binding is removed if it exists; otherwise, if `y` is `Some z` then `x` is associated to `z` in the resulting map.

```ocaml
val mergeMany : ('k, 'v, 'id) t -> ('k * 'v) array -> ('k, 'v, 'id) t
```
```reasonml
let mergeMany: t('k, 'v, 'id) => array(('k, 'v)) => t('k, 'v, 'id);
```
`mergeMany s xs`

Add each of `xs` to `s`, note unlike [`set`](./#val-set), the reference of return value might be changed even if all values in `xs` exist `s`

```ocaml
val mergeU : 
  ('k, 'v, 'id) t ->
  ('k, 'v2, 'id) t ->
  ('k -> 'v option -> 'v2 option -> 'v3 option) Js.Fn.arity3 ->
  ('k, 'v3, 'id) t
```
```reasonml
let mergeU: 
  t('k, 'v, 'id) =>
  t('k, 'v2, 'id) =>
  Js.Fn.arity3(('k => option('v) => option('v2) => option('v3))) =>
  t('k, 'v3, 'id);
```
```ocaml
val merge : 
  ('k, 'v, 'id) t ->
  ('k, 'v2, 'id) t ->
  ('k -> 'v option -> 'v2 option -> 'v3 option) ->
  ('k, 'v3, 'id) t
```
```reasonml
let merge: 
  t('k, 'v, 'id) =>
  t('k, 'v2, 'id) =>
  ('k => option('v) => option('v2) => option('v3)) =>
  t('k, 'v3, 'id);
```
`merge m1 m2 f` computes a map whose keys is a subset of keys of `m1` and of `m2`. The presence of each such binding, and the corresponding value, is determined with the function `f`.

```ocaml
val keepU : 
  ('k, 'v, 'id) t ->
  ('k -> 'v -> bool) Js.Fn.arity2 ->
  ('k, 'v, 'id) t
```
```reasonml
let keepU: 
  t('k, 'v, 'id) =>
  Js.Fn.arity2(('k => 'v => bool)) =>
  t('k, 'v, 'id);
```
```ocaml
val keep : ('k, 'v, 'id) t -> ('k -> 'v -> bool) -> ('k, 'v, 'id) t
```
```reasonml
let keep: t('k, 'v, 'id) => ('k => 'v => bool) => t('k, 'v, 'id);
```
`keep m p` returns the map with all the bindings in `m` that satisfy predicate `p`.

```ocaml
val partitionU : 
  ('k, 'v, 'id) t ->
  ('k -> 'v -> bool) Js.Fn.arity2 ->
  ('k, 'v, 'id) t * ('k, 'v, 'id) t
```
```reasonml
let partitionU: 
  t('k, 'v, 'id) =>
  Js.Fn.arity2(('k => 'v => bool)) =>
  (t('k, 'v, 'id), t('k, 'v, 'id));
```
```ocaml
val partition : 
  ('k, 'v, 'id) t ->
  ('k -> 'v -> bool) ->
  ('k, 'v, 'id) t * ('k, 'v, 'id) t
```
```reasonml
let partition: 
  t('k, 'v, 'id) =>
  ('k => 'v => bool) =>
  (t('k, 'v, 'id), t('k, 'v, 'id));
```
`partition m p` returns a pair of maps `(m1, m2)`, where `m1` contains all the bindings of `s` that satisfy the predicate `p`, and `m2` is the map with all the bindings of `s` that do not satisfy `p`.

```ocaml
val split : 
  ('k, 'v, 'id) t ->
  'k ->
  (('k, 'v, 'id) t * ('k, 'v, 'id) t) * 'v option
```
```reasonml
let split: 
  t('k, 'v, 'id) =>
  'k =>
  ((t('k, 'v, 'id), t('k, 'v, 'id)), option('v));
```
`split x m` returns a tuple `(l r), data`, where `l` is the map with all the bindings of `m` whose 'k is strictly less than `x`; `r` is the map with all the bindings of `m` whose 'k is strictly greater than `x`; `data` is `None` if `m` contains no binding for `x`, or `Some v` if `m` binds `v` to `x`.

```ocaml
val mapU : ('k, 'v, 'id) t -> ('v -> 'v2) Js.Fn.arity1 -> ('k, 'v2, 'id) t
```
```reasonml
let mapU: t('k, 'v, 'id) => Js.Fn.arity1(('v => 'v2)) => t('k, 'v2, 'id);
```
```ocaml
val map : ('k, 'v, 'id) t -> ('v -> 'v2) -> ('k, 'v2, 'id) t
```
```reasonml
let map: t('k, 'v, 'id) => ('v => 'v2) => t('k, 'v2, 'id);
```
`map m f` returns a map with same domain as `m`, where the associated value `a` of all bindings of `m` has been replaced by the result of the application of `f` to `a`. The bindings are passed to `f` in increasing order with respect to the ordering over the type of the keys.

```ocaml
val mapWithKeyU : 
  ('k, 'v, 'id) t ->
  ('k -> 'v -> 'v2) Js.Fn.arity2 ->
  ('k, 'v2, 'id) t
```
```reasonml
let mapWithKeyU: 
  t('k, 'v, 'id) =>
  Js.Fn.arity2(('k => 'v => 'v2)) =>
  t('k, 'v2, 'id);
```
```ocaml
val mapWithKey : ('k, 'v, 'id) t -> ('k -> 'v -> 'v2) -> ('k, 'v2, 'id) t
```
```reasonml
let mapWithKey: t('k, 'v, 'id) => ('k => 'v => 'v2) => t('k, 'v2, 'id);
```
`mapWithKey m f`

The same as [`map`](./#val-map) except that `f` is supplied with one more argument: the key

```ocaml
val getData : ('k, 'v, 'id) t -> ('k, 'v, 'id) Belt__.Belt_MapDict.t
```
```reasonml
let getData: t('k, 'v, 'id) => Belt__.Belt_MapDict.t('k, 'v, 'id);
```
`getData s0`

**Advanced usage only**

returns the raw data (detached from comparator), but its type is still manifested, so that user can pass identity directly without boxing
```ocaml
val getId : ('k, 'v, 'id) t -> ('k, 'id) id
```
```reasonml
let getId: t('k, 'v, 'id) => id('k, 'id);
```
`getId s0`

**Advanced usage only**

returns the identity of s0
```ocaml
val packIdData : 
  id:('k, 'id) id ->
  data:('k, 'v, 'id) Belt__.Belt_MapDict.t ->
  ('k, 'v, 'id) t
```
```reasonml
let packIdData: 
  id:id('k, 'id) =>
  data:Belt__.Belt_MapDict.t('k, 'v, 'id) =>
  t('k, 'v, 'id);
```
`packIdData ~id ~data`

**Advanced usage only**

returns the packed collection