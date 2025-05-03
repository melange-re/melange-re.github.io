
# Module `Js.Map`

Bindings to functions in `Map`

ES6 Map API

```
type ('k, 'v) t
```
```
val make : unit -> ('k, 'v) t
```
```
val fromArray : ('k * 'v) array -> ('k, 'v) t
```
```
val toArray : ('k, 'v) t -> ('k * 'v) array
```
```
val size : ('k, 'v) t -> int
```
```
val has : key:'k -> ('k, 'v) t -> bool
```
```
val get : key:'k -> ('k, 'v) t -> 'v option
```
```
val set : key:'k -> value:'v -> ('k, 'v) t -> ('k, 'v) t
```
```
val clear : ('k, 'v) t -> unit
```
```
val delete : key:'k -> ('k, 'v) t -> bool
```
```
val forEach : f:('v -> 'k -> ('k, 'v) t -> unit) -> ('k, 'v) t -> unit
```
```
val keys : ('k, 'v) t -> 'k Js.iterator
```
```
val values : ('k, 'v) t -> 'v Js.iterator
```
```
val entries : ('k, 'v) t -> ('k * 'v) Js.iterator
```