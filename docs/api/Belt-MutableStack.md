
# Module `Belt.MutableStack`

[`Belt.MutableStack`](#)

An FILO(first in last out) stack data structure

First in last out stack.

This module implements stacks, with in-place modification.

```ocaml
type 'a t
```
```reasonml
type t('a);
```
```ocaml
val make : unit -> 'a t
```
```reasonml
let make: unit => t('a);
```
returns a new stack, initially empty.
```ocaml
val clear : 'a t -> unit
```
```reasonml
let clear: t('a) => unit;
```
Discard all elements from the stack.

```ocaml
val copy : 'a t -> 'a t
```
```reasonml
let copy: t('a) => t('a);
```
`copy x` O(1) operation, return a new stack

```ocaml
val push : 'a t -> 'a -> unit
```
```reasonml
let push: t('a) => 'a => unit;
```
```ocaml
val popUndefined : 'a t -> 'a Js.undefined
```
```reasonml
let popUndefined: t('a) => Js.undefined('a);
```
```ocaml
val pop : 'a t -> 'a option
```
```reasonml
let pop: t('a) => option('a);
```
```ocaml
val topUndefined : 'a t -> 'a Js.undefined
```
```reasonml
let topUndefined: t('a) => Js.undefined('a);
```
```ocaml
val top : 'a t -> 'a option
```
```reasonml
let top: t('a) => option('a);
```
```ocaml
val isEmpty : 'a t -> bool
```
```reasonml
let isEmpty: t('a) => bool;
```
```ocaml
val size : 'a t -> int
```
```reasonml
let size: t('a) => int;
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
```ocaml
val dynamicPopIterU : 'a t -> ('a -> unit) Js.Fn.arity1 -> unit
```
```reasonml
let dynamicPopIterU: t('a) => Js.Fn.arity1(('a => unit)) => unit;
```
```ocaml
val dynamicPopIter : 'a t -> ('a -> unit) -> unit
```
```reasonml
let dynamicPopIter: t('a) => ('a => unit) => unit;
```
`dynamicPopIter s f ` apply `f` to each element of `s`. The item is poped before applying `f`, `s` will be empty after this opeartion. This function is useful for worklist algorithm
