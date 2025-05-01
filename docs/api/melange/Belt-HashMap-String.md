# Module `HashMap.String`
Specalized when key type is `string`, more efficient than the generic type
```
type key = string
```
```
type 'b t
```
```
val make : hintSize:int -> 'b t
```
```
val clear : 'b t -> unit
```
```
val isEmpty : _ t -> bool
```
```
val set : 'a t -> key -> 'a -> unit
```
`setDone tbl k v` if `k` does not exist, add the binding `k,v`, otherwise, update the old value with the new `v`
```
val copy : 'a t -> 'a t
```
```
val get : 'a t -> key -> 'a option
```
```
val has : 'b t -> key -> bool
```
```
val remove : 'a t -> key -> unit
```
```
val forEachU : 'b t -> (key -> 'b -> unit) Js.Fn.arity2 -> unit
```
```
val forEach : 'b t -> (key -> 'b -> unit) -> unit
```
```
val reduceU : 'b t -> 'c -> ('c -> key -> 'b -> 'c) Js.Fn.arity3 -> 'c
```
```
val reduce : 'b t -> 'c -> ('c -> key -> 'b -> 'c) -> 'c
```
```
val keepMapInPlaceU : 'a t -> (key -> 'a -> 'a option) Js.Fn.arity2 -> unit
```
```
val keepMapInPlace : 'a t -> (key -> 'a -> 'a option) -> unit
```
```
val size : _ t -> int
```
```
val toArray : 'a t -> (key * 'a) array
```
```
val keysToArray : 'a t -> key array
```
```
val valuesToArray : 'a t -> 'a array
```
```
val fromArray : (key * 'a) array -> 'a t
```
```
val mergeMany : 'a t -> (key * 'a) array -> unit
```
```
val getBucketHistogram : _ t -> int array
```
```
val logStats : _ t -> unit
```