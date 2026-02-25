
# Module `Stdlib.Printf`

Formatted output functions.

```ocaml
val fprintf : out_channel -> ('a, out_channel, unit) format -> 'a
```
```reasonml
let fprintf: out_channel => format('a, out_channel, unit) => 'a;
```
`fprintf outchan format arg1 ... argN` formats the arguments `arg1` to `argN` according to the format string `format`, and outputs the resulting string on the channel `outchan`.

The format string is a character string which contains two types of objects: plain characters, which are simply copied to the output channel, and conversion specifications, each of which causes conversion and printing of arguments.

Conversion specifications have the following form:

`% [flags] [width] [.precision] type`

In short, a conversion specification consists in the `%` character, followed by optional modifiers and a type which is made of one or two characters.

The types and their meanings are:

- `d`, `i`: convert an integer argument to signed decimal. The flag `#` adds underscores to large values for readability.
- `u`, `n`, `l`, `L`, or `N`: convert an integer argument to unsigned decimal. Warning: `n`, `l`, `L`, and `N` are used for `scanf`, and should not be used for `printf`. The flag `#` adds underscores to large values for readability.
- `x`: convert an integer argument to unsigned hexadecimal, using lowercase letters. The flag `#` adds a `0x` prefix to non zero values.
- `X`: convert an integer argument to unsigned hexadecimal, using uppercase letters. The flag `#` adds a `0X` prefix to non zero values.
- `o`: convert an integer argument to unsigned octal. The flag `#` adds a `0` prefix to non zero values.
- `s`: insert a string argument.
- `S`: convert a string argument to OCaml syntax (double quotes, escapes).
- `c`: insert a character argument.
- `C`: convert a character argument to OCaml syntax (single quotes, escapes).
- `f`: convert a floating-point argument to decimal notation, in the style `dddd.ddd`.
- `F`: convert a floating-point argument to OCaml syntax (`dddd.` or `dddd.ddd` or `d.ddd e+-dd`). Converts to hexadecimal with the `#` flag (see `h`).
- `e` or `E`: convert a floating-point argument to decimal notation, in the style `d.ddd e+-dd` (mantissa and exponent).
- `g` or `G`: convert a floating-point argument to decimal notation, in style `f` or `e`, `E` (whichever is more compact). Moreover, any trailing zeros are removed from the fractional part of the result and the decimal-point character is removed if there is no fractional part remaining.
- `h` or `H`: convert a floating-point argument to hexadecimal notation, in the style `0xh.hhhh p+-dd` (hexadecimal mantissa, exponent in decimal and denotes a power of 2\).
- `B`: convert a boolean argument to the string `true` or `false`
- `b`: convert a boolean argument (deprecated; do not use in new programs).
- `ld`, `li`, `lu`, `lx`, `lX`, `lo`: convert an `int32` argument to the format specified by the second letter (decimal, hexadecimal, etc).
- `nd`, `ni`, `nu`, `nx`, `nX`, `no`: convert a `nativeint` argument to the format specified by the second letter.
- `Ld`, `Li`, `Lu`, `Lx`, `LX`, `Lo`: convert an `int64` argument to the format specified by the second letter.
- `a`: user-defined printer. Take two arguments and apply the first one to `outchan` (the current output channel) and to the second argument. The first argument must therefore have type <code class="text-ocaml">out_channel -&gt; 'b -&gt; unit</code><code class="text-reasonml">(out_channel, 'b) =&gt; unit</code> and the second `'b`. The output produced by the function is inserted in the output of `fprintf` at the current point.
- `t`: same as `%a`, but take only one argument (with type <code class="text-ocaml">out_channel -&gt; unit</code><code class="text-reasonml">out_channel =&gt; unit</code>) and apply it to `outchan`.
- `\{ fmt %\}`: convert a format string argument to its type digest. The argument must have the same type as the internal format string `fmt`.
- `( fmt %)`: format string substitution. Take a format string argument and substitute it to the internal format string `fmt` to print following arguments. The argument must have the same type as the internal format string `fmt`.
- `!`: take no argument and flush the output.
- `%`: take no argument and output one `%` character.
- `\@`: take no argument and output one `\@` character.
- `,`: take no argument and output nothing: a no-op delimiter for conversion specifications.
The optional `flags` are:

- `-`: left-justify the output (default is right justification).
- `0`: for numerical conversions, pad with zeroes instead of spaces.
- `+`: for signed numerical conversions, prefix number with a `+` sign if positive.
- space: for signed numerical conversions, prefix number with a space if positive.
- `#`: request an alternate formatting style for the integer types and the floating-point type `F`.
The optional `width` is an integer indicating the minimal width of the result. For instance, `%6d` prints an integer, prefixing it with spaces to fill at least 6 characters.

