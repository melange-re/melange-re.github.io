
# Module `Stdlib.Float`

Floating-point arithmetic.

OCaml's floating-point numbers follow the IEEE 754 standard, using double precision (64 bits) numbers. Floating-point operations never raise an exception on overflow, underflow, division by zero, etc. Instead, special IEEE numbers are returned as appropriate, such as `infinity` for `1.0 /. 0.0`, `neg_infinity` for `-1.0 /. 0.0`, and `nan` ('not a number') for `0.0 /. 0.0`. These special numbers then propagate through floating-point computations as expected: for instance, `1.0 /. infinity` is `0.0`, basic arithmetic operations (`+.`, `-.`, `*.`, `/.`) with `nan` as an argument return `nan`, ...

since 4.07
```
val zero : float
```
The floating point 0.

since 4.08
```
val one : float
```
The floating-point 1\.

since 4.08
```
val minus_one : float
```
The floating-point \-1.

since 4.08
```
val neg : float -> float
```
Unary negation.

```
val add : float -> float -> float
```
Floating-point addition.

```
val sub : float -> float -> float
```
Floating-point subtraction.

```
val mul : float -> float -> float
```
Floating-point multiplication.

```
val div : float -> float -> float
```
Floating-point division.

```
val fma : float -> float -> float -> float
```
`fma x y z` returns `x * y + z`, with a best effort for computing this expression with a single rounding, using either hardware instructions (providing full IEEE compliance) or a software emulation.

On 64-bit Cygwin, 64-bit mingw-w64 and MSVC 2017 and earlier, this function may be emulated owing to known bugs on limitations on these platforms. Note: since software emulation of the fma is costly, make sure that you are using hardware fma support if performance matters.

since 4.08
```
val rem : float -> float -> float
```
`rem a b` returns the remainder of `a` with respect to `b`. The returned value is `a -. n *. b`, where `n` is the quotient `a /. b` rounded towards zero to an integer.

