
# Module `SortArray.String`

Specalized when key type is `string`, more efficient than the generic type

This is a specialized module for [`Belt.SortArray`](./Belt-SortArray.md), the docs in that module also applies here, except the comparator is fixed and inlined

```ocaml
type element = string
```
```reasonml
type element = string;
```
```ocaml
val strictlySortedLength : element array -> int
```
```reasonml
let strictlySortedLength: array(element) => int;
```
The same as [`Belt.SortArray.strictlySortedLength`](./Belt-SortArray.md#val-strictlySortedLength) except the comparator is fixed

returns \+n means increasing order -n means negative order
```ocaml
val isSorted : element array -> bool
```
```reasonml
let isSorted: array(element) => bool;
```
`sorted xs` return true if `xs` is in non strict increasing order

```ocaml
val stableSortInPlace : element array -> unit
```
```reasonml
let stableSortInPlace: array(element) => unit;
```
The same as [`Belt.SortArray.stableSortInPlaceBy`](./Belt-SortArray.md#val-stableSortInPlaceBy) except the comparator is fixed

```ocaml
val stableSort : element array -> element array
```
```reasonml
let stableSort: array(element) => array(element);
```
The same as [`Belt.SortArray.stableSortBy`](./Belt-SortArray.md#val-stableSortBy) except the comparator is fixed

```ocaml
val binarySearch : element array -> element -> int
```
```reasonml
let binarySearch: array(element) => element => int;
```
If value is not found and value is less than one or more elements in array, the negative number returned is the bitwise complement of the index of the first element that is larger than value.

If value is not found and value is greater than all elements in array, the negative number returned is the bitwise complement of (the index of the last element plus 1\)

for example, if `key` is smaller than all elements return `-1` since `lnot (-1) = 0` if `key` is larger than all elements return `- (len + 1)` since `lnot (-(len+1)) = len`
