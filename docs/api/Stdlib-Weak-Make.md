
# Module `Weak.Make`

Functor building an implementation of the weak hash set structure. `H.equal` can't be the physical equality, since only shallow copies of the elements in the set are given to it.


## Parameters

```ocaml
module H : Hashtbl.HashedType
```
```reasonml
module H: Hashtbl.HashedType
```

## Signature

```ocaml
type data = H.t
```
```reasonml
type data = H.t;
```
The type of the elements stored in the table.

```ocaml
type t
```
```reasonml
type t;
```
The type of tables that contain elements of type `data`. Note that weak hash sets cannot be marshaled using [`Stdlib.output_value`](./Stdlib.md#val-output_value) or the functions of the [`Marshal`](./Stdlib-Marshal.md) module.

```ocaml
val create : int -> t
```
```reasonml
let create: int => t;
```
`create n` creates a new empty weak hash set, of initial size `n`. The table will grow as needed.

```ocaml
val clear : t -> unit
```
```reasonml
let clear: t => unit;
```
Remove all elements from the table.

```ocaml
val merge : t -> data -> data
```
```reasonml
let merge: t => data => data;
```
`merge t x` returns an instance of `x` found in `t` if any, or else adds `x` to `t` and return `x`.

```ocaml
val add : t -> data -> unit
```
```reasonml
let add: t => data => unit;
```
`add t x` adds `x` to `t`. If there is already an instance of `x` in `t`, it is unspecified which one will be returned by subsequent calls to `find` and `merge`.

```ocaml
val remove : t -> data -> unit
```
```reasonml
let remove: t => data => unit;
```
`remove t x` removes from `t` one instance of `x`. Does nothing if there is no instance of `x` in `t`.

```ocaml
val find : t -> data -> data
```
```reasonml
let find: t => data => data;
```
`find t x` returns an instance of `x` found in `t`.

raises [`Not_found`](./Stdlib.md#exception-Not_found) if there is no such element.
```ocaml
val find_opt : t -> data -> data option
```
```reasonml
let find_opt: t => data => option(data);
```
`find_opt t x` returns an instance of `x` found in `t` or `None` if there is no such element.

since 4\.05
```ocaml
val find_all : t -> data -> data list
```
```reasonml
let find_all: t => data => list(data);
```
`find_all t x` returns a list of all the instances of `x` found in `t`.

```ocaml
val mem : t -> data -> bool
```
```reasonml
let mem: t => data => bool;
```
`mem t x` returns `true` if there is at least one instance of `x` in `t`, false otherwise.

```ocaml
val iter : (data -> unit) -> t -> unit
```
```reasonml
let iter: (data => unit) => t => unit;
```
`iter f t` calls `f` on each element of `t`, in some unspecified order. It is not specified what happens if `f` tries to change `t` itself.

```ocaml
val fold : (data -> 'acc -> 'acc) -> t -> 'acc -> 'acc
```
```reasonml
let fold: (data => 'acc => 'acc) => t => 'acc => 'acc;
```
`fold f t init` computes `(f d1 (... (f dN init)))` where `d1 ... dN` are the elements of `t` in some unspecified order. It is not specified what happens if `f` tries to change `t` itself.

```ocaml
val count : t -> int
```
```reasonml
let count: t => int;
```
Count the number of elements in the table. `count t` gives the same result as `fold (fun _ n -> n+1) t 0` but does not delay the deallocation of the dead elements.

```ocaml
val stats : t -> int * int * int * int * int * int
```
```reasonml
let stats: t => (int, int, int, int, int, int);
```
Return statistics on the table. The numbers are, in order: table length, number of entries, sum of bucket lengths, smallest bucket length, median bucket length, biggest bucket length.
