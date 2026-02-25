
# Module `Set.Dict`

This module seprate identity from data, it is a bit more verboe but slightly more efficient due to the fact that there is no need to pack identity and data back after each operation

```ocaml
type ('value, 'identity) t
```
```reasonml
type t('value, 'identity);
```
```ocaml
type ('value, 'id) cmp
```
```reasonml
type cmp('value, 'id);
```
```ocaml
val empty : ('value, 'id) t
```
```reasonml
let empty: t('value, 'id);
```
```ocaml
val fromArray : 'value array -> cmp:('value, 'id) cmp -> ('value, 'id) t
```
```reasonml
let fromArray: array('value) => cmp:cmp('value, 'id) => t('value, 'id);
```
```ocaml
val fromSortedArrayUnsafe : 'value array -> ('value, 'id) t
```
```reasonml
let fromSortedArrayUnsafe: array('value) => t('value, 'id);
```
```ocaml
val isEmpty : (_, _) t -> bool
```
```reasonml
let isEmpty: t(_, _) => bool;
```
```ocaml
val has : ('value, 'id) t -> 'value -> cmp:('value, 'id) cmp -> bool
```
```reasonml
let has: t('value, 'id) => 'value => cmp:cmp('value, 'id) => bool;
```
```ocaml
val add : ('value, 'id) t -> 'value -> cmp:('value, 'id) cmp -> ('value, 'id) t
```
```reasonml
let add: t('value, 'id) => 'value => cmp:cmp('value, 'id) => t('value, 'id);
```
`add s x` If `x` was already in `s`, `s` is returned unchanged.

```ocaml
val mergeMany : 
  ('value, 'id) t ->
  'value array ->
  cmp:('value, 'id) cmp ->
  ('value, 'id) t
```
```reasonml
let mergeMany: 
  t('value, 'id) =>
  array('value) =>
  cmp:cmp('value, 'id) =>
  t('value, 'id);
```
```ocaml
val remove : 
  ('value, 'id) t ->
  'value ->
  cmp:('value, 'id) cmp ->
  ('value, 'id) t
```
```reasonml
let remove: t('value, 'id) => 'value => cmp:cmp('value, 'id) => t('value, 'id);
```
`remove m x` If `x` was not in `m`, `m` is returned reference unchanged.

```ocaml
val removeMany : 
  ('value, 'id) t ->
  'value array ->
  cmp:('value, 'id) cmp ->
  ('value, 'id) t
```
```reasonml
let removeMany: 
  t('value, 'id) =>
  array('value) =>
  cmp:cmp('value, 'id) =>
  t('value, 'id);
```
```ocaml
val union : 
  ('value, 'id) t ->
  ('value, 'id) t ->
  cmp:('value, 'id) cmp ->
  ('value, 'id) t
```
```reasonml
let union: 
  t('value, 'id) =>
  t('value, 'id) =>
  cmp:cmp('value, 'id) =>
  t('value, 'id);
```
```ocaml
val intersect : 
  ('value, 'id) t ->
  ('value, 'id) t ->
  cmp:('value, 'id) cmp ->
  ('value, 'id) t
```
```reasonml
let intersect: 
  t('value, 'id) =>
  t('value, 'id) =>
  cmp:cmp('value, 'id) =>
  t('value, 'id);
```
```ocaml
val diff : 
  ('value, 'id) t ->
  ('value, 'id) t ->
  cmp:('value, 'id) cmp ->
  ('value, 'id) t
```
```reasonml
let diff: 
  t('value, 'id) =>
  t('value, 'id) =>
  cmp:cmp('value, 'id) =>
  t('value, 'id);
```
```ocaml
val subset : 
  ('value, 'id) t ->
  ('value, 'id) t ->
  cmp:('value, 'id) cmp ->
  bool
```
```reasonml
let subset: t('value, 'id) => t('value, 'id) => cmp:cmp('value, 'id) => bool;
```
`subset s1 s2` tests whether the set `s1` is a subset of the set `s2`.

```ocaml
val cmp : ('value, 'id) t -> ('value, 'id) t -> cmp:('value, 'id) cmp -> int
```
```reasonml
let cmp: t('value, 'id) => t('value, 'id) => cmp:cmp('value, 'id) => int;
```
Total ordering between sets. Can be used as the ordering function for doing sets of sets.

```ocaml
val eq : ('value, 'id) t -> ('value, 'id) t -> cmp:('value, 'id) cmp -> bool
```
```reasonml
let eq: t('value, 'id) => t('value, 'id) => cmp:cmp('value, 'id) => bool;
```
`eq s1 s2` tests whether the sets `s1` and `s2` are equal, that is, contain equal elements.

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
`forEach s f` applies `f` in turn to all elements of `s`. In increasing order

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
Iterate in increasing order.

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
`every p s` checks if all elements of the set satisfy the predicate `p`. Order unspecified.

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
`some p s` checks if at least one element of the set satisfies the predicate `p`. Oder unspecified.

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
`keep p s` returns the set of all elements in `s` that satisfy predicate `p`.

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
val get : ('value, 'id) t -> 'value -> cmp:('value, 'id) cmp -> 'value option
```
```reasonml
let get: t('value, 'id) => 'value => cmp:cmp('value, 'id) => option('value);
```
```ocaml
val getUndefined : 
  ('value, 'id) t ->
  'value ->
  cmp:('value, 'id) cmp ->
  'value Js.undefined
```
```reasonml
let getUndefined: 
  t('value, 'id) =>
  'value =>
  cmp:cmp('value, 'id) =>
  Js.undefined('value);
```
```ocaml
val getExn : ('value, 'id) t -> 'value -> cmp:('value, 'id) cmp -> 'value
```
```reasonml
let getExn: t('value, 'id) => 'value => cmp:cmp('value, 'id) => 'value;
```
```ocaml
val split : 
  ('value, 'id) t ->
  'value ->
  cmp:('value, 'id) cmp ->
  (('value, 'id) t * ('value, 'id) t) * bool
```
```reasonml
let split: 
  t('value, 'id) =>
  'value =>
  cmp:cmp('value, 'id) =>
  ((t('value, 'id), t('value, 'id)), bool);
```
`split x s` returns a triple `(l, present, r)`, where `l` is the set of elements of `s` that are strictly less than `x`; `r` is the set of elements of `s` that are strictly greater than `x`; `present` is `false` if `s` contains no element equal to `x`, or `true` if `s` contains an element equal to `x`.

```ocaml
val checkInvariantInternal : (_, _) t -> unit
```
```reasonml
let checkInvariantInternal: t(_, _) => unit;
```
**raise** when invariant is not held
