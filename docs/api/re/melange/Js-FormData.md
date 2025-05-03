
# Module `Js.FormData`

Bindings to FormData

```
type t
```
```
type entryValue
```
The values returned by the \`get`,All`\` and iteration functions is either a string or a Blob. Melange uses an abstract type and defers to users of the API to handle it according to their application needs.

```
val make : unit -> t
```
`make ()` creates a new `FormData` object, initially empty.

```
val append : 
  name:string ->
  value:[ `String of string | `Object of < .. > Js.t | `Dict of _ Js.dict ] ->
  t ->
  unit
```
`append t ~name ~value` appends a new value onto an existing key inside a FormData object, or adds the key if it does not already exist.

```
val appendBlob : 
  name:string ->
  value:[ `Blob of Js.blob | `File of Js.file ] ->
  ?filename:string ->
  t ->
  unit
```
`appendBlob t ~name ~value` appends a new value onto an existing key inside a FormData object, or adds the key if it does not already exist. This method differs from `append` in that instances in the Blob hierarchy can pass a third filename argument.

```
val delete : name:string -> t -> unit
```
`delete t ~name` deletes a key and its value(s) from a FormData object.

```
val get : name:string -> t -> entryValue option
```
`get t ~name` returns the first value associated with a given key from within a FormData object. If you expect multiple values and want all of them, use [`getAll`](./#val-getAll) instead.

```
val getAll : name:string -> t -> entryValue array
```
`getAll t ~name` returns all the values associated with a given key from within a FormData object.

```
val set : 
  name:string ->
  [ `String of string | `Object of < .. > Js.t | `Dict of _ Js.dict ] ->
  t ->
  unit
```
`set t ~name ~value` sets a new value for an existing key inside a FormData object, or adds the key/value if it does not already exist.

```
val setBlob : 
  name:string ->
  [ `Blob of Js.blob | `File of Js.file ] ->
  ?filename:string ->
  t ->
  unit
```
`setBlob t ~name ~value ?filename` sets a new value for an existing key inside a FormData object, or adds the key/value if it does not already exist. This method differs from `set` in that instances in the Blob hierarchy can pass a third filename argument.

```
val has : name:string -> t -> bool
```
`has ~name t` returns whether a FormData object contains a certain key.

```
val keys : t -> string Js.iterator
```
`keys t` returns an iterator which iterates through all keys contained in the FormData. The keys are strings.

```
val values : t -> entryValue Js.iterator
```
`values t` returns an iterator which iterates through all values contained in the FormData. The values are strings or Blob objects.

```
val entries : t -> (string * entryValue) Js.iterator
```
`entries t` returns an iterator which iterates through all key/value pairs contained in the FormData.
