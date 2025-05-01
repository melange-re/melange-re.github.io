# Module `HashSet.Int`
Specalized when key type is `int`, more efficient than the generic type
This module is [`Belt.HashSet`](./Belt-HashSet.md) specialized with key type to be a primitive type.
It is more efficient in general, the API is the same with [`Belt.HashSet`](./Belt-HashSet.md) except its key type is fixed, and identity is not needed(using the built-in one)
**See** [`Belt.HashSet`](./Belt-HashSet.md)
```
type key = int
```
```
type t
```
```
val make : hintSize:int -> t
```
```
val clear : t -> unit
```
```
val isEmpty : t -> bool
```
```
val add : t -> key -> unit
```
```
val copy : t -> t
```
```
val has : t -> key -> bool
```
```
val remove : t -> key -> unit
```
```
val forEachU : t -> (key -> unit) Js.Fn.arity1 -> unit
```
```
val forEach : t -> (key -> unit) -> unit
```
```
val reduceU : t -> 'c -> ('c -> key -> 'c) Js.Fn.arity2 -> 'c
```
```
val reduce : t -> 'c -> ('c -> key -> 'c) -> 'c
```
```
val size : t -> int
```
```
val logStats : t -> unit
```
```
val toArray : t -> key array
```
```
val fromArray : key array -> t
```
```
val mergeMany : t -> key array -> unit
```
```
val getBucketHistogram : t -> int array
```