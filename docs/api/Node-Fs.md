
# Module `Node.Fs`

Node FS API

see [https://blogs.janestreet.com/a-and-a/](https://blogs.janestreet.com/a-and-a/) refernce documentation
```ocaml
val readdirSync : string -> string array
```
```reasonml
let readdirSync: string => array(string);
```
Most fs functions let you omit the callback argument. If you do, a default callback is used that rethrows errors. To get a trace to the original call site, set the \`NODE\_DEBUG\` environment variable.

```ocaml
val renameSync : string -> string -> unit
```
```reasonml
let renameSync: string => string => unit;
```
```ocaml
type fd = private int
```
```reasonml
type fd = pri int;
```
```ocaml
type path = string
```
```reasonml
type path = string;
```
The relative path to a filename can be used. Remember, however, that this path will be relative to `process.cwd()`.

```ocaml
module Watch : sig ... end
```
```reasonml
module Watch: { ... };
```
```ocaml
val ftruncateSync : fd -> int -> unit
```
```reasonml
let ftruncateSync: fd => int => unit;
```
```ocaml
val truncateSync : string -> int -> unit
```
```reasonml
let truncateSync: string => int => unit;
```
```ocaml
val chownSync : string -> uid:int -> gid:int -> unit
```
```reasonml
let chownSync: string => uid:int => gid:int => unit;
```
```ocaml
val fchownSync : fd -> uid:int -> gid:int -> unit
```
```reasonml
let fchownSync: fd => uid:int => gid:int => unit;
```
```ocaml
val readlinkSync : string -> string
```
```reasonml
let readlinkSync: string => string;
```
```ocaml
val unlinkSync : string -> unit
```
```reasonml
let unlinkSync: string => unit;
```
```ocaml
val rmdirSync : string -> unit
```
```reasonml
let rmdirSync: string => unit;
```
```ocaml
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
```reasonml
let openSync: 
  path =>
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
  | `Append_read_fail_if_exists ] =>
  unit;
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
```ocaml
 ]
```
```reasonml
 ];
```
```ocaml
val readFileSync : string -> encoding -> string
```
```reasonml
let readFileSync: string => encoding => string;
```
```ocaml
val readFileAsUtf8Sync : string -> string
```
```reasonml
let readFileAsUtf8Sync: string => string;
```
```ocaml
val existsSync : string -> bool
```
```reasonml
let existsSync: string => bool;
```
```ocaml
val writeFileSync : string -> string -> encoding -> unit
```
```reasonml
let writeFileSync: string => string => encoding => unit;
```
```ocaml
val writeFileAsUtf8Sync : string -> string -> unit
```
```reasonml
let writeFileAsUtf8Sync: string => string => unit;
```