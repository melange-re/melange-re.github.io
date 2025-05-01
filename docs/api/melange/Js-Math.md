# Module `Js.Math`
Bindings to the functions in the `Math` object
JavaScript Math API
```
val _E : float
```
Euler's number
```
val _LN2 : float
```
natural logarithm of 2
```
val _LN10 : float
```
natural logarithm of 10
```
val _LOG2E : float
```
base 2 logarithm of E
```
val _LOG10E : float
```
base 10 logarithm of E
```
val _PI : float
```
Pi... (ratio of the circumference and diameter of a circle)
```
val _SQRT1_2 : float
```
square root of 1/2
```
val _SQRT2 : float
```
square root of 2
```
val abs_int : int -> int
```
absolute value
```
val abs_float : float -> float
```
absolute value
```
val acos : float -> float
```
arccosine in radians, can return NaN
```
val acosh : float -> float
```
hyperbolic arccosine in raidans, can return NaN, ES2015
```
val asin : float -> float
```
arcsine in radians, can return NaN
```
val asinh : float -> float
```
hyperbolic arcsine in raidans, ES2015
```
val atan : float -> float
```
arctangent in radians
```
val atanh : float -> float
```
hyperbolic arctangent in radians, can return NaN, ES2015
```
val atan2 : y:float -> x:float -> float
```
arctangent of the quotient of x and y, mostly... this one's a bit weird
```
val cbrt : float -> float
```
cube root, can return NaN, ES2015
```
val unsafe_ceil_int : float -> int
```
may return values not representable by `int`
```
val ceil_int : float -> int
```
smallest int greater than or equal to the argument
```
val ceil_float : float -> float
```
smallest float greater than or equal to the argument
```
val clz32 : int -> int
```
number of leading zero bits of the argument's 32 bit int representation, ES2015
```
val cos : float -> float
```
cosine in radians
```
val cosh : float -> float
```
hyperbolic cosine in radians, ES2015
```
val exp : float -> float
```
natural exponentional
```
val expm1 : float -> float
```
natural exponential minus 1, ES2015
```
val unsafe_floor_int : float -> int
```
may return values not representable by `int`
```
val floor_int : float -> int
```
largest int greater than or equal to the arugment
```
val floor_float : float -> float
```
```
val fround : float -> float
```
round to nearest single precision float, ES2015
```
val hypot : float -> float -> float
```
pythagorean equation, ES2015
```
val hypotMany : float array -> float
```
generalized pythagorean equation, ES2015
```
val imul : int -> int -> int
```
32-bit integer multiplication, ES2015
```
val log : float -> float
```
natural logarithm, can return NaN
```
val log1p : float -> float
```
natural logarithm of 1 \+ the argument, can return NaN, ES2015
```
val log10 : float -> float
```
base 10 logarithm, can return NaN, ES2015
```
val log2 : float -> float
```
base 2 logarithm, can return NaN, ES2015
```
val max_int : int -> int -> int
```
max value
```
val maxMany_int : int array -> int
```
max value
```
val max_float : float -> float -> float
```
max value
```
val maxMany_float : float array -> float
```
max value
```
val min_int : int -> int -> int
```
min value
```
val minMany_int : int array -> int
```
min value
```
val min_float : float -> float -> float
```
min value
```
val minMany_float : float array -> float
```
min value
```
val pow_float : base:float -> exp:float -> float
```
base to the power of the exponent
```
val random : unit -> float
```
random number in \[0,1)
```
val random_int : int -> int -> int
```
random number in \[min,max)
```
val unsafe_round : float -> int
```
rounds to nearest integer, returns a value not representable as `int` if NaN
```
val round : float -> float
```
rounds to nearest integer
```
val sign_int : int -> int
```
the sign of the argument, 1, \-1 or 0, ES2015
```
val sign_float : float -> float
```
the sign of the argument, 1, \-1, 0, \-0 or NaN, ES2015
```
val sin : float -> float
```
sine in radians
```
val sinh : float -> float
```
hyperbolic sine in radians, ES2015
```
val sqrt : float -> float
```
square root, can return NaN
```
val tan : float -> float
```
tangent in radians
```
val tanh : float -> float
```
hyperbolic tangent in radians, ES2015
```
val unsafe_trunc : float -> int
```
truncate, ie. remove fractional digits, returns a value not representable as `int` if NaN, ES2015
```
val trunc : float -> float
```
truncate, ie. remove fractional digits, returns a value not representable as `int` if NaN, ES2015