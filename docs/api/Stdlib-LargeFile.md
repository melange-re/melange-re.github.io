
# Module `Stdlib.LargeFile`

Operations on large files. This sub-module provides 64-bit variants of the channel functions that manipulate file positions and file sizes. By representing positions and sizes by 64-bit integers (type `int64`) instead of regular integers (type `int`), these alternate functions allow operating on files whose sizes are greater than `max_int`.

```ocaml
val seek_out : out_channel -> int64 -> unit
```
```reasonml
let seek_out: out_channel => int64 => unit;
```
```ocaml
val pos_out : out_channel -> int64
```
```reasonml
let pos_out: out_channel => int64;
```
```ocaml
val out_channel_length : out_channel -> int64
```
```reasonml
let out_channel_length: out_channel => int64;
```
```ocaml
val seek_in : in_channel -> int64 -> unit
```
```reasonml
let seek_in: in_channel => int64 => unit;
```
```ocaml
val pos_in : in_channel -> int64
```
```reasonml
let pos_in: in_channel => int64;
```
```ocaml
val in_channel_length : in_channel -> int64
```
```reasonml
let in_channel_length: in_channel => int64;
```