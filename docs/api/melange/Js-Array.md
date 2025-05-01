# Module `Js.Array`
Bindings to the functions in `Array.prototype`
JavaScript Array API
```
type 'a t = 'a array
```
```
type 'a array_like = 'a Js.array_like
```
```
val from : 'a array_like -> 'a array
```
```
val fromMap : 'a array_like -> f:('a -> 'b) -> 'b array
```
```
val isArray : 'a -> bool
```
```
val length : 'a array -> int
```
Mutating functions
```
val copyWithin : to_:int -> ?start:int -> ?end_:int -> 'a t -> 'a t
```
```
val fill : value:'a -> ?start:int -> ?end_:int -> 'a t -> 'a t
```
```
val pop : 'a t -> 'a option
```
https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/Array/push
```
val push : value:'a -> 'a t -> int
```
```
val pushMany : values:'a array -> 'a t -> int
```
```
val reverseInPlace : 'a t -> 'a t
```
```
val shift : 'a t -> 'a option
```
```
val sortInPlace : 'a t -> 'a t
```
```
val sortInPlaceWith : f:('a -> 'a -> int) -> 'a t -> 'a t
```
```
val spliceInPlace : start:int -> remove:int -> add:'a array -> 'a t -> 'a t
```
```
val removeFromInPlace : start:int -> 'a t -> 'a t
```
```
val removeCountInPlace : start:int -> count:int -> 'a t -> 'a t
```
```
val unshift : value:'a -> 'a t -> int
```
```
val unshiftMany : values:'a array -> 'a t -> int
```
```
val concat : other:'a t -> 'a t -> 'a t
```
```
val concatMany : arrays:'a t array -> 'a t -> 'a t
```
```
val includes : value:'a -> 'a t -> bool
```
ES2015
```
val join : ?sep:string -> 'a t -> string
```
Accessor functions
```
val indexOf : value:'a -> ?start:int -> 'a t -> int
```
```
val lastIndexOf : value:'a -> 'a t -> int
```
```
val lastIndexOfFrom : value:'a -> start:int -> 'a t -> int
```
```
val copy : 'a t -> 'a t
```
```
val slice : ?start:int -> ?end_:int -> 'a t -> 'a t
```
```
val toString : 'a t -> string
```
```
val toLocaleString : 'a t -> string
```
Iteration functions
```
val entries : 'a t -> (int * 'a) Js.iterator
```
```
val every : f:('a -> bool) -> 'a t -> bool
```
```
val everyi : f:('a -> int -> bool) -> 'a t -> bool
```
```
val filter : f:('a -> bool) -> 'a t -> 'a t
```
```
val filteri : f:('a -> int -> bool) -> 'a t -> 'a t
```
```
val find : f:('a -> bool) -> 'a t -> 'a option
```
```
val findi : f:('a -> int -> bool) -> 'a t -> 'a option
```
```
val findIndex : f:('a -> bool) -> 'a t -> int
```
```
val findIndexi : f:('a -> int -> bool) -> 'a t -> int
```
```
val forEach : f:('a -> unit) -> 'a t -> unit
```
```
val forEachi : f:('a -> int -> unit) -> 'a t -> unit
```
```
val keys : 'a t -> int Js.iterator
```
```
val map : f:('a -> 'b) -> 'a t -> 'b t
```
```
val mapi : f:('a -> int -> 'b) -> 'a t -> 'b t
```
```
val reduce : f:('b -> 'a -> 'b) -> init:'b -> 'a t -> 'b
```
```
val reducei : f:('b -> 'a -> int -> 'b) -> init:'b -> 'a t -> 'b
```
```
val reduceRight : f:('b -> 'a -> 'b) -> init:'b -> 'a t -> 'b
```
```
val reduceRighti : f:('b -> 'a -> int -> 'b) -> init:'b -> 'a t -> 'b
```
```
val some : f:('a -> bool) -> 'a t -> bool
```
```
val somei : f:('a -> int -> bool) -> 'a t -> bool
```
```
val values : 'a t -> 'a Js.iterator
```
```
val unsafe_get : 'a array -> int -> 'a
```
```
val unsafe_set : 'a array -> int -> 'a -> unit
```