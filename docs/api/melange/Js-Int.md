
# Module `Js.Int`

Bindings to functions in JavaScript's `Number` that deal with ints

Provides functions for inspecting and manipulating `int`s

```
type t = int
```
If we use number, we need coerce to int32 by adding \`\|0\`, otherwise \`+0\` can be wrong. Most JS API is float oriented, it may overflow int32 or comes with `NAN`

```
val toExponential : ?digits:t -> t -> string
```
Formats an `int` using exponential (scientific) notation

**digits** specifies how many digits should appear after the decimal point. The value must be in the range \[0, 20\] (inclusive).

**Returns** a `string` representing the given value in exponential notation

The output will be rounded or padded with zeroes if necessary.

raises `RangeError` if digits is not in the range \[0, 20\] (inclusive)
```ocaml
  Js.Int.toExponential 77 = "7.7e+1"
  Js.Int.toExponential ~digits:2 77 = "7.70e+1"
  Js.Int.toExponential ~digits:2 5678 = "5.68e+3"
```
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/Number/toExponential](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toExponential) MDN
```
val toPrecision : ?digits:t -> t -> string
```
Formats an `int` using some fairly arbitrary rules

**digits** specifies how many digits should appear in total. The value must between 1 and some 100.

**Returns** a `string` representing the given value in fixed-point or scientific notation

The output will be rounded or padded with zeroes if necessary.

`toPrecision` differs from [`Js.Float.toFixed`](./Js-Float.md#val-toFixed) in that the former will count all digits against the precision, while the latter will count only the digits after the decimal point. `toPrecision` will also use scientific notation if the specified precision is less than the number for digits before the decimal point.

raises `RangeError` if digits is not between 1 and 100.
```ocaml
  Js.Int.toPrecision 123456789 = "123456789"
  Js.Int.toPrecision ~digits:2 123456789 = "1.2e+8"
  Js.Int.toPrecision ~digits:2 0 = "0.0"
```
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/Number/toPrecision](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toPrecision) MDN
```
val toString : ?radix:t -> t -> string
```
Formats an `int` as a string

**radix** specifies the radix base to use for the formatted number. The value must be in the range \[2, 36\] (inclusive).

**Returns** a `string` representing the given value in fixed-point (usually)

raises `RangeError` if radix is not in the range \[2, 36\] (inclusive)
```ocaml
  Js.Int.toString 123456789 = "123456789"
  Js.Int.toString ~radix:2 6 = "110"
  Js.Int.toString ~radix:16 3735928559 = "deadbeef"
  Js.Int.toString ~radix:36 123456 = "2n9c"
```
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/Number/toString](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toString) MDN
```
val toFloat : t -> float
```
```
val equal : t -> t -> bool
```
```
val max : t
```
```
val min : t
```