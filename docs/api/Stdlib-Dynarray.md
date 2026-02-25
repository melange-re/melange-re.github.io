
# Module `Stdlib.Dynarray`

Dynamic arrays.

The [`Array`](./Stdlib-Array.md) module provide arrays of fixed length. [`Dynarray`](#) provides arrays whose length can change over time, by adding or removing elements at the end of the array.

This is typically used to accumulate elements whose number is not known in advance or changes during computation, while also providing fast access to elements at arbitrary indices.

```ocaml
    let dynarray_of_list li =
      let arr = Dynarray.create () in
      List.iter (fun v -> Dynarray.add_last arr v) li;
      arr
```
```reasonml
let dynarray_of_list = li => {
  let arr = Dynarray.create();
  List.iter(v => Dynarray.add_last(arr, v), li);
  arr;
};
```
The [`Buffer`](./Stdlib-Buffer.md) module provides similar features, but it is specialized for accumulating characters into a dynamically-resized string.

The [`Stack`](./Stdlib-Stack.md) module provides a last-in first-out data structure that can be easily implemented on top of dynamic arrays.

since 5\.2
**Unsynchronized accesses**

Concurrent accesses to dynamic arrays must be synchronized (for instance with a [`Mutex.t`](./Stdlib-Mutex.md#type-t)). Unsynchronized accesses to a dynamic array are a programming error that may lead to an invalid dynamic array state, on which some operations would fail with an `Invalid_argument` exception.


## Dynamic arrays

```ocaml
type !'a t
```
```reasonml
type t(!'a);
```
A dynamic array containing values of type `'a`.

A dynamic array `a` provides constant-time `get` and `set` operations on indices between `0` and `Dynarray.length a - 1` included. Its [`length`](./#val-length) may change over time by adding or removing elements to the end of the array.

We say that an index into a dynarray `a` is valid if it is in `0 .. length a - 1` and invalid otherwise.

```ocaml
val create : unit -> 'a t
```
```reasonml
let create: unit => t('a);
```
`create ()` is a new, empty array.

```ocaml
val make : int -> 'a -> 'a t
```
```reasonml
let make: int => 'a => t('a);
```
`make n x` is a new array of length `n`, filled with `x`.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if n \< 0 or n \> Sys.max\_array\_length.
```ocaml
val init : int -> (int -> 'a) -> 'a t
```
```reasonml
let init: int => (int => 'a) => t('a);
```
`init n f` is a new array `a` of length `n`, such that `get a i` is `f i`. In other words, the elements of `a` are `f 0`, then `f 1`, then `f 2`... and `f (n - 1)` last, evaluated in that order.

This is similar to [`Array.init`](./Stdlib-Array.md#val-init).

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if n \< 0 or n \> Sys.max\_array\_length.
```ocaml
val get : 'a t -> int -> 'a
```
```reasonml
let get: t('a) => int => 'a;
```
`get a i` is the `i`\-th element of `a`, starting with index `0`.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if the index is invalid
```ocaml
val set : 'a t -> int -> 'a -> unit
```
```reasonml
let set: t('a) => int => 'a => unit;
```
`set a i x` sets the `i`\-th element of `a` to be `x`.

`i` must be a valid index. `set` does not add new elements to the array \-- see [`add_last`](./#val-add_last) to add an element.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if the index is invalid.
```ocaml
val length : 'a t -> int
```
```reasonml
let length: t('a) => int;
```
`length a` is the number of elements in the array.

```ocaml
val is_empty : 'a t -> bool
```
```reasonml
let is_empty: t('a) => bool;
```
`is_empty a` is `true` if `a` is empty, that is, if `length a = 0`.

```ocaml
val get_last : 'a t -> 'a
```
```reasonml
let get_last: t('a) => 'a;
```
`get_last a` is the element of `a` at index `length a - 1`.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if a is empty.
```ocaml
val find_last : 'a t -> 'a option
```
```reasonml
let find_last: t('a) => option('a);
```
`find_last a` is `None` if `a` is empty and `Some (get_last a)` otherwise.

```ocaml
val copy : 'a t -> 'a t
```
```reasonml
let copy: t('a) => t('a);
```
`copy a` is a shallow copy of `a`, a new array containing the same elements as `a`.


## Adding elements

Note: all operations adding elements raise `Invalid_argument` if the length needs to grow beyond [`Sys.max_array_length`](./Stdlib-Sys.md#val-max_array_length).

```ocaml
val add_last : 'a t -> 'a -> unit
```
```reasonml
let add_last: t('a) => 'a => unit;
```
`add_last a x` adds the element `x` at the end of the array `a`.

```ocaml
val append_array : 'a t -> 'a array -> unit
```
```reasonml
let append_array: t('a) => array('a) => unit;
```
`append_array a b` adds all elements of `b` at the end of `a`, in the order they appear in `b`.

For example:

```ocaml
  let a = Dynarray.of_list [1;2] in
  Dynarray.append_array a [|3; 4|];
  assert (Dynarray.to_list a = [1; 2; 3; 4])
```
```reasonml
{
  let a = Dynarray.of_list([1, 2]);
  Dynarray.append_array(a, [|3, 4|]);
  assert(Dynarray.to_list(a) == [1, 2, 3, 4]);
};
```
```ocaml
val append_list : 'a t -> 'a list -> unit
```
```reasonml
let append_list: t('a) => list('a) => unit;
```
Like [`append_array`](./#val-append_array) but with a list.

```ocaml
val append : 'a t -> 'a t -> unit
```
```reasonml
let append: t('a) => t('a) => unit;
```
`append a b` is like `append_array a b`, but `b` is itself a dynamic array instead of a fixed-size array.

Warning: `append a a` is a programming error because it iterates on `a` and adds elements to it at the same time \-- see the [Iteration](./#iteration) section below. It fails with `Invalid_argument`. If you really want to append a copy of `a` to itself, you can use `Dynarray.append_array a (Dynarray.to_array a)` which copies `a` into a temporary array.

```ocaml
val append_seq : 'a t -> 'a Seq.t -> unit
```
```reasonml
let append_seq: t('a) => Seq.t('a) => unit;
```
Like [`append_array`](./#val-append_array) but with a sequence.

Warning: `append_seq a (to_seq_reentrant a)` simultaneously traverses `a` and adds element to it; the ordering of those operations is unspecified, and may result in an infinite loop \-- the new elements may in turn be produced by `to_seq_reentrant a` and get added again and again.

```ocaml
val append_iter : 'a t -> (('a -> unit) -> 'x -> unit) -> 'x -> unit
```
```reasonml
let append_iter: t('a) => (('a => unit) => 'x => unit) => 'x => unit;
```
`append_iter a iter x` adds each element of `x` to the end of `a`. This is `iter (add_last a) x`.

For example, `append_iter a List.iter [1;2;3]` would add elements `1`, `2`, and then `3` at the end of `a`. `append_iter a Queue.iter q` adds elements from the queue `q`.

```ocaml
val blit : 
  src:'a t ->
  src_pos:int ->
  dst:'a t ->
  dst_pos:int ->
  len:int ->
  unit
```
```reasonml
let blit: 
  src:t('a) =>
  src_pos:int =>
  dst:t('a) =>
  dst_pos:int =>
  len:int =>
  unit;
```
`blit ~src ~src_pos ~dst ~dst_pos ~len` copies `len` elements from a source dynarray `src`, starting at index `src_pos`, to a destination dynarray `dst`, starting at index `dst_pos`. It works correctly even if `src` and `dst` are the same array, and the source and destination chunks overlap.

Unlike [`Array.blit`](./Stdlib-Array.md#val-blit), [`Dynarray.blit`](./#val-blit) can extend the destination array with new elements: it is valid to call `blit` even when `dst_pos + len` is larger than `length dst`. The only requirement is that `dst_pos` must be at most `length dst` (included), so that there is no gap between the current elements and the blit region.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if src\_pos and len do not designate a valid subarray of src, or if dst\_pos is strictly below 0 or strictly above length dst.

## Removing elements

```ocaml
val pop_last_opt : 'a t -> 'a option
```
```reasonml
let pop_last_opt: t('a) => option('a);
```
`pop_last_opt a` removes and returns the last element of `a`, or `None` if the array is empty.

```ocaml
val pop_last : 'a t -> 'a
```
```reasonml
let pop_last: t('a) => 'a;
```
`pop_last a` removes and returns the last element of `a`.

raises [`Not_found`](./Stdlib.md#exception-Not_found) on an empty array.
```ocaml
val remove_last : 'a t -> unit
```
```reasonml
let remove_last: t('a) => unit;
```
`remove_last a` removes the last element of `a`, if any. It does nothing if `a` is empty.

```ocaml
val truncate : 'a t -> int -> unit
```
```reasonml
let truncate: t('a) => int => unit;
```
`truncate a n` truncates `a` to have at most `n` elements.

It removes elements whose index is greater or equal to `n`. It does nothing if `n >= length a`.

`truncate a n` is equivalent to:

```ocaml
  if n < 0 then invalid_argument "...";
  while length a > n do
    remove_last a
  done
```
```reasonml
{
  if (n < 0) {
    invalid_argument("...");
  };
  while (length(a) > n) {
    remove_last(a);
  };
};
```
raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if n \< 0.
```ocaml
val clear : 'a t -> unit
```
```reasonml
let clear: t('a) => unit;
```
`clear a` is `truncate a 0`, it removes all the elements of `a`.


## Iteration

The iteration functions traverse the elements of a dynamic array. Traversals of `a` are computed in increasing index order: from the element of index `0` to the element of index `length a - 1`.

It is a programming error to change the length of an array (by adding or removing elements) during an iteration on the array. Any iteration function will fail with `Invalid_argument` if it detects such a length change.

```ocaml
val iter : ('a -> unit) -> 'a t -> unit
```
```reasonml
let iter: ('a => unit) => t('a) => unit;
```
`iter f a` calls `f` on each element of `a`.

```ocaml
val iteri : (int -> 'a -> unit) -> 'a t -> unit
```
```reasonml
let iteri: (int => 'a => unit) => t('a) => unit;
```
`iteri f a` calls `f i x` for each `x` at index `i` in `a`.

```ocaml
val map : ('a -> 'b) -> 'a t -> 'b t
```
```reasonml
let map: ('a => 'b) => t('a) => t('b);
```
`map f a` is a new array of elements of the form `f x` for each element `x` of `a`.

For example, if the elements of `a` are `x0`, `x1`, `x2`, then the elements of `b` are `f x0`, `f x1`, `f x2`.

```ocaml
val mapi : (int -> 'a -> 'b) -> 'a t -> 'b t
```
```reasonml
let mapi: (int => 'a => 'b) => t('a) => t('b);
```
`mapi f a` is a new array of elements of the form `f i x` for each element `x` of `a` at index `i`.

For example, if the elements of `a` are `x0`, `x1`, `x2`, then the elements of `b` are `f 0 x0`, `f 1 x1`, `f 2 x2`.

```ocaml
val fold_left : ('acc -> 'a -> 'acc) -> 'acc -> 'a t -> 'acc
```
```reasonml
let fold_left: ('acc => 'a => 'acc) => 'acc => t('a) => 'acc;
```
`fold_left f acc a` folds `f` over `a` in order, starting with accumulator `acc`.

For example, if the elements of `a` are `x0`, `x1`, then `fold f acc a` is

```ocaml
  let acc = f acc x0 in
  let acc = f acc x1 in
  acc
```
```reasonml
{
  let acc = f(acc, x0);
  let acc = f(acc, x1);
  acc;
};
```
```ocaml
val fold_right : ('a -> 'acc -> 'acc) -> 'a t -> 'acc -> 'acc
```
```reasonml
let fold_right: ('a => 'acc => 'acc) => t('a) => 'acc => 'acc;
```
`fold_right f a acc` computes `f x0 (f x1 (... (f xn acc) ...))` where `x0`, `x1`, ..., `xn` are the elements of `a`.

```ocaml
val filter : ('a -> bool) -> 'a t -> 'a t
```
```reasonml
let filter: ('a => bool) => t('a) => t('a);
```
`filter f a` is a new array of all the elements of `a` that satisfy `f`. In other words, it is an array `b` such that, for each element `x` in `a` in order, `x` is added to `b` if `f x` is `true`.

For example, `filter (fun x -> x >= 0) a` is a new array of all non-negative elements of `a`, in order.

```ocaml
val filter_map : ('a -> 'b option) -> 'a t -> 'b t
```
```reasonml
let filter_map: ('a => option('b)) => t('a) => t('b);
```
`filter_map f a` is a new array of elements `y` such that `f x` is `Some y` for an element `x` of `a`. In others words, it is an array `b` such that, for each element `x` of `a` in order:

- if `f x = Some y`, then `y` is added to `b`,
- if `f x = None`, then no element is added to `b`.
For example, `filter_map int_of_string_opt inputs` returns a new array of integers read from the strings in `inputs`, ignoring strings that cannot be converted to integers.


## Dynarray scanning

```ocaml
val exists : ('a -> bool) -> 'a t -> bool
```
```reasonml
let exists: ('a => bool) => t('a) => bool;
```
`exists f a` is `true` if some element of `a` satisfies `f`.

For example, if the elements of `a` are `x0`, `x1`, `x2`, then `exists f a` is `f x0 || f x1 || f x2`.

```ocaml
val for_all : ('a -> bool) -> 'a t -> bool
```
```reasonml
let for_all: ('a => bool) => t('a) => bool;
```
`for_all f a` is `true` if all elements of `a` satisfy `f`. This includes the case where `a` is empty.

For example, if the elements of `a` are `x0`, `x1`, `x2`, then `for_all f a` is `f x0 && f x1 && f x2`.

```ocaml
val exists2 : ('a -> 'b -> bool) -> 'a t -> 'b t -> bool
```
```reasonml
let exists2: ('a => 'b => bool) => t('a) => t('b) => bool;
```
Same as [`exists`](./#val-exists), but for a two-argument predicate.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if the two arrays have different lengths.
since 5\.4
```ocaml
val for_all2 : ('a -> 'b -> bool) -> 'a t -> 'b t -> bool
```
```reasonml
let for_all2: ('a => 'b => bool) => t('a) => t('b) => bool;
```
Same as [`for_all`](./#val-for_all), but for a two-argument predicate.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if the two arrays have different lengths.
since 5\.4
```ocaml
val mem : 'a -> 'a t -> bool
```
```reasonml
let mem: 'a => t('a) => bool;
```
`mem a set` is true if and only if `a` is structurally equal to an element of `set` (i.e. there is an `x` in `set` such that `compare a x = 0`).

since 5\.3
```ocaml
val memq : 'a -> 'a t -> bool
```
```reasonml
let memq: 'a => t('a) => bool;
```
Same as [`mem`](./#val-mem), but uses physical equality instead of structural equality to compare array elements.

since 5\.3
```ocaml
val find_opt : ('a -> bool) -> 'a t -> 'a option
```
```reasonml
let find_opt: ('a => bool) => t('a) => option('a);
```
`find_opt f a` returns the first element of the array `a` that satisfies the predicate `f`, or `None` if there is no value that satisfies `f` in the array `a`.

since 5\.3
```ocaml
val find_index : ('a -> bool) -> 'a t -> int option
```
```reasonml
let find_index: ('a => bool) => t('a) => option(int);
```
`find_index f a` returns `Some i`, where `i` is the index of the first element of the array `a` that satisfies `f x`, if there is such an element.

It returns `None` if there is no such element.

since 5\.3
```ocaml
val find_map : ('a -> 'b option) -> 'a t -> 'b option
```
```reasonml
let find_map: ('a => option('b)) => t('a) => option('b);
```
`find_map f a` applies `f` to the elements of `a` in order, and returns the first result of the form `Some v`, or `None` if none exist.

since 5\.3
```ocaml
val find_mapi : (int -> 'a -> 'b option) -> 'a t -> 'b option
```
```reasonml
let find_mapi: (int => 'a => option('b)) => t('a) => option('b);
```
Same as `find_map`, but the predicate is applied to the index of the element as first argument (counting from 0\), and the element itself as second argument.

since 5\.3

## Comparison functions

Comparison functions iterate over their arguments; it is a programming error to change their length during the iteration, see the [Iteration](./#iteration) section above.

```ocaml
val equal : ('a -> 'a -> bool) -> 'a t -> 'a t -> bool
```
```reasonml
let equal: ('a => 'a => bool) => t('a) => t('a) => bool;
```
`equal eq a b` holds when `a` and `b` have the same length, and for all indices `i` we have `eq (get a i) (get b i)`.

since 5\.3
```ocaml
val compare : ('a -> 'a -> int) -> 'a t -> 'a t -> int
```
```reasonml
let compare: ('a => 'a => int) => t('a) => t('a) => int;
```
`compare cmp a b` compares `a` and `b` according to the shortlex order, that is, shorter arrays are smaller and equal-sized arrays are compared in lexicographic order using `cmp` to compare elements.

For more details on comparison functions, see [`Array.sort`](./Stdlib-Array.md#val-sort).

since 5\.3

## Conversions to other data structures

Note: the `of_*` functions raise `Invalid_argument` if the length needs to grow beyond [`Sys.max_array_length`](./Stdlib-Sys.md#val-max_array_length).

The `to_*` functions, except those specifically marked "reentrant", iterate on their dynarray argument. In particular it is a programming error if the length of the dynarray changes during their execution, and the conversion functions raise `Invalid_argument` if they observe such a change.

```ocaml
val of_array : 'a array -> 'a t
```
```reasonml
let of_array: array('a) => t('a);
```
`of_array arr` returns a dynamic array corresponding to the fixed-sized array `a`. Operates in `O(n)` time by making a copy.

```ocaml
val to_array : 'a t -> 'a array
```
```reasonml
let to_array: t('a) => array('a);
```
`to_array a` returns a fixed-sized array corresponding to the dynamic array `a`. This always allocate a new array and copies elements into it.

```ocaml
val of_list : 'a list -> 'a t
```
```reasonml
let of_list: list('a) => t('a);
```
`of_list l` is the array containing the elements of `l` in the same order.

```ocaml
val to_list : 'a t -> 'a list
```
```reasonml
let to_list: t('a) => list('a);
```
`to_list a` is a list with the elements contained in the array `a`.

```ocaml
val of_seq : 'a Seq.t -> 'a t
```
```reasonml
let of_seq: Seq.t('a) => t('a);
```
`of_seq seq` is an array containing the same elements as `seq`.

It traverses `seq` once and will terminate only if `seq` is finite.

```ocaml
val to_seq : 'a t -> 'a Seq.t
```
```reasonml
let to_seq: t('a) => Seq.t('a);
```
`to_seq a` is the sequence of elements `get a 0`, `get a 1`... `get a (length a - 1)`.

```ocaml
val to_seq_reentrant : 'a t -> 'a Seq.t
```
```reasonml
let to_seq_reentrant: t('a) => Seq.t('a);
```
`to_seq_reentrant a` is a reentrant variant of [`to_seq`](./#val-to_seq), in the sense that one may still access its elements after the length of `a` has changed.

Demanding the `i`\-th element of the resulting sequence (which can happen zero, one or several times) will access the `i`\-th element of `a` at the time of the demand. The sequence stops if `a` has less than `i` elements at this point.

```ocaml
val to_seq_rev : 'a t -> 'a Seq.t
```
```reasonml
let to_seq_rev: t('a) => Seq.t('a);
```
`to_seq_rev a` is the sequence of elements `get a (l - 1)`, `get a (l - 2)`... `get a 0`, where `l` is `length a` at the time `to_seq_rev` is invoked.

```ocaml
val to_seq_rev_reentrant : 'a t -> 'a Seq.t
```
```reasonml
let to_seq_rev_reentrant: t('a) => Seq.t('a);
```
`to_seq_rev_reentrant a` is a reentrant variant of [`to_seq_rev`](./#val-to_seq_rev), in the sense that one may still access its elements after the length of `a` has changed.

Elements that have been removed from the array by the time they are demanded in the sequence are skipped.


## Advanced topics for performance


### Backing array, capacity

Internally, a dynamic array uses a **backing array** (a fixed-size array as provided by the [`Array`](./Stdlib-Array.md) module) whose length is greater or equal to the length of the dynamic array. We define the **capacity** of a dynamic array as the length of its backing array.

The capacity of a dynamic array is relevant in advanced scenarios, when reasoning about the performance of dynamic array programs:

- The memory usage of a dynamic array is proportional to its capacity, rather than its length.
- When there is no empty space left at the end of the backing array, adding elements requires allocating a new, larger backing array.
The implementation uses a standard exponential reallocation strategy which guarantees amortized constant-time operation; in particular, the total capacity of all backing arrays allocated over the lifetime of a dynamic array is at worst proportional to the total number of elements added.

In other words, users need not care about capacity and reallocations, and they will get reasonable behavior by default. However, in some performance-sensitive scenarios the functions below can help control memory usage or guarantee an optimal number of reallocations.

```ocaml
val capacity : 'a t -> int
```
```reasonml
let capacity: t('a) => int;
```
`capacity a` is the length of `a`'s backing array.

```ocaml
val ensure_capacity : 'a t -> int -> unit
```
```reasonml
let ensure_capacity: t('a) => int => unit;
```
`ensure_capacity a n` makes sure that the capacity of `a` is at least `n`.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if the requested capacity is outside the range 0 .. Sys.max\_array\_length.
An example would be to reimplement [`of_array`](./#val-of_array) without using [`init`](./#val-init):

```ocaml
let of_array arr =
  let a = Dynarray.create () in
  Dynarray.ensure_capacity a (Array.length arr);
  Array.iter (fun v -> add_last a v) arr
```
```reasonml
let of_array = arr => {
  let a = Dynarray.create();
  Dynarray.ensure_capacity(a, Array.length(arr));
  Array.iter(v => add_last(a, v), arr);
};
```
Using `ensure_capacity` guarantees that at most one reallocation will take place, instead of possibly several.

Without this `ensure_capacity` hint, the number of resizes would be logarithmic in the length of `arr`, creating a constant-factor slowdown noticeable when `arr` is large.

```ocaml
val ensure_extra_capacity : 'a t -> int -> unit
```
```reasonml
let ensure_extra_capacity: t('a) => int => unit;
```
`ensure_extra_capacity a n` is `ensure_capacity a (length a + n)`, it makes sure that `a` has room for `n` extra items.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if the total requested capacity is outside the range 0 .. Sys.max\_array\_length.
A use case would be to implement [`append_array`](./#val-append_array):

```ocaml
let append_array a arr =
  ensure_extra_capacity a (Array.length arr);
  Array.iter (fun v -> add_last a v) arr
```
```reasonml
let append_array = (a, arr) => {
  ensure_extra_capacity(a, Array.length(arr));
  Array.iter(v => add_last(a, v), arr);
};
```
```ocaml
val fit_capacity : 'a t -> unit
```
```reasonml
let fit_capacity: t('a) => unit;
```
`fit_capacity a` reallocates a backing array if necessary, so that the resulting capacity is exactly `length a`, with no additional empty space at the end. This can be useful to make sure there is no memory wasted on a long-lived array.

Note that calling `fit_capacity` breaks the amortized complexity guarantees provided by the default reallocation strategy. Calling it repeatedly on an array may have quadratic complexity, both in time and in total number of words allocated.

If you know that a dynamic array has reached its final length, which will remain fixed in the future, it is sufficient to call `to_array` and only keep the resulting fixed-size array. `fit_capacity` is useful when you need to keep a dynamic array for eventual future resizes.

```ocaml
val set_capacity : 'a t -> int -> unit
```
```reasonml
let set_capacity: t('a) => int => unit;
```
`set_capacity a n` reallocates a backing array if necessary, so that the resulting capacity is exactly `n`. In particular, all elements of index `n` or greater are removed.

Like [`fit_capacity`](./#val-fit_capacity), this function breaks the amortized complexity guarantees provided by the reallocation strategy. Calling it repeatedly on an array may have quadratic complexity, both in time and in total number of words allocated.

This is an advanced function; in particular, [`ensure_capacity`](./#val-ensure_capacity) should be preferred to increase the capacity, as it preserves those amortized guarantees.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if n \< 0.
```ocaml
val reset : 'a t -> unit
```
```reasonml
let reset: t('a) => unit;
```
`reset a` clears `a` and replaces its backing array by an empty array.

It is equivalent to `set_capacity a 0` or `clear a; fit_capacity a`.


### No leaks: preservation of memory liveness

The user-provided values reachable from a dynamic array `a` are exactly the elements in the indices `0` to `length a - 1`. In particular, no user-provided values are "leaked" by being present in the backing array at index `length a` or later.

```ocaml
val unsafe_to_iarray : capacity:int -> ('a t -> unit) -> 'a iarray
```
```reasonml
let unsafe_to_iarray: capacity:int => (t('a) => unit) => iarray('a);
```
`unsafe_to_iarray ~capacity f` calls `f` on a new empty dynarray with the given `capacity`, then turns it into an immutable array without a copy, when possible, that is, if two conditions hold:

- the array elements are not floats, and
- after `f` returned, the array's capacity is equal to its length.
Note that the `capacity` argument is only a hint. For example, nothing prevents from calling [`fit_capacity`](./#val-fit_capacity) at the end of `f`.

This function is unsafe because type safety may be broken by concurrent writes to the dynarray from other domains, without proper synchronization, before `f` returns.


## Code examples


### Min-heaps for mutable priority queues

We can use dynamic arrays to implement a mutable priority queue. A priority queue provides a function to add elements, and a function to extract the minimum element \-- according to some comparison function.

```ocaml
(* We present our priority queues as a functor
   parametrized on the comparison function. *)
module Heap (Elem : Map.OrderedType) : sig
  type t
  val create : unit -> t
  val add : t -> Elem.t -> unit
  val pop_min : t -> Elem.t option
end = struct

  (* Our priority queues are implemented using the standard "min heap"
     data structure, a dynamic array representing a binary tree. *)
  type t = Elem.t Dynarray.t
  let create = Dynarray.create

 (* The node of index [i] has as children the nodes of index [2 * i + 1]
    and [2 * i + 2] -- if they are valid indices in the dynarray. *)
  let left_child i = 2 * i + 1
  let right_child i = 2 * i + 2
  let parent_node i = (i - 1) / 2

  (* We use indexing operators for convenient notations. *)
  let ( .!() ) = Dynarray.get
  let ( .!()<- ) = Dynarray.set

  (* Auxiliary functions to compare and swap two elements
     in the dynamic array. *)
  let order h i j =
    Elem.compare h.!(i) h.!(j)

  let swap h i j =
    let v = h.!(i) in
    h.!(i) <- h.!(j);
    h.!(j) <- v

  (* We say that a heap respects the "heap ordering" if the value of
     each node is smaller than the value of its children. The
     algorithm manipulates arrays that respect the heap algorithm,
     except for one node whose value may be too small or too large.

     The auxiliary functions [heap_up] and [heap_down] take
     such a misplaced value, and move it "up" (respectively: "down")
     the tree by permuting it with its parent value (respectively:
     a child value) until the heap ordering is restored. *)

  let rec heap_up h i =
    if i = 0 then () else
    let parent = parent_node i in
    if order h i parent < 0 then
      (swap h i parent; heap_up h parent)

  and heap_down h ~len i =
    let left, right = left_child i, right_child i in
    if left >= len then () (* no child, stop *) else
    let smallest =
      if right >= len then left (* no right child *) else
      if order h left right < 0 then left else right
    in
    if order h i smallest > 0 then
      (swap h i smallest; heap_down h ~len smallest)

  let add h s =
    let i = Dynarray.length h in
    Dynarray.add_last h s;
    heap_up h i

  let pop_min h =
    if Dynarray.is_empty h then None
    else begin
      (* Standard trick: swap the 'best' value at index 0
         with the last value of the array. *)
      let last = Dynarray.length h - 1 in
      swap h 0 last;
      (* At this point [pop_last] returns the 'best' value,
         and leaves a heap with one misplaced element at index [0]. *)
      let best = Dynarray.pop_last h in
      (* Restore the heap ordering -- does nothing if the heap is empty. *)
      heap_down h ~len:last 0;
      Some best
    end
end
```
```reasonml
/* We present our priority queues as a functor
   parametrized on the comparison function. */
module Heap =
       (Elem: Map.OrderedType)
       : {
         type t;
         let create: unit => t;
         let add: (t, Elem.t) => unit;
         let pop_min: t => option(Elem.t);
       } => {
  /* Our priority queues are implemented using the standard "min heap"
     data structure, a dynamic array representing a binary tree. */
  type t = Dynarray.t(Elem.t);
  let create = Dynarray.create;

  /* The node of index [i] has as children the nodes of index [2 * i + 1]
     and [2 * i + 2] -- if they are valid indices in the dynarray. */
  let left_child = i => 2 * i + 1;
  let right_child = i => 2 * i + 2;
  let parent_node = i => (i - 1) / 2;

  /* We use indexing operators for convenient notations. */
  let .!() = Dynarray.get;
  let .!()<- = Dynarray.set;

  /* Auxiliary functions to compare and swap two elements
     in the dynamic array. */
  let order = (h, i, j) => Elem.compare(.!()(h, i), .!()(h, j));

  let swap = (h, i, j) => {
    let v = .!()(h, i);
    .!()<-(h, i, .!()(h, j));
    .!()<-(h, j, v);
  };

  /* We say that a heap respects the "heap ordering" if the value of
     each node is smaller than the value of its children. The
     algorithm manipulates arrays that respect the heap algorithm,
     except for one node whose value may be too small or too large.

     The auxiliary functions [heap_up] and [heap_down] take
     such a misplaced value, and move it "up" (respectively: "down")
     the tree by permuting it with its parent value (respectively:
     a child value) until the heap ordering is restored. */

  let rec heap_up = (h, i) =>
    if (i == 0) {
      ();
    } else {
      let parent = parent_node(i);
      if (order(h, i, parent) < 0) {
        swap(h, i, parent);
        heap_up(h, parent);
      };
    }

  and heap_down = (h, ~len, i) => {
    let (left, right) = (left_child(i), right_child(i));
    if (left >= len) {();} /* no child, stop */ else {
      let smallest =
        if (right >= len) {left;} /* no right child */ else if (order(
                                                                  h,
                                                                  left,
                                                                  right,
                                                                )
                                                                < 0) {
          left;
        } else {
          right;
        };

      if (order(h, i, smallest) > 0) {
        swap(h, i, smallest);
        heap_down(h, ~len, smallest);
      };
    };
  };

  let add = (h, s) => {
    let i = Dynarray.length(h);
    Dynarray.add_last(h, s);
    heap_up(h, i);
  };

  let pop_min = h =>
    if (Dynarray.is_empty(h)) {
      None;
    } else {
      /* Standard trick: swap the 'best' value at index 0
         with the last value of the array. */
      let last = Dynarray.length(h) - 1;
      swap(h, 0, last);
      /* At this point [pop_last] returns the 'best' value,
         and leaves a heap with one misplaced element at index [0]. */
      let best = Dynarray.pop_last(h);
      /* Restore the heap ordering -- does nothing if the heap is empty. */
      heap_down(h, ~len=last, 0);
      Some(best);
    };
};
```
The production code from which this example was inspired includes logic to free the backing array when the heap becomes empty, only in the case where the capacity is above a certain threshold. This can be done by calling the following function from `pop`:

```ocaml
let shrink h =
  if Dynarray.length h = 0 && Dynarray.capacity h > 1 lsl 18 then
    Dynarray.reset h
```
```reasonml
let shrink = h =>
  if (Dynarray.length(h) == 0 && Dynarray.capacity(h) > 1 lsl 18) {
    Dynarray.reset(h);
  };
```
The `Heap` functor can be used to implement a sorting function, by adding all elements into a priority queue and then extracting them in order.

```ocaml
let heap_sort (type a) cmp li =
  let module Heap = Heap(struct type t = a let compare = cmp end) in
  let heap = Heap.create () in
  List.iter (Heap.add heap) li;
  List.map (fun _ -> Heap.pop_min heap |> Option.get) li
```
```reasonml
let heap_sort = (type a, cmp, li) => {
  module Heap =
    Heap({
      type t = a;
      let compare = cmp;
    });
  let heap = Heap.create();
  List.iter(Heap.add(heap), li);
  List.map(_ => Heap.pop_min(heap) |> Option.get, li);
};
```