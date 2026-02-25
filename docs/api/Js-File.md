
# Module `Js.File`

Bindings to File

```ocaml
type t = Js.file
```
```reasonml
type t = Js.file;
```
```
type options = {
```
`type_ : string option;`
A string representing the MIME type of the content that will be put into the file. Defaults to a value of "".

`endings : [ `transparent | `native ] option;`
How to interpret newline characters (\\n) within the contents, if the data is text. The default value, transparent, copies newline characters into the file without changing them. To convert newlines to the host system's native convention, specify the value native.

`lastModified : float option;`
A number representing the number of milliseconds between the Unix time epoch and when the file was last modified. Defaults to a value of Date.now().

```ocaml
}
```
```reasonml
};
```
```ocaml
val options : 
  ?type_:string ->
  ?endings:[ `transparent | `native ] ->
  ?lastModified:float ->
  unit ->
  options
```
```reasonml
let options: 
  ?type_:string =>
  ?endings:[ `transparent | `native ] =>
  ?lastModified:float =>
  unit =>
  options;
```
```ocaml
val make : 
  string Js.iterator ->
  filename:string ->
  ?options:options ->
  unit ->
  t
```
```reasonml
let make: 
  Js.iterator(string) =>
  filename:string =>
  ?options:options =>
  unit =>
  t;
```
`make contents_array ~filename` creates a new file from an iterable object such as an Array, having ArrayBuffers, TypedArrays, DataViews, Blobs, strings, or a mix of any of such elements, that will be put inside the File. Note that strings here are encoded as UTF-8, unlike the usual JavaScript UTF-16 strings.

```ocaml
val lastModified : t -> float
```
```reasonml
let lastModified: t => float;
```
`lastModified t` accesses the read-only property of the File interface, which provides the last modified date of the file as the number of milliseconds since the Unix epoch (January 1, 1970 at midnight). Files without a known last modified date return the current date.

```ocaml
val name : t -> string
```
```reasonml
let name: t => string;
```
The `name t` read-only property of the File interface returns the name of the file represented by a File object. For security reasons, the path is excluded from this property.

```ocaml
val size : t -> float
```
```reasonml
let size: t => float;
```
`size t` returns the size of the File in bytes

```ocaml
val type_ : t -> string
```
```reasonml
let type_: t => string;
```
`type_ t` returns the MIME type of the file.

```ocaml
val arrayBuffer : t -> Js.arrayBuffer Js.promise
```
```reasonml
let arrayBuffer: t => Js.promise(Js.arrayBuffer);
```
`arrayBuffer t` returns a Promise that resolves with the contents of the blob as binary data contained in a `Js.arrayBuffer`.

```ocaml
val bytes : t -> Js.uint8Array Js.promise
```
```reasonml
let bytes: t => Js.promise(Js.uint8Array);
```
`bytes t` returns a Promise that resolves with a `Js.uint8Array` containing the contents of the file as an array of bytes.

```ocaml
val slice : ?start:int -> ?end_:int -> ?contentType:string -> t -> t
```
```reasonml
let slice: ?start:int => ?end_:int => ?contentType:string => t => t;
```
`slice ?start ?end_ ?contentType t` creates and returns a new File object which contains data from a subset of the file on which it's called.

```ocaml
val text : t -> string Js.promise
```
```reasonml
let text: t => Js.promise(string);
```
`text t` returns a Promise that resolves with a string containing the contents of the file, interpreted as UTF-8.
