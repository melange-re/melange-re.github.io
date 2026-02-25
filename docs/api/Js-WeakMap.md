
# Module `Js.WeakMap`

Bindings to functions in `WeakMap`

ES6 WeakMap API

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
val get : key:'k Js.dict -> ('k, 'v) t -> 'v option
```
```reasonml
let get: key:Js.dict('k) => t('k, 'v) => option('v);
```
```ocaml
val has : key:'k Js.dict -> ('k, 'v) t -> bool
```
```reasonml
let has: key:Js.dict('k) => t('k, 'v) => bool;
```
```ocaml
val set : key:'k Js.dict -> value:'v -> ('k, 'v) t -> ('k, 'v) t
```
```reasonml
let set: key:Js.dict('k) => value:'v => t('k, 'v) => t('k, 'v);
```
```ocaml
val delete : key:'k Js.dict -> ('k, 'v) t -> bool
```
```reasonml
let delete: key:Js.dict('k) => t('k, 'v) => bool;
```