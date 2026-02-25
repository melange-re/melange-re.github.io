
# Module `Stdlib.Pqueue`

Priority queues.

The [`Pqueue`](#) module implements a data structure of priority queues, given a totally ordered type for elements. This is a mutable data structure. Both min- and max-priority queues are provided.

The implementation uses a heap stored in a dynamic array, and is therefore reasonably efficient: accessing the minimum (resp. maximum) element takes constant time, and insertion and removal take time logarithmic in the size of the priority queue. Note that `of_array` runs in linear time (and thus must be preferred to repeated insertions with `add`).

It is fine to have several elements with the same priority. Nothing is guaranteed regarding the order in which they will be popped. However, it is guaranteed that the element returned by `min_elt` (or `get_min_elt`) is the one that is removed from the priority queue by `pop_min` (or `remove_min`). This is important in many algorithms, (e.g. when peeking at several priority queues and then selecting one to remove from).

since 5\.4
```ocaml
module type OrderedType = sig ... end
```
```reasonml
module type OrderedType = { ... };
```
Input signature of the functors [`MakeMin`](./Stdlib-Pqueue-MakeMin.md) and [`MakeMax`](./Stdlib-Pqueue-MakeMax.md).

```ocaml
module type Min = sig ... end
```
```reasonml
module type Min = { ... };
```
Output signature of the functor [`MakeMin`](./Stdlib-Pqueue-MakeMin.md).

```ocaml
module MakeMin (E : OrderedType) : Min with type elt := E.t
```
```reasonml
module MakeMin:  (E: OrderedType) => Min with type elt := E.t;
```
Functor building an implementation of the min-priority queue structure given a totally ordered type for elements.

```ocaml
module type Max = sig ... end
```
```reasonml
module type Max = { ... };
```
Output signature of the functor [`MakeMax`](./Stdlib-Pqueue-MakeMax.md).

```ocaml
module MakeMax (E : OrderedType) : Max with type elt := E.t
```
```reasonml
module MakeMax:  (E: OrderedType) => Max with type elt := E.t;
```
Functor building an implementation of the max-priority queue structure given a totally ordered type for elements.


## Polymorphic priority queues

The following, more complex functors create polymorphic queues of type <code class="text-ocaml">'a t</code><code class="text-reasonml">t('a)</code>, just like other polymorphic containers (lists, arrays...). They require a notion of "polymorphic elements" <code class="text-ocaml">'a elt</code><code class="text-reasonml">elt('a)</code> that can be compared without depending on the values of `'a`.

One usage scenario is when the user wants to pass priorities separately from the value stored in the queue. This is done by using pairs <code class="text-ocaml">priority * 'a</code><code class="text-reasonml">(priority, 'a)</code> as elements.

```ocaml
  module Prio : OrderedType = ...

  module PrioQueue = Pqueue.MakeMinPoly(struct
    type 'a t = Prio.t * 'a
    let compare (p1, _) (p2, _) = Prio.compare p1 p2
  end)

  (* for example, we now have: *)
  PrioQueue.add: 'a PrioQueue.t -> Prio.t * 'a -> unit
  PrioQueue.min_elt: 'a PrioQueue.t -> (Prio.t * 'a) option
```
```ocaml
module type OrderedPolyType = sig ... end
```
```reasonml
module type OrderedPolyType = { ... };
```
Input signature of the functors [`MakeMinPoly`](./Stdlib-Pqueue-MakeMinPoly.md) and [`MakeMaxPoly`](./Stdlib-Pqueue-MakeMaxPoly.md).

```ocaml
module type MinPoly = sig ... end
```
```reasonml
module type MinPoly = { ... };
```
Output signature of the functor [`MakeMinPoly`](./Stdlib-Pqueue-MakeMinPoly.md).

```ocaml
module MakeMinPoly (E : OrderedPolyType) : MinPoly with type 'a elt := 'a E.t
```
```reasonml
module MakeMinPoly: 
   (E: OrderedPolyType) =>
  MinPoly with type elt('a) := E.t('a);
```
Functor building an implementation of min-priority queues given a totally ordered type for the elements.

```ocaml
module type MaxPoly = sig ... end
```
```reasonml
module type MaxPoly = { ... };
```
Output signature of the functor [`MakeMaxPoly`](./Stdlib-Pqueue-MakeMaxPoly.md).

```ocaml
module MakeMaxPoly (E : OrderedPolyType) : MaxPoly with type 'a elt := 'a E.t
```
```reasonml
module MakeMaxPoly: 
   (E: OrderedPolyType) =>
  MaxPoly with type elt('a) := E.t('a);
```
Functor building an implementation of max-priority queues given a totally ordered type for the elements.
