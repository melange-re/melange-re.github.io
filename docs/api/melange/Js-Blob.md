# Module `Js.Blob`
Bindings to Blob
```
type t = Js.blob
```
```
type options = {
```
`type_ : string option;`
A string representing the MIME type of the content that will be put into the file. Defaults to a value of "".
``endings : [ `transparent | `native ] option;``
How to interpret newline characters (\\n) within the contents, if the data is text. The default value, transparent, copies newline characters into the blob without changing them. To convert newlines to the host system's native convention, specify the value native.
```
}
```
```
val make : string Js.iterator -> ?options:options -> unit -> t
```
`make (Js.Array.values contents_array)` creates a new file from an iterable object such as an Array, having ArrayBuffers, TypedArrays, DataViews, Blobs, strings, or a mix of any of such elements, that will be put inside the File. Note that strings here are encoded as UTF-8, unlike the usual JavaScript UTF-16 strings.
```
val size : t -> float
```
`size t` returns the size of the Blob in bytes
```
val type_ : t -> string
```
`type_ t` returns the MIME type of the file.
```
val arrayBuffer : t -> Js.arrayBuffer Js.promise
```
`arrayBuffer t` returns a Promise that resolves with the contents of the blob as binary data contained in a `Js.arrayBuffer`.
```
val bytes : t -> Js.uint8Array Js.promise
```
`bytes t` returns a Promise that resolves with a `Js.uint8Array` containing the contents of the blob as an array of bytes.
```
val slice : ?start:int -> ?end_:int -> ?contentType:string -> t -> t
```
`slice ?start ?end_ ?contentType t` creates and returns a new Blob object which contains data from a subset of the blob on which it's called.
```
val text : t -> string Js.promise
```
`text t` returns a Promise that resolves with a string containing the contents of the blob, interpreted as UTF-8.