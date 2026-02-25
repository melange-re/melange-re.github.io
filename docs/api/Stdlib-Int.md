
# Module `Stdlib.Int`

Integer values.

Integers are [`Sys.int_size`](./Stdlib-Sys.md#val-int_size) bits wide and use two's complement representation. All operations are taken modulo 2`Sys.int_size`. They do not fail on overflow.

since 4\.08

## Integers

```ocaml
type t = int
```
```reasonml
type t = int;
```
The type for integer values.

```ocaml
val zero : int
```
```reasonml
let zero: int;
```
`zero` is the integer `0`.

```ocaml
val one : int
```
```reasonml
let one: int;
```
`one` is the integer `1`.

```ocaml
val minus_one : int
```
```reasonml
let minus_one: int;
```
`minus_one` is the integer `-1`.

```ocaml
val neg : int -> int
```
```reasonml
let neg: int => int;
```
`neg x` is `~-x`.

```ocaml
val add : int -> int -> int
```
```reasonml
let add: int => int => int;
```
`add x y` is the addition `x + y`.

```ocaml
val sub : int -> int -> int
```
```reasonml
let sub: int => int => int;
```
`sub x y` is the subtraction `x - y`.

```ocaml
val mul : int -> int -> int
```
```reasonml
let mul: int => int => int;
```
`mul x y` is the multiplication <code class="text-ocaml">x * y</code><code class="text-reasonml">(x, y)</code>.

```ocaml
val div : int -> int -> int
```
```reasonml
let div: int => int => int;
```
`div x y` is the division `x / y`. See [`Stdlib.(/)`](./Stdlib.md#val-\(/\)) for details.

```ocaml
val rem : int -> int -> int
```
```reasonml
let rem: int => int => int;
```
`rem x y` is the remainder `x mod y`. See [`Stdlib.(mod)`](./Stdlib.md#val-\(mod\)) for details.

```ocaml
val succ : int -> int
```
```reasonml
let succ: int => int;
```
`succ x` is `add x 1`.

```ocaml
val pred : int -> int
```
```reasonml
let pred: int => int;
```
`pred x` is `sub x 1`.

```ocaml
val abs : int -> int
```
```reasonml
let abs: int => int;
```
`abs x` is the absolute value of `x`. That is `x` if `x` is positive and `neg x` if `x` is negative. **Warning.** This may be negative if the argument is [`min_int`](./#val-min_int).

```ocaml
val max_int : int
```
```reasonml
let max_int: int;
```
`max_int` is the greatest representable integer, `2``Sys.int_size - 1``-1`.

```ocaml
val min_int : int
```
```reasonml
let min_int: int;
```
`min_int` is the smallest representable integer, `-2``Sys.int_size - 1`.

```ocaml
val logand : int -> int -> int
```
```reasonml
let logand: int => int => int;
```
`logand x y` is the bitwise logical and of `x` and `y`.

```ocaml
val logor : int -> int -> int
```
```reasonml
let logor: int => int => int;
```
`logor x y` is the bitwise logical or of `x` and `y`.

```ocaml
val logxor : int -> int -> int
```
```reasonml
let logxor: int => int => int;
```
`logxor x y` is the bitwise logical exclusive or of `x` and `y`.

```ocaml
val lognot : int -> int
```
```reasonml
let lognot: int => int;
```
`lognot x` is the bitwise logical negation of `x`.

```ocaml
val shift_left : int -> int -> int
```
```reasonml
let shift_left: int => int => int;
```
`shift_left x n` shifts `x` to the left by `n` bits. The result is unspecified if `n < 0` or `n > `[`Sys.int_size`](./Stdlib-Sys.md#val-int_size).

```ocaml
val shift_right : int -> int -> int
```
```reasonml
let shift_right: int => int => int;
```
`shift_right x n` shifts `x` to the right by `n` bits. This is an arithmetic shift: the sign bit of `x` is replicated and inserted in the vacated bits. The result is unspecified if `n < 0` or `n > `[`Sys.int_size`](./Stdlib-Sys.md#val-int_size).

```ocaml
val shift_right_logical : int -> int -> int
```
```reasonml
let shift_right_logical: int => int => int;
```
`shift_right x n` shifts `x` to the right by `n` bits. This is a logical shift: zeroes are inserted in the vacated bits regardless of the sign of `x`. The result is unspecified if `n < 0` or `n > `[`Sys.int_size`](./Stdlib-Sys.md#val-int_size).


## Predicates and comparisons

```ocaml
val equal : int -> int -> bool
```
```reasonml
let equal: int => int => bool;
```
`equal x y` is `true` if and only if `x = y`.

```ocaml
val compare : int -> int -> int
```
```reasonml
let compare: int => int => int;
```
`compare x y` is [`Stdlib.compare`](./Stdlib.md#val-compare)` x y` but more efficient.

```ocaml
val min : int -> int -> int
```
```reasonml
let min: int => int => int;
```
Return the smaller of the two arguments.

since 4\.13
```ocaml
val max : int -> int -> int
```
```reasonml
let max: int => int => int;
```
Return the greater of the two arguments.

since 4\.13

## Converting

```ocaml
val to_float : int -> float
```
```reasonml
let to_float: int => float;
```
`to_float x` is `x` as a floating point number.

```ocaml
val of_float : float -> int
```
```reasonml
let of_float: float => int;
```
`of_float x` truncates `x` to an integer. The result is unspecified if the argument is `nan` or falls outside the range of representable integers.

```ocaml
val to_string : int -> string
```
```reasonml
let to_string: int => string;
```
`to_string x` is the written representation of `x` in decimal.

```ocaml
val seeded_hash : int -> int -> int
```
```reasonml
let seeded_hash: int => int => int;
```
A seeded hash function for ints, with the same output value as [`Hashtbl.seeded_hash`](./Stdlib-Hashtbl.md#val-seeded_hash). This function allows this module to be passed as argument to the functor [`Hashtbl.MakeSeeded`](./Stdlib-Hashtbl-MakeSeeded.md).

since 5\.1
```ocaml
val hash : int -> int
```
```reasonml
let hash: int => int;
```
An unseeded hash function for ints, with the same output value as [`Hashtbl.hash`](./Stdlib-Hashtbl.md#val-hash). This function allows this module to be passed as argument to the functor [`Hashtbl.Make`](./Stdlib-Hashtbl-Make.md).

since 5\.1