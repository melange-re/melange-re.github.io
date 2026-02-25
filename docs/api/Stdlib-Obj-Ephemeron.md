
# Module `Obj.Ephemeron`

Ephemeron with arbitrary arity and untyped

```ocaml
type obj_t = t
```
```reasonml
type obj_t = t;
```
alias for [`Obj.t`](./Stdlib-Obj.md#type-t)

```ocaml
type t
```
```reasonml
type t;
```
an ephemeron cf [`Ephemeron`](#)

```ocaml
val create : int -> t
```
```reasonml
let create: int => t;
```
`create n` returns an ephemeron with `n` keys. All the keys and the data are initially empty. The argument `n` must be between zero and [`max_ephe_length`](./#val-max_ephe_length) (limits included).

```ocaml
val length : t -> int
```
```reasonml
let length: t => int;
```
return the number of keys

```ocaml
val get_key : t -> int -> obj_t option
```
```reasonml
let get_key: t => int => option(obj_t);
```
```ocaml
val get_key_copy : t -> int -> obj_t option
```
```reasonml
let get_key_copy: t => int => option(obj_t);
```
```ocaml
val set_key : t -> int -> obj_t -> unit
```
```reasonml
let set_key: t => int => obj_t => unit;
```
```ocaml
val unset_key : t -> int -> unit
```
```reasonml
let unset_key: t => int => unit;
```
```ocaml
val check_key : t -> int -> bool
```
```reasonml
let check_key: t => int => bool;
```
```ocaml
val blit_key : t -> int -> t -> int -> int -> unit
```
```reasonml
let blit_key: t => int => t => int => int => unit;
```
```ocaml
val get_data : t -> obj_t option
```
```reasonml
let get_data: t => option(obj_t);
```
```ocaml
val get_data_copy : t -> obj_t option
```
```reasonml
let get_data_copy: t => option(obj_t);
```
```ocaml
val set_data : t -> obj_t -> unit
```
```reasonml
let set_data: t => obj_t => unit;
```
```ocaml
val unset_data : t -> unit
```
```reasonml
let unset_data: t => unit;
```
```ocaml
val check_data : t -> bool
```
```reasonml
let check_data: t => bool;
```
```ocaml
val blit_data : t -> t -> unit
```
```reasonml
let blit_data: t => t => unit;
```
```ocaml
val max_ephe_length : int
```
```reasonml
let max_ephe_length: int;
```
Maximum length of an ephemeron, ie the maximum number of keys an ephemeron could contain
