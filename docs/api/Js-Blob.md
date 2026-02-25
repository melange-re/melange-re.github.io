
# Module `Js.Blob`

Bindings to Blob

```ocaml
type t = Js.blob
```
```reasonml
type t = Js.blob;
```
```
type options = {
```
`type_ : string option;`
A string representing the MIME type of the content that will be put into the file. Defaults to a value of "".

`endings : [ `transparent | `native ] option;`
How to interpret newline characters (\\n) within the contents, if the data is text. The default value, transparent, copies newline characters into the blob without changing them. To convert newlines to the host system's native convention, specify the value native.

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
  unit ->
  options
```
```reasonml
let options: 
  ?type_:string =>
  ?endings:[ `transparent | `native ] =>
  unit =>
  options;
```
```ocaml
val make : string Js.iterator -> ?options:options -> unit -> t
```
```reasonml
let make: Js.iterator(string) => ?options:options => unit => t;
```
`make (Js.Array.values contents_array)` creates a new file from an iterable object such as an Array, having ArrayBuffers, TypedArrays, DataViews, Blobs, strings, or a mix of any of such elements, that will be put inside the File. Note that strings here are encoded as UTF-8, unlike the usual JavaScript UTF-16 strings.

```ocaml
val size : t -> float
```
```reasonml
let size: t => float;
```
`size t` returns the size of the Blob in bytes

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
`bytes t` returns a Promise that resolves with a `Js.uint8Array` containing the contents of the blob as an array of bytes.

```ocaml
val slice : ?start:int -> ?end_:int -> ?contentType:string -> t -> t
```
```reasonml
let slice: ?start:int => ?end_:int => ?contentType:string => t => t;
```
`slice ?start ?end_ ?contentType t` creates and returns a new Blob object which contains data from a subset of the blob on which it's called.

```ocaml
val text : t -> string Js.promise
```
```reasonml
let text: t => Js.promise(string);
```
`text t` returns a Promise that resolves with a string containing the contents of the blob, interpreted as UTF-8.
