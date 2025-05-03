
# Module `Stdlib.Digest`

Message digest.

This module provides functions to compute 'digests', also known as 'hashes', of arbitrary-length strings or files. The supported hashing algorithms are BLAKE2 and MD5.


## Basic functions

The functions in this section use the MD5 hash function to produce 128-bit digests (16 bytes). MD5 is not cryptographically secure. Hence, these functions should not be used for security-sensitive applications. The BLAKE2 functions below are cryptographically secure.

```
type t = string
```
The type of digests: 16-byte strings.

```
val compare : t -> t -> int
```
The comparison function for 16-byte digests, with the same specification as [`Stdlib.compare`](./Stdlib.md#val-compare) and the implementation shared with [`String.compare`](./Stdlib-String.md#val-compare). Along with the type `t`, this function `compare` allows the module `Digest` to be passed as argument to the functors [`Set.Make`](./Stdlib-Set-Make.md) and [`Map.Make`](./Stdlib-Map-Make.md).

since 4.00
```
val equal : t -> t -> bool
```
The equal function for 16-byte digests.

since 4.03
```
val string : string -> t
```
Return the digest of the given string.

```
val bytes : bytes -> t
```
Return the digest of the given byte sequence.

since 4.02
```
val substring : string -> int -> int -> t
```
`Digest.substring s ofs len` returns the digest of the substring of `s` starting at index `ofs` and containing `len` characters.

```
val subbytes : bytes -> int -> int -> t
```
`Digest.subbytes s ofs len` returns the digest of the subsequence of `s` starting at index `ofs` and containing `len` bytes.

since 4.02
```
val channel : in_channel -> int -> t
```
If `len` is nonnegative, `Digest.channel ic len` reads `len` characters from channel `ic` and returns their digest, or raises `End_of_file` if end-of-file is reached before `len` characters are read. If `len` is negative, `Digest.channel ic len` reads all characters from `ic` until end-of-file is reached and return their digest.

```
val file : string -> t
```
Return the digest of the file whose name is given.

```
val output : out_channel -> t -> unit
```
Write a digest on the given output channel.

```
val input : in_channel -> t
```
Read a digest from the given input channel.

```
val to_hex : t -> string
```
Return the printable hexadecimal representation of the given digest.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if the argument is not exactly 16 bytes.
```
val of_hex : string -> t
```
Convert a hexadecimal representation back into the corresponding digest.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if the argument is not exactly 32 hexadecimal characters.
since 5.2
```
val from_hex : string -> t
```
Same function as [`Digest.of_hex`](./#val-of_hex).

since 4.00

## Generic interface

```
module type S = sig ... end
```
The signature for a hash function that produces digests of length `hash_length` from character strings, byte arrays, and files.


## Specific hash functions

```
module BLAKE128 : S
```
`BLAKE128` is the BLAKE2b hash function producing 128-bit (16-byte) digests. It is cryptographically secure. However, the small size of the digests enables brute-force attacks in `2{^64}` attempts.

```
module BLAKE256 : S
```
`BLAKE256` is the BLAKE2b hash function producing 256-bit (32-byte) digests. It is cryptographically secure, and the digests are large enough to thwart brute-force attacks.

```
module BLAKE512 : S
```
`BLAKE512` is the BLAKE2b hash function producing 512-bit (64-byte) digests. It is cryptographically secure, and the digests are large enough to thwart brute-force attacks.

```
module MD5 : S
```
`MD5` is the MD5 hash function. It produces 128-bit (16-byte) digests and is not cryptographically secure at all. It should be used only for compatibility with earlier designs that mandate the use of MD5.
