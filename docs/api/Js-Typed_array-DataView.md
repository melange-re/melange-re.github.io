
# Module `Typed_array.DataView`

The DataView view provides a low-level interface for reading and writing multiple number types in an ArrayBuffer irrespective of the platform's endianness.

see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/DataView](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView) MDN
```ocaml
type t
```
```reasonml
type t;
```
```ocaml
val make : Js.arrayBuffer -> t
```
```reasonml
let make: Js.arrayBuffer => t;
```
```ocaml
val fromBuffer : Js.arrayBuffer -> ?off:int -> ?len:int -> unit -> t
```
```reasonml
let fromBuffer: Js.arrayBuffer => ?off:int => ?len:int => unit => t;
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
val getInt8 : int -> t -> int
```
```reasonml
let getInt8: int => t => int;
```
```ocaml
val getUint8 : int -> t -> int
```
```reasonml
let getUint8: int => t => int;
```
```ocaml
val getInt16 : int -> t -> int
```
```reasonml
let getInt16: int => t => int;
```
```ocaml
val getInt16LittleEndian : int -> t -> int
```
```reasonml
let getInt16LittleEndian: int => t => int;
```
```ocaml
val getUint16 : int -> t -> int
```
```reasonml
let getUint16: int => t => int;
```
```ocaml
val getUint16LittleEndian : int -> t -> int
```
```reasonml
let getUint16LittleEndian: int => t => int;
```
```ocaml
val getInt32 : int -> t -> int
```
```reasonml
let getInt32: int => t => int;
```
```ocaml
val getInt32LittleEndian : int -> t -> int
```
```reasonml
let getInt32LittleEndian: int => t => int;
```
```ocaml
val getUint32 : int -> t -> int
```
```reasonml
let getUint32: int => t => int;
```
```ocaml
val getUint32LittleEndian : int -> t -> int
```
```reasonml
let getUint32LittleEndian: int => t => int;
```
```ocaml
val getFloat32 : int -> t -> float
```
```reasonml
let getFloat32: int => t => float;
```
```ocaml
val getFloat32LittleEndian : int -> t -> float
```
```reasonml
let getFloat32LittleEndian: int => t => float;
```
```ocaml
val getFloat64 : int -> t -> float
```
```reasonml
let getFloat64: int => t => float;
```
```ocaml
val getFloat64LittleEndian : int -> t -> float
```
```reasonml
let getFloat64LittleEndian: int => t => float;
```
```ocaml
val setInt8 : int -> int -> t -> unit
```
```reasonml
let setInt8: int => int => t => unit;
```
```ocaml
val setUint8 : int -> int -> t -> unit
```
```reasonml
let setUint8: int => int => t => unit;
```
```ocaml
val setInt16 : int -> int -> t -> unit
```
```reasonml
let setInt16: int => int => t => unit;
```
```ocaml
val setInt16LittleEndian : int -> int -> t -> unit
```
```reasonml
let setInt16LittleEndian: int => int => t => unit;
```
```ocaml
val setUint16 : int -> int -> t -> unit
```
```reasonml
let setUint16: int => int => t => unit;
```
```ocaml
val setUint16LittleEndian : int -> int -> t -> unit
```
```reasonml
let setUint16LittleEndian: int => int => t => unit;
```
```ocaml
val setInt32 : int -> int -> t -> unit
```
```reasonml
let setInt32: int => int => t => unit;
```
```ocaml
val setInt32LittleEndian : int -> int -> t -> unit
```
```reasonml
let setInt32LittleEndian: int => int => t => unit;
```
```ocaml
val setUint32 : int -> int -> t -> unit
```
```reasonml
let setUint32: int => int => t => unit;
```
```ocaml
val setUint32LittleEndian : int -> int -> t -> unit
```
```reasonml
let setUint32LittleEndian: int => int => t => unit;
```
```ocaml
val setFloat32 : int -> float -> t -> unit
```
```reasonml
let setFloat32: int => float => t => unit;
```
```ocaml
val setFloat32LittleEndian : int -> float -> t -> unit
```
```reasonml
let setFloat32LittleEndian: int => float => t => unit;
```
```ocaml
val setFloat64 : int -> float -> t -> unit
```
```reasonml
let setFloat64: int => float => t => unit;
```
```ocaml
val setFloat64LittleEndian : int -> float -> t -> unit
```
```reasonml
let setFloat64LittleEndian: int => float => t => unit;
```