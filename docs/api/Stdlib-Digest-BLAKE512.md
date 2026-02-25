
# Module `Digest.BLAKE512`

`BLAKE512` is the BLAKE2b hash function producing 512-bit (64-byte) digests. It is cryptographically secure, and the digests are large enough to thwart brute-force attacks.

since 5\.2
```ocaml
type t = string
```
```reasonml
type t = string;
```
The type of digests.

```ocaml
val hash_length : int
```
```reasonml
let hash_length: int;
```
The length of digests, in bytes.

```ocaml
val compare : t -> t -> int
```
```reasonml
let compare: t => t => int;
```
Compare two digests, with the same specification as [`Stdlib.compare`](./Stdlib.md#val-compare).

```ocaml
val equal : t -> t -> bool
```
```reasonml
let equal: t => t => bool;
```
Test two digests for equality.

```ocaml
val string : string -> t
```
```reasonml
let string: string => t;
```
Return the digest of the given string.

```ocaml
val bytes : bytes -> t
```
```reasonml
let bytes: bytes => t;
```
Return the digest of the given byte sequence.

```ocaml
val substring : string -> int -> int -> t
```
```reasonml
let substring: string => int => int => t;
```
`substring s ofs len` returns the digest of the substring of `s` starting at index `ofs` and containing `len` characters.

```ocaml
val subbytes : bytes -> int -> int -> t
```
```reasonml
let subbytes: bytes => int => int => t;
```
`subbytes s ofs len` returns the digest of the subsequence of `s` starting at index `ofs` and containing `len` bytes.

```ocaml
val channel : in_channel -> int -> t
```
```reasonml
let channel: in_channel => int => t;
```
Read characters from the channel and return their digest. See [`Digest.channel`](./Stdlib-Digest.md#val-channel) for the full specification.

```ocaml
val file : string -> t
```
```reasonml
let file: string => t;
```
Return the digest of the file whose name is given.

```ocaml
val output : out_channel -> t -> unit
```
```reasonml
let output: out_channel => t => unit;
```
Write a digest on the given output channel.

```ocaml
val input : in_channel -> t
```
```reasonml
let input: in_channel => t;
```
Read a digest from the given input channel.

```ocaml
val to_hex : t -> string
```
```reasonml
let to_hex: t => string;
```
Return the printable hexadecimal representation of the given digest.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if the length of the argument is not hash\_length,
```ocaml
val of_hex : string -> t
```
```reasonml
let of_hex: string => t;
```
Convert a hexadecimal representation back into the corresponding digest.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if the length of the argument is not 2 \* hash\_length, or if the arguments contains non-hexadecimal characters.