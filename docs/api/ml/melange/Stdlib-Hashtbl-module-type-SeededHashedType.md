
# Module type `Hashtbl.SeededHashedType`

The input signature of the functor [`MakeSeeded`](./Stdlib-Hashtbl-MakeSeeded.md).

since 4.00
```
type t
```
The type of the hashtable keys.

```
val equal : t -> t -> bool
```
The equality predicate used to compare keys.

```
val seeded_hash : int -> t -> int
```
A seeded hashing function on keys. The first argument is the seed. It must be the case that if `equal x y` is true, then `seeded_hash seed x = seeded_hash seed y` for any value of `seed`. A suitable choice for `seeded_hash` is the function [`Hashtbl.seeded_hash`](./Stdlib-Hashtbl.md#val-seeded_hash) below.
