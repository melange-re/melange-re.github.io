
# Module `Node.Path`

Node Path API

```ocaml
val basename : string -> string
```
```reasonml
let basename: string => string;
```
```ocaml
val extname : string -> string
```
```reasonml
let extname: string => string;
```
```ocaml
val basename_ext : string -> string -> string
```
```reasonml
let basename_ext: string => string => string;
```
```ocaml
val delimiter : string
```
```reasonml
let delimiter: string;
```
```ocaml
val dirname : string -> string
```
```reasonml
let dirname: string => string;
```
```ocaml
val dirname_ext : string -> string -> string
```
```reasonml
let dirname_ext: string => string => string;
```
```ocaml
type pathObject =
  < dir : string
    ; root : string
    ; base : string
    ; name : string
    ; ext : string >
    Js.t
```
```reasonml
type pathObject =
  Js.t({. dir: string
    , root: string
    , base: string
    , name: string
    , ext: string});
```
```ocaml
val format : pathObject -> string
```
```reasonml
let format: pathObject => string;
```
```ocaml
val isAbsolute : string -> bool
```
```reasonml
let isAbsolute: string => bool;
```
```ocaml
val join2 : string -> string -> string
```
```reasonml
let join2: string => string => string;
```
```ocaml
val join : string array -> string
```
```reasonml
let join: array(string) => string;
```
```ocaml
val normalize : string -> string
```
```reasonml
let normalize: string => string;
```
```ocaml
val parse : string -> pathObject
```
```reasonml
let parse: string => pathObject;
```
```ocaml
val relative : from:string -> to_:string -> unit -> string
```
```reasonml
let relative: from:string => to_:string => unit => string;
```
```ocaml
val resolve : string -> string -> string
```
```reasonml
let resolve: string => string => string;
```
```ocaml
val sep : string
```
```reasonml
let sep: string;
```