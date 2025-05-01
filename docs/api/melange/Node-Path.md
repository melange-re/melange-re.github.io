# Module `Node.Path`
Node Path API
```
val basename : string -> string
```
```
val basename_ext : string -> string -> string
```
```
val delimiter : string
```
```
val dirname : string -> string
```
```
val dirname_ext : string -> string -> string
```
```
type pathObject =
  < dir : string
    ; root : string
    ; base : string
    ; name : string
    ; ext : string >
    Js.t
```
```
val format : pathObject -> string
```
```
val isAbsolute : string -> bool
```
```
val join2 : string -> string -> string
```
```
val join : string array -> string
```
```
val normalize : string -> string
```
```
val parse : string -> pathObject
```
```
val relative : from:string -> to_:string -> unit -> string
```
```
val resolve : string -> string -> string
```
```
val sep : string
```