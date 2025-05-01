# Module `Belt.MutableStack`
[`Belt.MutableStack`](#)
An FILO(first in last out) stack data structure
First in last out stack.
This module implements stacks, with in-place modification.
```
type 'a t
```
```
val make : unit -> 'a t
```
returns a new stack, initially empty.
```
val clear : 'a t -> unit
```
Discard all elements from the stack.
```
val copy : 'a t -> 'a t
```
`copy x` O(1) operation, return a new stack
```
val push : 'a t -> 'a -> unit
```
```
val popUndefined : 'a t -> 'a Js.undefined
```
```
val pop : 'a t -> 'a option
```
```
val topUndefined : 'a t -> 'a Js.undefined
```
```
val top : 'a t -> 'a option
```
```
val isEmpty : 'a t -> bool
```
```
val size : 'a t -> int
```
```
val forEachU : 'a t -> ('a -> unit) Js.Fn.arity1 -> unit
```
```
val forEach : 'a t -> ('a -> unit) -> unit
```
```
val dynamicPopIterU : 'a t -> ('a -> unit) Js.Fn.arity1 -> unit
```
```
val dynamicPopIter : 'a t -> ('a -> unit) -> unit
```
`dynamicPopIter s f ` apply `f` to each element of `s`. The item is poped before applying `f`, `s` will be empty after this opeartion. This function is useful for worklist algorithm