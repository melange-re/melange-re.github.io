
# Module `Typed_array.Float64Array`

```ocaml
type elt = float
```
```reasonml
type elt = float;
```
```ocaml
type 'a typed_array = Js.float64Array
```
```reasonml
type typed_array('a) = Js.float64Array;
```
```ocaml
type t = elt typed_array
```
```reasonml
type t = typed_array(elt);
```
```ocaml
val unsafe_get : t -> int -> elt
```
```reasonml
let unsafe_get: t => int => elt;
```
```ocaml
val unsafe_set : t -> int -> elt -> unit
```
```reasonml
let unsafe_set: t => int => elt => unit;
```
```ocaml
val buffer : t -> Js.arrayBuffer
```
```reasonml
let buffer: t => Js.arrayBuffer;
```
```ocaml
val byteLength : t -> int
```
```reasonml
let byteLength: t => int;
```
```ocaml
val byteOffset : t -> int
```
```reasonml
let byteOffset: t => int;
```
```ocaml
val setArray : elt array -> t -> unit
```
```reasonml
let setArray: array(elt) => t => unit;
```
```ocaml
val setArrayOffset : elt array -> int -> t -> unit
```
```reasonml
let setArrayOffset: array(elt) => int => t => unit;
```
```ocaml
val length : t -> int
```
```reasonml
let length: t => int;
```
```ocaml
val copyWithin : to_:int -> ?start:int -> ?end_:int -> t -> t
```
```reasonml
let copyWithin: to_:int => ?start:int => ?end_:int => t => t;
```
```ocaml
val fill : elt -> ?start:int -> ?end_:int -> t -> t
```
```reasonml
let fill: elt => ?start:int => ?end_:int => t => t;
```
```ocaml
val reverseInPlace : t -> t
```
```reasonml
let reverseInPlace: t => t;
```
```ocaml
val sortInPlace : t -> t
```
```reasonml
let sortInPlace: t => t;
```
```ocaml
val sortInPlaceWith : f:(elt -> elt -> int) -> t -> t
```
```reasonml
let sortInPlaceWith: f:(elt => elt => int) => t => t;
```
```ocaml
val includes : value:elt -> t -> bool
```
```reasonml
let includes: value:elt => t => bool;
```
```ocaml
val indexOf : value:elt -> ?start:int -> t -> int
```
```reasonml
let indexOf: value:elt => ?start:int => t => int;
```
```ocaml
val join : ?sep:string -> t -> string
```
```reasonml
let join: ?sep:string => t => string;
```
```ocaml
val lastIndexOf : value:elt -> t -> int
```
```reasonml
let lastIndexOf: value:elt => t => int;
```
```ocaml
val lastIndexOfFrom : value:elt -> from:int -> t -> int
```
```reasonml
let lastIndexOfFrom: value:elt => from:int => t => int;
```
```ocaml
val slice : ?start:int -> ?end_:int -> t -> t
```
```reasonml
let slice: ?start:int => ?end_:int => t => t;
```
`start` is inclusive, `end_` exclusive

```ocaml
val copy : t -> t
```
```reasonml
let copy: t => t;
```
```ocaml
val subarray : ?start:int -> ?end_:int -> t -> t
```
```reasonml
let subarray: ?start:int => ?end_:int => t => t;
```
`start` is inclusive, `end_` exclusive

