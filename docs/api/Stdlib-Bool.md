
# Module `Stdlib.Bool`

Boolean values.

since 4\.08

## Booleans

```
type t = bool = 
```
```
| false
```
```
| true
```
```ocaml

```
```reasonml
;
```
The type of booleans (truth values).

The constructors `false` and `true` are included here so that they have paths, but they are not intended to be used in user-defined data types.

```ocaml
val not : bool -> bool
```
```reasonml
let not: bool => bool;
```
`not b` is the boolean negation of `b`.

```ocaml
val (&&) : bool -> bool -> bool
```
```reasonml
let (&&): bool => bool => bool;
```
`e0 && e1` is the lazy boolean conjunction of expressions `e0` and `e1`. If `e0` evaluates to `false`, `e1` is not evaluated. Right-associative operator at precedence level 3/11.

```ocaml
val (||) : bool -> bool -> bool
```
```reasonml
let (||): bool => bool => bool;
```
`e0 || e1` is the lazy boolean disjunction of expressions `e0` and `e1`. If `e0` evaluates to `true`, `e1` is not evaluated. Right-associative operator at precedence level 2/11.

```ocaml
val logand : bool -> bool -> bool
```
```reasonml
let logand: bool => bool => bool;
```
`logand b1 b2` is `true` if and only if `b1` and `b2` are both `true`.

```ocaml
val logor : bool -> bool -> bool
```
```reasonml
let logor: bool => bool => bool;
```
`logor b1 b2` is `true` if and only if either `b1` or `b2` is `true`.

```ocaml
val logxor : bool -> bool -> bool
```
```reasonml
let logxor: bool => bool => bool;
```
`logxor b1 b2` is `true` if exactly one of `b1` and `b2` is `true`.


## Predicates and comparisons

```ocaml
val equal : bool -> bool -> bool
```
```reasonml
let equal: bool => bool => bool;
```
`equal b0 b1` is `true` if and only if `b0` and `b1` are both `true` or both `false`.

```ocaml
val compare : bool -> bool -> int
```
```reasonml
let compare: bool => bool => int;
```
`compare b0 b1` is a total order on boolean values. `false` is smaller than `true`.


## Converting

```ocaml
val to_int : bool -> int
```
```reasonml
let to_int: bool => int;
```
`to_int b` is `0` if `b` is `false` and `1` if `b` is `true`.

```ocaml
val to_float : bool -> float
```
```reasonml
let to_float: bool => float;
```
`to_float b` is `0.` if `b` is `false` and `1.` if `b` is `true`.

```ocaml
val to_string : bool -> string
```
```reasonml
let to_string: bool => string;
```
`to_string b` is `"true"` if `b` is `true` and `"false"` if `b` is `false`.

```ocaml
val seeded_hash : int -> bool -> int
```
```reasonml
let seeded_hash: int => bool => int;
```
A seeded hash function for booleans, with the same output value as [`Hashtbl.seeded_hash`](./Stdlib-Hashtbl.md#val-seeded_hash). This function allows this module to be passed as argument to the functor [`Hashtbl.MakeSeeded`](./Stdlib-Hashtbl-MakeSeeded.md).

since 5\.1
```ocaml
val hash : bool -> int
```
```reasonml
let hash: bool => int;
```
An unseeded hash function for booleans, with the same output value as [`Hashtbl.hash`](./Stdlib-Hashtbl.md#val-hash). This function allows this module to be passed as argument to the functor [`Hashtbl.Make`](./Stdlib-Hashtbl-Make.md).

since 5\.1