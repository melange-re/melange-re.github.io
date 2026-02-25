
# Module `Stdlib.Iarray`

Operations on immutable arrays. This module mirrors the API of `Array`, but omits functions that assume mutability; in addition to obviously mutating functions, it omits `copy` along with the functions `make`, `create_float`, and `make_matrix` that produce all-constant arrays. The exception is the sorting functions, which are given a copying API to replace the in-place one.

since 5\.4
```ocaml
type +'a t = 'a iarray
```
```reasonml
type t(+'a) = iarray('a);
```
An alias for the type of immutable arrays.

```ocaml
val length : 'a iarray -> int
```
```reasonml
let length: iarray('a) => int;
```
Return the length (number of elements) of the given immutable array.

```ocaml
val get : 'a iarray -> int -> 'a
```
```reasonml
let get: iarray('a) => int => 'a;
```
`get a n` returns the element number `n` of immutable array `a`. The first element has number 0\. The last element has number `length a - 1`.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if n is outside the range 0 to (length a - 1).
```ocaml
val init : int -> (int -> 'a) -> 'a iarray
```
```reasonml
let init: int => (int => 'a) => iarray('a);
```
`init n f` returns a fresh immutable array of length `n`, with element number `i` initialized to the result of `f i`. In other terms, `init n f` tabulates the results of `f` applied to the integers `0` to `n-1`.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if n \< 0 or n \> Sys.max\_array\_length. If the return type of f is float, then the maximum size is only Sys.max\_array\_length / 2.
```ocaml
val append : 'a iarray -> 'a iarray -> 'a iarray
```
```reasonml
let append: iarray('a) => iarray('a) => iarray('a);
```
`append v1 v2` returns a fresh immutable array containing the concatenation of the immutable arrays `v1` and `v2`.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if length v1 + length v2 \> Sys.max\_array\_length.
```ocaml
val concat : 'a iarray list -> 'a iarray
```
```reasonml
let concat: list(iarray('a)) => iarray('a);
```
Same as [`append`](./#val-append), but concatenates a list of immutable arrays.

```ocaml
val sub : 'a iarray -> pos:int -> len:int -> 'a iarray
```
```reasonml
let sub: iarray('a) => pos:int => len:int => iarray('a);
```
`sub a ~pos ~len` returns a fresh immutable array of length `len`, containing the elements number `pos` to `pos + len - 1` of immutable array `a`. This creates a copy of the selected portion of the immutable array.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if pos and len do not designate a valid subarray of a; that is, if pos \< 0, or len \< 0, or pos + len \> length a.
```ocaml
val to_list : 'a iarray -> 'a list
```
```reasonml
let to_list: iarray('a) => list('a);
```
`to_list a` returns the list of all the elements of `a`.

```ocaml
val of_list : 'a list -> 'a iarray
```
```reasonml
let of_list: list('a) => iarray('a);
```
`of_list l` returns a fresh immutable array containing the elements of `l`.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if the length of l is greater than Sys.max\_array\_length.

## Converting to and from mutable arrays

```ocaml
val to_array : 'a iarray -> 'a array
```
```reasonml
let to_array: iarray('a) => array('a);
```
`to_array a` returns a mutable copy of the immutable array `a`; that is, a fresh (mutable) array containing the same elements as `a`

```ocaml
val of_array : 'a array -> 'a iarray
```
```reasonml
let of_array: array('a) => iarray('a);
```
`of_array ma` returns an immutable copy of the mutable array `ma`; that is, a fresh immutable array containing the same elements as `ma`


## Comparison

```ocaml
val equal : ('a -> 'a -> bool) -> 'a iarray -> 'a iarray -> bool
```
```reasonml
let equal: ('a => 'a => bool) => iarray('a) => iarray('a) => bool;
```
`eq [|a1; ...; an|] [|b1; ..; bm|]` holds when the two input immutable arrays have the same length, and for each pair of elements `ai, bi` at the same position we have `eq ai bi`.

```ocaml
val compare : ('a -> 'a -> int) -> 'a iarray -> 'a iarray -> int
```
```reasonml
let compare: ('a => 'a => int) => iarray('a) => iarray('a) => int;
```
Provided the function `cmp` defines a preorder on elements, `compare cmp a b` compares first `a` and `b` by their length, and then, if equal, by their elements according to the lexicographic preorder.

For more details on comparison functions, see [`Iarray.sort`](./#val-sort).


## Iterators

```ocaml
val iter : ('a -> unit) -> 'a iarray -> unit
```
```reasonml
let iter: ('a => unit) => iarray('a) => unit;
```
`iter f a` applies function `f` in turn to all the elements of `a`. It is equivalent to `f (get a 0); f (get a 1); ...; f (get a (length a - 1)); ()`.

```ocaml
val iteri : (int -> 'a -> unit) -> 'a iarray -> unit
```
```reasonml
let iteri: (int => 'a => unit) => iarray('a) => unit;
```
Same as [`iter`](./#val-iter), but the function is applied to the index of the element as first argument, and the element itself as second argument.

```ocaml
val map : ('a -> 'b) -> 'a iarray -> 'b iarray
```
```reasonml
let map: ('a => 'b) => iarray('a) => iarray('b);
```
`map f a` applies function `f` to all the elements of `a`, and builds an immutable array with the results returned by `f`: `[| f (get a 0); f (get a 1); ...; f (get a (length a - 1)) |]`.

```ocaml
val mapi : (int -> 'a -> 'b) -> 'a iarray -> 'b iarray
```
```reasonml
let mapi: (int => 'a => 'b) => iarray('a) => iarray('b);
```
Same as [`map`](./#val-map), but the function is applied to the index of the element as first argument, and the element itself as second argument.

```ocaml
val fold_left : ('a -> 'b -> 'a) -> 'a -> 'b iarray -> 'a
```
```reasonml
let fold_left: ('a => 'b => 'a) => 'a => iarray('b) => 'a;
```
`fold_left f init a` computes `f (... (f (f init (get a 0)) (get a 1)) ...) (get a n-1)`, where `n` is the length of the immutable array `a`.

```ocaml
val fold_left_map : ('a -> 'b -> 'a * 'c) -> 'a -> 'b iarray -> 'a * 'c iarray
```
```reasonml
let fold_left_map: 
  ('a => 'b => ('a, 'c)) =>
  'a =>
  iarray('b) =>
  ('a, iarray('c));
```
`fold_left_map` is a combination of [`fold_left`](./#val-fold_left) and [`map`](./#val-map) that threads an accumulator through calls to `f`.

```ocaml
val fold_right : ('b -> 'a -> 'a) -> 'b iarray -> 'a -> 'a
```
```reasonml
let fold_right: ('b => 'a => 'a) => iarray('b) => 'a => 'a;
```
`fold_right f a init` computes `f (get a 0) (f (get a 1) ( ... (f (get a (n-1)) init) ...))`, where `n` is the length of the immutable array `a`.


## Iterators on two arrays

```ocaml
val iter2 : ('a -> 'b -> unit) -> 'a iarray -> 'b iarray -> unit
```
```reasonml
let iter2: ('a => 'b => unit) => iarray('a) => iarray('b) => unit;
```
`iter2 f a b` applies function `f` to all the elements of `a` and `b`.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if the immutable arrays are not the same size.
```ocaml
val map2 : ('a -> 'b -> 'c) -> 'a iarray -> 'b iarray -> 'c iarray
```
```reasonml
let map2: ('a => 'b => 'c) => iarray('a) => iarray('b) => iarray('c);
```
`map2 f a b` applies function `f` to all the elements of `a` and `b`, and builds an immutable array with the results returned by `f`: `[| f (get a 0) (get b 0); ...; f (get a (length a - 1)) (get b (length b - 1))|]`.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if the immutable arrays are not the same size.

## Array scanning

```ocaml
val for_all : ('a -> bool) -> 'a iarray -> bool
```
```reasonml
let for_all: ('a => bool) => iarray('a) => bool;
```
`for_all f [|a1; ...; an|]` checks if all elements of the immutable array satisfy the predicate `f`. That is, it returns `(f a1) && (f a2) && ... && (f an)`.

```ocaml
val exists : ('a -> bool) -> 'a iarray -> bool
```
```reasonml
let exists: ('a => bool) => iarray('a) => bool;
```
`exists f [|a1; ...; an|]` checks if at least one element of the immutable array satisfies the predicate `f`. That is, it returns `(f a1) || (f a2) || ... || (f an)`.

```ocaml
val for_all2 : ('a -> 'b -> bool) -> 'a iarray -> 'b iarray -> bool
```
```reasonml
let for_all2: ('a => 'b => bool) => iarray('a) => iarray('b) => bool;
```
Same as [`for_all`](./#val-for_all), but for a two-argument predicate.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if the two immutable arrays have different lengths.
```ocaml
val exists2 : ('a -> 'b -> bool) -> 'a iarray -> 'b iarray -> bool
```
```reasonml
let exists2: ('a => 'b => bool) => iarray('a) => iarray('b) => bool;
```
Same as [`exists`](./#val-exists), but for a two-argument predicate.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if the two immutable arrays have different lengths.
```ocaml
val mem : 'a -> 'a iarray -> bool
```
```reasonml
let mem: 'a => iarray('a) => bool;
```
`mem a set` is true if and only if `a` is structurally equal to an element of `l` (i.e. there is an `x` in `l` such that `compare a x = 0`).

```ocaml
val memq : 'a -> 'a iarray -> bool
```
```reasonml
let memq: 'a => iarray('a) => bool;
```
Same as [`mem`](./#val-mem), but uses physical equality instead of structural equality to compare array elements.

```ocaml
val find_opt : ('a -> bool) -> 'a iarray -> 'a option
```
```reasonml
let find_opt: ('a => bool) => iarray('a) => option('a);
```
`find_opt f a` returns the first element of the immutable array `a` that satisfies the predicate `f`, or `None` if there is no value that satisfies `f` in the array `a`.

```ocaml
val find_index : ('a -> bool) -> 'a iarray -> int option
```
```reasonml
let find_index: ('a => bool) => iarray('a) => option(int);
```
`find_index f a` returns `Some i`, where `i` is the index of the first element of the array `a` that satisfies `f x`, if there is such an element.

It returns `None` if there is no such element.

```ocaml
val find_map : ('a -> 'b option) -> 'a iarray -> 'b option
```
```reasonml
let find_map: ('a => option('b)) => iarray('a) => option('b);
```
`find_map f a` applies `f` to the elements of `a` in order, and returns the first result of the form `Some v`, or `None` if none exist.

```ocaml
val find_mapi : (int -> 'a -> 'b option) -> 'a iarray -> 'b option
```
```reasonml
let find_mapi: (int => 'a => option('b)) => iarray('a) => option('b);
```
Same as `find_map`, but the predicate is applied to the index of the element as first argument (counting from 0\), and the element itself as second argument.


## Arrays of pairs

```ocaml
val split : ('a * 'b) iarray -> 'a iarray * 'b iarray
```
```reasonml
let split: iarray(('a, 'b)) => (iarray('a), iarray('b));
```
`split [|(a1,b1); ...; (an,bn)|]` is `([|a1; ...; an|], [|b1; ...; bn|])`.

```ocaml
val combine : 'a iarray -> 'b iarray -> ('a * 'b) iarray
```
```reasonml
let combine: iarray('a) => iarray('b) => iarray(('a, 'b));
```
`combine [|a1; ...; an|] [|b1; ...; bn|]` is `[|(a1,b1); ...; (an,bn)|]`. Raise `Invalid_argument` if the two immutable arrays have different lengths.


## Sorting

```ocaml
val sort : ('a -> 'a -> int) -> 'a iarray -> 'a iarray
```
```reasonml
let sort: ('a => 'a => int) => iarray('a) => iarray('a);
```
Sort an immutable array in increasing order according to a comparison function. The comparison function must return 0 if its arguments compare as equal, a positive integer if the first is greater, and a negative integer if the first is smaller (see below for a complete specification). For example, [`Stdlib.compare`](./Stdlib.md#val-compare) is a suitable comparison function. The result of calling `sort` is a fresh immutable array containing the same elements as the original sorted in increasing order. Other than this fresh array, `sort` is guaranteed to run in constant heap space and (at most) logarithmic stack space.

The current implementation uses Heap Sort. It runs in constant stack space.

Specification of the comparison function: Let `a` be the immutable array and `cmp` the comparison function. The following must be true for all `x`, `y`, `z` in `a` :

- `cmp x y` \> 0 if and only if `cmp y x` \< 0
- if `cmp x y` \>= 0 and `cmp y z` \>= 0 then `cmp x z` \>= 0
The result of `sort`, which we'll call `a'`, contains the same elements as `a`, reordered in such a way that for all i and j valid indices of `a` (or equivalently, of `a'`):

- `cmp (get a' i) (get a' j)` \>= 0 if and only if i \>= j
```ocaml
val stable_sort : ('a -> 'a -> int) -> 'a iarray -> 'a iarray
```
```reasonml
let stable_sort: ('a => 'a => int) => iarray('a) => iarray('a);
```
Same as [`sort`](./#val-sort), but the sorting algorithm is stable (i.e. elements that compare equal are kept in their original order) and not guaranteed to run in constant heap space.

The current implementation uses Merge Sort. It uses a temporary array of length `n/2`, where `n` is the length of the immutable array. It is usually faster than the current implementation of [`sort`](./#val-sort).

```ocaml
val fast_sort : ('a -> 'a -> int) -> 'a iarray -> 'a iarray
```
```reasonml
let fast_sort: ('a => 'a => int) => iarray('a) => iarray('a);
```
Same as [`sort`](./#val-sort) or [`stable_sort`](./#val-stable_sort), whichever is faster on typical input.


## Iterators

```ocaml
val to_seq : 'a iarray -> 'a Seq.t
```
```reasonml
let to_seq: iarray('a) => Seq.t('a);
```
Iterate on the immutable array, in increasing order.

```ocaml
val to_seqi : 'a iarray -> (int * 'a) Seq.t
```
```reasonml
let to_seqi: iarray('a) => Seq.t((int, 'a));
```
Iterate on the immutable array, in increasing order, yielding indices along elements.

```ocaml
val of_seq : 'a Seq.t -> 'a iarray
```
```reasonml
let of_seq: Seq.t('a) => iarray('a);
```
Create an immutable array from the generator
