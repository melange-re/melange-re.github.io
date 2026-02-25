
# Parameter `MakeMax.E`

```ocaml
type t
```
```reasonml
type t;
```
The type of elements.

```ocaml
val compare : t -> t -> int
```
```reasonml
let compare: t => t => int;
```
A total ordering function to compare elements.

This is a two-argument function `f` such that `f e1 e2` is zero if the elements `e1` and `e2` are equal, `f e1 e2` is strictly negative if `e1` is smaller than `e2`, and `f e1 e2` is strictly positive if `e1` is greater than `e2`.

The generic structural comparison function [`Stdlib.compare`](./Stdlib.md#val-compare) is a suitable ordering function for element types such as `int` or `string`.
