
# Module `Stdlib.Complex`

Complex numbers.

This module provides arithmetic operations on complex numbers. Complex numbers are represented by their real and imaginary parts (cartesian representation). Each part is represented by a double-precision floating-point number (type `float`).

```
type t = {
```
`re : float;`
`im : float;`
```ocaml
}
```
```reasonml
};
```
The type of complex numbers. `re` is the real part and `im` the imaginary part.

```ocaml
val zero : t
```
```reasonml
let zero: t;
```
The complex number `0`.

```ocaml
val one : t
```
```reasonml
let one: t;
```
The complex number `1`.

```ocaml
val i : t
```
```reasonml
let i: t;
```
The complex number `i`.

```ocaml
val neg : t -> t
```
```reasonml
let neg: t => t;
```
Unary negation.

```ocaml
val conj : t -> t
```
```reasonml
let conj: t => t;
```
Conjugate: given the complex `x + i.y`, returns `x - i.y`.

```ocaml
val add : t -> t -> t
```
```reasonml
let add: t => t => t;
```
Addition

```ocaml
val sub : t -> t -> t
```
```reasonml
let sub: t => t => t;
```
Subtraction

```ocaml
val mul : t -> t -> t
```
```reasonml
let mul: t => t => t;
```
Multiplication

```ocaml
val inv : t -> t
```
```reasonml
let inv: t => t;
```
Multiplicative inverse (`1/z`).

```ocaml
val div : t -> t -> t
```
```reasonml
let div: t => t => t;
```
Division

```ocaml
val sqrt : t -> t
```
```reasonml
let sqrt: t => t;
```
Square root. The result `x + i.y` is such that `x > 0` or `x = 0` and `y >= 0`. This function has a discontinuity along the negative real axis.

```ocaml
val norm2 : t -> float
```
```reasonml
let norm2: t => float;
```
Norm squared: given `x + i.y`, returns `x^2 + y^2`.

```ocaml
val norm : t -> float
```
```reasonml
let norm: t => float;
```
Norm: given `x + i.y`, returns `sqrt(x^2 + y^2)`.

```ocaml
val arg : t -> float
```
```reasonml
let arg: t => float;
```
Argument. The argument of a complex number is the angle in the complex plane between the positive real axis and a line passing through zero and the number. This angle ranges from `-pi` to `pi`. This function has a discontinuity along the negative real axis.

```ocaml
val polar : float -> float -> t
```
```reasonml
let polar: float => float => t;
```
`polar norm arg` returns the complex having norm `norm` and argument `arg`.

```ocaml
val exp : t -> t
```
```reasonml
let exp: t => t;
```
Exponentiation. `exp z` returns `e` to the `z` power.

```ocaml
val log : t -> t
```
```reasonml
let log: t => t;
```
Natural logarithm (in base `e`).

```ocaml
val pow : t -> t -> t
```
```reasonml
let pow: t => t => t;
```
Power function. `pow z1 z2` returns `z1` to the `z2` power.
