
# Module `Belt.MutableSet`

[`Belt.MutableSet`](#)

The top level provides generic **mutable** set operations.

It also has two specialized inner modules [`Belt.MutableSet.Int`](./Belt-MutableSet-Int.md) and [`Belt.MutableSet.String`](./Belt-MutableSet-String.md)

A *mutable* sorted set module which allows customize *compare* behavior.

Same as Belt.Set, but mutable.

```ocaml
module Int : sig ... end
```
```reasonml
module Int: { ... };
```
Specalized when key type is `int`, more efficient than the generic type

```ocaml
module String : sig ... end
```
```reasonml
module String: { ... };
```
Specalized when key type is `string`, more efficient than the generic type

```ocaml
type ('k, 'id) t
```
```reasonml
type t('k, 'id);
```
```ocaml
type ('k, 'id) id =
  (module Belt__.Belt_Id.Comparable
  with type identity = 'id
   and type t = 'k)
```
```reasonml
type id('k, 'id) =
  (module Belt__.Belt_Id.Comparable
  with type identity = 'id
   and type t = 'k);
```
```ocaml
val make : id:('value, 'id) id -> ('value, 'id) t
```
```reasonml
let make: id:id('value, 'id) => t('value, 'id);
```
```ocaml
val fromArray : 'k array -> id:('k, 'id) id -> ('k, 'id) t
```
```reasonml
let fromArray: array('k) => id:id('k, 'id) => t('k, 'id);
```
```ocaml
val fromSortedArrayUnsafe : 
  'value array ->
  id:('value, 'id) id ->
  ('value, 'id) t
```
```reasonml
let fromSortedArrayUnsafe: 
  array('value) =>
  id:id('value, 'id) =>
  t('value, 'id);
```
```ocaml
val copy : ('k, 'id) t -> ('k, 'id) t
```
```reasonml
let copy: t('k, 'id) => t('k, 'id);
```
```ocaml
val isEmpty : (_, _) t -> bool
```
```reasonml
let isEmpty: t(_, _) => bool;
```
```ocaml
val has : ('value, _) t -> 'value -> bool
```
```reasonml
let has: t('value, _) => 'value => bool;
```
```ocaml
val add : ('value, 'id) t -> 'value -> unit
```
```reasonml
let add: t('value, 'id) => 'value => unit;
```
```ocaml
val addCheck : ('value, 'id) t -> 'value -> bool
```
```reasonml
let addCheck: t('value, 'id) => 'value => bool;
```
```ocaml
val mergeMany : ('value, 'id) t -> 'value array -> unit
```
```reasonml
let mergeMany: t('value, 'id) => array('value) => unit;
```
```ocaml
val remove : ('value, 'id) t -> 'value -> unit
```
```reasonml
let remove: t('value, 'id) => 'value => unit;
```
```ocaml
val removeCheck : ('value, 'id) t -> 'value -> bool
```
```reasonml
let removeCheck: t('value, 'id) => 'value => bool;
```
```ocaml
val removeMany : ('value, 'id) t -> 'value array -> unit
```
```reasonml
let removeMany: t('value, 'id) => array('value) => unit;
```
```ocaml
val union : ('value, 'id) t -> ('value, 'id) t -> ('value, 'id) t
```
```reasonml
let union: t('value, 'id) => t('value, 'id) => t('value, 'id);
```
```ocaml
val intersect : ('value, 'id) t -> ('value, 'id) t -> ('value, 'id) t
```
```reasonml
let intersect: t('value, 'id) => t('value, 'id) => t('value, 'id);
```
```ocaml
val diff : ('value, 'id) t -> ('value, 'id) t -> ('value, 'id) t
```
```reasonml
let diff: t('value, 'id) => t('value, 'id) => t('value, 'id);
```
```ocaml
val subset : ('value, 'id) t -> ('value, 'id) t -> bool
```
```reasonml
let subset: t('value, 'id) => t('value, 'id) => bool;
```
```ocaml
val cmp : ('value, 'id) t -> ('value, 'id) t -> int
```
```reasonml
let cmp: t('value, 'id) => t('value, 'id) => int;
```
```ocaml
val eq : ('value, 'id) t -> ('value, 'id) t -> bool
```
```reasonml
let eq: t('value, 'id) => t('value, 'id) => bool;
```
```ocaml
val forEachU : ('value, 'id) t -> ('value -> unit) Js.Fn.arity1 -> unit
```
```reasonml
let forEachU: t('value, 'id) => Js.Fn.arity1(('value => unit)) => unit;
```
```ocaml
val forEach : ('value, 'id) t -> ('value -> unit) -> unit
```
```reasonml
let forEach: t('value, 'id) => ('value => unit) => unit;
```
`forEach m f` applies `f` in turn to all elements of `m`. In increasing order

```ocaml
val reduceU : ('value, 'id) t -> 'a -> ('a -> 'value -> 'a) Js.Fn.arity2 -> 'a
```
```reasonml
let reduceU: t('value, 'id) => 'a => Js.Fn.arity2(('a => 'value => 'a)) => 'a;
```
```ocaml
val reduce : ('value, 'id) t -> 'a -> ('a -> 'value -> 'a) -> 'a
```
```reasonml
let reduce: t('value, 'id) => 'a => ('a => 'value => 'a) => 'a;
```
In increasing order.

```ocaml
val everyU : ('value, 'id) t -> ('value -> bool) Js.Fn.arity1 -> bool
```
```reasonml
let everyU: t('value, 'id) => Js.Fn.arity1(('value => bool)) => bool;
```
```ocaml
val every : ('value, 'id) t -> ('value -> bool) -> bool
```
```reasonml
let every: t('value, 'id) => ('value => bool) => bool;
```
`every s p` checks if all elements of the set satisfy the predicate `p`. Order unspecified

```ocaml
val someU : ('value, 'id) t -> ('value -> bool) Js.Fn.arity1 -> bool
```
```reasonml
let someU: t('value, 'id) => Js.Fn.arity1(('value => bool)) => bool;
```
```ocaml
val some : ('value, 'id) t -> ('value -> bool) -> bool
```
```reasonml
let some: t('value, 'id) => ('value => bool) => bool;
```
`some p s` checks if at least one element of the set satisfies the predicate `p`.

```ocaml
val keepU : ('value, 'id) t -> ('value -> bool) Js.Fn.arity1 -> ('value, 'id) t
```
```reasonml
let keepU: t('value, 'id) => Js.Fn.arity1(('value => bool)) => t('value, 'id);
```
```ocaml
val keep : ('value, 'id) t -> ('value -> bool) -> ('value, 'id) t
```
```reasonml
let keep: t('value, 'id) => ('value => bool) => t('value, 'id);
```
`keep s p` returns the set of all elements in `s` that satisfy predicate `p`.

```ocaml
val partitionU : 
  ('value, 'id) t ->
  ('value -> bool) Js.Fn.arity1 ->
  ('value, 'id) t * ('value, 'id) t
```
```reasonml
let partitionU: 
  t('value, 'id) =>
  Js.Fn.arity1(('value => bool)) =>
  (t('value, 'id), t('value, 'id));
```
```ocaml
val partition : 
  ('value, 'id) t ->
  ('value -> bool) ->
  ('value, 'id) t * ('value, 'id) t
```
```reasonml
let partition: 
  t('value, 'id) =>
  ('value => bool) =>
  (t('value, 'id), t('value, 'id));
```
`partition p s` returns a pair of sets `(s1, s2)`, where `s1` is the set of all the elements of `s` that satisfy the predicate `p`, and `s2` is the set of all the elements of `s` that do not satisfy `p`.

```ocaml
val size : ('value, 'id) t -> int
```
```reasonml
let size: t('value, 'id) => int;
```
```ocaml
val toList : ('value, 'id) t -> 'value list
```
```reasonml
let toList: t('value, 'id) => list('value);
```
In increasing order

```ocaml
val toArray : ('value, 'id) t -> 'value array
```
```reasonml
let toArray: t('value, 'id) => array('value);
```
In increasing order

```ocaml
val minimum : ('value, 'id) t -> 'value option
```
```reasonml
let minimum: t('value, 'id) => option('value);
```
```ocaml
val minUndefined : ('value, 'id) t -> 'value Js.undefined
```
```reasonml
let minUndefined: t('value, 'id) => Js.undefined('value);
```
```ocaml
val maximum : ('value, 'id) t -> 'value option
```
```reasonml
let maximum: t('value, 'id) => option('value);
```
```ocaml
val maxUndefined : ('value, 'id) t -> 'value Js.undefined
```
```reasonml
let maxUndefined: t('value, 'id) => Js.undefined('value);
```
```ocaml
val get : ('value, 'id) t -> 'value -> 'value option
```
```reasonml
let get: t('value, 'id) => 'value => option('value);
```
```ocaml
val getUndefined : ('value, 'id) t -> 'value -> 'value Js.undefined
```
```reasonml
let getUndefined: t('value, 'id) => 'value => Js.undefined('value);
```
```ocaml
val getExn : ('value, 'id) t -> 'value -> 'value
```
```reasonml
let getExn: t('value, 'id) => 'value => 'value;
```
```ocaml
val split : 
  ('value, 'id) t ->
  'value ->
  (('value, 'id) t * ('value, 'id) t) * bool
```
```reasonml
let split: 
  t('value, 'id) =>
  'value =>
  ((t('value, 'id), t('value, 'id)), bool);
```
`split s x` returns a triple `((l, r), present)`, where `l` is the set of elements of `s` that are strictly less than `x`; `r` is the set of elements of `s` that are strictly greater than `x`; `present` is `false` if `s` contains no element equal to `x`, or `true` if `s` contains an element equal to `x`. `l,r` are freshly made, no sharing with `s`

```ocaml
val checkInvariantInternal : (_, _) t -> unit
```
```reasonml
let checkInvariantInternal: t(_, _) => unit;
```
**raise** when invariant is not held
