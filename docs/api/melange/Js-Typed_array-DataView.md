# Module `Typed_array.DataView`
The DataView view provides a low-level interface for reading and writing multiple number types in an ArrayBuffer irrespective of the platform's endianness.
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/DataView](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView) MDN
```
type t
```
```
val make : Js.arrayBuffer -> t
```
```
val fromBuffer : Js.arrayBuffer -> ?off:int -> ?len:int -> unit -> t
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
val getInt8 : int -> t -> int
```
```
val getUint8 : int -> t -> int
```
```
val getInt16 : int -> t -> int
```
```
val getInt16LittleEndian : int -> t -> int
```
```
val getUint16 : int -> t -> int
```
```
val getUint16LittleEndian : int -> t -> int
```
```
val getInt32 : int -> t -> int
```
```
val getInt32LittleEndian : int -> t -> int
```
```
val getUint32 : int -> t -> int
```
```
val getUint32LittleEndian : int -> t -> int
```
```
val getFloat32 : int -> t -> float
```
```
val getFloat32LittleEndian : int -> t -> float
```
```
val getFloat64 : int -> t -> float
```
```
val getFloat64LittleEndian : int -> t -> float
```
```
val setInt8 : int -> int -> t -> unit
```
```
val setUint8 : int -> int -> t -> unit
```
```
val setInt16 : int -> int -> t -> unit
```
```
val setInt16LittleEndian : int -> int -> t -> unit
```
```
val setUint16 : int -> int -> t -> unit
```
```
val setUint16LittleEndian : int -> int -> t -> unit
```
```
val setInt32 : int -> int -> t -> unit
```
```
val setInt32LittleEndian : int -> int -> t -> unit
```
```
val setUint32 : int -> int -> t -> unit
```
```
val setUint32LittleEndian : int -> int -> t -> unit
```
```
val setFloat32 : int -> float -> t -> unit
```
```
val setFloat32LittleEndian : int -> float -> t -> unit
```
```
val setFloat64 : int -> float -> t -> unit
```
```
val setFloat64LittleEndian : int -> float -> t -> unit
```