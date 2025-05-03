
# Module type `Hashtbl.HashedType`

The input signature of the functor [`Make`](./Stdlib-Hashtbl-Make.md).

```
type t
```
The type of the hashtable keys.

```
val equal : t -> t -> bool
```
The equality predicate used to compare keys.

```
val hash : t -> int
```
A hashing function on keys. It must be such that if two keys are equal according to `equal`, then they have identical hash values as computed by `hash`. Examples: suitable (`equal`, `hash`) pairs for arbitrary key types include

- (`(=)`, [`hash`](./#val-hash)) for comparing objects by structure (provided objects do not contain floats)
- (`(fun x y -> compare x y = 0)`, [`hash`](./#val-hash)) for comparing objects by structure and handling [`Stdlib.nan`](./Stdlib.md#val-nan) correctly
- (`(==)`, [`hash`](./#val-hash)) for comparing objects by physical equality (e.g. for mutable or cyclic objects).