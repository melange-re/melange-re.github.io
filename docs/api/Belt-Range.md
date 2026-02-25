
# Module `Belt.Range`

[`Belt.Range`](#)

Utilities for a closed range `(from, start)`

A small module to provide a inclusive range operations `[start, finsish]`, it use a for-loop internally instead of creating an array

```ocaml
val forEachU : int -> int -> (int -> unit) Js.Fn.arity1 -> unit
```
```reasonml
let forEachU: int => int => Js.Fn.arity1((int => unit)) => unit;
```
```ocaml
val forEach : int -> int -> (int -> unit) -> unit
```
```reasonml
let forEach: int => int => (int => unit) => unit;
```
`forEach start finish action`

equivalent to `Belt.Array.(forEach (range start finish) action)`

```ocaml
val everyU : int -> int -> (int -> bool) Js.Fn.arity1 -> bool
```
```reasonml
let everyU: int => int => Js.Fn.arity1((int => bool)) => bool;
```
```ocaml
val every : int -> int -> (int -> bool) -> bool
```
```reasonml
let every: int => int => (int => bool) => bool;
```
`every start finish p`

equivalent to `Belt.Array.(every (range start finish) p )`

```ocaml
val everyByU : int -> int -> step:int -> (int -> bool) Js.Fn.arity1 -> bool
```
```reasonml
let everyByU: int => int => step:int => Js.Fn.arity1((int => bool)) => bool;
```
```ocaml
val everyBy : int -> int -> step:int -> (int -> bool) -> bool
```
```reasonml
let everyBy: int => int => step:int => (int => bool) => bool;
```
`everyBy start finish ~step p`

**See** [`Belt.Array.rangeBy`](./Belt-Array.md#val-rangeBy)

equivalent to `Belt.Array.(every (rangeBy start finish ~step) p)`

```ocaml
val someU : int -> int -> (int -> bool) Js.Fn.arity1 -> bool
```
```reasonml
let someU: int => int => Js.Fn.arity1((int => bool)) => bool;
```
```ocaml
val some : int -> int -> (int -> bool) -> bool
```
```reasonml
let some: int => int => (int => bool) => bool;
```
`some start finish p`

equivalent to `Belt.Array.(some (range start finish) p)`

```ocaml
val someByU : int -> int -> step:int -> (int -> bool) Js.Fn.arity1 -> bool
```
```reasonml
let someByU: int => int => step:int => Js.Fn.arity1((int => bool)) => bool;
```
```ocaml
val someBy : int -> int -> step:int -> (int -> bool) -> bool
```
```reasonml
let someBy: int => int => step:int => (int => bool) => bool;
```
`someBy start finish ~step  p`

**See** [`Belt.Array.rangeBy`](./Belt-Array.md#val-rangeBy)

equivalent to `Belt.Array.(some (rangeBy start finish ~step) p)`
