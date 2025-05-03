
# Module `Obj.Ephemeron`

Ephemeron with arbitrary arity and untyped

```
type obj_t = t
```
alias for [`Obj.t`](./Stdlib-Obj.md#type-t)

```
type t
```
an ephemeron cf [`Ephemeron`](#)

```
val create : int -> t
```
`create n` returns an ephemeron with `n` keys. All the keys and the data are initially empty. The argument `n` must be between zero and [`max_ephe_length`](./#val-max_ephe_length) (limits included).

```
val length : t -> int
```
return the number of keys

```
val get_key : t -> int -> obj_t option
```
```
val get_key_copy : t -> int -> obj_t option
```
```
val set_key : t -> int -> obj_t -> unit
```
```
val unset_key : t -> int -> unit
```
```
val check_key : t -> int -> bool
```
```
val blit_key : t -> int -> t -> int -> int -> unit
```
```
val get_data : t -> obj_t option
```
```
val get_data_copy : t -> obj_t option
```
```
val set_data : t -> obj_t -> unit
```
```
val unset_data : t -> unit
```
```
val check_data : t -> bool
```
```
val blit_data : t -> t -> unit
```
```
val max_ephe_length : int
```
Maximum length of an ephemeron, ie the maximum number of keys an ephemeron could contain
