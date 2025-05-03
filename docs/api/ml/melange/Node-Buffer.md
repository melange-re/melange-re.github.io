
# Module `Node.Buffer`

Node Buffer API

```
type t = Node.buffer
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
```
 ]
```
```
val isBuffer : 'a -> bool
```
```
val fromString : string -> t
```
```
val fromStringWithEncoding : string -> encoding:encoding -> t
```
```
val toString : ?encoding:encoding -> t -> string
```
```
val concat : t array -> t
```