
# Module `Stdlib`

The OCaml Standard library.

This module is automatically opened at the beginning of each compilation. All components of this module can therefore be referred by their short name, without prefixing them by `Stdlib`.

In particular, it provides the basic operations over the built-in types (numbers, booleans, byte sequences, strings, exceptions, references, lists, arrays, input-output channels, ...) and the [standard library modules](./#modules).


## Exceptions

```ocaml
val raise : exn -> 'a
```
```reasonml
let raise: exn => 'a;
```
Raise the given exception value

```ocaml
val raise_notrace : exn -> 'a
```
```reasonml
let raise_notrace: exn => 'a;
```
A faster version `raise` which does not record the backtrace.

since 4\.02
```ocaml
val invalid_arg : string -> 'a
```
```reasonml
let invalid_arg: string => 'a;
```
Raise exception `Invalid_argument` with the given string.

```ocaml
val failwith : string -> 'a
```
```reasonml
let failwith: string => 'a;
```
Raise exception `Failure` with the given string.

```ocaml
exception Exit
```
```reasonml
exception Exit;
```
The `Exit` exception is not raised by any library function. It is provided for use in your programs.

```ocaml
exception Match_failure of string * int * int
```
```reasonml
exception Match_failure((string, int, int));
```
Exception raised when none of the cases of a pattern-matching apply. The arguments are the location of the match keyword in the source code (file name, line number, column number).

```ocaml
exception Assert_failure of string * int * int
```
```reasonml
exception Assert_failure((string, int, int));
```
Exception raised when an assertion fails. The arguments are the location of the assert keyword in the source code (file name, line number, column number).

```ocaml
exception Invalid_argument of string
```
```reasonml
exception Invalid_argument(string);
```
Exception raised by library functions to signal that the given arguments do not make sense. The string gives some information to the programmer. As a general rule, this exception should not be caught, it denotes a programming error and the code should be modified not to trigger it.

```ocaml
exception Failure of string
```
```reasonml
exception Failure(string);
```
Exception raised by library functions to signal that they are undefined on the given arguments. The string is meant to give some information to the programmer; you must not pattern match on the string literal because it may change in future versions (use Failure \_ instead).

```ocaml
exception Not_found
```
```reasonml
exception Not_found;
```
Exception raised by search functions when the desired object could not be found.

```ocaml
exception Out_of_memory
```
```reasonml
exception Out_of_memory;
```
Exception raised by the garbage collector when there is insufficient memory to complete the computation. (Not reliable for allocations on the minor heap.)

```ocaml
exception Stack_overflow
```
```reasonml
exception Stack_overflow;
```
Exception raised by the bytecode interpreter when the evaluation stack reaches its maximal size. This often indicates infinite or excessively deep recursion in the user's program.

Before 4\.10, it was not fully implemented by the native-code compiler.

```ocaml
exception Sys_error of string
```
```reasonml
exception Sys_error(string);
```
Exception raised by the input/output functions to report an operating system error. The string is meant to give some information to the programmer; you must not pattern match on the string literal because it may change in future versions (use Sys\_error \_ instead).

```ocaml
exception End_of_file
```
```reasonml
exception End_of_file;
```
Exception raised by input functions to signal that the end of file has been reached.

```ocaml
exception Division_by_zero
```
```reasonml
exception Division_by_zero;
```
Exception raised by integer division and remainder operations when their second argument is zero.

```ocaml
exception Sys_blocked_io
```
```reasonml
exception Sys_blocked_io;
```
A special case of Sys\_error raised when no I/O is possible on a non-blocking I/O channel.

```ocaml
exception Undefined_recursive_module of string * int * int
```
```reasonml
exception Undefined_recursive_module((string, int, int));
```
Exception raised when an ill-founded recursive module definition is evaluated. The arguments are the location of the definition in the source code (file name, line number, column number).


## Comparisons

```ocaml
val (=) : 'a -> 'a -> bool
```
```reasonml
let (=): 'a => 'a => bool;
```
Alias of [`Repr.equal`](./Stdlib-Repr.md#val-equal) Left-associative operator, see `Ocaml_operators` for more information.

```ocaml
val (<>) : 'a -> 'a -> bool
```
```reasonml
let (<>): 'a => 'a => bool;
```
Negation of [`Repr.equal`](./Stdlib-Repr.md#val-equal). Left-associative operator, see `Ocaml_operators` for more information.

```ocaml
val (<) : 'a -> 'a -> bool
```
```reasonml
let (<): 'a => 'a => bool;
```
See [`Stdlib.(>=)`](./#val-\(>=\)). Left-associative operator, see `Ocaml_operators` for more information.

```ocaml
val (>) : 'a -> 'a -> bool
```
```reasonml
let (>): 'a => 'a => bool;
```
See [`Stdlib.(>=)`](./#val-\(>=\)). Left-associative operator, see `Ocaml_operators` for more information.

```ocaml
val (<=) : 'a -> 'a -> bool
```
```reasonml
let (<=): 'a => 'a => bool;
```
See [`Stdlib.(>=)`](./#val-\(>=\)). Left-associative operator, see `Ocaml_operators` for more information.

```ocaml
val (>=) : 'a -> 'a -> bool
```
```reasonml
let (>=): 'a => 'a => bool;
```
Structural ordering functions. These functions coincide with the usual orderings over integers, characters, strings, byte sequences and floating-point numbers, and extend them to a total ordering over all types. The ordering is compatible with [`Repr.equal`](./Stdlib-Repr.md#val-equal). As in the case of [`Repr.equal`](./Stdlib-Repr.md#val-equal), mutable structures are compared by contents. Comparison between functional values raises `Invalid_argument`. Comparison between cyclic structures may not terminate. Left-associative operator, see `Ocaml_operators` for more information.

```ocaml
val compare : 'a -> 'a -> int
```
```reasonml
let compare: 'a => 'a => int;
```
Alias of [`Repr.compare`](./Stdlib-Repr.md#val-compare).

```ocaml
val min : 'a -> 'a -> 'a
```
```reasonml
let min: 'a => 'a => 'a;
```
```ocaml
val max : 'a -> 'a -> 'a
```
```reasonml
let max: 'a => 'a => 'a;
```
```ocaml
val (==) : 'a -> 'a -> bool
```
```reasonml
let (==): 'a => 'a => bool;
```
Alias of [`Repr.phys_equal`](./Stdlib-Repr.md#val-phys_equal). Left-associative operator, see `Ocaml_operators` for more information.

```ocaml
val (!=) : 'a -> 'a -> bool
```
```reasonml
let (!=): 'a => 'a => bool;
```
Negation of [`Repr.phys_equal`](./Stdlib-Repr.md#val-phys_equal). Left-associative operator, see `Ocaml_operators` for more information.


## Boolean operations

```ocaml
val not : bool -> bool
```
```reasonml
let not: bool => bool;
```
The boolean negation.

```ocaml
val (&&) : bool -> bool -> bool
```
```reasonml
let (&&): bool => bool => bool;
```
The boolean 'and'. Evaluation is sequential, left-to-right: in `e1 && e2`, `e1` is evaluated first, and if it returns `false`, `e2` is not evaluated at all. Right-associative operator, see `Ocaml_operators` for more information.

```ocaml
val (||) : bool -> bool -> bool
```
```reasonml
let (||): bool => bool => bool;
```
The boolean 'or'. Evaluation is sequential, left-to-right: in `e1 || e2`, `e1` is evaluated first, and if it returns `true`, `e2` is not evaluated at all. Right-associative operator, see `Ocaml_operators` for more information.


## Debugging

```ocaml
val __LOC__ : string
```
```reasonml
let __LOC__: string;
```
`__LOC__` returns the location at which this expression appears in the file currently being parsed by the compiler, with the standard error format of OCaml: "File %S, line %d, characters %d-%d".

since 4\.02
```ocaml
val __FILE__ : string
```
```reasonml
let __FILE__: string;
```
`__FILE__` returns the name of the file currently being parsed by the compiler.

since 4\.02
```ocaml
val __LINE__ : int
```
```reasonml
let __LINE__: int;
```
`__LINE__` returns the line number at which this expression appears in the file currently being parsed by the compiler.

since 4\.02
```ocaml
val __MODULE__ : string
```
```reasonml
let __MODULE__: string;
```
`__MODULE__` returns the module name of the file being parsed by the compiler.

since 4\.02
```ocaml
val __POS__ : string * int * int * int
```
```reasonml
let __POS__: (string, int, int, int);
```
`__POS__` returns a tuple `(file,lnum,cnum,enum)`, corresponding to the location at which this expression appears in the file currently being parsed by the compiler. `file` is the current filename, `lnum` the line number, `cnum` the character position in the line and `enum` the last character position in the line.

since 4\.02
```ocaml
val __FUNCTION__ : string
```
```reasonml
let __FUNCTION__: string;
```
`__FUNCTION__` returns the name of the current function or method, including any enclosing modules or classes.

since 4\.12
```ocaml
val __LOC_OF__ : 'a -> string * 'a
```
```reasonml
let __LOC_OF__: 'a => (string, 'a);
```
`__LOC_OF__ expr` returns a pair `(loc, expr)` where `loc` is the location of `expr` in the file currently being parsed by the compiler, with the standard error format of OCaml: "File %S, line %d, characters %d-%d".

since 4\.02
```ocaml
val __LINE_OF__ : 'a -> int * 'a
```
```reasonml
let __LINE_OF__: 'a => (int, 'a);
```
`__LINE_OF__ expr` returns a pair `(line, expr)`, where `line` is the line number at which the expression `expr` appears in the file currently being parsed by the compiler.

since 4\.02
```ocaml
val __POS_OF__ : 'a -> (string * int * int * int) * 'a
```
```reasonml
let __POS_OF__: 'a => ((string, int, int, int), 'a);
```
`__POS_OF__ expr` returns a pair `(loc,expr)`, where `loc` is a tuple `(file,lnum,cnum,enum)` corresponding to the location at which the expression `expr` appears in the file currently being parsed by the compiler. `file` is the current filename, `lnum` the line number, `cnum` the character position in the line and `enum` the last character position in the line.

since 4\.02

## Composition operators

```ocaml
val (|>) : 'a -> ('a -> 'b) -> 'b
```
```reasonml
let (|>): 'a => ('a => 'b) => 'b;
```
Reverse-application operator: `x |> f |> g` is exactly equivalent to `g (f (x))`. Left-associative operator, see `Ocaml_operators` for more information.

since 4\.01
```ocaml
val (@@) : ('a -> 'b) -> 'a -> 'b
```
```reasonml
let (@@): ('a => 'b) => 'a => 'b;
```
Application operator: `g @@ f @@ x` is exactly equivalent to `g (f (x))`. Right-associative operator, see `Ocaml_operators` for more information.

since 4\.01

## Integer arithmetic

Integers are `Sys.int_size` bits wide. All operations are taken modulo 2`Sys.int_size`. They do not fail on overflow.

```ocaml
val (~-) : int -> int
```
```reasonml
let (~-): int => int;
```
Unary negation. You can also write `- e` instead of `~- e`. Unary operator, see `Ocaml_operators` for more information.

```ocaml
val (~+) : int -> int
```
```reasonml
let (~+): int => int;
```
Unary addition. You can also write `+ e` instead of `~+ e`. Unary operator, see `Ocaml_operators` for more information.

since 3\.12
```ocaml
val succ : int -> int
```
```reasonml
let succ: int => int;
```
`succ x` is `x + 1`.

```ocaml
val pred : int -> int
```
```reasonml
let pred: int => int;
```
`pred x` is `x - 1`.

```ocaml
val (+) : int -> int -> int
```
```reasonml
let (+): int => int => int;
```
Integer addition. Left-associative operator, see `Ocaml_operators` for more information.

```ocaml
val (-) : int -> int -> int
```
```reasonml
let (-): int => int => int;
```
Integer subtraction. Left-associative operator, , see `Ocaml_operators` for more information.

```ocaml
val (*) : int -> int -> int
```
```reasonml
let (*): int => int => int;
```
Integer multiplication. Left-associative operator, see `Ocaml_operators` for more information.

```ocaml
val (/) : int -> int -> int
```
```reasonml
let (/): int => int => int;
```
Integer division. Integer division rounds the real quotient of its arguments towards zero. More precisely, if `x >= 0` and `y > 0`, `x / y` is the greatest integer less than or equal to the real quotient of `x` by `y`. Moreover, `(- x) / y = x / (- y) = - (x / y)`. Left-associative operator, see `Ocaml_operators` for more information.

raises [`Division_by_zero`](./#exception-Division_by_zero) if the second argument is 0.
```ocaml
val (mod) : int -> int -> int
```
```reasonml
let (mod): int => int => int;
```
Integer remainder. If `y` is not zero, the result of `x mod y` satisfies the following properties: `x = (x / y) * y + x mod y` and `abs(x mod y) <= abs(y) - 1`. If `y = 0`, `x mod y` raises `Division_by_zero`. Note that `x mod y` is negative only if `x < 0`. Left-associative operator, see `Ocaml_operators` for more information.

raises [`Division_by_zero`](./#exception-Division_by_zero) if y is zero.
```ocaml
val abs : int -> int
```
```reasonml
let abs: int => int;
```
`abs x` is the absolute value of `x`. On `min_int` this is `min_int` itself and thus remains negative.

```ocaml
val max_int : int
```
```reasonml
let max_int: int;
```
The greatest representable integer.

```ocaml
val min_int : int
```
```reasonml
let min_int: int;
```
The smallest representable integer.


### Bitwise operations

```ocaml
val (land) : int -> int -> int
```
```reasonml
let (land): int => int => int;
```
Bitwise logical and. Left-associative operator, see `Ocaml_operators` for more information.

```ocaml
val (lor) : int -> int -> int
```
```reasonml
let (lor): int => int => int;
```
Bitwise logical or. Left-associative operator, see `Ocaml_operators` for more information.

```ocaml
val (lxor) : int -> int -> int
```
```reasonml
let (lxor): int => int => int;
```
Bitwise logical exclusive or. Left-associative operator, see `Ocaml_operators` for more information.

```ocaml
val lnot : int -> int
```
```reasonml
let lnot: int => int;
```
Bitwise logical negation.

```ocaml
val (lsl) : int -> int -> int
```
```reasonml
let (lsl): int => int => int;
```
`n lsl m` shifts `n` to the left by `m` bits. The result is unspecified if `m < 0` or `m > Sys.int_size`. Right-associative operator, see `Ocaml_operators` for more information.

```ocaml
val (lsr) : int -> int -> int
```
```reasonml
let (lsr): int => int => int;
```
`n lsr m` shifts `n` to the right by `m` bits. This is a logical shift: zeroes are inserted regardless of the sign of `n`. The result is unspecified if `m < 0` or `m > Sys.int_size`. Right-associative operator, see `Ocaml_operators` for more information.

```ocaml
val (asr) : int -> int -> int
```
```reasonml
let (asr): int => int => int;
```
`n asr m` shifts `n` to the right by `m` bits. This is an arithmetic shift: the sign bit of `n` is replicated. The result is unspecified if `m < 0` or `m > Sys.int_size`. Right-associative operator, see `Ocaml_operators` for more information.


## Floating-point arithmetic

OCaml's floating-point numbers follow the IEEE 754 standard, using double precision (64 bits) numbers. Floating-point operations never raise an exception on overflow, underflow, division by zero, etc. Instead, special IEEE numbers are returned as appropriate, such as `infinity` for `1.0 /. 0.0`, `neg_infinity` for `-1.0 /. 0.0`, and `nan` ('not a number') for `0.0 /. 0.0`. These special numbers then propagate through floating-point computations as expected: for instance, `1.0 /. infinity` is `0.0`, basic arithmetic operations (`+.`, `-.`, `*.`, `/.`) with `nan` as an argument return `nan`, ...

```ocaml
val (~-.) : float -> float
```
```reasonml
let (~-.): float => float;
```
Unary negation. You can also write `-. e` instead of `~-. e`. Unary operator, see `Ocaml_operators` for more information.

```ocaml
val (~+.) : float -> float
```
```reasonml
let (~+.): float => float;
```
Unary addition. You can also write `+. e` instead of `~+. e`. Unary operator, see `Ocaml_operators` for more information.

since 3\.12
```ocaml
val (+.) : float -> float -> float
```
```reasonml
let (+.): float => float => float;
```
Floating-point addition. Left-associative operator, see `Ocaml_operators` for more information.

```ocaml
val (-.) : float -> float -> float
```
```reasonml
let (-.): float => float => float;
```
Floating-point subtraction. Left-associative operator, see `Ocaml_operators` for more information.

```ocaml
val (*.) : float -> float -> float
```
```reasonml
let (*.): float => float => float;
```
Floating-point multiplication. Left-associative operator, see `Ocaml_operators` for more information.

```ocaml
val (/.) : float -> float -> float
```
```reasonml
let (/.): float => float => float;
```
Floating-point division. Left-associative operator, see `Ocaml_operators` for more information.

```ocaml
val (**) : float -> float -> float
```
```reasonml
let (**): float => float => float;
```
Exponentiation.

```ocaml
val sqrt : float -> float
```
```reasonml
let sqrt: float => float;
```
Square root.

```ocaml
val exp : float -> float
```
```reasonml
let exp: float => float;
```
Exponential.

```ocaml
val log : float -> float
```
```reasonml
let log: float => float;
```
Natural logarithm.

```ocaml
val log10 : float -> float
```
```reasonml
let log10: float => float;
```
Base 10 logarithm.

```ocaml
val expm1 : float -> float
```
```reasonml
let expm1: float => float;
```
`expm1 x` computes `exp x -. 1.0`, giving numerically-accurate results even if `x` is close to `0.0`.

since 3\.12.0
```ocaml
val log1p : float -> float
```
```reasonml
let log1p: float => float;
```
`log1p x` computes `log(1.0 +. x)` (natural logarithm), giving numerically-accurate results even if `x` is close to `0.0`.

since 3\.12.0
```ocaml
val cos : float -> float
```
```reasonml
let cos: float => float;
```
Cosine. Argument is in radians.

```ocaml
val sin : float -> float
```
```reasonml
let sin: float => float;
```
Sine. Argument is in radians.

```ocaml
val tan : float -> float
```
```reasonml
let tan: float => float;
```
Tangent. Argument is in radians.

```ocaml
val acos : float -> float
```
```reasonml
let acos: float => float;
```
Arc cosine. The argument must fall within the range `[-1.0, 1.0]`. Result is in radians and is between `0.0` and `pi`.

```ocaml
val asin : float -> float
```
```reasonml
let asin: float => float;
```
Arc sine. The argument must fall within the range `[-1.0, 1.0]`. Result is in radians and is between `-pi/2` and `pi/2`.

```ocaml
val atan : float -> float
```
```reasonml
let atan: float => float;
```
Arc tangent. Result is in radians and is between `-pi/2` and `pi/2`.

```ocaml
val atan2 : float -> float -> float
```
```reasonml
let atan2: float => float => float;
```
`atan2 y x` returns the arc tangent of `y /. x`. The signs of `x` and `y` are used to determine the quadrant of the result. Result is in radians and is between `-pi` and `pi`.

```ocaml
val hypot : float -> float -> float
```
```reasonml
let hypot: float => float => float;
```
`hypot x y` returns `sqrt(x *. x + y *. y)`, that is, the length of the hypotenuse of a right-angled triangle with sides of length `x` and `y`, or, equivalently, the distance of the point `(x,y)` to origin.

since 4\.00.0
```ocaml
val cosh : float -> float
```
```reasonml
let cosh: float => float;
```
Hyperbolic cosine. Argument is in radians.

```ocaml
val sinh : float -> float
```
```reasonml
let sinh: float => float;
```
Hyperbolic sine. Argument is in radians.

```ocaml
val tanh : float -> float
```
```reasonml
let tanh: float => float;
```
Hyperbolic tangent. Argument is in radians.

```ocaml
val acosh : float -> float
```
```reasonml
let acosh: float => float;
```
Hyperbolic arc cosine. The argument must fall within the range `[1.0, inf]`. Result is in radians and is between `0.0` and `inf`.

since 4\.13.0
```ocaml
val asinh : float -> float
```
```reasonml
let asinh: float => float;
```
Hyperbolic arc sine. The argument and result range over the entire real line. Result is in radians.

since 4\.13.0
```ocaml
val atanh : float -> float
```
```reasonml
let atanh: float => float;
```
Hyperbolic arc tangent. The argument must fall within the range `[-1.0, 1.0]`. Result is in radians and ranges over the entire real line.

since 4\.13.0
```ocaml
val ceil : float -> float
```
```reasonml
let ceil: float => float;
```
Round above to an integer value. `ceil f` returns the least integer value greater than or equal to `f`. The result is returned as a float.

```ocaml
val floor : float -> float
```
```reasonml
let floor: float => float;
```
Round below to an integer value. `floor f` returns the greatest integer value less than or equal to `f`. The result is returned as a float.

```ocaml
val abs_float : float -> float
```
```reasonml
let abs_float: float => float;
```
`abs_float f` returns the absolute value of `f`.

```ocaml
val copysign : float -> float -> float
```
```reasonml
let copysign: float => float => float;
```
`copysign x y` returns a float whose absolute value is that of `x` and whose sign is that of `y`. If `x` is `nan`, returns `nan`. If `y` is `nan`, returns either `x` or `-. x`, but it is not specified which.

since 4\.00
```ocaml
val mod_float : float -> float -> float
```
```reasonml
let mod_float: float => float => float;
```
`mod_float a b` returns the remainder of `a` with respect to `b`. The returned value is `a -. n *. b`, where `n` is the quotient `a /. b` rounded towards zero to an integer.

```ocaml
val frexp : float -> float * int
```
```reasonml
let frexp: float => (float, int);
```
`frexp f` returns the pair of the significant and the exponent of `f`. When `f` is zero, the significant `x` and the exponent `n` of `f` are equal to zero. When `f` is non-zero, they are defined by `f = x *. 2 ** n` and `0.5 <= x < 1.0`.

```ocaml
val ldexp : float -> int -> float
```
```reasonml
let ldexp: float => int => float;
```
`ldexp x n` returns `x *. 2 ** n`.

```ocaml
val modf : float -> float * float
```
```reasonml
let modf: float => (float, float);
```
`modf f` returns the pair of the fractional and integral part of `f`.

```ocaml
val float : int -> float
```
```reasonml
let float: int => float;
```
Same as [`Stdlib.float_of_int`](./#val-float_of_int).

```ocaml
val float_of_int : int -> float
```
```reasonml
let float_of_int: int => float;
```
Convert an integer to floating-point.

```ocaml
val truncate : float -> int
```
```reasonml
let truncate: float => int;
```
Same as [`Stdlib.int_of_float`](./#val-int_of_float).

```ocaml
val int_of_float : float -> int
```
```reasonml
let int_of_float: float => int;
```
Truncate the given floating-point number to an integer. The result is unspecified if the argument is `nan` or falls outside the range of representable integers.

```ocaml
val infinity : float
```
```reasonml
let infinity: float;
```
Positive infinity.

```ocaml
val neg_infinity : float
```
```reasonml
let neg_infinity: float;
```
Negative infinity.

```ocaml
val nan : float
```
```reasonml
let nan: float;
```
```ocaml
val max_float : float
```
```reasonml
let max_float: float;
```
The largest positive finite value of type `float`.

```ocaml
val min_float : float
```
```reasonml
let min_float: float;
```
The smallest positive, non-zero, non-denormalized value of type `float`.

```ocaml
val epsilon_float : float
```
```reasonml
let epsilon_float: float;
```
The difference between `1.0` and the smallest exactly representable floating-point number greater than `1.0`.

```
type fpclass = 
```
```
| FP_normal
```
Normal number, none of the below

```
| FP_subnormal
```
Number very close to 0\.0, has reduced precision

```
| FP_zero
```
Number is 0\.0 or \-0.0

```
| FP_infinite
```
Number is positive or negative infinity

```
| FP_nan
```
Not a number: result of an undefined operation

```ocaml

```
```reasonml
;
```
The five classes of floating-point numbers, as determined by the [`Stdlib.classify_float`](./#val-classify_float) function.

```ocaml
val classify_float : float -> fpclass
```
```reasonml
let classify_float: float => fpclass;
```

## String operations

More string operations are provided in module [`String`](./Stdlib-String.md).

```ocaml
val (^) : string -> string -> string
```
```reasonml
let (^): string => string => string;
```
String concatenation. Right-associative operator, see `Ocaml_operators` for more information.

raises [`Invalid_argument`](./#exception-Invalid_argument) if the result is longer then than Sys.max\_string\_length bytes.

## Character operations

More character operations are provided in module [`Char`](./Stdlib-Char.md).

```ocaml
val int_of_char : char -> int
```
```reasonml
let int_of_char: char => int;
```
Return the ASCII code of the argument.

```ocaml
val char_of_int : int -> char
```
```reasonml
let char_of_int: int => char;
```
Return the character with the given ASCII code.

raises [`Invalid_argument`](./#exception-Invalid_argument) if the argument is outside the range 0--255.

## Unit operations

```ocaml
val ignore : 'a -> unit
```
```reasonml
let ignore: 'a => unit;
```
Discard the value of its argument and return `()`. For instance, `ignore(f x)` discards the result of the side-effecting function `f`. It is equivalent to `f x; ()`, except that the latter may generate a compiler warning; writing `ignore(f x)` instead avoids the warning.


## String conversion functions

```ocaml
val string_of_bool : bool -> string
```
```reasonml
let string_of_bool: bool => string;
```
Return the string representation of a boolean. As the returned values may be shared, the user should not modify them directly.

```ocaml
val bool_of_string_opt : string -> bool option
```
```reasonml
let bool_of_string_opt: string => option(bool);
```
Convert the given string to a boolean.

Return `None` if the string is not `"true"` or `"false"`.

since 4\.05
```ocaml
val bool_of_string : string -> bool
```
```reasonml
let bool_of_string: string => bool;
```
Same as [`Stdlib.bool_of_string_opt`](./#val-bool_of_string_opt), but raise `Invalid_argument "bool_of_string"` instead of returning `None`.

```ocaml
val string_of_int : int -> string
```
```reasonml
let string_of_int: int => string;
```
Return the string representation of an integer, in decimal.

```ocaml
val int_of_string_opt : string -> int option
```
```reasonml
let int_of_string_opt: string => option(int);
```
Convert the given string to an integer. The string is read in decimal (by default, or if the string begins with `0u`), in hexadecimal (if it begins with `0x` or `0X`), in octal (if it begins with `0o` or `0O`), or in binary (if it begins with `0b` or `0B`).

The `0u` prefix reads the input as an unsigned integer in the range `[0, 2*max_int+1]`. If the input exceeds [`max_int`](./#val-max_int) it is converted to the signed integer `min_int + input - max_int - 1`.

The `_` (underscore) character can appear anywhere in the string and is ignored.

Return `None` if the given string is not a valid representation of an integer, or if the integer represented exceeds the range of integers representable in type `int`.

since 4\.05
```ocaml
val int_of_string : string -> int
```
```reasonml
let int_of_string: string => int;
```
Same as [`Stdlib.int_of_string_opt`](./#val-int_of_string_opt), but raise `Failure "int_of_string"` instead of returning `None`.

```ocaml
val string_of_float : float -> string
```
```reasonml
let string_of_float: float => string;
```
Return a string representation of a floating-point number.

This conversion can involve a loss of precision. For greater control over the manner in which the number is printed, see [`Printf`](./Stdlib-Printf.md).

```ocaml
val float_of_string_opt : string -> float option
```
```reasonml
let float_of_string_opt: string => option(float);
```
Convert the given string to a float. The string is read in decimal (by default) or in hexadecimal (marked by `0x` or `0X`).

The format of decimal floating-point numbers is ` [-] dd.ddd (e|E) [+|-] dd `, where `d` stands for a decimal digit.

The format of hexadecimal floating-point numbers is ` [-] 0(x|X) hh.hhh (p|P) [+|-] dd `, where `h` stands for an hexadecimal digit and `d` for a decimal digit.

In both cases, at least one of the integer and fractional parts must be given; the exponent part is optional.

The `_` (underscore) character can appear anywhere in the string and is ignored.

Depending on the execution platforms, other representations of floating-point numbers can be accepted, but should not be relied upon.

Return `None` if the given string is not a valid representation of a float.

since 4\.05
```ocaml
val float_of_string : string -> float
```
```reasonml
let float_of_string: string => float;
```
Same as [`Stdlib.float_of_string_opt`](./#val-float_of_string_opt), but raise `Failure "float_of_string"` instead of returning `None`.


## Pair operations

```ocaml
val fst : ('a * 'b) -> 'a
```
```reasonml
let fst: ('a, 'b) => 'a;
```
Return the first component of a pair.

```ocaml
val snd : ('a * 'b) -> 'b
```
```reasonml
let snd: ('a, 'b) => 'b;
```
Return the second component of a pair.


## List operations

More list operations are provided in module [`List`](./Stdlib-List.md).

```ocaml
val (@) : 'a list -> 'a list -> 'a list
```
```reasonml
let (@): list('a) => list('a) => list('a);
```
`l0 @ l1` appends `l1` to `l0`. Same function as [`List.append`](./Stdlib-List.md#val-append). Right-associative operator, see `Ocaml_operators` for more information.

since 5\.1 this function is tail-recursive.

## Input/output

Note: all input/output functions can raise `Sys_error` when the system calls they invoke fail.

```ocaml
type in_channel
```
```reasonml
type in_channel;
```
The type of input channel.

```ocaml
type out_channel
```
```reasonml
type out_channel;
```
The type of output channel.

```ocaml
val stdin : in_channel
```
```reasonml
let stdin: in_channel;
```
The standard input for the process.

```ocaml
val stdout : out_channel
```
```reasonml
let stdout: out_channel;
```
The standard output for the process.

```ocaml
val stderr : out_channel
```
```reasonml
let stderr: out_channel;
```
The standard error output for the process.


### Output functions on standard output

```ocaml
val print_char : char -> unit
```
```reasonml
let print_char: char => unit;
```
Print a character on standard output.

```ocaml
val print_string : string -> unit
```
```reasonml
let print_string: string => unit;
```
Print a string on standard output.

```ocaml
val print_bytes : bytes -> unit
```
```reasonml
let print_bytes: bytes => unit;
```
Print a byte sequence on standard output.

since 4\.02
```ocaml
val print_int : int -> unit
```
```reasonml
let print_int: int => unit;
```
Print an integer, in decimal, on standard output.

```ocaml
val print_float : float -> unit
```
```reasonml
let print_float: float => unit;
```
Print a floating-point number, in decimal, on standard output.

The conversion of the number to a string uses [`string_of_float`](./#val-string_of_float) and can involve a loss of precision.

```ocaml
val print_endline : string -> unit
```
```reasonml
let print_endline: string => unit;
```
Print a string, followed by a newline character, on standard output and flush standard output.

```ocaml
val print_newline : unit -> unit
```
```reasonml
let print_newline: unit => unit;
```
Print a newline character on standard output, and flush standard output. This can be used to simulate line buffering of standard output.


### Output functions on standard error

```ocaml
val prerr_char : char -> unit
```
```reasonml
let prerr_char: char => unit;
```
Print a character on standard error.

```ocaml
val prerr_string : string -> unit
```
```reasonml
let prerr_string: string => unit;
```
Print a string on standard error.

```ocaml
val prerr_bytes : bytes -> unit
```
```reasonml
let prerr_bytes: bytes => unit;
```
Print a byte sequence on standard error.

since 4\.02
```ocaml
val prerr_int : int -> unit
```
```reasonml
let prerr_int: int => unit;
```
Print an integer, in decimal, on standard error.

```ocaml
val prerr_float : float -> unit
```
```reasonml
let prerr_float: float => unit;
```
Print a floating-point number, in decimal, on standard error.

The conversion of the number to a string uses [`string_of_float`](./#val-string_of_float) and can involve a loss of precision.

```ocaml
val prerr_endline : string -> unit
```
```reasonml
let prerr_endline: string => unit;
```
Print a string, followed by a newline character on standard error and flush standard error.

```ocaml
val prerr_newline : unit -> unit
```
```reasonml
let prerr_newline: unit => unit;
```
Print a newline character on standard error, and flush standard error.


### Input functions on standard input

```ocaml
val read_line : unit -> string
```
```reasonml
let read_line: unit => string;
```
Flush standard output, then read characters from standard input until a newline character is encountered.

Return the string of all characters read, without the newline character at the end.

raises [`End_of_file`](./#exception-End_of_file) if the end of the file is reached at the beginning of line.
```ocaml
val read_int_opt : unit -> int option
```
```reasonml
let read_int_opt: unit => option(int);
```
Flush standard output, then read one line from standard input and convert it to an integer.

Return `None` if the line read is not a valid representation of an integer.

since 4\.05
```ocaml
val read_int : unit -> int
```
```reasonml
let read_int: unit => int;
```
Same as [`Stdlib.read_int_opt`](./#val-read_int_opt), but raise `Failure "int_of_string"` instead of returning `None`.

```ocaml
val read_float_opt : unit -> float option
```
```reasonml
let read_float_opt: unit => option(float);
```
Flush standard output, then read one line from standard input and convert it to a floating-point number.

Return `None` if the line read is not a valid representation of a floating-point number.

since 4\.05
```ocaml
val read_float : unit -> float
```
```reasonml
let read_float: unit => float;
```
Same as [`Stdlib.read_float_opt`](./#val-read_float_opt), but raise `Failure "float_of_string"` instead of returning `None`.


### General output functions

```
type open_flag = 
```
```
| Open_rdonly
```
open for reading.

```
| Open_wronly
```
open for writing.

```
| Open_append
```
open for appending: always write at end of file.

```
| Open_creat
```
create the file if it does not exist.

```
| Open_trunc
```
empty the file if it already exists.

```
| Open_excl
```
fail if Open\_creat and the file already exists.

```
| Open_binary
```
open in binary mode (no conversion).

```
| Open_text
```
open in text mode (may perform conversions).

```
| Open_nonblock
```
open in non-blocking mode.

```ocaml

```
```reasonml
;
```
Opening modes for [`Stdlib.open_out_gen`](./#val-open_out_gen) and [`Stdlib.open_in_gen`](./#val-open_in_gen).

```ocaml
val open_out : string -> out_channel
```
```reasonml
let open_out: string => out_channel;
```
Open the named file for writing, and return a new output channel on that file, positioned at the beginning of the file. The file is truncated to zero length if it already exists. It is created if it does not already exists.

```ocaml
val open_out_bin : string -> out_channel
```
```reasonml
let open_out_bin: string => out_channel;
```
Same as [`Stdlib.open_out`](./#val-open_out), but the file is opened in binary mode, so that no translation takes place during writes. On operating systems that do not distinguish between text mode and binary mode, this function behaves like [`Stdlib.open_out`](./#val-open_out).

```ocaml
val open_out_gen : open_flag list -> int -> string -> out_channel
```
```reasonml
let open_out_gen: list(open_flag) => int => string => out_channel;
```
`open_out_gen mode perm filename` opens the named file for writing, as described above. The extra argument `mode` specifies the opening mode. The extra argument `perm` specifies the file permissions, in case the file must be created. [`Stdlib.open_out`](./#val-open_out) and [`Stdlib.open_out_bin`](./#val-open_out_bin) are special cases of this function.

```ocaml
val flush : out_channel -> unit
```
```reasonml
let flush: out_channel => unit;
```
Flush the buffer associated with the given output channel, performing all pending writes on that channel. Interactive programs must be careful about flushing standard output and standard error at the right time.

```ocaml
val flush_all : unit -> unit
```
```reasonml
let flush_all: unit => unit;
```
Flush all open output channels; ignore errors.

```ocaml
val output_char : out_channel -> char -> unit
```
```reasonml
let output_char: out_channel => char => unit;
```
Write the character on the given output channel.

```ocaml
val output_string : out_channel -> string -> unit
```
```reasonml
let output_string: out_channel => string => unit;
```
Write the string on the given output channel.

```ocaml
val output_bytes : out_channel -> bytes -> unit
```
```reasonml
let output_bytes: out_channel => bytes => unit;
```
Write the byte sequence on the given output channel.

since 4\.02
```ocaml
val output : out_channel -> bytes -> int -> int -> unit
```
```reasonml
let output: out_channel => bytes => int => int => unit;
```
`output oc buf pos len` writes `len` characters from byte sequence `buf`, starting at offset `pos`, to the given output channel `oc`.

raises [`Invalid_argument`](./#exception-Invalid_argument) if pos and len do not designate a valid range of buf.
```ocaml
val output_substring : out_channel -> string -> int -> int -> unit
```
```reasonml
let output_substring: out_channel => string => int => int => unit;
```
Same as `output` but take a string as argument instead of a byte sequence.

since 4\.02
```ocaml
val output_byte : out_channel -> int -> unit
```
```reasonml
let output_byte: out_channel => int => unit;
```
Write one 8-bit integer (as the single character with that code) on the given output channel. The given integer is taken modulo 256\.

```ocaml
val output_binary_int : out_channel -> int -> unit
```
```reasonml
let output_binary_int: out_channel => int => unit;
```
Write one integer in binary format (4 bytes, big-endian) on the given output channel. The given integer is taken modulo 232. The only reliable way to read it back is through the [`Stdlib.input_binary_int`](./#val-input_binary_int) function. The format is compatible across all machines for a given version of OCaml.

```ocaml
val output_value : out_channel -> 'a -> unit
```
```reasonml
let output_value: out_channel => 'a => unit;
```
Write the representation of a structured value of any type to a channel. Circularities and sharing inside the value are detected and preserved. The object can be read back, by the function [`Stdlib.input_value`](./#val-input_value). See the description of module [`Marshal`](./Stdlib-Marshal.md) for more information. [`Stdlib.output_value`](./#val-output_value) is equivalent to [`Marshal.to_channel`](./Stdlib-Marshal.md#val-to_channel) with an empty list of flags.

```ocaml
val seek_out : out_channel -> int -> unit
```
```reasonml
let seek_out: out_channel => int => unit;
```
`seek_out chan pos` sets the current writing position to `pos` for channel `chan`. This works only for regular files. On files of other kinds (such as terminals, pipes and sockets), the behavior is unspecified.

```ocaml
val pos_out : out_channel -> int
```
```reasonml
let pos_out: out_channel => int;
```
Return the current writing position for the given channel. Does not work on channels opened with the `Open_append` flag (returns unspecified results). For files opened in text mode under Windows, the returned position is approximate (owing to end-of-line conversion); in particular, saving the current position with `pos_out`, then going back to this position using `seek_out` will not work. For this programming idiom to work reliably and portably, the file must be opened in binary mode.

```ocaml
val out_channel_length : out_channel -> int
```
```reasonml
let out_channel_length: out_channel => int;
```
Return the size (number of characters) of the regular file on which the given channel is opened. If the channel is opened on a file that is not a regular file, the result is meaningless.

```ocaml
val close_out : out_channel -> unit
```
```reasonml
let close_out: out_channel => unit;
```
Close the given channel, flushing all buffered write operations. Output functions raise a `Sys_error` exception when they are applied to a closed output channel, except `close_out` and `flush`, which do nothing when applied to an already closed channel. Note that `close_out` may raise `Sys_error` if the operating system signals an error when flushing or closing.

```ocaml
val close_out_noerr : out_channel -> unit
```
```reasonml
let close_out_noerr: out_channel => unit;
```
Same as `close_out`, but ignore all errors.

```ocaml
val set_binary_mode_out : out_channel -> bool -> unit
```
```reasonml
let set_binary_mode_out: out_channel => bool => unit;
```
`set_binary_mode_out oc true` sets the channel `oc` to binary mode: no translations take place during output. `set_binary_mode_out oc false` sets the channel `oc` to text mode: depending on the operating system, some translations may take place during output. For instance, under Windows, end-of-lines will be translated from `\n` to `\r\n`. This function has no effect under operating systems that do not distinguish between text mode and binary mode.


### General input functions

```ocaml
val open_in : string -> in_channel
```
```reasonml
let open_in: string => in_channel;
```
Open the named file for reading, and return a new input channel on that file, positioned at the beginning of the file.

```ocaml
val open_in_bin : string -> in_channel
```
```reasonml
let open_in_bin: string => in_channel;
```
Same as [`Stdlib.open_in`](./#val-open_in), but the file is opened in binary mode, so that no translation takes place during reads. On operating systems that do not distinguish between text mode and binary mode, this function behaves like [`Stdlib.open_in`](./#val-open_in).

```ocaml
val open_in_gen : open_flag list -> int -> string -> in_channel
```
```reasonml
let open_in_gen: list(open_flag) => int => string => in_channel;
```
`open_in_gen mode perm filename` opens the named file for reading, as described above. The extra arguments `mode` and `perm` specify the opening mode and file permissions. [`Stdlib.open_in`](./#val-open_in) and [`Stdlib.open_in_bin`](./#val-open_in_bin) are special cases of this function.

```ocaml
val input_char : in_channel -> char
```
```reasonml
let input_char: in_channel => char;
```
Read one character from the given input channel.

raises [`End_of_file`](./#exception-End_of_file) if there are no more characters to read.
```ocaml
val input_line : in_channel -> string
```
```reasonml
let input_line: in_channel => string;
```
Read characters from the given input channel, until a newline character is encountered. Return the string of all characters read, without the newline character at the end.

raises [`End_of_file`](./#exception-End_of_file) if the end of the file is reached at the beginning of line.
```ocaml
val input : in_channel -> bytes -> int -> int -> int
```
```reasonml
let input: in_channel => bytes => int => int => int;
```
`input ic buf pos len` reads up to `len` characters from the given channel `ic`, storing them in byte sequence `buf`, starting at character number `pos`. It returns the actual number of characters read, between 0 and `len` (inclusive). A return value of 0 means that the end of file was reached. A return value between 0 and `len` exclusive means that not all requested `len` characters were read, either because no more characters were available at that time, or because the implementation found it convenient to do a partial read; `input` must be called again to read the remaining characters, if desired. (See also [`Stdlib.really_input`](./#val-really_input) for reading exactly `len` characters.) Exception `Invalid_argument "input"` is raised if `pos` and `len` do not designate a valid range of `buf`.

```ocaml
val really_input : in_channel -> bytes -> int -> int -> unit
```
```reasonml
let really_input: in_channel => bytes => int => int => unit;
```
`really_input ic buf pos len` reads `len` characters from channel `ic`, storing them in byte sequence `buf`, starting at character number `pos`.

raises [`End_of_file`](./#exception-End_of_file) if the end of file is reached before len characters have been read.
raises [`Invalid_argument`](./#exception-Invalid_argument) if pos and len do not designate a valid range of buf.
```ocaml
val really_input_string : in_channel -> int -> string
```
```reasonml
let really_input_string: in_channel => int => string;
```
`really_input_string ic len` reads `len` characters from channel `ic` and returns them in a new string.

raises [`End_of_file`](./#exception-End_of_file) if the end of file is reached before len characters have been read.
since 4\.02
```ocaml
val input_byte : in_channel -> int
```
```reasonml
let input_byte: in_channel => int;
```
Same as [`Stdlib.input_char`](./#val-input_char), but return the 8-bit integer representing the character.

raises [`End_of_file`](./#exception-End_of_file) if the end of file was reached.
```ocaml
val input_binary_int : in_channel -> int
```
```reasonml
let input_binary_int: in_channel => int;
```
Read an integer encoded in binary format (4 bytes, big-endian) from the given input channel. See [`Stdlib.output_binary_int`](./#val-output_binary_int).

raises [`End_of_file`](./#exception-End_of_file) if the end of file was reached while reading the integer.
```ocaml
val input_value : in_channel -> 'a
```
```reasonml
let input_value: in_channel => 'a;
```
Read the representation of a structured value, as produced by [`Stdlib.output_value`](./#val-output_value), and return the corresponding value. This function is identical to [`Marshal.from_channel`](./Stdlib-Marshal.md#val-from_channel); see the description of module [`Marshal`](./Stdlib-Marshal.md) for more information, in particular concerning the lack of type safety.

```ocaml
val seek_in : in_channel -> int -> unit
```
```reasonml
let seek_in: in_channel => int => unit;
```
`seek_in chan pos` sets the current reading position to `pos` for channel `chan`. This works only for regular files. On files of other kinds, the behavior is unspecified.

```ocaml
val pos_in : in_channel -> int
```
```reasonml
let pos_in: in_channel => int;
```
Return the current reading position for the given channel. For files opened in text mode under Windows, the returned position is approximate (owing to end-of-line conversion); in particular, saving the current position with `pos_in`, then going back to this position using `seek_in` will not work. For this programming idiom to work reliably and portably, the file must be opened in binary mode.

```ocaml
val in_channel_length : in_channel -> int
```
```reasonml
let in_channel_length: in_channel => int;
```
Return the size (number of characters) of the regular file on which the given channel is opened. If the channel is opened on a file that is not a regular file, the result is meaningless. The returned size does not take into account the end-of-line translations that can be performed when reading from a channel opened in text mode.

```ocaml
val close_in : in_channel -> unit
```
```reasonml
let close_in: in_channel => unit;
```
Close the given channel. Input functions raise a `Sys_error` exception when they are applied to a closed input channel, except `close_in`, which does nothing when applied to an already closed channel.

```ocaml
val close_in_noerr : in_channel -> unit
```
```reasonml
let close_in_noerr: in_channel => unit;
```
Same as `close_in`, but ignore all errors.

```ocaml
val set_binary_mode_in : in_channel -> bool -> unit
```
```reasonml
let set_binary_mode_in: in_channel => bool => unit;
```
`set_binary_mode_in ic true` sets the channel `ic` to binary mode: no translations take place during input. `set_binary_mode_out ic false` sets the channel `ic` to text mode: depending on the operating system, some translations may take place during input. For instance, under Windows, end-of-lines will be translated from `\r\n` to `\n`. This function has no effect under operating systems that do not distinguish between text mode and binary mode.


### Operations on large files

```ocaml
module LargeFile : sig ... end
```
```reasonml
module LargeFile: { ... };
```
Operations on large files. This sub-module provides 64-bit variants of the channel functions that manipulate file positions and file sizes. By representing positions and sizes by 64-bit integers (type `int64`) instead of regular integers (type `int`), these alternate functions allow operating on files whose sizes are greater than `max_int`.


## References

```ocaml
type 'a ref = {
```
```reasonml
type ref('a) = {
```
`mutable contents : 'a;`
```ocaml
}
```
```reasonml
};
```
The type of references (mutable indirection cells) containing a value of type `'a`.

```ocaml
val ref : 'a -> 'a ref
```
```reasonml
let ref: 'a => ref('a);
```
Return a fresh reference containing the given value.

```ocaml
val (!) : 'a ref -> 'a
```
```reasonml
let (!): ref('a) => 'a;
```
`!r` returns the current contents of reference `r`. Equivalent to `fun r -> r.contents`. Unary operator, see `Ocaml_operators` for more information.

```ocaml
val (:=) : 'a ref -> 'a -> unit
```
```reasonml
let (:=): ref('a) => 'a => unit;
```
`r := a` stores the value of `a` in reference `r`. Equivalent to `fun r v -> r.contents <- v`. Right-associative operator, see `Ocaml_operators` for more information.

```ocaml
val incr : int ref -> unit
```
```reasonml
let incr: ref(int) => unit;
```
Increment the integer contained in the given reference. Equivalent to `fun r -> r := succ !r`.

```ocaml
val decr : int ref -> unit
```
```reasonml
let decr: ref(int) => unit;
```
Decrement the integer contained in the given reference. Equivalent to `fun r -> r := pred !r`.


## Result type

```ocaml
type ('a, 'b) result = 
```
```reasonml
type result('a, 'b) = 
```
```ocaml
| Ok of 'a
```
```reasonml
| Ok('a)
```
```ocaml
| Error of 'b
```
```reasonml
| Error('b)
```
```ocaml

```
```reasonml
;
```
since 4\.03

## Operations on format strings

Format strings are character strings with special lexical conventions that defines the functionality of formatted input/output functions. Format strings are used to read data with formatted input functions from module [`Scanf`](./Stdlib-Scanf.md) and to print data with formatted output functions from modules [`Printf`](./Stdlib-Printf.md) and [`Format`](./Stdlib-Format.md).

Format strings are made of three kinds of entities:

- *conversions specifications*, introduced by the special character `'%'` followed by one or more characters specifying what kind of argument to read or print,
- *formatting indications*, introduced by the special character `'@'` followed by one or more characters specifying how to read or print the argument,
- *plain characters* that are regular characters with usual lexical conventions. Plain characters specify string literals to be read in the input or printed in the output.
There is an additional lexical rule to escape the special characters `'%'` and `'@'` in format strings: if a special character follows a `'%'` character, it is treated as a plain character. In other words, `"%%"` is considered as a plain `'%'` and `"%@"` as a plain `'@'`.

For more information about conversion specifications and formatting indications available, read the documentation of modules [`Scanf`](./Stdlib-Scanf.md), [`Printf`](./Stdlib-Printf.md) and [`Format`](./Stdlib-Format.md).

Format strings have a general and highly polymorphic type <code class="text-ocaml">('a, 'b, 'c, 'd, 'e, 'f) format6</code><code class="text-reasonml">format6('a, 'b, 'c, 'd, 'e, 'f)</code>. The two simplified types, `format` and `format4` below are included for backward compatibility with earlier releases of OCaml.

The meaning of format string type parameters is as follows:

- `'a` is the type of the parameters of the format for formatted output functions (`printf`\-style functions); `'a` is the type of the values read by the format for formatted input functions (`scanf`\-style functions).
- `'b` is the type of input source for formatted input functions and the type of output target for formatted output functions. For `printf`\-style functions from module [`Printf`](./Stdlib-Printf.md), `'b` is typically `out_channel`; for `printf`\-style functions from module [`Format`](./Stdlib-Format.md), `'b` is typically [`Format.formatter`](./Stdlib-Format.md#type-formatter); for `scanf`\-style functions from module [`Scanf`](./Stdlib-Scanf.md), `'b` is typically [`Scanf.Scanning.in_channel`](./Stdlib-Scanf-Scanning.md#type-in_channel).
Type argument `'b` is also the type of the first argument given to user's defined printing functions for `%a` and `%t` conversions, and user's defined reading functions for `%r` conversion.

- `'c` is the type of the result of the `%a` and `%t` printing functions, and also the type of the argument transmitted to the first argument of `kprintf`\-style functions or to the `kscanf`\-style functions.
- `'d` is the type of parameters for the `scanf`\-style functions.
- `'e` is the type of the receiver function for the `scanf`\-style functions.
- `'f` is the final result type of a formatted input/output function invocation: for the `printf`\-style functions, it is typically `unit`; for the `scanf`\-style functions, it is typically the result type of the receiver function.
```ocaml
type ('a, 'b, 'c, 'd, 'e, 'f) format6 =
  ('a, 'b, 'c, 'd, 'e, 'f) CamlinternalFormatBasics.format6
```
```reasonml
type format6('a, 'b, 'c, 'd, 'e, 'f) =
  CamlinternalFormatBasics.format6('a, 'b, 'c, 'd, 'e, 'f);
```
```ocaml
type ('a, 'b, 'c, 'd) format4 = ('a, 'b, 'c, 'c, 'c, 'd) format6
```
```reasonml
type format4('a, 'b, 'c, 'd) = format6('a, 'b, 'c, 'c, 'c, 'd);
```
```ocaml
type ('a, 'b, 'c) format = ('a, 'b, 'c, 'c) format4
```
```reasonml
type format('a, 'b, 'c) = format4('a, 'b, 'c, 'c);
```
```ocaml
val string_of_format : ('a, 'b, 'c, 'd, 'e, 'f) format6 -> string
```
```reasonml
let string_of_format: format6('a, 'b, 'c, 'd, 'e, 'f) => string;
```
Converts a format string into a string.

```ocaml
val format_of_string : 
  ('a, 'b, 'c, 'd, 'e, 'f) format6 ->
  ('a, 'b, 'c, 'd, 'e, 'f) format6
```
```reasonml
let format_of_string: 
  format6('a, 'b, 'c, 'd, 'e, 'f) =>
  format6('a, 'b, 'c, 'd, 'e, 'f);
```
`format_of_string s` returns a format string read from the string literal `s`. Note: `format_of_string` can not convert a string argument that is not a literal. If you need this functionality, use the more general [`Scanf.format_from_string`](./Stdlib-Scanf.md#val-format_from_string) function.

```ocaml
val (^^) : 
  ('a, 'b, 'c, 'd, 'e, 'f) format6 ->
  ('f, 'b, 'c, 'e, 'g, 'h) format6 ->
  ('a, 'b, 'c, 'd, 'g, 'h) format6
```
```reasonml
let (^^): 
  format6('a, 'b, 'c, 'd, 'e, 'f) =>
  format6('f, 'b, 'c, 'e, 'g, 'h) =>
  format6('a, 'b, 'c, 'd, 'g, 'h);
```
`f1 ^^ f2` catenates format strings `f1` and `f2`. The result is a format string that behaves as the concatenation of format strings `f1` and `f2`: in case of formatted output, it accepts arguments from `f1`, then arguments from `f2`; in case of formatted input, it returns results from `f1`, then results from `f2`. Right-associative operator, see `Ocaml_operators` for more information.


## Program termination

```ocaml
val exit : int -> 'a
```
```reasonml
let exit: int => 'a;
```
Terminate the process, returning the given status code to the operating system: usually 0 to indicate no errors, and a small positive integer to indicate failure. All open output channels are flushed with `flush_all`. The callbacks registered with [`Domain.at_exit`](./Stdlib-Domain.md#val-at_exit) are called followed by those registered with [`Stdlib.at_exit`](./#val-at_exit).

An implicit `exit 0` is performed each time a program terminates normally. An implicit `exit 2` is performed if the program terminates early because of an uncaught exception.

```ocaml
val at_exit : (unit -> unit) -> unit
```
```reasonml
let at_exit: (unit => unit) => unit;
```
Register the given function to be called at program termination time. The functions registered with `at_exit` will be called when the program does any of the following:

- executes [`Stdlib.exit`](./#val-exit)
- terminates, either normally or because of an uncaught exception
- executes the C function `caml_shutdown`. The functions are called in 'last in, first out' order: the function most recently added with `at_exit` is called first.

## Standard library modules

```ocaml
module Arg : sig ... end
```
```reasonml
module Arg: { ... };
```
Parsing of command line arguments.

```ocaml
module Array : sig ... end
```
```reasonml
module Array: { ... };
```
Array operations.

```ocaml
module ArrayLabels : sig ... end
```
```reasonml
module ArrayLabels: { ... };
```
Array operations.

```ocaml
module Atomic : sig ... end
```
```reasonml
module Atomic: { ... };
```
Atomic references.

```ocaml
module Bool : sig ... end
```
```reasonml
module Bool: { ... };
```
Boolean values.

```ocaml
module Buffer : sig ... end
```
```reasonml
module Buffer: { ... };
```
Extensible buffers.

```ocaml
module Bytes : sig ... end
```
```reasonml
module Bytes: { ... };
```
Byte sequence operations.

```ocaml
module BytesLabels : sig ... end
```
```reasonml
module BytesLabels: { ... };
```
Byte sequence operations.

```ocaml
module Char : sig ... end
```
```reasonml
module Char: { ... };
```
Character operations.

```ocaml
module Complex : sig ... end
```
```reasonml
module Complex: { ... };
```
Complex numbers.

```ocaml
module Digest : sig ... end
```
```reasonml
module Digest: { ... };
```
Message digest.

```ocaml
module Domain : sig ... end
```
```reasonml
module Domain: { ... };
```
```ocaml
module Dynarray : sig ... end
```
```reasonml
module Dynarray: { ... };
```
Dynamic arrays.

```ocaml
module Pqueue : sig ... end
```
```reasonml
module Pqueue: { ... };
```
Priority queues.

```ocaml
module Effect : sig ... end
```
```reasonml
module Effect: { ... };
```
```ocaml
module Either : sig ... end
```
```reasonml
module Either: { ... };
```
Either type.

```ocaml
module Filename : sig ... end
```
```reasonml
module Filename: { ... };
```
Operations on file names.

```ocaml
module Float : sig ... end
```
```reasonml
module Float: { ... };
```
Floating-point arithmetic.

```ocaml
module Format : sig ... end
```
```reasonml
module Format: { ... };
```
Pretty-printing.

```ocaml
module Fun : sig ... end
```
```reasonml
module Fun: { ... };
```
Function manipulation.

```ocaml
module Gc : sig ... end
```
```reasonml
module Gc: { ... };
```
Memory management control and statistics; finalised values.

```ocaml
module Hashtbl : sig ... end
```
```reasonml
module Hashtbl: { ... };
```
Hash tables and hash functions.

```ocaml
module Iarray : sig ... end
```
```reasonml
module Iarray: { ... };
```
Operations on immutable arrays. This module mirrors the API of `Array`, but omits functions that assume mutability; in addition to obviously mutating functions, it omits `copy` along with the functions `make`, `create_float`, and `make_matrix` that produce all-constant arrays. The exception is the sorting functions, which are given a copying API to replace the in-place one.

```ocaml
module In_channel : sig ... end
```
```reasonml
module In_channel: { ... };
```
Input channels.

```ocaml
module Int : sig ... end
```
```reasonml
module Int: { ... };
```
Integer values.

```ocaml
module Int32 : sig ... end
```
```reasonml
module Int32: { ... };
```
32-bit integers.

```ocaml
module Int64 : sig ... end
```
```reasonml
module Int64: { ... };
```
64-bit integers.

```ocaml
module Lazy : sig ... end
```
```reasonml
module Lazy: { ... };
```
Deferred computations.

```ocaml
module Lexing : sig ... end
```
```reasonml
module Lexing: { ... };
```
The run-time library for lexers generated by `ocamllex`.

```ocaml
module List : sig ... end
```
```reasonml
module List: { ... };
```
List operations.

```ocaml
module ListLabels : sig ... end
```
```reasonml
module ListLabels: { ... };
```
List operations.

```ocaml
module Map : sig ... end
```
```reasonml
module Map: { ... };
```
Association tables over ordered types.

```ocaml
module Marshal : sig ... end
```
```reasonml
module Marshal: { ... };
```
Marshaling of data structures.

```ocaml
module MoreLabels : sig ... end
```
```reasonml
module MoreLabels: { ... };
```
Extra labeled libraries.

```ocaml
module Mutex : sig ... end
```
```reasonml
module Mutex: { ... };
```
Locks for mutual exclusion.

```ocaml
module Obj : sig ... end
```
```reasonml
module Obj: { ... };
```
Operations on internal representations of values.

```ocaml
module Oo : sig ... end
```
```reasonml
module Oo: { ... };
```
Operations on objects

```ocaml
module Option : sig ... end
```
```reasonml
module Option: { ... };
```
Option values.

```ocaml
module Out_channel : sig ... end
```
```reasonml
module Out_channel: { ... };
```
Output channels.

```ocaml
module Pair : sig ... end
```
```reasonml
module Pair: { ... };
```
Operations on pairs.

```ocaml
module Parsing : sig ... end
```
```reasonml
module Parsing: { ... };
```
The run-time library for parsers generated by `ocamlyacc`.

```ocaml
module Printexc : sig ... end
```
```reasonml
module Printexc: { ... };
```
Facilities for printing exceptions and inspecting current call stack.

```ocaml
module Printf : sig ... end
```
```reasonml
module Printf: { ... };
```
Formatted output functions.

```ocaml
module Queue : sig ... end
```
```reasonml
module Queue: { ... };
```
First-in first-out queues.

```ocaml
module Random : sig ... end
```
```reasonml
module Random: { ... };
```
Pseudo-random number generators (PRNG).

```ocaml
module Result : sig ... end
```
```reasonml
module Result: { ... };
```
Result values.

```ocaml
module Repr : sig ... end
```
```reasonml
module Repr: { ... };
```
Functions defined on the low-level representations of values.

```ocaml
module Scanf : sig ... end
```
```reasonml
module Scanf: { ... };
```
Formatted input functions.

```ocaml
module Seq : sig ... end
```
```reasonml
module Seq: { ... };
```
Sequences.

```ocaml
module Set : sig ... end
```
```reasonml
module Set: { ... };
```
Sets over ordered types.

```ocaml
module Stack : sig ... end
```
```reasonml
module Stack: { ... };
```
Last-in first-out stacks.

```ocaml
module StdLabels : sig ... end
```
```reasonml
module StdLabels: { ... };
```
Standard labeled libraries.

```ocaml
module String : sig ... end
```
```reasonml
module String: { ... };
```
Strings.

```ocaml
module StringLabels : sig ... end
```
```reasonml
module StringLabels: { ... };
```
Strings.

```ocaml
module Sys : sig ... end
```
```reasonml
module Sys: { ... };
```
System interface.

```ocaml
module Type : sig ... end
```
```reasonml
module Type: { ... };
```
Type introspection.

```ocaml
module Uchar : sig ... end
```
```reasonml
module Uchar: { ... };
```
Unicode characters.

```ocaml
module Unit : sig ... end
```
```reasonml
module Unit: { ... };
```
Unit values.

```ocaml
module Weak : sig ... end
```
```reasonml
module Weak: { ... };
```
Arrays of weak pointers and hash sets of weak pointers.
