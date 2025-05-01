# Module `Js.Dict`
Utility functions to treat a JS object as a dictionary
```
type 'a t = 'a Js.dict
```
Dictionary type (ie an '{ }' JS object). However it is restricted to hold a single type; therefore values must have the same type.
This Dictionary type is mostly used with the `Js_json.t` type.
```
type key = string
```
Key type
```
val get : 'a t -> key -> 'a option
```
`get dict key` returns `None` if the `key` is not found in the dictionary, `Some value` otherwise
```
val unsafeGet : 'a t -> key -> 'a
```
`unsafeGet dict key` return the value if the `key` exists, otherwise an **undefined** value is returned. Must be used only when the existence of a key is certain. (i.e. when having called `keys` function previously.
```ocaml
Array.iter (fun key -> Js.log (Js_dict.unsafeGet dic key)) (Js_dict.keys dict)
```
```
val set : 'a t -> key -> 'a -> unit
```
`set dict key value` sets the `key`/`value` in `dict`
```
val keys : 'a t -> string array
```
`keys dict` returns all the keys in the dictionary `dict`
```
val empty : unit -> 'a t
```
`empty ()` returns an empty dictionary
```
val unsafeDeleteKey : (string t -> string -> unit) Js.Fn.arity2
```
Experimental internal function
```
val entries : 'a t -> (key * 'a) array
```
`entries dict` returns the key value pairs in `dict` (ES2017)
```
val values : 'a t -> 'a array
```
`values dict` returns the values in `dict` (ES2017)
```
val fromList : (key * 'a) list -> 'a t
```
`fromList entries` creates a new dictionary containing each `(key, value)` pair in `entries`
```
val fromArray : (key * 'a) array -> 'a t
```
`fromArray entries` creates a new dictionary containing each `(key, value)` pair in `entries`
```
val map : f:('a -> 'b) Js.Fn.arity1 -> 'a t -> 'b t
```
`map f dict` maps `dict` to a new dictionary with the same keys, using `f` to map each value