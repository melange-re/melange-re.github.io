
# Parameter `MakeHashableU.M`

```ocaml
type t
```
```reasonml
type t;
```
```ocaml
val hash : (t -> int) Js.Fn.arity1
```
```reasonml
let hash: Js.Fn.arity1((t => int));
```
```ocaml
val eq : (t -> t -> bool) Js.Fn.arity2
```
```reasonml
let eq: Js.Fn.arity2((t => t => bool));
```