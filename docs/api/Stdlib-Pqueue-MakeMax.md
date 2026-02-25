
# Module `Pqueue.MakeMax`

Functor building an implementation of the max-priority queue structure given a totally ordered type for elements.


## Parameters

```ocaml
module E : OrderedType
```
```reasonml
module E: OrderedType
```

## Signature

```ocaml
type t
```
```reasonml
type t;
```
```ocaml
val create : unit -> t
```
```reasonml
let create: unit => t;
```
```ocaml
val length : t -> int
```
```reasonml
let length: t => int;
```
```ocaml
val is_empty : t -> bool
```
```reasonml
let is_empty: t => bool;
```
```ocaml
val add : t -> E.t -> unit
```
```reasonml
let add: t => E.t => unit;
```
```ocaml
val add_iter : t -> ((E.t -> unit) -> 'x -> unit) -> 'x -> unit
```
```reasonml
let add_iter: t => ((E.t => unit) => 'x => unit) => 'x => unit;
```
```ocaml
val max_elt : t -> E.t option
```
```reasonml
let max_elt: t => option(E.t);
```
```ocaml
val get_max_elt : t -> E.t
```
```reasonml
let get_max_elt: t => E.t;
```
```ocaml
val pop_max : t -> E.t option
```
```reasonml
let pop_max: t => option(E.t);
```
```ocaml
val remove_max : t -> unit
```
```reasonml
let remove_max: t => unit;
```
```ocaml
val clear : t -> unit
```
```reasonml
let clear: t => unit;
```
```ocaml
val copy : t -> t
```
```reasonml
let copy: t => t;
```
```ocaml
val of_array : E.t array -> t
```
```reasonml
let of_array: array(E.t) => t;
```
```ocaml
val of_list : E.t list -> t
```
```reasonml
let of_list: list(E.t) => t;
```
```ocaml
val of_iter : ((E.t -> unit) -> 'x -> unit) -> 'x -> t
```
```reasonml
let of_iter: ((E.t => unit) => 'x => unit) => 'x => t;
```
```ocaml
val iter_unordered : (E.t -> unit) -> t -> unit
```
```reasonml
let iter_unordered: (E.t => unit) => t => unit;
```
```ocaml
val fold_unordered : ('acc -> E.t -> 'acc) -> 'acc -> t -> 'acc
```
```reasonml
let fold_unordered: ('acc => E.t => 'acc) => 'acc => t => 'acc;
```