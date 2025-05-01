# Module `Stdlib.Random`
Pseudo-random number generators (PRNG).
With multiple domains, each domain has its own generator that evolves independently of the generators of other domains. When a domain is created, its generator is initialized by splitting the state of the generator associated with the parent domain.
In contrast, all threads within a domain share the same domain-local generator. Independent generators can be created with the `Random.split` function and used with the functions from the [`Random.State`](./Stdlib-Random-State.md) module.
before 5.0 Random value generation used a different algorithm. This affects all the functions in this module which return random values.
## Basic functions
```
val init : int -> unit
```
Initialize the domain-local generator, using the argument as a seed. The same seed will always yield the same sequence of numbers.
```
val full_init : int array -> unit
```
Same as [`Random.init`](./#val-init) but takes more data as seed.
```
val self_init : unit -> unit
```
Initialize the domain-local generator with a random seed chosen in a system-dependent way. If `/dev/urandom` is available on the host machine, it is used to provide a highly random initial seed. Otherwise, a less random seed is computed from system parameters (current time, process IDs, domain-local state).
```
val bits : unit -> int
```
Return 30 random bits in a nonnegative integer.
```
val int : int -> int
```
`Random.int bound` returns a random integer between 0 (inclusive) and `bound` (exclusive). `bound` must be greater than 0 and less than 230.
raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if bound \<= 0 or bound \>= 230.
```
val full_int : int -> int
```
`Random.full_int bound` returns a random integer between 0 (inclusive) and `bound` (exclusive). `bound` may be any positive integer.
If `bound` is less than 231, then `Random.full_int bound` yields identical output across systems with varying `int` sizes.
If `bound` is less than 230, then `Random.full_int bound` is equal to [`Random.int`](./#val-int)` bound`.
If `bound` is at least 230 (on 64-bit systems, or non-standard environments such as JavaScript), then `Random.full_int` returns a value whereas [`Random.int`](./#val-int) raises [`Stdlib.Invalid_argument`](./Stdlib.md#exception-Invalid_argument).
raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if bound \<= 0.
since 4.13
```
val int32 : Int32.t -> Int32.t
```
`Random.int32 bound` returns a random integer between 0 (inclusive) and `bound` (exclusive). `bound` must be greater than 0.
raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if bound \<= 0.
```
val int64 : Int64.t -> Int64.t
```
`Random.int64 bound` returns a random integer between 0 (inclusive) and `bound` (exclusive). `bound` must be greater than 0.
raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if bound \<= 0.
```
val float : float -> float
```
`Random.float bound` returns a random floating-point number between 0 and `bound` (inclusive). If `bound` is negative, the result is negative or zero. If `bound` is 0, the result is 0.
```
val bool : unit -> bool
```
`Random.bool ()` returns `true` or `false` with probability 0.5 each.
```
val bits32 : unit -> Int32.t
```
`Random.bits32 ()` returns 32 random bits as an integer between [`Int32.min_int`](./Stdlib-Int32.md#val-min_int) and [`Int32.max_int`](./Stdlib-Int32.md#val-max_int).
since 4.14
```
val bits64 : unit -> Int64.t
```
`Random.bits64 ()` returns 64 random bits as an integer between [`Int64.min_int`](./Stdlib-Int64.md#val-min_int) and [`Int64.max_int`](./Stdlib-Int64.md#val-max_int).
since 4.14
## Advanced functions
The functions from module [`State`](./Stdlib-Random-State.md) manipulate the current state of the random generator explicitly. This allows using one or several deterministic PRNGs, even in a multi-threaded program, without interference from other parts of the program.
```
module State : sig ... end
```
```
val get_state : unit -> State.t
```
`get_state()` returns a fresh copy of the current state of the domain-local generator (which is used by the basic functions).
```
val set_state : State.t -> unit
```
`set_state s` updates the current state of the domain-local generator (which is used by the basic functions) by copying the state `s` into it.