
# Module `Atomic.Loc`

Atomic "locations", such as record fields.

```ocaml
type 'a t = 'a atomic_loc
```
```reasonml
type t('a) = atomic_loc('a);
```
This module exposes a dedicated type <code class="text-ocaml">'a Atomic.Loc.t</code><code class="text-reasonml">Atomic.Loc.t('a)</code> for atomic locations (storing a value of type `'a`) inside objects that may not be atomic references. It is used in particular for atomic record fields: if a record `r` has an atomic field `f` of type `foo`, then `[%atomic.loc r.f]` has type `foo Atomic.Loc.t`. The API below mirrors the API to access [atomic references](./#type-t), see the documentation above for more information.

```ocaml
val get : 'a t -> 'a
```
```reasonml
let get: t('a) => 'a;
```
```ocaml
val set : 'a t -> 'a -> unit
```
```reasonml
let set: t('a) => 'a => unit;
```
```ocaml
val exchange : 'a t -> 'a -> 'a
```
```reasonml
let exchange: t('a) => 'a => 'a;
```
```ocaml
val compare_and_set : 'a t -> 'a -> 'a -> bool
```
```reasonml
let compare_and_set: t('a) => 'a => 'a => bool;
```
```ocaml
val fetch_and_add : int t -> int -> int
```
```reasonml
let fetch_and_add: t(int) => int => int;
```
```ocaml
val incr : int t -> unit
```
```reasonml
let incr: t(int) => unit;
```
```ocaml
val decr : int t -> unit
```
```reasonml
let decr: t(int) => unit;
```