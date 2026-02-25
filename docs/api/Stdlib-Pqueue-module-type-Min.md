
# Module type `Pqueue.Min`

Output signature of the functor [`MakeMin`](./Stdlib-Pqueue-MakeMin.md).


## Min-priority queues

```ocaml
type t
```
```reasonml
type t;
```
The type of priority queues.

```ocaml
type elt
```
```reasonml
type elt;
```
The type of priority queue elements.

```ocaml
val create : unit -> t
```
```reasonml
let create: unit => t;
```
Return a new priority queue, initially empty.

```ocaml
val length : t -> int
```
```reasonml
let length: t => int;
```
Return the number of elements in a priority queue.

```ocaml
val is_empty : t -> bool
```
```reasonml
let is_empty: t => bool;
```
`is_empty q` is `true` iff `q` is empty, that is, iff `length q = 0`.

```ocaml
val add : t -> elt -> unit
```
```reasonml
let add: t => elt => unit;
```
`add q x` adds the element `x` in the priority queue `q`.

```ocaml
val add_iter : t -> ((elt -> unit) -> 'x -> unit) -> 'x -> unit
```
```reasonml
let add_iter: t => ((elt => unit) => 'x => unit) => 'x => unit;
```
`add_iter q iter x` adds each element of `x` to the end of `q`. This is `iter (add q) x`.

```ocaml
val min_elt : t -> elt option
```
```reasonml
let min_elt: t => option(elt);
```
`min_elt q` is an element of `q` with minimal priority or `None` if the queue is empty. The queue is not modified.

```ocaml
val get_min_elt : t -> elt
```
```reasonml
let get_min_elt: t => elt;
```
`get_min_elt q` returns an element of `q` with minimal priority, or raises [`Stdlib.Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if the queue is empty. The queue is not modified.

```ocaml
val pop_min : t -> elt option
```
```reasonml
let pop_min: t => option(elt);
```
`pop_min q` removes and returns an element in queue `q` with minimal priority, or returns `None` if the queue is empty.

```ocaml
val remove_min : t -> unit
```
```reasonml
let remove_min: t => unit;
```
`remove_min q` removes an element in queue `q` with minimal priority. It does nothing if `q` is empty.

```ocaml
val clear : t -> unit
```
```reasonml
let clear: t => unit;
```
`clear q` removes all elements from `q`.

```ocaml
val copy : t -> t
```
```reasonml
let copy: t => t;
```
`copy q` is a new priority queue with the same elements `q` has.


## Conversions from other data structures

```ocaml
val of_array : elt array -> t
```
```reasonml
let of_array: array(elt) => t;
```
`of_array a` returns a new priority queue containing the elements of array `a`. Runs in linear time.

```ocaml
val of_list : elt list -> t
```
```reasonml
let of_list: list(elt) => t;
```
`of_list l` returns a new priority queue containing the elements of list `l`. Runs in linear time.

```ocaml
val of_iter : ((elt -> unit) -> 'x -> unit) -> 'x -> t
```
```reasonml
let of_iter: ((elt => unit) => 'x => unit) => 'x => t;
```
`of_iter iter x` returns a new priority queue containing the elements of `x`, obtained from `iter`.

For example, `of_iter Seq.iter s` returns a new priority queue containing all the elements of the sequence `s` (provided it is finite).

Runs in linear time (excluding the time spent in `iter`).


## Iteration

The order in which the elements of a priority queue are traversed is unspecified.

It is a programming error to mutate a priority queue (by adding or removing elements) during an iteration of the queue. Such an error may be detected and signaled by the backing dynamic array implementation, but this is not guaranteed.

```ocaml
val iter_unordered : (elt -> unit) -> t -> unit
```
```reasonml
let iter_unordered: (elt => unit) => t => unit;
```
`iter_unordered f q` applies `f` to all elements in `q`. The order in which the elements are passed to `f` is unspecified.

The behavior is not specified if the priority queue is modified by `f` during the iteration.

```ocaml
val fold_unordered : ('acc -> elt -> 'acc) -> 'acc -> t -> 'acc
```
```reasonml
let fold_unordered: ('acc => elt => 'acc) => 'acc => t => 'acc;
```
`fold_unordered f accu q` is `(f (... (f (f accu x1) x2) ...) xn)` where `x1,x2,...,xn` are the elements of `q`. The order in which the elements are passed to `f` is unspecified.

The behavior is not specified if the priority queue is modified by `f` during the iteration.
