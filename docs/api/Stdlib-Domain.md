
# Module `Stdlib.Domain`

alert unstable The Domain interface may change in incompatible ways in the future.
Domains.

See 'Parallel programming' chapter in the manual.

since 5\.0
alert unstable The Domain interface may change in incompatible ways in the future.
```ocaml
type !'a t
```
```reasonml
type t(!'a);
```
A domain of type <code class="text-ocaml">'a t</code><code class="text-reasonml">t('a)</code> runs independently, eventually producing a result of type 'a, or an exception

```ocaml
val spawn : (unit -> 'a) -> 'a t
```
```reasonml
let spawn: (unit => 'a) => t('a);
```
`spawn f` creates a new domain that runs in parallel with the current domain.

raises [`Failure`](./Stdlib.md#exception-Failure) if the program has insufficient resources to create another domain.
```ocaml
val join : 'a t -> 'a Js.Promise.t
```
```reasonml
let join: t('a) => Js.Promise.t('a);
```
`join d` blocks until domain `d` runs to completion. If `d` results in a value, then that is returned by `join d`. If `d` raises an uncaught exception, then that is re-raised by `join d`.

```ocaml
type id = private int
```
```reasonml
type id = pri int;
```
Domains have unique integer identifiers

```ocaml
val get_id : 'a t -> id
```
```reasonml
let get_id: t('a) => id;
```
`get_id d` returns the identifier of the domain `d`

```ocaml
val self : unit -> id
```
```reasonml
let self: unit => id;
```
`self ()` is the identifier of the currently running domain

```ocaml
val before_first_spawn : (unit -> unit) -> unit
```
```reasonml
let before_first_spawn: (unit => unit) => unit;
```
`before_first_spawn f` registers `f` to be called before the first domain is spawned by the program. The functions registered with `before_first_spawn` are called on the main (initial) domain. The functions registered with `before_first_spawn` are called in 'first in, first out' order: the oldest function added with `before_first_spawn` is called first.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if the program has already spawned a domain.
```ocaml
val at_exit : (unit -> unit) -> unit
```
```reasonml
let at_exit: (unit => unit) => unit;
```
`at_exit f` registers `f` to be called when the current domain exits. Note that `at_exit` callbacks are domain-local and only apply to the calling domain. The registered functions are called in 'last in, first out' order: the function most recently added with `at_exit` is called first. An example:

```ocaml
let temp_file_key = Domain.DLS.new_key (fun _ ->
  let tmp = snd (Filename.open_temp_file "" "") in
  Domain.at_exit (fun () -> close_out_noerr tmp);
  tmp)
```
```reasonml
let temp_file_key =
  Domain.DLS.new_key(_ => {
    let tmp = snd(Filename.open_temp_file("", ""));
    Domain.at_exit(() => close_out_noerr(tmp));
    tmp;
  });
```
The snippet above creates a key that when retrieved for the first time will open a temporary file and register an `at_exit` callback to close it, thus guaranteeing the descriptor is not leaked in case the current domain exits.

```ocaml
val cpu_relax : unit -> unit
```
```reasonml
let cpu_relax: unit => unit;
```
If busy-waiting, calling cpu\_relax () between iterations will improve performance on some CPU architectures

```ocaml
val is_main_domain : unit -> bool
```
```reasonml
let is_main_domain: unit => bool;
```
`is_main_domain ()` returns true if called from the initial domain.

```ocaml
val recommended_domain_count : unit -> int
```
```reasonml
let recommended_domain_count: unit => int;
```
The recommended maximum number of domains which should be running simultaneously (including domains already running).

The value returned is at least `1`.

```ocaml
val self_index : unit -> int
```
```reasonml
let self_index: unit => int;
```
The index of the current domain. It is an integer unique among currently-running domains, in the interval `0; N-1` where N is the peak number of domains running simultaneously so far.

The index of a terminated domain may be reused for a new domain. Use `(Domain.self () :> int)` instead for an identifier unique among all domains ever created by the program.

since 5\.3
```ocaml
module DLS : sig ... end
```
```reasonml
module DLS: { ... };
```
Domain-local Storage
