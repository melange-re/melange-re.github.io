
# Module `Stdlib.Char`

Character operations.

Characters are the elements of `string` and `bytes` values. Characters represent bytes, that is an integer in the range \[`0x00`;`0xFF`\].

Some of the functions of this module interpret the characters in the range \[`0x00`;`0x7F`\] as the characters of the ASCII character set.


## Characters

```ocaml
type t = char
```
```reasonml
type t = char;
```
An alias for the type of characters.

```ocaml
val code : char -> int
```
```reasonml
let code: char => int;
```
Return the integer code of the argument.

```ocaml
val chr : int -> char
```
```reasonml
let chr: int => char;
```
Return the character with the given integer code.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if the argument is outside the range \[0x00;0xFF\].
```ocaml
val escaped : char -> string
```
```reasonml
let escaped: char => string;
```
Return a string representing the given character, with special characters escaped following the lexical conventions of OCaml. All characters outside the ASCII printable range \[`0x20`;`0x7E`\] are escaped, as well as backslash, double-quote, and single-quote.


## Predicates and comparisons

See also the [`Ascii`](./Stdlib-Char-Ascii.md) module.

```ocaml
val compare : t -> t -> int
```
```reasonml
let compare: t => t => int;
```
The comparison function for characters, with the same specification as [`Stdlib.compare`](./Stdlib.md#val-compare). Along with the type `t`, this function `compare` allows the module `Char` to be passed as argument to the functors [`Set.Make`](./Stdlib-Set-Make.md) and [`Map.Make`](./Stdlib-Map-Make.md).

```ocaml
val equal : t -> t -> bool
```
```reasonml
let equal: t => t => bool;
```
The equal function for chars.

since 4\.03

## ASCII characters

```ocaml
module Ascii : sig ... end
```
```reasonml
module Ascii: { ... };
```
ASCII character set support.

```ocaml
val lowercase_ascii : char -> char
```
```reasonml
let lowercase_ascii: char => char;
```
Use the equivalent [`Ascii.lowercase`](./Stdlib-Char-Ascii.md#val-lowercase) instead.

since 4\.03
```ocaml
val uppercase_ascii : char -> char
```
```reasonml
let uppercase_ascii: char => char;
```
Use the equivalent [`Ascii.uppercase`](./Stdlib-Char-Ascii.md#val-uppercase) instead.

since 4\.03

## Hashing

```ocaml
val seeded_hash : int -> t -> int
```
```reasonml
let seeded_hash: int => t => int;
```
A seeded hash function for characters, with the same output value as [`Hashtbl.seeded_hash`](./Stdlib-Hashtbl.md#val-seeded_hash). This function allows this module to be passed as argument to the functor [`Hashtbl.MakeSeeded`](./Stdlib-Hashtbl-MakeSeeded.md).

since 5\.1
```ocaml
val hash : t -> int
```
```reasonml
let hash: t => int;
```
An unseeded hash function for characters, with the same output value as [`Hashtbl.hash`](./Stdlib-Hashtbl.md#val-hash). This function allows this module to be passed as argument to the functor [`Hashtbl.Make`](./Stdlib-Hashtbl-Make.md).

since 5\.1