```
val succ : float -> float
```
`succ x` returns the floating point number right after `x` i.e., the smallest floating-point number greater than `x`. See also [`next_after`](./#val-next_after).

since 4.08
```
val pred : float -> float
```
`pred x` returns the floating-point number right before `x` i.e., the greatest floating-point number smaller than `x`. See also [`next_after`](./#val-next_after).

since 4.08
```
val abs : float -> float
```
`abs f` returns the absolute value of `f`.

```
val infinity : float
```
Positive infinity.

```
val neg_infinity : float
```
Negative infinity.

```
val nan : float
```
A special floating-point value denoting the result of an undefined operation such as `0.0 /. 0.0`. Stands for 'not a number'. Any floating-point operation with `nan` as argument returns `nan` as result, unless otherwise specified in IEEE 754 standard. As for floating-point comparisons, `=`, `<`, `<=`, `>` and `>=` return `false` and `<>` returns `true` if one or both of their arguments is `nan`.

`nan` is `quiet_nan` since 5.1; it was a signaling NaN before.

```
val signaling_nan : float
```
Signaling NaN. The corresponding signals do not raise OCaml exception, but the value can be useful for interoperability with C libraries.

since 5.1
```
val quiet_nan : float
```
Quiet NaN.

since 5.1
```
val pi : float
```
The constant pi.

```
val max_float : float
```
The largest positive finite value of type `float`.

```
val min_float : float
```
The smallest positive, non-zero, non-denormalized value of type `float`.

```
val epsilon : float
```
The difference between `1.0` and the smallest exactly representable floating-point number greater than `1.0`.

```
val is_finite : float -> bool
```
`is_finite x` is `true` if and only if `x` is finite i.e., not infinite and not [`nan`](./#val-nan).

since 4.08
```
val is_infinite : float -> bool
```
`is_infinite x` is `true` if and only if `x` is [`infinity`](./#val-infinity) or [`neg_infinity`](./#val-neg_infinity).

since 4.08
```
val is_nan : float -> bool
```
`is_nan x` is `true` if and only if `x` is not a number (see [`nan`](./#val-nan)).

since 4.08
```
val is_integer : float -> bool
```
`is_integer x` is `true` if and only if `x` is an integer.

since 4.08
```
val of_int : int -> float
```
Convert an integer to floating-point.

```
val to_int : float -> int
```
Truncate the given floating-point number to an integer. The result is unspecified if the argument is `nan` or falls outside the range of representable integers.

```
val of_string : string -> float
```
Convert the given string to a float. The string is read in decimal (by default) or in hexadecimal (marked by `0x` or `0X`). The format of decimal floating-point numbers is ` [-] dd.ddd (e|E) [+|-] dd `, where `d` stands for a decimal digit. The format of hexadecimal floating-point numbers is ` [-] 0(x|X) hh.hhh (p|P) [+|-] dd `, where `h` stands for an hexadecimal digit and `d` for a decimal digit. In both cases, at least one of the integer and fractional parts must be given; the exponent part is optional. The `_` (underscore) character can appear anywhere in the string and is ignored. Depending on the execution platforms, other representations of floating-point numbers can be accepted, but should not be relied upon.

raises [`Failure`](./Stdlib.md#exception-Failure) if the given string is not a valid representation of a float.
```
val of_string_opt : string -> float option
```
Same as `of_string`, but returns `None` instead of raising.

```
val to_string : float -> string
```
Return a string representation of a floating-point number.

This conversion can involve a loss of precision. For greater control over the manner in which the number is printed, see [`Printf`](./Stdlib-Printf.md).

This function is an alias for [`Stdlib.string_of_float`](./Stdlib.md#val-string_of_float).

```
type fpclass = fpclass = 
```
```
| FP_normal
```
Normal number, none of the below

```
| FP_subnormal
```
Number very close to 0.0, has reduced precision

```
| FP_zero
```
Number is 0.0 or \-0.0

```
| FP_infinite
```
Number is positive or negative infinity

```
| FP_nan
```
Not a number: result of an undefined operation

```

```
The five classes of floating-point numbers, as determined by the [`classify_float`](./#val-classify_float) function.

```
val classify_float : float -> fpclass
```
Return the class of the given floating-point number: normal, subnormal, zero, infinite, or not a number.

```
val pow : float -> float -> float
```
Exponentiation.

```
val sqrt : float -> float
```
Square root.

```
val cbrt : float -> float
```
Cube root.

since 4.13
```
val exp : float -> float
```
Exponential.

```
val exp2 : float -> float
```
Base 2 exponential function.

since 4.13
```
val log : float -> float
```
Natural logarithm.

```
val log10 : float -> float
```
Base 10 logarithm.

```
val log2 : float -> float
```
Base 2 logarithm.

since 4.13
```
val expm1 : float -> float
```
`expm1 x` computes `exp x -. 1.0`, giving numerically-accurate results even if `x` is close to `0.0`.

```
val log1p : float -> float
```
`log1p x` computes `log(1.0 +. x)` (natural logarithm), giving numerically-accurate results even if `x` is close to `0.0`.

```
val cos : float -> float
```
Cosine. Argument is in radians.

```
val sin : float -> float
```
Sine. Argument is in radians.

```
val tan : float -> float
```
Tangent. Argument is in radians.

```
val acos : float -> float
```
Arc cosine. The argument must fall within the range `[-1.0, 1.0]`. Result is in radians and is between `0.0` and `pi`.

```
val asin : float -> float
```
Arc sine. The argument must fall within the range `[-1.0, 1.0]`. Result is in radians and is between `-pi/2` and `pi/2`.

```
val atan : float -> float
```
Arc tangent. Result is in radians and is between `-pi/2` and `pi/2`.

```
val atan2 : float -> float -> float
```
`atan2 y x` returns the arc tangent of `y /. x`. The signs of `x` and `y` are used to determine the quadrant of the result. Result is in radians and is between `-pi` and `pi`.

```
val hypot : float -> float -> float
```
`hypot x y` returns `sqrt(x *. x +. y *. y)`, that is, the length of the hypotenuse of a right-angled triangle with sides of length `x` and `y`, or, equivalently, the distance of the point `(x,y)` to origin. If one of `x` or `y` is infinite, returns `infinity` even if the other is `nan`.

```
val cosh : float -> float
```
Hyperbolic cosine. Argument is in radians.

```
val sinh : float -> float
```
Hyperbolic sine. Argument is in radians.

```
val tanh : float -> float
```
Hyperbolic tangent. Argument is in radians.

```
val acosh : float -> float
```
Hyperbolic arc cosine. The argument must fall within the range `[1.0, inf]`. Result is in radians and is between `0.0` and `inf`.

since 4.13
```
val asinh : float -> float
```
Hyperbolic arc sine. The argument and result range over the entire real line. Result is in radians.

since 4.13
```
val atanh : float -> float
```
Hyperbolic arc tangent. The argument must fall within the range `[-1.0, 1.0]`. Result is in radians and ranges over the entire real line.

since 4.13
```
val erf : float -> float
```
Error function. The argument ranges over the entire real line. The result is always within `[-1.0, 1.0]`.

since 4.13
```
val erfc : float -> float
```
Complementary error function (`erfc x = 1 - erf x`). The argument ranges over the entire real line. The result is always within `[0.0, 2.0]`.

since 4.13
```
val trunc : float -> float
```
`trunc x` rounds `x` to the nearest integer whose absolute value is less than or equal to `x`.

since 4.08
```
val round : float -> float
```
`round x` rounds `x` to the nearest integer with ties (fractional values of 0.5) rounded away from zero, regardless of the current rounding direction. If `x` is an integer, `+0.`, `-0.`, `nan`, or infinite, `x` itself is returned.

On 64-bit mingw-w64, this function may be emulated owing to a bug in the C runtime library (CRT) on this platform.

since 4.08
```
val ceil : float -> float
```
Round above to an integer value. `ceil f` returns the least integer value greater than or equal to `f`. The result is returned as a float.

```
val floor : float -> float
```
Round below to an integer value. `floor f` returns the greatest integer value less than or equal to `f`. The result is returned as a float.

```
val next_after : float -> float -> float
```
`next_after x y` returns the next representable floating-point value following `x` in the direction of `y`. More precisely, if `y` is greater (resp. less) than `x`, it returns the smallest (resp. largest) representable number greater (resp. less) than `x`. If `x` equals `y`, the function returns `y`. If `x` or `y` is `nan`, a `nan` is returned. Note that `next_after max_float infinity = infinity` and that `next_after 0. infinity` is the smallest denormalized positive number. If `x` is the smallest denormalized positive number, `next_after x 0. = 0.`

since 4.08
```
val copy_sign : float -> float -> float
```
`copy_sign x y` returns a float whose absolute value is that of `x` and whose sign is that of `y`. If `x` is `nan`, returns `nan`. If `y` is `nan`, returns either `x` or `-. x`, but it is not specified which.

```
val sign_bit : float -> bool
```
`sign_bit x` is `true` if and only if the sign bit of `x` is set. For example `sign_bit 1.` and `signbit 0.` are `false` while `sign_bit (-1.)` and `sign_bit (-0.)` are `true`.

since 4.08
```
val frexp : float -> float * int
```
`frexp f` returns the pair of the significant and the exponent of `f`. When `f` is zero, the significant `x` and the exponent `n` of `f` are equal to zero. When `f` is non-zero, they are defined by `f = x *. 2 ** n` and `0.5 <= x < 1.0`.

```
val ldexp : float -> int -> float
```
`ldexp x n` returns `x *. 2 ** n`.

```
val modf : float -> float * float
```
`modf f` returns the pair of the fractional and integral part of `f`.

```
type t = float
```
An alias for the type of floating-point numbers.

```
val compare : t -> t -> int
```
`compare x y` returns `0` if `x` is equal to `y`, a negative integer if `x` is less than `y`, and a positive integer if `x` is greater than `y`. `compare` treats `nan` as equal to itself and less than any other float value. This treatment of `nan` ensures that `compare` defines a total ordering relation.

```
val equal : t -> t -> bool
```
The equal function for floating-point numbers, compared using [`compare`](./#val-compare).

```
val min : t -> t -> t
```
`min x y` returns the minimum of `x` and `y`. It returns `nan` when `x` or `y` is `nan`. Moreover `min (-0.) (+0.) = -0.`

since 4.08
```
val max : float -> float -> float
```
`max x y` returns the maximum of `x` and `y`. It returns `nan` when `x` or `y` is `nan`. Moreover `max (-0.) (+0.) = +0.`

since 4.08
```
val min_max : float -> float -> float * float
```
`min_max x y` is `(min x y, max x y)`, just more efficient.

since 4.08
```
val min_num : t -> t -> t
```
`min_num x y` returns the minimum of `x` and `y` treating `nan` as missing values. If both `x` and `y` are `nan`, `nan` is returned. Moreover `min_num (-0.) (+0.) = -0.`

since 4.08
```
val max_num : t -> t -> t
```
`max_num x y` returns the maximum of `x` and `y` treating `nan` as missing values. If both `x` and `y` are `nan` `nan` is returned. Moreover `max_num (-0.) (+0.) = +0.`

since 4.08
```
val min_max_num : float -> float -> float * float
```
`min_max_num x y` is `(min_num x y, max_num x y)`, just more efficient. Note that in particular `min_max_num x nan = (x, x)` and `min_max_num nan y = (y, y)`.

since 4.08
```
val seeded_hash : int -> t -> int
```
A seeded hash function for floats, with the same output value as [`Hashtbl.seeded_hash`](./Stdlib-Hashtbl.md#val-seeded_hash). This function allows this module to be passed as argument to the functor [`Hashtbl.MakeSeeded`](./Stdlib-Hashtbl-MakeSeeded.md).

since 5.1
```
val hash : t -> int
```
An unseeded hash function for floats, with the same output value as [`Hashtbl.hash`](./Stdlib-Hashtbl.md#val-hash). This function allows this module to be passed as argument to the functor [`Hashtbl.Make`](./Stdlib-Hashtbl-Make.md).

```
module Array : sig ... end
```
Float arrays with packed representation.
