
# Module `Char.Ascii`

ASCII character set support.

These functions give meaning to the integers \[`0x00`;`0x7F`\] of the [ASCII character set](https://en.wikipedia.org/wiki/ASCII#Character_set).

Since the UTF-8 encoding of Unicode has the same encoding and character semantics (U+0000 to U+001F) for these bytes, the functions can be safely used on elements of UTF-8 encoded `string` and `bytes` values. However the functions only deal with ASCII related matters. For example the notion of Unicode whitespace is much larger than the ASCII whitespace determined by [`Char.Ascii.is_white`](./#val-is_white).

since 5\.4

## Characters

```ocaml
val min : char
```
```reasonml
let min: char;
```
`min` is `'\x00'`.

```ocaml
val max : char
```
```reasonml
let max: char;
```
`max` is `'\x7F'`.


## Predicates

```ocaml
val is_valid : char -> bool
```
```reasonml
let is_valid: char => bool;
```
`is_valid c` is `true` if and only if `c` is an ASCII character, that is a byte in the range \[[`min`](./#val-min);[`max`](./#val-max)\].

```ocaml
val is_upper : char -> bool
```
```reasonml
let is_upper: char => bool;
```
`is_upper c` is `true` if and only if `c` is an ASCII uppercase letter `'A'` to `'Z'`, that is a byte in the range \[`0x41`;`0x5A`\].

```ocaml
val is_lower : char -> bool
```
```reasonml
let is_lower: char => bool;
```
`is_lower c` is `true` if and only if `c` is an ASCII lowercase letter `'a'` to `'z'`, that is a byte in the range \[`0x61`;`0x7A`\].

```ocaml
val is_letter : char -> bool
```
```reasonml
let is_letter: char => bool;
```
`is_letter c` is [`is_lower`](./#val-is_lower)` c || `[`is_upper`](./#val-is_upper)` c`.

```ocaml
val is_alphanum : char -> bool
```
```reasonml
let is_alphanum: char => bool;
```
`is_alphanum c` is [`is_letter`](./#val-is_letter)` c || `[`is_digit`](./#val-is_digit)` c`.

```ocaml
val is_white : char -> bool
```
```reasonml
let is_white: char => bool;
```
`is_white c` is `true` if and only if `c` is an ASCII white space character, that is one of tab `'\t'` (`0x09`), newline `'\n'` (`0x0A`), vertical tab (`0x0B`), form feed (`0x0C`), carriage return `'\r'` (`0x0D`) or space `' '` (`0x20`),

```ocaml
val is_blank : char -> bool
```
```reasonml
let is_blank: char => bool;
```
`is_blank c` is `true` if and only if `c` is an ASCII blank character, that is either space `' '` (`0x20`) or tab `'\t'` (`0x09`).

```ocaml
val is_graphic : char -> bool
```
```reasonml
let is_graphic: char => bool;
```
`is_graphic c` is `true` if and only if `c` is an ASCII graphic character, that is a byte in the range \[`0x21`;`0x7E`\].

```ocaml
val is_print : char -> bool
```
```reasonml
let is_print: char => bool;
```
`is_print c` is [`is_graphic`](./#val-is_graphic)` c || c = ' '`.

```ocaml
val is_control : char -> bool
```
```reasonml
let is_control: char => bool;
```
`is_control c` is `true` if and only if `c` is an ASCII control character, that is a byte in the range \[`0x00`;`0x1F`\] or `0x7F`.


## Decimal digits

```ocaml
val is_digit : char -> bool
```
```reasonml
let is_digit: char => bool;
```
`is_digit c` is `true` if and only if `c` is an ASCII decimal digit `'0'` to `'9'`, that is a byte in the range \[`0x30`;`0x39`\].

```ocaml
val digit_to_int : char -> int
```
```reasonml
let digit_to_int: char => int;
```
`digit_to_int c` is the numerical value of a digit that satisfies [`is_digit`](./#val-is_digit). Raises `Invalid_argument` if [`is_digit`](./#val-is_digit)` c` is `false`.

```ocaml
val digit_of_int : int -> char
```
```reasonml
let digit_of_int: int => char;
```
`digit_of_int n` is an ASCII decimal digit for the decimal value `abs (n mod 10)`.


## Hexadecimal digits

```ocaml
val is_hex_digit : char -> bool
```
```reasonml
let is_hex_digit: char => bool;
```
`is_hex_digit c` is `true` if and only if `c` is an ASCII hexadecimal digit `'0'` to `'9'`, `'a'` to `'f'` or `'A'` to `'F'`, that is a byte in one of the ranges \[`0x30`;`0x39`\], \[`0x41`;`0x46`\], \[`0x61`;`0x66`\].

```ocaml
val hex_digit_to_int : char -> int
```
```reasonml
let hex_digit_to_int: char => int;
```
`hex_digit_to_int c` is the numerical value of a digit that satisfies [`is_hex_digit`](./#val-is_hex_digit). Raises `Invalid_argument` if [`is_hex_digit`](./#val-is_hex_digit)` c` is `false`.

```ocaml
val lower_hex_digit_of_int : int -> char
```
```reasonml
let lower_hex_digit_of_int: int => char;
```
`lower_hex_digit_of_int n` is a lowercase ASCII hexadecimal digit for the hexadecimal value `abs (n mod 16)`.

```ocaml
val upper_hex_digit_of_int : int -> char
```
```reasonml
let upper_hex_digit_of_int: int => char;
```
`upper_hex_digit_of_int n` is an uppercase ASCII hexadecimal digit for the hexadecimal value `abs (n mod 16)`.


## Casing transforms

```ocaml
val uppercase : char -> char
```
```reasonml
let uppercase: char => char;
```
`uppercase c` is `c` with ASCII characters `'a'` to `'z'` respectively mapped to uppercase characters `'A'` to `'Z'`. Other characters are left untouched.

```ocaml
val lowercase : char -> char
```
```reasonml
let lowercase: char => char;
```
`lowercase c` is `c` with ASCII characters `'A'` to `'Z'` respectively mapped to lowercase characters `'a'` to `'z'`. Other characters are left untouched.
