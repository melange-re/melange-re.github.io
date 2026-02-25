
# Module `Belt.MutableQueue`

[`Belt.MutableQueue`](#)

An FIFO(first in first out) queue data structure

First-in first-out queues.

This module implements queues (FIFOs), with in-place modification.

```ocaml
type 'a t
```
```reasonml
type t('a);
```
The type of queues containing elements of type `'a`.

```ocaml
val make : unit -> 'a t
```
```reasonml
let make: unit => t('a);
```
returns a new queue, initially empty.
```ocaml
val clear : 'a t -> unit
```
```reasonml
let clear: t('a) => unit;
```
Discard all elements from the queue.

```ocaml
val isEmpty : 'a t -> bool
```
```reasonml
let isEmpty: t('a) => bool;
```
returns true if the given queue is empty, false otherwise.
```ocaml
val fromArray : 'a array -> 'a t
```
```reasonml
let fromArray: array('a) => t('a);
```
`fromArray a` is equivalent to `Array.forEach a (add q a)`

```ocaml
val add : 'a t -> 'a -> unit
```
```reasonml
let add: t('a) => 'a => unit;
```
`add q x` adds the element `x` at the end of the queue `q`.

```ocaml
val peek : 'a t -> 'a option
```
```reasonml
let peek: t('a) => option('a);
```
`peekOpt q` returns the first element in queue `q`, without removing it from the queue.

```ocaml
val peekUndefined : 'a t -> 'a Js.undefined
```
```reasonml
let peekUndefined: t('a) => Js.undefined('a);
```
`peekUndefined q` returns `undefined` if not found

```ocaml
val peekExn : 'a t -> 'a
```
```reasonml
let peekExn: t('a) => 'a;
```
`peekExn q`

**raise** an exception if `q` is empty

```ocaml
val pop : 'a t -> 'a option
```
```reasonml
let pop: t('a) => option('a);
```
`pop q` removes and returns the first element in queue `q`.

```ocaml
val popUndefined : 'a t -> 'a Js.undefined
```
```reasonml
let popUndefined: t('a) => Js.undefined('a);
```
`popUndefined q` removes and returns the first element in queue `q`. it will return undefined if it is already empty

```ocaml
val popExn : 'a t -> 'a
```
```reasonml
let popExn: t('a) => 'a;
```
`popExn q`

**raise** an exception if `q` is empty

```ocaml
val copy : 'a t -> 'a t
```
```reasonml
let copy: t('a) => t('a);
```
`copy q`

returns a fresh queue
```ocaml
val size : 'a t -> int
```
```reasonml
let size: t('a) => int;
```
returns the number of elements in a queue.
```ocaml
val mapU : 'a t -> ('a -> 'b) Js.Fn.arity1 -> 'b t
```
```reasonml
let mapU: t('a) => Js.Fn.arity1(('a => 'b)) => t('b);
```
```ocaml
val map : 'a t -> ('a -> 'b) -> 'b t
```
```reasonml
let map: t('a) => ('a => 'b) => t('b);
```
```ocaml
val forEachU : 'a t -> ('a -> unit) Js.Fn.arity1 -> unit
```
```reasonml
let forEachU: t('a) => Js.Fn.arity1(('a => unit)) => unit;
```
```ocaml
val forEach : 'a t -> ('a -> unit) -> unit
```
```reasonml
let forEach: t('a) => ('a => unit) => unit;
```
`forEach q f` applies `f` in turn to all elements of `q`, from the least recently entered to the most recently entered. The queue itself is unchanged.

```ocaml
val reduceU : 'a t -> 'b -> ('b -> 'a -> 'b) Js.Fn.arity2 -> 'b
```
```reasonml
let reduceU: t('a) => 'b => Js.Fn.arity2(('b => 'a => 'b)) => 'b;
```
```ocaml
val reduce : 'a t -> 'b -> ('b -> 'a -> 'b) -> 'b
```
```reasonml
let reduce: t('a) => 'b => ('b => 'a => 'b) => 'b;
```
`reduce q accu f` is equivalent to `List.reduce l accu f`, where `l` is the list of `q`'s elements. The queue remains unchanged.

```ocaml
val transfer : 'a t -> 'a t -> unit
```
```reasonml
let transfer: t('a) => t('a) => unit;
```
`transfer q1 q2` adds all of `q1`'s elements at the end of the queue `q2`, then clears `q1`. It is equivalent to the sequence `forEach (fun x -> add x q2) q1; clear q1`, but runs in constant time.

```ocaml
val toArray : 'a t -> 'a array
```
```reasonml
let toArray: t('a) => array('a);
```
First added will be in the beginning of the array
