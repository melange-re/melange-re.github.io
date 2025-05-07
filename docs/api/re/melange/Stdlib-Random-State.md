
# Module `Random.State`

```
type t
```
The type of PRNG states.

```
val make : int array -> t
```
Create a new state and initialize it with the given seed.

```
val make_self_init : unit -> t
```
Create a new state and initialize it with a random seed chosen in a system-dependent way. The seed is obtained as described in [`Random.self_init`](./Stdlib-Random.md#val-self_init).

```
val copy : t -> t
```
Return a copy of the given state.

```
val bits : t -> int
```
```
val int : t -> int -> int
```
```
val full_int : t -> int -> int
```
```
val int32 : t -> Int32.t -> Int32.t
```
```
val int64 : t -> Int64.t -> Int64.t
```
```
val float : t -> float -> float
```
```
val bool : t -> bool
```
```
val bits32 : t -> Int32.t
```
```
val bits64 : t -> Int64.t
```