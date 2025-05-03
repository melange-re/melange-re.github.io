
# Module `Js.Obj`

Utility functions on \`Js.t\` JS objects

```
val empty : unit -> < .. > Js.t
```
```
val assign : < .. > Js.t -> < .. > Js.t -> < .. > Js.t
```
```
val merge : < .. > Js.t -> < .. > Js.t -> < .. > Js.t
```
`merge obj1 obj2` assigns the properties in `obj2` to a copy of `obj1`. The function returns a new object, and both arguments are not mutated

```
val keys : _ Js.t -> string array
```