
# Module `Typed_array.ArrayBuffer`

The underlying buffer that the typed arrays provide views of

see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/ArrayBuffer](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/ArrayBuffer) MDN
```
type t = Js.arrayBuffer
```
```
val make : int -> t
```
takes length. initializes elements to 0

```
val byteLength : t -> int
```
```
val slice : ?start:int -> ?end_:int -> t -> Js.arrayBuffer
```