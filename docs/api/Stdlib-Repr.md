
# Module `Stdlib.Repr`

Functions defined on the low-level representations of values.

since 5\.4

## Physical comparison

```ocaml
val phys_equal : 'a -> 'a -> bool
```
```reasonml
let phys_equal: 'a => 'a => bool;
```
`phys_equal e1 e2` tests for physical equality of `e1` and `e2`. On mutable types such as references, arrays, byte sequences, records with mutable fields and objects with mutable instance variables, `phys_equal e1 e2` is true if and only if physical modification of `e1` also affects `e2`. On non-mutable types, the behavior of `phys_equal` is implementation-dependent; however, it is guaranteed that `phys_equal e1 e2` implies `compare e1 e2 = 0`.


## Polymorphic comparison

```ocaml
val equal : 'a -> 'a -> bool
```
```reasonml
let equal: 'a => 'a => bool;
```
`equal e1 e2` tests for structural equality of `e1` and `e2`. Mutable structures (e.g. references and arrays) are equal if and only if their current contents are structurally equal, even if the two mutable objects are not the same physical object. Equality between functional values raises `Invalid_argument`. Equality between cyclic data structures may not terminate.

```ocaml
val compare : 'a -> 'a -> int
```
```reasonml
let compare: 'a => 'a => int;
```
`compare x y` returns `0` if `x` is equal to `y`, a negative integer if `x` is less than `y`, and a positive integer if `x` is greater than `y`. The ordering implemented by `compare` is compatible with the comparison predicates [`Stdlib.(=)`](./Stdlib.md#val-\(=\)), [`Stdlib.(<)`](./Stdlib.md#val-\(<\)) and [`Stdlib.(>)`](./Stdlib.md#val-\(>\)), as well as the `equal` function defined above, with one difference on the treatment of the float value [`Stdlib.nan`](./Stdlib.md#val-nan). Namely, the comparison predicates treat `nan` as different from any other float value, including itself; while `compare` treats `nan` as equal to itself and less than any other float value. This treatment of `nan` ensures that `compare` defines a total ordering relation.

`compare` applied to functional values may raise `Invalid_argument`. `compare` applied to cyclic structures may not terminate.

The `compare` function can be used as the comparison function required by the [`Set.Make`](./Stdlib-Set-Make.md) and [`Map.Make`](./Stdlib-Map-Make.md) functors, as well as the [`List.sort`](./Stdlib-List.md#val-sort) and [`Array.sort`](./Stdlib-Array.md#val-sort) functions.

```ocaml
val min : 'a -> 'a -> 'a
```
```reasonml
let min: 'a => 'a => 'a;
```
Return the smaller of the two arguments. The result is unspecified if one of the arguments contains the float value [`Stdlib.nan`](./Stdlib.md#val-nan).

```ocaml
val max : 'a -> 'a -> 'a
```
```reasonml
let max: 'a => 'a => 'a;
```
Return the greater of the two arguments. The result is unspecified if one of the arguments contains the float value [`Stdlib.nan`](./Stdlib.md#val-nan).
