
# Module `Js.WeakSet`

Bindings to functions in `WeakSet`

ES6 WeakSet API

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
val add : value:'a Js.dict -> 'a t -> 'a t
```
```reasonml
let add: value:Js.dict('a) => t('a) => t('a);
```
```ocaml
val delete : value:'a Js.dict -> 'a t -> bool
```
```reasonml
let delete: value:Js.dict('a) => t('a) => bool;
```
```ocaml
val has : value:'a Js.dict -> 'a t -> bool
```
```reasonml
let has: value:Js.dict('a) => t('a) => bool;
```