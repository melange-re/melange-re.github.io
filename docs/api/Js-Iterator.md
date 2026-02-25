
# Module `Js.Iterator`

Bindings to functions on `Iterator`

```ocaml
type 'a t = 'a Js.iterator
```
```reasonml
type t('a) = Js.iterator('a);
```
```ocaml
type 'a value = {
```
```reasonml
type value('a) = {
```
`done_ : bool option;`
`value : 'a option;`
```ocaml
}
```
```reasonml
};
```
```ocaml
val next : 'a t -> 'a value
```
```reasonml
let next: t('a) => value('a);
```
```ocaml
val toArray : 'a t -> 'a array
```
```reasonml
let toArray: t('a) => array('a);
```
```ocaml
val toArrayWithMapper : 'a t -> f:('a -> 'b) -> 'b array
```
```reasonml
let toArrayWithMapper: t('a) => f:('a => 'b) => array('b);
```