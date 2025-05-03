
# Module `Js.WeakSet`

Bindings to functions in `WeakSet`

ES6 WeakSet API

```
type 'a t
```
```
val make : unit -> 'a t
```
```
val add : value:'a Js.dict -> 'a t -> 'a t
```
```
val delete : value:'a Js.dict -> 'a t -> bool
```
```
val has : value:'a Js.dict -> 'a t -> bool
```