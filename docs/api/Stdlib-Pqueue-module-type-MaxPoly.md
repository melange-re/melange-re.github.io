
# Module type `Pqueue.MaxPoly`

Output signature of the functor [`MakeMaxPoly`](./Stdlib-Pqueue-MakeMaxPoly.md).

```ocaml
type 'a t
```
```reasonml
type t('a);
```
```ocaml
type 'a elt
```
```reasonml
type elt('a);
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
val add : 'a t -> 'a elt -> unit
```
```reasonml
let add: t('a) => elt('a) => unit;
```
```ocaml
val add_iter : 'a t -> (('a elt -> unit) -> 'x -> unit) -> 'x -> unit
```
```reasonml
let add_iter: t('a) => ((elt('a) => unit) => 'x => unit) => 'x => unit;
```
```ocaml
val max_elt : 'a t -> 'a elt option
```
```reasonml
let max_elt: t('a) => option(elt('a));
```
```ocaml
val get_max_elt : 'a t -> 'a elt
```
```reasonml
let get_max_elt: t('a) => elt('a);
```
```ocaml
val pop_max : 'a t -> 'a elt option
```
```reasonml
let pop_max: t('a) => option(elt('a));
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
val of_array : 'a elt array -> 'a t
```
```reasonml
let of_array: array(elt('a)) => t('a);
```
```ocaml
val of_list : 'a elt list -> 'a t
```
```reasonml
let of_list: list(elt('a)) => t('a);
```
```ocaml
val of_iter : (('a elt -> unit) -> 'x -> unit) -> 'x -> 'a t
```
```reasonml
let of_iter: ((elt('a) => unit) => 'x => unit) => 'x => t('a);
```
```ocaml
val iter_unordered : ('a elt -> unit) -> 'a t -> unit
```
```reasonml
let iter_unordered: (elt('a) => unit) => t('a) => unit;
```
```ocaml
val fold_unordered : ('acc -> 'a elt -> 'acc) -> 'acc -> 'a t -> 'acc
```
```reasonml
let fold_unordered: ('acc => elt('a) => 'acc) => 'acc => t('a) => 'acc;
```