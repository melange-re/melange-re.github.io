
# Module `Js.Map`

Bindings to functions in `Map`

ES6 Map API

```ocaml
type ('k, 'v) t
```
```reasonml
type t('k, 'v);
```
```ocaml
val make : unit -> ('k, 'v) t
```
```reasonml
let make: unit => t('k, 'v);
```
```ocaml
val fromArray : ('k * 'v) array -> ('k, 'v) t
```
```reasonml
let fromArray: array(('k, 'v)) => t('k, 'v);
```
```ocaml
val toArray : ('k, 'v) t -> ('k * 'v) array
```
```reasonml
let toArray: t('k, 'v) => array(('k, 'v));
```
```ocaml
val size : ('k, 'v) t -> int
```
```reasonml
let size: t('k, 'v) => int;
```
```ocaml
val has : key:'k -> ('k, 'v) t -> bool
```
```reasonml
let has: key:'k => t('k, 'v) => bool;
```
```ocaml
val get : key:'k -> ('k, 'v) t -> 'v option
```
```reasonml
let get: key:'k => t('k, 'v) => option('v);
```
```ocaml
val set : key:'k -> value:'v -> ('k, 'v) t -> ('k, 'v) t
```
```reasonml
let set: key:'k => value:'v => t('k, 'v) => t('k, 'v);
```
```ocaml
val clear : ('k, 'v) t -> unit
```
```reasonml
let clear: t('k, 'v) => unit;
```
```ocaml
val delete : key:'k -> ('k, 'v) t -> bool
```
```reasonml
let delete: key:'k => t('k, 'v) => bool;
```
```ocaml
val forEach : f:('v -> 'k -> ('k, 'v) t -> unit) -> ('k, 'v) t -> unit
```
```reasonml
let forEach: f:('v => 'k => t('k, 'v) => unit) => t('k, 'v) => unit;
```
```ocaml
val keys : ('k, 'v) t -> 'k Js.iterator
```
```reasonml
let keys: t('k, 'v) => Js.iterator('k);
```
```ocaml
val values : ('k, 'v) t -> 'v Js.iterator
```
```reasonml
let values: t('k, 'v) => Js.iterator('v);
```
```ocaml
val entries : ('k, 'v) t -> ('k * 'v) Js.iterator
```
```reasonml
let entries: t('k, 'v) => Js.iterator(('k, 'v));
```