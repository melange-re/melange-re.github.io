
# Module `Stdlib.Char`

Character operations.

```
val code : char -> int
```
Return the ASCII code of the argument.

```
val chr : int -> char
```
Return the character with the given ASCII code.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if the argument is outside the range 0--255.
```
val escaped : char -> string
```
Return a string representing the given character, with special characters escaped following the lexical conventions of OCaml. All characters outside the ASCII printable range (32..126) are escaped, as well as backslash, double-quote, and single-quote.

```
val lowercase_ascii : char -> char
```
Convert the given character to its equivalent lowercase character, using the US-ASCII character set.

since 4.03
```
val uppercase_ascii : char -> char
```
Convert the given character to its equivalent uppercase character, using the US-ASCII character set.

since 4.03
```
type t = char
```
An alias for the type of characters.

```
val compare : t -> t -> int
```
The comparison function for characters, with the same specification as [`Stdlib.compare`](./Stdlib.md#val-compare). Along with the type `t`, this function `compare` allows the module `Char` to be passed as argument to the functors [`Set.Make`](./Stdlib-Set-Make.md) and [`Map.Make`](./Stdlib-Map-Make.md).

```
val equal : t -> t -> bool
```
The equal function for chars.

since 4.03
```
val seeded_hash : int -> t -> int
```
A seeded hash function for characters, with the same output value as [`Hashtbl.seeded_hash`](./Stdlib-Hashtbl.md#val-seeded_hash). This function allows this module to be passed as argument to the functor [`Hashtbl.MakeSeeded`](./Stdlib-Hashtbl-MakeSeeded.md).

since 5.1
```
val hash : t -> int
```
An unseeded hash function for characters, with the same output value as [`Hashtbl.hash`](./Stdlib-Hashtbl.md#val-hash). This function allows this module to be passed as argument to the functor [`Hashtbl.Make`](./Stdlib-Hashtbl-Make.md).

since 5.1