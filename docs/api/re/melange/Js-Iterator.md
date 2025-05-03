
# Module `Js.Iterator`

Bindings to functions on `Iterator`

```
type 'a t = 'a Js.iterator
```
```
type 'a value = {
```
`done_ : bool option;`
`value : 'a option;`
```
}
```
```
val next : 'a t -> 'a value
```
```
val toArray : 'a t -> 'a array
```
```
val toArrayWithMapper : 'a t -> f:('a -> 'b) -> 'b array
```