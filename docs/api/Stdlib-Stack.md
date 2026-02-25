
# Module `Stdlib.Stack`

Last-in first-out stacks.

This module implements stacks (LIFOs), with in-place modification.

**Unsynchronized accesses**

Unsynchronized accesses to a stack may lead to an invalid queue state. Thus, concurrent accesses to stacks must be synchronized (for instance with a [`Mutex.t`](./Stdlib-Mutex.md#type-t)).

```ocaml
type !'a t
```
```reasonml
type t(!'a);
```
The type of stacks containing elements of type `'a`.

```ocaml
exception Empty
```
```reasonml
exception Empty;
```
Raised when [`Stack.pop`](./#val-pop) or [`Stack.top`](./#val-top) is applied to an empty stack.

```ocaml
val create : unit -> 'a t
```
```reasonml
let create: unit => t('a);
```
Return a new stack, initially empty.

```ocaml
val push : 'a -> 'a t -> unit
```
```reasonml
let push: 'a => t('a) => unit;
```
`push x s` adds the element `x` at the top of stack `s`.

```ocaml
val pop : 'a t -> 'a
```
```reasonml
let pop: t('a) => 'a;
```
`pop s` removes and returns the topmost element in stack `s`, or raises [`Empty`](./#exception-Empty) if the stack is empty.

```ocaml
val pop_opt : 'a t -> 'a option
```
```reasonml
let pop_opt: t('a) => option('a);
```
`pop_opt s` removes and returns the topmost element in stack `s`, or returns `None` if the stack is empty.

since 4\.08
```ocaml
val drop : 'a t -> unit
```
```reasonml
let drop: t('a) => unit;
```
`drop s` removes the topmost element in stack `s`, or raises [`Empty`](./#exception-Empty) if the stack is empty.

since 5\.1
```ocaml
val top : 'a t -> 'a
```
```reasonml
let top: t('a) => 'a;
```
`top s` returns the topmost element in stack `s`, or raises [`Empty`](./#exception-Empty) if the stack is empty.

```ocaml
val top_opt : 'a t -> 'a option
```
```reasonml
let top_opt: t('a) => option('a);
```
`top_opt s` returns the topmost element in stack `s`, or `None` if the stack is empty.

since 4\.08
```ocaml
val clear : 'a t -> unit
```
```reasonml
let clear: t('a) => unit;
```
Discard all elements from a stack.

```ocaml
val copy : 'a t -> 'a t
```
```reasonml
let copy: t('a) => t('a);
```
Return a copy of the given stack.

```ocaml
val is_empty : 'a t -> bool
```
```reasonml
let is_empty: t('a) => bool;
```
Return `true` if the given stack is empty, `false` otherwise.

```ocaml
val length : 'a t -> int
```
```reasonml
let length: t('a) => int;
```
Return the number of elements in a stack. Time complexity O(1)

```ocaml
val iter : ('a -> unit) -> 'a t -> unit
```
```reasonml
let iter: ('a => unit) => t('a) => unit;
```
`iter f s` applies `f` in turn to all elements of `s`, from the element at the top of the stack to the element at the bottom of the stack. The stack itself is unchanged.

```ocaml
val fold : ('acc -> 'a -> 'acc) -> 'acc -> 'a t -> 'acc
```
```reasonml
let fold: ('acc => 'a => 'acc) => 'acc => t('a) => 'acc;
```
`fold f accu s` is `(f (... (f (f accu x1) x2) ...) xn)` where `x1` is the top of the stack, `x2` the second element, and `xn` the bottom element. The stack is unchanged.

since 4\.03

## Stacks and Sequences

```ocaml
val to_seq : 'a t -> 'a Seq.t
```
```reasonml
let to_seq: t('a) => Seq.t('a);
```
Iterate on the stack, top to bottom. It is safe to modify the stack during iteration.

since 4\.07
```ocaml
val add_seq : 'a t -> 'a Seq.t -> unit
```
```reasonml
let add_seq: t('a) => Seq.t('a) => unit;
```
Add the elements from the sequence on the top of the stack.

since 4\.07
```ocaml
val of_seq : 'a Seq.t -> 'a t
```
```reasonml
let of_seq: Seq.t('a) => t('a);
```
Create a stack from the sequence.

since 4\.07