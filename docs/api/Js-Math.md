
# Module `Js.Math`

Bindings to the functions in the `Math` object

JavaScript Math API

```ocaml
val _E : float
```
```reasonml
let _E: float;
```
Euler's number

```ocaml
val _LN2 : float
```
```reasonml
let _LN2: float;
```
natural logarithm of 2

```ocaml
val _LN10 : float
```
```reasonml
let _LN10: float;
```
natural logarithm of 10

```ocaml
val _LOG2E : float
```
```reasonml
let _LOG2E: float;
```
base 2 logarithm of E

```ocaml
val _LOG10E : float
```
```reasonml
let _LOG10E: float;
```
base 10 logarithm of E

```ocaml
val _PI : float
```
```reasonml
let _PI: float;
```
Pi... (ratio of the circumference and diameter of a circle)

```ocaml
val _SQRT1_2 : float
```
```reasonml
let _SQRT1_2: float;
```
square root of 1/2

```ocaml
val _SQRT2 : float
```
```reasonml
let _SQRT2: float;
```
square root of 2

```ocaml
val abs_int : int -> int
```
```reasonml
let abs_int: int => int;
```
absolute value

```ocaml
val abs_float : float -> float
```
```reasonml
let abs_float: float => float;
```
absolute value

```ocaml
val acos : float -> float
```
```reasonml
let acos: float => float;
```
arccosine in radians, can return NaN

```ocaml
val acosh : float -> float
```
```reasonml
let acosh: float => float;
```
hyperbolic arccosine in raidans, can return NaN, ES2015

```ocaml
val asin : float -> float
```
```reasonml
let asin: float => float;
```
arcsine in radians, can return NaN

```ocaml
val asinh : float -> float
```
```reasonml
let asinh: float => float;
```
hyperbolic arcsine in raidans, ES2015

```ocaml
val atan : float -> float
```
```reasonml
let atan: float => float;
```
arctangent in radians

```ocaml
val atanh : float -> float
```
```reasonml
let atanh: float => float;
```
hyperbolic arctangent in radians, can return NaN, ES2015

```ocaml
val atan2 : y:float -> x:float -> float
```
```reasonml
let atan2: y:float => x:float => float;
```
arctangent of the quotient of x and y, mostly... this one's a bit weird

```ocaml
val cbrt : float -> float
```
```reasonml
let cbrt: float => float;
```
cube root, can return NaN, ES2015

```ocaml
val unsafe_ceil_int : float -> int
```
```reasonml
let unsafe_ceil_int: float => int;
```
may return values not representable by `int`

```ocaml
val ceil_int : float -> int
```
```reasonml
let ceil_int: float => int;
```
smallest int greater than or equal to the argument

```ocaml
val ceil_float : float -> float
```
```reasonml
let ceil_float: float => float;
```
smallest float greater than or equal to the argument

```ocaml
val clz32 : int -> int
```
```reasonml
let clz32: int => int;
```
number of leading zero bits of the argument's 32 bit int representation, ES2015

```ocaml
val cos : float -> float
```
```reasonml
let cos: float => float;
```
cosine in radians

```ocaml
val cosh : float -> float
```
```reasonml
let cosh: float => float;
```
hyperbolic cosine in radians, ES2015

```ocaml
val exp : float -> float
```
```reasonml
let exp: float => float;
```
natural exponentional

```ocaml
val expm1 : float -> float
```
```reasonml
let expm1: float => float;
```
natural exponential minus 1, ES2015

```ocaml
val unsafe_floor_int : float -> int
```
```reasonml
let unsafe_floor_int: float => int;
```
may return values not representable by `int`

```ocaml
val floor_int : float -> int
```
```reasonml
let floor_int: float => int;
```
largest int greater than or equal to the arugment

```ocaml
val floor_float : float -> float
```
```reasonml
let floor_float: float => float;
```
```ocaml
val fround : float -> float
```
```reasonml
let fround: float => float;
```
round to nearest single precision float, ES2015

