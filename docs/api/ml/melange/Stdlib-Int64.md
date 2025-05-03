
# Module `Stdlib.Int64`

64-bit integers.

This module provides operations on the type `int64` of signed 64-bit integers. Unlike the built-in `int` type, the type `int64` is guaranteed to be exactly 64-bit wide on all platforms. All arithmetic operations over `int64` are taken modulo 264

Performance notice: values of type `int64` occupy more memory space than values of type `int`, and arithmetic operations on `int64` are generally slower than those on `int`. Use `int64` only when the application requires exact 64-bit arithmetic.

Literals for 64-bit integers are suffixed by L:

```ocaml
  let zero: int64 = 0L
  let one: int64 = 1L
  let m_one: int64 = -1L
```
```
val zero : int64
```
The 64-bit integer 0.

```
val one : int64
```
The 64-bit integer 1\.

```
val minus_one : int64
```
The 64-bit integer \-1.

```
val neg : int64 -> int64
```
Unary negation.

```
val add : int64 -> int64 -> int64
```
Addition.

```
val sub : int64 -> int64 -> int64
```
Subtraction.

```
val mul : int64 -> int64 -> int64
```
Multiplication.

```
val div : int64 -> int64 -> int64
```
Integer division.

raises [`Division_by_zero`](./Stdlib.md#exception-Division_by_zero) if the second argument is zero. This division rounds the real quotient of its arguments towards zero, as specified for Stdlib.(/).
```
val unsigned_div : int64 -> int64 -> int64
```
Same as [`div`](./#val-div), except that arguments and result are interpreted as *unsigned* 64-bit integers.

since 4.08
```
val rem : int64 -> int64 -> int64
```
Integer remainder. If `y` is not zero, the result of `Int64.rem x y` satisfies the following property: `x = Int64.add (Int64.mul (Int64.div x y) y) (Int64.rem x y)`. If `y = 0`, `Int64.rem x y` raises `Division_by_zero`.

```
val unsigned_rem : int64 -> int64 -> int64
```
Same as [`rem`](./#val-rem), except that arguments and result are interpreted as *unsigned* 64-bit integers.

since 4.08
```
val succ : int64 -> int64
```
Successor. `Int64.succ x` is `Int64.add x Int64.one`.

```
val pred : int64 -> int64
```
Predecessor. `Int64.pred x` is `Int64.sub x Int64.one`.

```
val abs : int64 -> int64
```
`abs x` is the absolute value of `x`. On `min_int` this is `min_int` itself and thus remains negative.

```
val max_int : int64
```
The greatest representable 64-bit integer, 263 \- 1\.

```
val min_int : int64
```
The smallest representable 64-bit integer, \-263.

```
val logand : int64 -> int64 -> int64
```
Bitwise logical and.

```
val logor : int64 -> int64 -> int64
```
Bitwise logical or.

```
val logxor : int64 -> int64 -> int64
```
Bitwise logical exclusive or.

```
val lognot : int64 -> int64
```
Bitwise logical negation.

```
val shift_left : int64 -> int -> int64
```
`Int64.shift_left x y` shifts `x` to the left by `y` bits. The result is unspecified if `y < 0` or `y >= 64`.

```
val shift_right : int64 -> int -> int64
```
`Int64.shift_right x y` shifts `x` to the right by `y` bits. This is an arithmetic shift: the sign bit of `x` is replicated and inserted in the vacated bits. The result is unspecified if `y < 0` or `y >= 64`.

```
val shift_right_logical : int64 -> int -> int64
```
`Int64.shift_right_logical x y` shifts `x` to the right by `y` bits. This is a logical shift: zeroes are inserted in the vacated bits regardless of the sign of `x`. The result is unspecified if `y < 0` or `y >= 64`.

```
val of_int : int -> int64
```
Convert the given integer (type `int`) to a 64-bit integer (type `int64`).

```
val to_int : int64 -> int
```
Convert the given 64-bit integer (type `int64`) to an integer (type `int`). On 64-bit platforms, the 64-bit integer is taken modulo 263, i.e. the high-order bit is lost during the conversion. On 32-bit platforms, the 64-bit integer is taken modulo 231, i.e. the top 33 bits are lost during the conversion.

```
val unsigned_to_int : int64 -> int option
```
Same as [`to_int`](./#val-to_int), but interprets the argument as an *unsigned* integer. Returns `None` if the unsigned value of the argument cannot fit into an `int`.

since 4.08
```
val of_float : float -> int64
```
Convert the given floating-point number to a 64-bit integer, discarding the fractional part (truncate towards 0). If the truncated floating-point number is outside the range \[[`Int64.min_int`](./#val-min_int), [`Int64.max_int`](./#val-max_int)\], no exception is raised, and an unspecified, platform-dependent integer is returned.

```
val to_float : int64 -> float
```
Convert the given 64-bit integer to a floating-point number.

```
val of_int32 : int32 -> int64
```
Convert the given 32-bit integer (type `int32`) to a 64-bit integer (type `int64`).

```
val to_int32 : int64 -> int32
```
Convert the given 64-bit integer (type `int64`) to a 32-bit integer (type `int32`). The 64-bit integer is taken modulo 232, i.e. the top 32 bits are lost during the conversion.

```
val of_nativeint : nativeint -> int64
```
Convert the given native integer (type `nativeint`) to a 64-bit integer (type `int64`).

```
val to_nativeint : int64 -> nativeint
```
Convert the given 64-bit integer (type `int64`) to a native integer. On 32-bit platforms, the 64-bit integer is taken modulo 232. On 64-bit platforms, the conversion is exact.

```
val of_string : string -> int64
```
Convert the given string to a 64-bit integer. The string is read in decimal (by default, or if the string begins with `0u`) or in hexadecimal, octal or binary if the string begins with `0x`, `0o` or `0b` respectively.

The `0u` prefix reads the input as an unsigned integer in the range `[0, 2*Int64.max_int+1]`. If the input exceeds [`Int64.max_int`](./#val-max_int) it is converted to the signed integer `Int64.min_int + input - Int64.max_int - 1`.

The `_` (underscore) character can appear anywhere in the string and is ignored.

raises [`Failure`](./Stdlib.md#exception-Failure) if the given string is not a valid representation of an integer, or if the integer represented exceeds the range of integers representable in type int64.
```
val of_string_opt : string -> int64 option
```
Same as `of_string`, but return `None` instead of raising.

since 4.05
```
val to_string : int64 -> string
```
Return the string representation of its argument, in decimal.

```
val bits_of_float : float -> int64
```
Return the internal representation of the given float according to the IEEE 754 floating-point 'double format' bit layout. Bit 63 of the result represents the sign of the float; bits 62 to 52 represent the (biased) exponent; bits 51 to 0 represent the mantissa.

```
val float_of_bits : int64 -> float
```
Return the floating-point number whose internal representation, according to the IEEE 754 floating-point 'double format' bit layout, is the given `int64`.

```
type t = int64
```
An alias for the type of 64-bit integers.

```
val compare : t -> t -> int
```
The comparison function for 64-bit integers, with the same specification as [`Stdlib.compare`](./Stdlib.md#val-compare). Along with the type `t`, this function `compare` allows the module `Int64` to be passed as argument to the functors [`Set.Make`](./Stdlib-Set-Make.md) and [`Map.Make`](./Stdlib-Map-Make.md).

```
val unsigned_compare : t -> t -> int
```
Same as [`compare`](./#val-compare), except that arguments are interpreted as *unsigned* 64-bit integers.

since 4.08
```
val equal : t -> t -> bool
```
The equal function for int64s.

since 4.03
```
val min : t -> t -> t
```
Return the smaller of the two arguments.

since 4.13
```
val max : t -> t -> t
```
Return the greater of the two arguments.

since 4.13
```
val seeded_hash : int -> t -> int
```
A seeded hash function for 64-bit ints, with the same output value as [`Hashtbl.seeded_hash`](./Stdlib-Hashtbl.md#val-seeded_hash). This function allows this module to be passed as argument to the functor [`Hashtbl.MakeSeeded`](./Stdlib-Hashtbl-MakeSeeded.md).

since 5.1
```
val hash : t -> int
```
An unseeded hash function for 64-bit ints, with the same output value as [`Hashtbl.hash`](./Stdlib-Hashtbl.md#val-hash). This function allows this module to be passed as argument to the functor [`Hashtbl.Make`](./Stdlib-Hashtbl-Make.md).

since 5.1