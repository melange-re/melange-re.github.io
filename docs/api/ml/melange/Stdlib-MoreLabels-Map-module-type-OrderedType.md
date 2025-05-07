
# Module type `Map.OrderedType`

Input signature of the functor [`Make`](./Stdlib-MoreLabels-Map-Make.md).

```
type t
```
The type of the map keys.

```
val compare : t -> t -> int
```
A total ordering function over the keys. This is a two-argument function `f` such that `f e1 e2` is zero if the keys `e1` and `e2` are equal, `f e1 e2` is strictly negative if `e1` is smaller than `e2`, and `f e1 e2` is strictly positive if `e1` is greater than `e2`. Example: a suitable ordering function is the generic structural comparison function [`Stdlib.compare`](./Stdlib.md#val-compare).
