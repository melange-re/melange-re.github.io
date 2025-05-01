# Module `Belt.SortArray`
[`Belt.SortArray`](#)
The top level provides some generic sort related utilities.
It also has two specialized inner modules [`Belt.SortArray.Int`](./Belt-SortArray-Int.md) and [`Belt.SortArray.String`](./Belt-SortArray-String.md)
A module for Array sort relevant utiliites
```
module Int : sig ... end
```
Specalized when key type is `int`, more efficient than the generic type
```
module String : sig ... end
```
Specalized when key type is `string`, more efficient than the generic type
```
val strictlySortedLengthU : 'a array -> ('a -> 'a -> bool) Js.Fn.arity2 -> int
```
```
val strictlySortedLength : 'a array -> ('a -> 'a -> bool) -> int
```
`strictlySortedLenght xs cmp` return `+n` means increasing order `-n` means negative order
```ocaml
   strictlySortedLength [|1;2;3;4;3|] (fun x y -> x < y) = 4;;
   strictlySortedLength [||] (fun x y -> x < y) = 0;;
   strictlySortedLength [|1|] (fun x y -> x < y) = 1;;
   strictlySortedLength [|4;3;2;1|] (fun x y -> x < y) = -4;;
```
```
val isSortedU : 'a array -> ('a -> 'a -> int) Js.Fn.arity2 -> bool
```
```
val isSorted : 'a array -> ('a -> 'a -> int) -> bool
```
`isSorted arr cmp`
returns true if array is increasingly sorted (equal is okay ) isSorted \[\|1;1;2;3;4\|\] (fun x y -\> compare x y) = true
```
val stableSortInPlaceByU : 'a array -> ('a -> 'a -> int) Js.Fn.arity2 -> unit
```
```
val stableSortInPlaceBy : 'a array -> ('a -> 'a -> int) -> unit
```
`stableSortBy xs cmp`
Sort xs in place using comparator `cmp`, the stable means if the elements are equal, their order will be preserved
```
val stableSortByU : 'a array -> ('a -> 'a -> int) Js.Fn.arity2 -> 'a array
```
```
val stableSortBy : 'a array -> ('a -> 'a -> int) -> 'a array
```
`stableSort xs cmp`
returns a fresh array
The same as [`stableSortInPlaceBy`](./#val-stableSortInPlaceBy) except that `xs` is not modified
```
val binarySearchByU : 'a array -> 'a -> ('a -> 'a -> int) Js.Fn.arity2 -> int
```
```
val binarySearchBy : 'a array -> 'a -> ('a -> 'a -> int) -> int
```
If value is not found and value is less than one or more elements in array, the negative number returned is the bitwise complement of the index of the first element that is larger than value.
If value is not found and value is greater than all elements in array, the negative number returned is the bitwise complement of (the index of the last element plus 1\)
for example, if `key` is smaller than all elements return `-1` since `lnot (-1) = 0` if `key` is larger than all elements return `- (len + 1)` since `lnot (-(len+1)) = len`
```ocaml
  binarySearchBy [|1;2;3;4;33;35;36|] 33 = 4;;
  lnot (binarySearchBy [|1;3;5;7|] 4) = 2;;
```