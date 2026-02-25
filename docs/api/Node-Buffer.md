
# Module `Node.Buffer`

Node Buffer API

```ocaml
type t = Node.buffer
```
```reasonml
type t = Node.buffer;
```
```
type encoding = [ 
```
```
| `ascii
```
```
| `utf8
```
```
| `utf16le
```
```
| `ucs2
```
```
| `base64
```
```
| `base64url
```
```
| `latin1
```
```
| `binary
```
```
| `hex
```
```ocaml
 ]
```
```reasonml
 ];
```
```ocaml
val isBuffer : 'a -> bool
```
```reasonml
let isBuffer: 'a => bool;
```
```ocaml
val fromString : string -> t
```
```reasonml
let fromString: string => t;
```
```ocaml
val fromStringWithEncoding : string -> encoding:encoding -> t
```
```reasonml
let fromStringWithEncoding: string => encoding:encoding => t;
```
```ocaml
val toString : ?encoding:encoding -> t -> string
```
```reasonml
let toString: ?encoding:encoding => t => string;
```
```ocaml
val concat : t array -> t
```
```reasonml
let concat: array(t) => t;
```