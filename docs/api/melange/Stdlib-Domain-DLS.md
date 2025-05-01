# Module `Domain.DLS`
Domain-local Storage
```
type 'a key
```
Type of a DLS key
```
val new_key : ?split_from_parent:('a -> 'a) -> (unit -> 'a) -> 'a key
```
`new_key f` returns a new key bound to initialiser `f` for accessing domain-local variables.
If `split_from_parent` is not provided, the value for a new domain will be computed on-demand by the new domain: the first `get` call will call the initializer `f` and store that value.
**Warning.** `f` may be called several times if another call to `get` occurs during initialization on the same domain. Only the 'first' value computed will be used, the other now-useless values will be discarded. Your initialization function should support this situation, or contain logic to detect this case and fail.
If `split_from_parent` is provided, spawning a domain will derive the child value (for this key) from the parent value. This computation happens in the parent domain and it always happens, regardless of whether the child domain will use it. If the splitting function is expensive or requires child-side computation, consider using `'a Lazy.t key`:
```ocaml
let init () = ...

let split_from_parent parent_value =
  ... parent-side computation ...;
  lazy (
    ... child-side computation ...
  )

let key = Domain.DLS.new_key ~split_from_parent init

let get () = Lazy.force (Domain.DLS.get key)
```
In this case a part of the computation happens on the child domain; in particular, it can access `parent_value` concurrently with the parent domain, which may require explicit synchronization to avoid data races.
```
val get : 'a key -> 'a
```
`get k` returns `v` if a value `v` is associated to the key `k` on the calling domain's domain-local state. Sets `k`'s value with its initialiser and returns it otherwise.
```
val set : 'a key -> 'a -> unit
```
`set k v` updates the calling domain's domain-local state to associate the key `k` with value `v`. It overwrites any previous values associated to `k`, which cannot be restored later.