
# Module `Stdlib.Uchar`

Unicode characters.

since 4.03
```
type t
```
The type for Unicode characters.

A value of this type represents a Unicode [scalar value](http://unicode.org/glossary/#unicode_scalar_value) which is an integer in the ranges `0x0000`...`0xD7FF` or `0xE000`...`0x10FFFF`.

```
val min : t
```
`min` is U+0000.

```
val max : t
```
`max` is U+10FFFF.

```
val bom : t
```
`bom` is U+FEFF, the [byte order mark](http://unicode.org/glossary/#byte_order_mark) (BOM) character.

since 4.06
```
val rep : t
```
`rep` is U+FFFD, the [replacement](http://unicode.org/glossary/#replacement_character) character.

since 4.06
```
val succ : t -> t
```
`succ u` is the scalar value after `u` in the set of Unicode scalar values.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if u is max.
```
val pred : t -> t
```
`pred u` is the scalar value before `u` in the set of Unicode scalar values.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if u is min.
```
val is_valid : int -> bool
```
`is_valid n` is `true` if and only if `n` is a Unicode scalar value (i.e. in the ranges `0x0000`...`0xD7FF` or `0xE000`...`0x10FFFF`).

```
val of_int : int -> t
```
`of_int i` is `i` as a Unicode character.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if i does not satisfy is\_valid.
```
val to_int : t -> int
```
`to_int u` is `u` as an integer.

```
val is_char : t -> bool
```
`is_char u` is `true` if and only if `u` is a latin1 OCaml character.

```
val of_char : char -> t
```
`of_char c` is `c` as a Unicode character.

```
val to_char : t -> char
```
`to_char u` is `u` as an OCaml latin1 character.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if u does not satisfy is\_char.
```
val equal : t -> t -> bool
```
`equal u u'` is `u = u'`.

```
val compare : t -> t -> int
```
`compare u u'` is `Stdlib.compare u u'`.

```
val seeded_hash : int -> t -> int
```
`seeded_hash seed u` A seeded hash function with the same output value as [`Hashtbl.seeded_hash`](./Stdlib-Hashtbl.md#val-seeded_hash). This function allows this module to be passed as an argument to the functor [`Hashtbl.MakeSeeded`](./Stdlib-Hashtbl-MakeSeeded.md).

since 5.3
```
val hash : t -> int
```
An unseeded hash function with the same output value as [`Hashtbl.hash`](./Stdlib-Hashtbl.md#val-hash). This function allows this module to be passed as an argument to the functor [`Hashtbl.Make`](./Stdlib-Hashtbl-Make.md).

since 5.3

## UTF codecs tools

since 4.14
```
type utf_decode
```
The type for UTF decode results. Values of this type represent the result of a Unicode Transformation Format decoding attempt.

```
val utf_decode_is_valid : utf_decode -> bool
```
`utf_decode_is_valid d` is `true` if and only if `d` holds a valid decode.

```
val utf_decode_uchar : utf_decode -> t
```
`utf_decode_uchar d` is the Unicode character decoded by `d` if `utf_decode_is_valid d` is `true` and [`Uchar.rep`](./#val-rep) otherwise.

```
val utf_decode_length : utf_decode -> int
```
`utf_decode_length d` is the number of elements from the source that were consumed by the decode `d`. This is always strictly positive and smaller or equal to `4`. The kind of source elements depends on the actual decoder; for the decoders of the standard library this function always returns a length in bytes.

```
val utf_decode : int -> t -> utf_decode
```
`utf_decode n u` is a valid UTF decode for `u` that consumed `n` elements from the source for decoding. `n` must be positive and smaller or equal to `4` (this is not checked by the module).

```
val utf_decode_invalid : int -> utf_decode
```
`utf_decode_invalid n` is an invalid UTF decode that consumed `n` elements from the source to error. `n` must be positive and smaller or equal to `4` (this is not checked by the module). The resulting decode has [`rep`](./#val-rep) as the decoded Unicode character.

```
val utf_8_byte_length : t -> int
```
`utf_8_byte_length u` is the number of bytes needed to encode `u` in UTF-8.

```
val utf_16_byte_length : t -> int
```
`utf_16_byte_length u` is the number of bytes needed to encode `u` in UTF-16.
