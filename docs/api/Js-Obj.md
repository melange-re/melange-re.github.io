
# Module `Js.Obj`

Utility functions on \`Js.t\` JS objects

```ocaml
val empty : unit -> < .. > Js.t
```
```reasonml
let empty: unit => Js.t({.. });
```
```ocaml
val assign : < .. > Js.t -> < .. > Js.t -> < .. > Js.t
```
```reasonml
let assign: Js.t({.. }) => Js.t({.. }) => Js.t({.. });
```
```ocaml
val merge : < .. > Js.t -> < .. > Js.t -> < .. > Js.t
```
```reasonml
let merge: Js.t({.. }) => Js.t({.. }) => Js.t({.. });
```
`merge obj1 obj2` assigns the properties in `obj2` to a copy of `obj1`. The function returns a new object, and both arguments are not mutated

```ocaml
val keys : _ Js.t -> string array
```
```reasonml
let keys: Js.t(_) => array(string);
```