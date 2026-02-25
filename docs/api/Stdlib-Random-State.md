
# Module `Random.State`

```ocaml
type t
```
```reasonml
type t;
```
The type of PRNG states.

```ocaml
val make : int array -> t
```
```reasonml
let make: array(int) => t;
```
Create a new state and initialize it with the given seed.

```ocaml
val make_self_init : unit -> t
```
```reasonml
let make_self_init: unit => t;
```
Create a new state and initialize it with a random seed chosen in a system-dependent way. The seed is obtained as described in [`Random.self_init`](./Stdlib-Random.md#val-self_init).

```ocaml
val copy : t -> t
```
```reasonml
let copy: t => t;
```
Return a copy of the given state.

```ocaml
val bits : t -> int
```
```reasonml
let bits: t => int;
```
```ocaml
val int : t -> int -> int
```
```reasonml
let int: t => int => int;
```
```ocaml
val full_int : t -> int -> int
```
```reasonml
let full_int: t => int => int;
```
```ocaml
val int32 : t -> Int32.t -> Int32.t
```
```reasonml
let int32: t => Int32.t => Int32.t;
```
```ocaml
val int64 : t -> Int64.t -> Int64.t
```
```reasonml
let int64: t => Int64.t => Int64.t;
```
```ocaml
val float : t -> float -> float
```
```reasonml
let float: t => float => float;
```
```ocaml
val bool : t -> bool
```
```reasonml
let bool: t => bool;
```
```ocaml
val bits32 : t -> Int32.t
```
```reasonml
let bits32: t => Int32.t;
```
```ocaml
val bits64 : t -> Int64.t
```
```reasonml
let bits64: t => Int64.t;
```