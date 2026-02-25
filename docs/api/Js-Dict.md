
# Module `Js.Dict`

Utility functions to treat a JS object as a dictionary

```ocaml
type 'a t = 'a Js.dict
```
```reasonml
type t('a) = Js.dict('a);
```
Dictionary type (ie an '{ }' JS object). However it is restricted to hold a single type; therefore values must have the same type.

This Dictionary type is mostly used with the `Js_json.t` type.

```ocaml
type key = string
```
```reasonml
type key = string;
```
Key type

```ocaml
val get : 'a t -> key -> 'a option
```
```reasonml
let get: t('a) => key => option('a);
```
`get dict key` returns `None` if the `key` is not found in the dictionary, `Some value` otherwise

```ocaml
val unsafeGet : 'a t -> key -> 'a
```
```reasonml
let unsafeGet: t('a) => key => 'a;
```
`unsafeGet dict key` return the value if the `key` exists, otherwise an **undefined** value is returned. Must be used only when the existence of a key is certain. (i.e. when having called `keys` function previously.

```ocaml
Array.iter (fun key -> Js.log (Js_dict.unsafeGet dic key)) (Js_dict.keys dict)
```
```reasonml
Array.iter(key => Js.log(Js_dict.unsafeGet(dic, key)), Js_dict.keys(dict));
```
```ocaml
val set : 'a t -> key -> 'a -> unit
```
```reasonml
let set: t('a) => key => 'a => unit;
```
`set dict key value` sets the `key`/`value` in `dict`

```ocaml
val keys : 'a t -> string array
```
```reasonml
let keys: t('a) => array(string);
```
`keys dict` returns all the keys in the dictionary `dict`

```ocaml
val empty : unit -> 'a t
```
```reasonml
let empty: unit => t('a);
```
`empty ()` returns an empty dictionary

```ocaml
val unsafeDeleteKey : (string t -> string -> unit) Js.Fn.arity2
```
```reasonml
let unsafeDeleteKey: Js.Fn.arity2((t(string) => string => unit));
```
Experimental internal function

```ocaml
val entries : 'a t -> (key * 'a) array
```
```reasonml
let entries: t('a) => array((key, 'a));
```
`entries dict` returns the key value pairs in `dict` (ES2017)

```ocaml
val values : 'a t -> 'a array
```
```reasonml
let values: t('a) => array('a);
```
`values dict` returns the values in `dict` (ES2017)

```ocaml
val fromList : (key * 'a) list -> 'a t
```
```reasonml
let fromList: list((key, 'a)) => t('a);
```
`fromList entries` creates a new dictionary containing each `(key, value)` pair in `entries`

```ocaml
val fromArray : (key * 'a) array -> 'a t
```
```reasonml
let fromArray: array((key, 'a)) => t('a);
```
`fromArray entries` creates a new dictionary containing each `(key, value)` pair in `entries`

```ocaml
val map : f:('a -> 'b) Js.Fn.arity1 -> 'a t -> 'b t
```
```reasonml
let map: f:Js.Fn.arity1(('a => 'b)) => t('a) => t('b);
```
`map f dict` maps `dict` to a new dictionary with the same keys, using `f` to map each value
