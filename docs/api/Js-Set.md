
# Module `Js.Set`

Bindings to functions in `Set`

ES6 Set API

```ocaml
type 'a t
```
```reasonml
type t('a);
```
```ocaml
val make : unit -> 'a t
```
```reasonml
let make: unit => t('a);
```
```ocaml
val fromArray : 'a array -> 'a t
```
```reasonml
let fromArray: array('a) => t('a);
```
```ocaml
val toArray : 'a t -> 'a array
```
```reasonml
let toArray: t('a) => array('a);
```
```ocaml
val size : 'a t -> int
```
```reasonml
let size: t('a) => int;
```
```ocaml
val add : value:'a -> 'a t -> 'a t
```
```reasonml
let add: value:'a => t('a) => t('a);
```
```ocaml
val clear : 'a t -> unit
```
```reasonml
let clear: t('a) => unit;
```
```ocaml
val delete : value:'a -> 'a t -> bool
```
```reasonml
let delete: value:'a => t('a) => bool;
```
```ocaml
val forEach : f:('a -> unit) -> 'a t -> unit
```
```reasonml
let forEach: f:('a => unit) => t('a) => unit;
```
```ocaml
val has : value:'a -> 'a t -> bool
```
```reasonml
let has: value:'a => t('a) => bool;
```
```ocaml
val values : 'a t -> 'a Js.iterator
```
```reasonml
let values: t('a) => Js.iterator('a);
```
```ocaml
val entries : 'a t -> ('a * 'a) Js.iterator
```
```reasonml
let entries: t('a) => Js.iterator(('a, 'a));
```