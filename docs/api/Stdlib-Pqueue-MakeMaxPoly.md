
# Module `Pqueue.MakeMaxPoly`

Functor building an implementation of max-priority queues given a totally ordered type for the elements.


## Parameters

```ocaml
module E : OrderedPolyType
```
```reasonml
module E: OrderedPolyType
```

## Signature

```ocaml
type 'a t
```
```reasonml
type t('a);
```
```ocaml
val create : unit -> 'a t
```
```reasonml
let create: unit => t('a);
```
```ocaml
val length : 'a t -> int
```
```reasonml
let length: t('a) => int;
```
```ocaml
val is_empty : 'a t -> bool
```
```reasonml
let is_empty: t('a) => bool;
```
```ocaml
val add : 'a t -> 'a E.t -> unit
```
```reasonml
let add: t('a) => E.t('a) => unit;
```
```ocaml
val add_iter : 'a t -> (('a E.t -> unit) -> 'x -> unit) -> 'x -> unit
```
```reasonml
let add_iter: t('a) => ((E.t('a) => unit) => 'x => unit) => 'x => unit;
```
```ocaml
val max_elt : 'a t -> 'a E.t option
```
```reasonml
let max_elt: t('a) => option(E.t('a));
```
```ocaml
val get_max_elt : 'a t -> 'a E.t
```
```reasonml
let get_max_elt: t('a) => E.t('a);
```
```ocaml
val pop_max : 'a t -> 'a E.t option
```
```reasonml
let pop_max: t('a) => option(E.t('a));
```
```ocaml
val remove_max : 'a t -> unit
```
```reasonml
let remove_max: t('a) => unit;
```
```ocaml
val clear : 'a t -> unit
```
```reasonml
let clear: t('a) => unit;
```
```ocaml
val copy : 'a t -> 'a t
```
```reasonml
let copy: t('a) => t('a);
```
```ocaml
val of_array : 'a E.t array -> 'a t
```
```reasonml
let of_array: array(E.t('a)) => t('a);
```
```ocaml
val of_list : 'a E.t list -> 'a t
```
```reasonml
let of_list: list(E.t('a)) => t('a);
```
```ocaml
val of_iter : (('a E.t -> unit) -> 'x -> unit) -> 'x -> 'a t
```
```reasonml
let of_iter: ((E.t('a) => unit) => 'x => unit) => 'x => t('a);
```
```ocaml
val iter_unordered : ('a E.t -> unit) -> 'a t -> unit
```
```reasonml
let iter_unordered: (E.t('a) => unit) => t('a) => unit;
```
```ocaml
val fold_unordered : ('acc -> 'a E.t -> 'acc) -> 'acc -> 'a t -> 'acc
```
```reasonml
let fold_unordered: ('acc => E.t('a) => 'acc) => 'acc => t('a) => 'acc;
```