```ocaml
val toString : t -> string
```
```reasonml
let toString: t => string;
```
```ocaml
val toLocaleString : t -> string
```
```reasonml
let toLocaleString: t => string;
```
```ocaml
val entries : t -> (int * elt) Js.iterator
```
```reasonml
let entries: t => Js.iterator((int, elt));
```
```ocaml
val every : f:(elt -> bool) -> t -> bool
```
```reasonml
let every: f:(elt => bool) => t => bool;
```
```ocaml
val everyi : f:(elt -> int -> bool) -> t -> bool
```
```reasonml
let everyi: f:(elt => int => bool) => t => bool;
```
```ocaml
val filter : f:(elt -> bool) -> t -> t
```
```reasonml
let filter: f:(elt => bool) => t => t;
```
```ocaml
val filteri : f:(elt -> int -> bool) -> t -> t
```
```reasonml
let filteri: f:(elt => int => bool) => t => t;
```
```ocaml
val find : f:(elt -> bool) -> t -> elt Js.undefined
```
```reasonml
let find: f:(elt => bool) => t => Js.undefined(elt);
```
```ocaml
val findi : f:(elt -> int -> bool) -> t -> elt Js.undefined
```
```reasonml
let findi: f:(elt => int => bool) => t => Js.undefined(elt);
```
```ocaml
val findIndex : f:(elt -> bool) -> t -> int
```
```reasonml
let findIndex: f:(elt => bool) => t => int;
```
```ocaml
val findIndexi : f:(elt -> int -> bool) -> t -> int
```
```reasonml
let findIndexi: f:(elt => int => bool) => t => int;
```
```ocaml
val forEach : f:(elt -> unit) -> t -> unit
```
```reasonml
let forEach: f:(elt => unit) => t => unit;
```
```ocaml
val forEachi : f:(elt -> int -> unit) -> t -> unit
```
```reasonml
let forEachi: f:(elt => int => unit) => t => unit;
```
```ocaml
val keys : t -> int Js.iterator
```
```reasonml
let keys: t => Js.iterator(int);
```
```ocaml
val map : f:(elt -> 'b) -> t -> 'b typed_array
```
```reasonml
let map: f:(elt => 'b) => t => typed_array('b);
```
```ocaml
val mapi : f:(elt -> int -> 'b) -> t -> 'b typed_array
```
```reasonml
let mapi: f:(elt => int => 'b) => t => typed_array('b);
```
```ocaml
val reduce : f:('b -> elt -> 'b) -> init:'b -> t -> 'b
```
```reasonml
let reduce: f:('b => elt => 'b) => init:'b => t => 'b;
```
```ocaml
val reducei : f:('b -> elt -> int -> 'b) -> init:'b -> t -> 'b
```
```reasonml
let reducei: f:('b => elt => int => 'b) => init:'b => t => 'b;
```
```ocaml
val reduceRight : f:('b -> elt -> 'b) -> init:'b -> t -> 'b
```
```reasonml
let reduceRight: f:('b => elt => 'b) => init:'b => t => 'b;
```
```ocaml
val reduceRighti : f:('b -> elt -> int -> 'b) -> init:'b -> t -> 'b
```
```reasonml
let reduceRighti: f:('b => elt => int => 'b) => init:'b => t => 'b;
```
```ocaml
val some : f:(elt -> bool) -> t -> bool
```
```reasonml
let some: f:(elt => bool) => t => bool;
```
```ocaml
val somei : f:(elt -> int -> bool) -> t -> bool
```
```reasonml
let somei: f:(elt => int => bool) => t => bool;
```
```ocaml
val _BYTES_PER_ELEMENT : int
```
```reasonml
let _BYTES_PER_ELEMENT: int;
```
```ocaml
val make : elt array -> t
```
```reasonml
let make: array(elt) => t;
```
```ocaml
val fromBuffer : Js.arrayBuffer -> ?off:int -> ?len:int -> unit -> t
```
```reasonml
let fromBuffer: Js.arrayBuffer => ?off:int => ?len:int => unit => t;
```
raises [`Js.Exn.Error`](./Js-Exn.md#extension-Error) raises Js exception
parameter offset is in bytes, length in elements
```ocaml
val fromLength : int -> t
```
```reasonml
let fromLength: int => t;
```
```ocaml
val from : elt Js.array_like -> t
```
```reasonml
let from: Js.array_like(elt) => t;
```
```ocaml
val values : t -> elt Js.iterator
```
```reasonml
let values: t => Js.iterator(elt);
```