The optional `precision` is a dot `.` followed by an integer indicating how many digits follow the decimal point in the `%f`, `%e`, `%E`, `%h`, and `%H` conversions or the maximum number of significant digits to appear for the `%F`, `%g` and `%G` conversions. For instance, `%.4f` prints a `float` with 4 fractional digits.

The integer in a `width` or `precision` can also be specified as `*`, in which case an extra integer argument is taken to specify the corresponding `width` or `precision`. This integer argument precedes immediately the argument to print. For instance, `%.*f` prints a `float` with as many fractional digits as the value of the argument given before the float.

```ocaml
val printf : ('a, out_channel, unit) format -> 'a
```
```reasonml
let printf: format('a, out_channel, unit) => 'a;
```
Same as [`Printf.fprintf`](./#val-fprintf), but output on `stdout`.

```ocaml
val eprintf : ('a, out_channel, unit) format -> 'a
```
```reasonml
let eprintf: format('a, out_channel, unit) => 'a;
```
Same as [`Printf.fprintf`](./#val-fprintf), but output on `stderr`.

```ocaml
val sprintf : ('a, unit, string) format -> 'a
```
```reasonml
let sprintf: format('a, unit, string) => 'a;
```
Same as [`Printf.fprintf`](./#val-fprintf), but instead of printing on an output channel, return a string containing the result of formatting the arguments.

```ocaml
val bprintf : Buffer.t -> ('a, Buffer.t, unit) format -> 'a
```
```reasonml
let bprintf: Buffer.t => format('a, Buffer.t, unit) => 'a;
```
Same as [`Printf.fprintf`](./#val-fprintf), but instead of printing on an output channel, append the formatted arguments to the given extensible buffer (see module [`Buffer`](./Stdlib-Buffer.md)).

```ocaml
val ifprintf : 'b -> ('a, 'b, 'c, unit) format4 -> 'a
```
```reasonml
let ifprintf: 'b => format4('a, 'b, 'c, unit) => 'a;
```
Same as [`Printf.fprintf`](./#val-fprintf), but does not print anything. Useful to ignore some material when conditionally printing.

since 3\.10
```ocaml
val ibprintf : Buffer.t -> ('a, Buffer.t, unit) format -> 'a
```
```reasonml
let ibprintf: Buffer.t => format('a, Buffer.t, unit) => 'a;
```
Same as [`Printf.bprintf`](./#val-bprintf), but does not print anything. Useful to ignore some material when conditionally printing.

since 4\.11
Formatted output functions with continuations.

```ocaml
val kfprintf : 
  (out_channel -> 'd) ->
  out_channel ->
  ('a, out_channel, unit, 'd) format4 ->
  'a
```
```reasonml
let kfprintf: 
  (out_channel => 'd) =>
  out_channel =>
  format4('a, out_channel, unit, 'd) =>
  'a;
```
Same as `fprintf`, but instead of returning immediately, passes the out channel to its first argument at the end of printing.

since 3\.09
```ocaml
val ikfprintf : ('b -> 'd) -> 'b -> ('a, 'b, 'c, 'd) format4 -> 'a
```
```reasonml
let ikfprintf: ('b => 'd) => 'b => format4('a, 'b, 'c, 'd) => 'a;
```
Same as `kfprintf` above, but does not print anything. Useful to ignore some material when conditionally printing.

since 4\.01
```ocaml
val ksprintf : (string -> 'd) -> ('a, unit, string, 'd) format4 -> 'a
```
```reasonml
let ksprintf: (string => 'd) => format4('a, unit, string, 'd) => 'a;
```
Same as `sprintf` above, but instead of returning the string, passes it to the first argument.

since 3\.09
```ocaml
val kbprintf : 
  (Buffer.t -> 'd) ->
  Buffer.t ->
  ('a, Buffer.t, unit, 'd) format4 ->
  'a
```
```reasonml
let kbprintf: 
  (Buffer.t => 'd) =>
  Buffer.t =>
  format4('a, Buffer.t, unit, 'd) =>
  'a;
```
Same as `bprintf`, but instead of returning immediately, passes the buffer to its first argument at the end of printing.

since 3\.10
```ocaml
val ikbprintf : 
  (Buffer.t -> 'd) ->
  Buffer.t ->
  ('a, Buffer.t, unit, 'd) format4 ->
  'a
```
```reasonml
let ikbprintf: 
  (Buffer.t => 'd) =>
  Buffer.t =>
  format4('a, Buffer.t, unit, 'd) =>
  'a;
```
Same as `kbprintf` above, but does not print anything. Useful to ignore some material when conditionally printing.

since 4\.11
Deprecated

```ocaml
val kprintf : (string -> 'b) -> ('a, unit, string, 'b) format4 -> 'a
```
```reasonml
let kprintf: (string => 'b) => format4('a, unit, string, 'b) => 'a;
```
A deprecated synonym for `ksprintf`.

deprecated Use Printf.ksprintf instead.