```ocaml
val hypot : float -> float -> float
```
```reasonml
let hypot: float => float => float;
```
pythagorean equation, ES2015

```ocaml
val hypotMany : float array -> float
```
```reasonml
let hypotMany: array(float) => float;
```
generalized pythagorean equation, ES2015

```ocaml
val imul : int -> int -> int
```
```reasonml
let imul: int => int => int;
```
32-bit integer multiplication, ES2015

```ocaml
val log : float -> float
```
```reasonml
let log: float => float;
```
natural logarithm, can return NaN

```ocaml
val log1p : float -> float
```
```reasonml
let log1p: float => float;
```
natural logarithm of 1 \+ the argument, can return NaN, ES2015

```ocaml
val log10 : float -> float
```
```reasonml
let log10: float => float;
```
base 10 logarithm, can return NaN, ES2015

```ocaml
val log2 : float -> float
```
```reasonml
let log2: float => float;
```
base 2 logarithm, can return NaN, ES2015

```ocaml
val max_int : int -> int -> int
```
```reasonml
let max_int: int => int => int;
```
max value

```ocaml
val maxMany_int : int array -> int
```
```reasonml
let maxMany_int: array(int) => int;
```
max value

```ocaml
val max_float : float -> float -> float
```
```reasonml
let max_float: float => float => float;
```
max value

```ocaml
val maxMany_float : float array -> float
```
```reasonml
let maxMany_float: array(float) => float;
```
max value

```ocaml
val min_int : int -> int -> int
```
```reasonml
let min_int: int => int => int;
```
min value

```ocaml
val minMany_int : int array -> int
```
```reasonml
let minMany_int: array(int) => int;
```
min value

```ocaml
val min_float : float -> float -> float
```
```reasonml
let min_float: float => float => float;
```
min value

```ocaml
val minMany_float : float array -> float
```
```reasonml
let minMany_float: array(float) => float;
```
min value

```ocaml
val pow_float : base:float -> exp:float -> float
```
```reasonml
let pow_float: base:float => exp:float => float;
```
base to the power of the exponent

```ocaml
val random : unit -> float
```
```reasonml
let random: unit => float;
```
random number in \[0,1)

```ocaml
val random_int : int -> int -> int
```
```reasonml
let random_int: int => int => int;
```
random number in \[min,max)

```ocaml
val unsafe_round : float -> int
```
```reasonml
let unsafe_round: float => int;
```
rounds to nearest integer, returns a value not representable as `int` if NaN

```ocaml
val round : float -> float
```
```reasonml
let round: float => float;
```
rounds to nearest integer

```ocaml
val sign_int : int -> int
```
```reasonml
let sign_int: int => int;
```
the sign of the argument, 1, \-1 or 0, ES2015

```ocaml
val sign_float : float -> float
```
```reasonml
let sign_float: float => float;
```
the sign of the argument, 1, \-1, 0, \-0 or NaN, ES2015

```ocaml
val sin : float -> float
```
```reasonml
let sin: float => float;
```
sine in radians

```ocaml
val sinh : float -> float
```
```reasonml
let sinh: float => float;
```
hyperbolic sine in radians, ES2015

```ocaml
val sqrt : float -> float
```
```reasonml
let sqrt: float => float;
```
square root, can return NaN

```ocaml
val tan : float -> float
```
```reasonml
let tan: float => float;
```
tangent in radians

```ocaml
val tanh : float -> float
```
```reasonml
let tanh: float => float;
```
hyperbolic tangent in radians, ES2015

```ocaml
val unsafe_trunc : float -> int
```
```reasonml
let unsafe_trunc: float => int;
```
truncate, ie. remove fractional digits, returns a value not representable as `int` if NaN, ES2015

```ocaml
val trunc : float -> float
```
```reasonml
let trunc: float => float;
```
truncate, ie. remove fractional digits, returns a value not representable as `int` if NaN, ES2015
