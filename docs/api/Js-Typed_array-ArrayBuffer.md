
# Module `Typed_array.ArrayBuffer`

The underlying buffer that the typed arrays provide views of

see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/ArrayBuffer](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/ArrayBuffer) MDN
```ocaml
type t = Js.arrayBuffer
```
```reasonml
type t = Js.arrayBuffer;
```
```ocaml
val make : int -> t
```
```reasonml
let make: int => t;
```
takes length. initializes elements to 0

```ocaml
val byteLength : t -> int
```
```reasonml
let byteLength: t => int;
```
```ocaml
val slice : ?start:int -> ?end_:int -> t -> Js.arrayBuffer
```
```reasonml
let slice: ?start:int => ?end_:int => t => Js.arrayBuffer;
```