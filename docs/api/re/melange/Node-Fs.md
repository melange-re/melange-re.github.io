
# Module `Node.Fs`

Node FS API

see [https://blogs.janestreet.com/a-and-a/](https://blogs.janestreet.com/a-and-a/) refernce documentation
```
val readdirSync : string -> string array
```
Most fs functions let you omit the callback argument. If you do, a default callback is used that rethrows errors. To get a trace to the original call site, set the \`NODE\_DEBUG\` environment variable.

```
val renameSync : string -> string -> unit
```
```
type fd = private int
```
```
type path = string
```
The relative path to a filename can be used. Remember, however, that this path will be relative to `process.cwd()`.

```
module Watch : sig ... end
```
```
val ftruncateSync : fd -> int -> unit
```
```
val truncateSync : string -> int -> unit
```
```
val chownSync : string -> uid:int -> gid:int -> unit
```
```
val fchownSync : fd -> uid:int -> gid:int -> unit
```
```
val readlinkSync : string -> string
```
```
val unlinkSync : string -> unit
```
```
val rmdirSync : string -> unit
```
```
val openSync : 
  path ->
  [ `Read
  | `Read_write
  | `Read_write_sync
  | `Write
  | `Write_fail_if_exists
  | `Write_read
  | `Write_read_fail_if_exists
  | `Append
  | `Append_fail_if_exists
  | `Append_read
  | `Append_read_fail_if_exists ] ->
  unit
```
```
type encoding = [ 
```
```
| `hex
```
```
| `utf8
```
```
| `ascii
```
```
| `latin1
```
```
| `base64
```
```
| `ucs2
```
```
| `base64
```
```
| `binary
```
```
| `utf16le
```
```
 ]
```
```
val readFileSync : string -> encoding -> string
```
```
val readFileAsUtf8Sync : string -> string
```
```
val existsSync : string -> bool
```
```
val writeFileSync : string -> string -> encoding -> unit
```
```
val writeFileAsUtf8Sync : string -> string -> unit
```