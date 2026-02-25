
# Module type `Pqueue.Max`

Output signature of the functor [`MakeMax`](./Stdlib-Pqueue-MakeMax.md).

```ocaml
type t
```
```reasonml
type t;
```
```ocaml
type elt
```
```reasonml
type elt;
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
val add : t -> elt -> unit
```
```reasonml
let add: t => elt => unit;
```
```ocaml
val add_iter : t -> ((elt -> unit) -> 'x -> unit) -> 'x -> unit
```
```reasonml
let add_iter: t => ((elt => unit) => 'x => unit) => 'x => unit;
```
```ocaml
val max_elt : t -> elt option
```
```reasonml
let max_elt: t => option(elt);
```
```ocaml
val get_max_elt : t -> elt
```
```reasonml
let get_max_elt: t => elt;
```
```ocaml
val pop_max : t -> elt option
```
```reasonml
let pop_max: t => option(elt);
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
val of_array : elt array -> t
```
```reasonml
let of_array: array(elt) => t;
```
```ocaml
val of_list : elt list -> t
```
```reasonml
let of_list: list(elt) => t;
```
```ocaml
val of_iter : ((elt -> unit) -> 'x -> unit) -> 'x -> t
```
```reasonml
let of_iter: ((elt => unit) => 'x => unit) => 'x => t;
```
```ocaml
val iter_unordered : (elt -> unit) -> t -> unit
```
```reasonml
let iter_unordered: (elt => unit) => t => unit;
```
```ocaml
val fold_unordered : ('acc -> elt -> 'acc) -> 'acc -> t -> 'acc
```
```reasonml
let fold_unordered: ('acc => elt => 'acc) => 'acc => t => 'acc;
```