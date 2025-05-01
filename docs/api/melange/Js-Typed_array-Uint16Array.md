# Module `Typed_array.Uint16Array`
```
type elt = int
```
```
type 'a typed_array = Js.uint16Array
```
```
type t = elt typed_array
```
```
val unsafe_get : t -> int -> elt
```
```
val unsafe_set : t -> int -> elt -> unit
```
```
val buffer : t -> Js.arrayBuffer
```
```
val byteLength : t -> int
```
```
val byteOffset : t -> int
```
```
val setArray : elt array -> t -> unit
```
```
val setArrayOffset : elt array -> int -> t -> unit
```
```
val length : t -> int
```
```
val copyWithin : to_:int -> ?start:int -> ?end_:int -> t -> t
```
```
val fill : elt -> ?start:int -> ?end_:int -> t -> t
```
```
val reverseInPlace : t -> t
```
```
val sortInPlace : t -> t
```
```
val sortInPlaceWith : f:(elt -> elt -> int) -> t -> t
```
```
val includes : value:elt -> t -> bool
```
```
val indexOf : value:elt -> ?start:int -> t -> int
```
```
val join : ?sep:string -> t -> string
```
```
val lastIndexOf : value:elt -> t -> int
```
```
val lastIndexOfFrom : value:elt -> from:int -> t -> int
```
```
val slice : ?start:int -> ?end_:int -> t -> t
```
`start` is inclusive, `end_` exclusive
```
val copy : t -> t
```
```
val subarray : ?start:int -> ?end_:int -> t -> t
```
`start` is inclusive, `end_` exclusive
```
val toString : t -> string
```
```
val toLocaleString : t -> string
```
```
val entries : t -> (int * elt) Js.iterator
```
```
val every : f:(elt -> bool) -> t -> bool
```
```
val everyi : f:(elt -> int -> bool) -> t -> bool
```
```
val filter : f:(elt -> bool) -> t -> t
```
```
val filteri : f:(elt -> int -> bool) -> t -> t
```
```
val find : f:(elt -> bool) -> t -> elt Js.undefined
```
```
val findi : f:(elt -> int -> bool) -> t -> elt Js.undefined
```
```
val findIndex : f:(elt -> bool) -> t -> int
```
```
val findIndexi : f:(elt -> int -> bool) -> t -> int
```
```
val forEach : f:(elt -> unit) -> t -> unit
```
```
val forEachi : f:(elt -> int -> unit) -> t -> unit
```
```
val keys : t -> int Js.iterator
```
```
val map : f:(elt -> 'b) -> t -> 'b typed_array
```
```
val mapi : f:(elt -> int -> 'b) -> t -> 'b typed_array
```
```
val reduce : f:('b -> elt -> 'b) -> init:'b -> t -> 'b
```
```
val reducei : f:('b -> elt -> int -> 'b) -> init:'b -> t -> 'b
```
```
val reduceRight : f:('b -> elt -> 'b) -> init:'b -> t -> 'b
```
```
val reduceRighti : f:('b -> elt -> int -> 'b) -> init:'b -> t -> 'b
```
```
val some : f:(elt -> bool) -> t -> bool
```
```
val somei : f:(elt -> int -> bool) -> t -> bool
```
```
val _BYTES_PER_ELEMENT : int
```
```
val make : elt array -> t
```
```
val fromBuffer : Js.arrayBuffer -> ?off:int -> ?len:int -> unit -> t
```
raises [`Js.Exn.Error`](./Js-Exn.md#extension-Error) raises Js exception
parameter offset is in bytes, length in elements
```
val fromLength : int -> t
```
```
val from : elt Js.array_like -> t
```
```
val values : t -> elt Js.iterator
```