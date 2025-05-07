
# Module `Js.Set`

Bindings to functions in `Set`

ES6 Set API

```
type 'a t
```
```
val make : unit -> 'a t
```
```
val fromArray : 'a array -> 'a t
```
```
val toArray : 'a t -> 'a array
```
```
val size : 'a t -> int
```
```
val add : value:'a -> 'a t -> 'a t
```
```
val clear : 'a t -> unit
```
```
val delete : value:'a -> 'a t -> bool
```
```
val forEach : f:('a -> unit) -> 'a t -> unit
```
```
val has : value:'a -> 'a t -> bool
```
```
val values : 'a t -> 'a Js.iterator
```
```
val entries : 'a t -> ('a * 'a) Js.iterator
```