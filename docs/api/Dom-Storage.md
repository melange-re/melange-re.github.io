
# Module `Dom.Storage`

```ocaml
type t
```
```reasonml
type t;
```
```ocaml
val getItem : string -> t -> string option
```
```reasonml
let getItem: string => t => option(string);
```
```ocaml
val setItem : string -> string -> t -> unit
```
```reasonml
let setItem: string => string => t => unit;
```
```ocaml
val removeItem : string -> t -> unit
```
```reasonml
let removeItem: string => t => unit;
```
```ocaml
val clear : t -> unit
```
```reasonml
let clear: t => unit;
```
```ocaml
val key : int -> t -> string option
```
```reasonml
let key: int => t => option(string);
```
```ocaml
val length : t -> int
```
```reasonml
let length: t => int;
```
```ocaml
val localStorage : t
```
```reasonml
let localStorage: t;
```
```ocaml
val sessionStorage : t
```
```reasonml
let sessionStorage: t;
```