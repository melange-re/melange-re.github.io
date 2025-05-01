# Module `Dom.Storage`
```
type t
```
```
val getItem : string -> t -> string option
```
```
val setItem : string -> string -> t -> unit
```
```
val removeItem : string -> t -> unit
```
```
val clear : t -> unit
```
```
val key : int -> t -> string option
```
```
val length : t -> int
```
```
val localStorage : t
```
```
val sessionStorage : t
```