# Module `Js.Float`
Bindings to functions in JavaScript's `Number` that deal with floats
Provides functions for inspecting and manipulating `float`s
```
type t = float
```
```
val _NaN : t
```
The special value "Not a Number"
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/NaN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/NaN) MDN
```
val isNaN : t -> bool
```
Tests if the given value is `_NaN`
Note that both `_NaN = _NaN` and `_NaN == _NaN` will return `false`. `isNaN` is therefore necessary to test for `_NaN`.
**Returns** `true` if the given value is `_NaN`, `false` otherwise
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/Number/isNaN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/isNaN) MDN
```
val isFinite : t -> bool
```
Tests if the given value is finite
**Returns** `true` if the given value is a finite number, `false` otherwise
```ocaml
(* returns [false] *)
let _ = Js.Float.isFinite infinity

(* returns [false] *)
let _ = Js.Float.isFinite neg_infinity

(* returns [false] *)
let _ = Js.Float.isFinite _NaN

(* returns [true] *)
let _ = Js.Float.isFinite 1234
```
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/Number/isFinite](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/isFinite) MDN
```
val toExponential : ?digits:int -> t -> string
```
Formats a `float` using exponential (scientific) notation
**digits** specifies how many digits should appear after the decimal point. The value must be in the range \[0, 20\] (inclusive).
**Returns** a `string` representing the given value in exponential notation
The output will be rounded or padded with zeroes if necessary.
raises `RangeError` if digits is not in the range \[0, 20\] (inclusive)
```ocaml
  Js.Float.toExponential 77.1234 = "7.71234e+1"
  Js.Float.toExponential 77. = "7.7e+1"
  Js.Float.toExponential ~digits:2 77.1234 = "7.71e+1"
```
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/Number/toExponential](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toExponential) MDN
```
val toFixed : ?digits:int -> t -> string
```
Formats a `float` using fixed point notation
**digits** specifies how many digits should appear after the decimal point. The value must be in the range \[0, 20\] (inclusive). Defaults to `0`.
**Returns** a `string` representing the given value in fixed-point notation (usually)
The output will be rounded or padded with zeroes if necessary.
raises `RangeError` if digits is not in the range \[0, 20\] (inclusive)
```ocaml
  Js.Float.toFixed 12345.6789 = "12346"
  Js.Float.toFixed 1.2e21 = "1.2e+21"
  Js.Float.toFixed ~digits:1 12345.6789 = "12345.7"
  Js.Float.toFixed ~digits:2 0. = "0.00"
```
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/Number/toFixed](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toFixed) MDN
```
val toPrecision : ?digits:int -> t -> string
```
Formats a `float` using some fairly arbitrary rules
**digits** specifies how many digits should appear in total. The value must between 0 and some arbitrary number that's hopefully at least larger than 20 (for Node it's 21. Why? Who knows).
**Returns** a `string` representing the given value in fixed-point or scientific notation
The output will be rounded or padded with zeroes if necessary.
`toPrecision` differs from `toFixed` in that the former will count all digits against the precision, while the latter will count only the digits after the decimal point. `toPrecision` will also use scientific notation if the specified precision is less than the number for digits before the decimal point.
raises `RangeError` if digits is not in the range accepted by this function (what do you mean "vague"?)
```ocaml
  Js.Float.toPrecision 12345.6789 = "12345.6789"
  Js.Float.toPrecision 1.2e21 = "1.2e+21"
  Js.Float.toPrecision ~digits:1 12345.6789 = "1e+4"
  Js.Float.toPrecision ~digits:2 0. = "0.0"
```
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/Number/toPrecision](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toPrecision) MDN
```
val toString : ?radix:int -> t -> string
```
Formats a `float` as a string
**radix** specifies the radix base to use for the formatted number. The value must be in the range \[2, 36\] (inclusive).
**Returns** a `string` representing the given value in fixed-point (usually)
raises `RangeError` if radix is not in the range \[2, 36\] (inclusive)
```ocaml
  Js.Float.toString 12345.6789 = "12345.6789"
  Js.Float.toString ~radix:2 6. = "110"
  Js.Float.toString ~radix:2 3.14 = "11.001000111101011100001010001111010111000010100011111"
  Js.Float.toString ~radix:16 3735928559. = "deadbeef"
  Js.Float.toString ~radix:36 123.456 = "3f.gez4w97ry0a18ymf6qadcxr"
```
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/Number/toString](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toString) MDN
```
val fromString : string -> t
```
Parses the given `string` into a `float` using JavaScript semantics
**Returns** the number as a `float` if successfully parsed, `_NaN` otherwise.
```ocaml
Js.Float.fromString "123" = 123.
Js.Float.fromString "12.3" = 12.3
Js.Float.fromString "" = 0.
Js.Float.fromString "0x11" = 17.
Js.Float.fromString "0b11" = 3.
Js.Float.fromString "0o11" = 9.
Js.Float.fromString "foo" = _NaN
Js.Float.fromString "100a" = _NaN
```