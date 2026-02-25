
# Module type `Hashtbl.S`

The output signature of the functor [`Make`](./Stdlib-MoreLabels-Hashtbl-Make.md).

```ocaml
type key
```
```reasonml
type key;
```
```ocaml
type !'a t
```
```reasonml
type t(!'a);
```
```ocaml
val create : int -> 'a t
```
```reasonml
let create: int => t('a);
```
```ocaml
val clear : 'a t -> unit
```
```reasonml
let clear: t('a) => unit;
```
```ocaml
val reset : 'a t -> unit
```
```reasonml
let reset: t('a) => unit;
```
since 4\.00
```ocaml
val copy : 'a t -> 'a t
```
```reasonml
let copy: t('a) => t('a);
```
```ocaml
val add : 'a t -> key:key -> data:'a -> unit
```
```reasonml
let add: t('a) => key:key => data:'a => unit;
```
```ocaml
val remove : 'a t -> key -> unit
```
```reasonml
let remove: t('a) => key => unit;
```
```ocaml
val find : 'a t -> key -> 'a
```
```reasonml
let find: t('a) => key => 'a;
```
```ocaml
val find_opt : 'a t -> key -> 'a option
```
```reasonml
let find_opt: t('a) => key => option('a);
```
since 4\.05
```ocaml
val find_all : 'a t -> key -> 'a list
```
```reasonml
let find_all: t('a) => key => list('a);
```
```ocaml
val replace : 'a t -> key:key -> data:'a -> unit
```
```reasonml
let replace: t('a) => key:key => data:'a => unit;
```
```ocaml
val mem : 'a t -> key -> bool
```
```reasonml
let mem: t('a) => key => bool;
```
```ocaml
val iter : f:(key:key -> data:'a -> unit) -> 'a t -> unit
```
```reasonml
let iter: f:(key:key => data:'a => unit) => t('a) => unit;
```
```ocaml
val filter_map_inplace : f:(key:key -> data:'a -> 'a option) -> 'a t -> unit
```
```reasonml
let filter_map_inplace: f:(key:key => data:'a => option('a)) => t('a) => unit;
```
since 4\.03
```ocaml
val fold : f:(key:key -> data:'a -> 'acc -> 'acc) -> 'a t -> init:'acc -> 'acc
```
```reasonml
let fold: f:(key:key => data:'a => 'acc => 'acc) => t('a) => init:'acc => 'acc;
```
```ocaml
val length : 'a t -> int
```
```reasonml
let length: t('a) => int;
```
```ocaml
val stats : 'a t -> statistics
```
```reasonml
let stats: t('a) => statistics;
```
since 4\.00
```ocaml
val to_seq : 'a t -> (key * 'a) Seq.t
```
```reasonml
let to_seq: t('a) => Seq.t((key, 'a));
```
since 4\.07
```ocaml
val to_seq_keys : _ t -> key Seq.t
```
```reasonml
let to_seq_keys: t(_) => Seq.t(key);
```
since 4\.07
```ocaml
val to_seq_values : 'a t -> 'a Seq.t
```
```reasonml
let to_seq_values: t('a) => Seq.t('a);
```
since 4\.07
```ocaml
val add_seq : 'a t -> (key * 'a) Seq.t -> unit
```
```reasonml
let add_seq: t('a) => Seq.t((key, 'a)) => unit;
```
since 4\.07
```ocaml
val replace_seq : 'a t -> (key * 'a) Seq.t -> unit
```
```reasonml
let replace_seq: t('a) => Seq.t((key, 'a)) => unit;
```
since 4\.07
```ocaml
val of_seq : (key * 'a) Seq.t -> 'a t
```
```reasonml
let of_seq: Seq.t((key, 'a)) => t('a);
```
since 4\.07