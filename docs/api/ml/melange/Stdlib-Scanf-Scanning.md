
# Module `Scanf.Scanning`

```
type in_channel
```
The notion of input channel for the [`Scanf`](./Stdlib-Scanf.md) module: those channels provide all the machinery necessary to read from any source of characters, including a [`Stdlib.in_channel`](./Stdlib.md#type-in_channel) value. A Scanf.Scanning.in\_channel value is also called a *formatted input channel* or equivalently a *scanning buffer*. The type [`Scanning.scanbuf`](./#type-scanbuf) below is an alias for `Scanning.in_channel`. Note that a `Scanning.in_channel` is not concurrency-safe: concurrent use may produce arbitrary values or exceptions.

since 3.12
```
type scanbuf = in_channel
```
The type of scanning buffers. A scanning buffer is the source from which a formatted input function gets characters. The scanning buffer holds the current state of the scan, plus a function to get the next char from the input, and a token buffer to store the string matched so far.

Note: a scanning action may often require to examine one character in advance; when this 'lookahead' character does not belong to the token read, it is stored back in the scanning buffer and becomes the next character yet to be read.

```
val stdin : in_channel
```
The standard input notion for the [`Scanf`](./Stdlib-Scanf.md) module. `Scanning.stdin` is the [`Scanning.in_channel`](./#type-in_channel) formatted input channel attached to [`Stdlib.stdin`](./Stdlib.md#val-stdin).

Note: in the interactive system, when input is read from [`Stdlib.stdin`](./Stdlib.md#val-stdin), the newline character that triggers evaluation is part of the input; thus, the scanning specifications must properly skip this additional newline character (for instance, simply add a `'\n'` as the last character of the format string).

since 3.12
```
type file_name = string
```
A convenient alias to designate a file name.

since 4.00
```
val open_in : file_name -> in_channel
```
`Scanning.open_in fname` returns a [`Scanning.in_channel`](./#type-in_channel) formatted input channel for bufferized reading in text mode from file `fname`.

Note: `open_in` returns a formatted input channel that efficiently reads characters in large chunks; in contrast, `from_channel` below returns formatted input channels that must read one character at a time, leading to a much slower scanning rate.

since 3.12
```
val open_in_bin : file_name -> in_channel
```
`Scanning.open_in_bin fname` returns a [`Scanning.in_channel`](./#type-in_channel) formatted input channel for bufferized reading in binary mode from file `fname`.

since 3.12
```
val close_in : in_channel -> unit
```
Closes the [`Stdlib.in_channel`](./Stdlib.md#type-in_channel) associated with the given [`Scanning.in_channel`](./#type-in_channel) formatted input channel.

since 3.12
```
val from_file : file_name -> in_channel
```
An alias for [`Scanning.open_in`](./#val-open_in) above.

```
val from_file_bin : string -> in_channel
```
An alias for [`Scanning.open_in_bin`](./#val-open_in_bin) above.

```
val from_string : string -> in_channel
```
`Scanning.from_string s` returns a [`Scanning.in_channel`](./#type-in_channel) formatted input channel which reads from the given string. Reading starts from the first character in the string. The end-of-input condition is set when the end of the string is reached.

```
val from_function : (unit -> char) -> in_channel
```
`Scanning.from_function f` returns a [`Scanning.in_channel`](./#type-in_channel) formatted input channel with the given function as its reading method.

When scanning needs one more character, the given function is called.

When the function has no more character to provide, it *must* signal an end-of-input condition by raising the exception `End_of_file`.

```
val from_channel : in_channel -> in_channel
```
`Scanning.from_channel ic` returns a [`Scanning.in_channel`](./#type-in_channel) formatted input channel which reads from the regular [`Stdlib.in_channel`](./Stdlib.md#type-in_channel) input channel `ic` argument. Reading starts at current reading position of `ic`.

```
val end_of_input : in_channel -> bool
```
`Scanning.end_of_input ic` tests the end-of-input condition of the given [`Scanning.in_channel`](./#type-in_channel) formatted input channel.

```
val beginning_of_input : in_channel -> bool
```
`Scanning.beginning_of_input ic` tests the beginning of input condition of the given [`Scanning.in_channel`](./#type-in_channel) formatted input channel.

```
val name_of_input : in_channel -> string
```
`Scanning.name_of_input ic` returns the name of the character source for the given [`Scanning.in_channel`](./#type-in_channel) formatted input channel.

since 3.09