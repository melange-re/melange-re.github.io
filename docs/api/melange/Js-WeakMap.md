
# Module `Js.WeakMap`

Bindings to functions in `WeakMap`

ES6 WeakMap API

```
type ('k, 'v) t
```
```
val make : unit -> ('k, 'v) t
```
```
val get : key:'k Js.dict -> ('k, 'v) t -> 'v option
```
```
val has : key:'k Js.dict -> ('k, 'v) t -> bool
```
```
val set : key:'k Js.dict -> value:'v -> ('k, 'v) t -> ('k, 'v) t
```
```
val delete : key:'k Js.dict -> ('k, 'v) t -> bool
```