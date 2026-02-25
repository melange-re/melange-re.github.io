
# Module `Result.Syntax`

Binding operators.

since 5\.4
```ocaml
val (let*) : ('a, 'e) result -> ('a -> ('b, 'e) result) -> ('b, 'e) result
```
```reasonml
let (let*): result('a, 'e) => ('a => result('b, 'e)) => result('b, 'e);
```
`( let* )` is [`Result.bind`](./Stdlib-Result.md#val-bind).

```ocaml
val (and*) : ('a, 'e) result -> ('b, 'e) result -> ('a * 'b, 'e) result
```
```reasonml
let (and*): result('a, 'e) => result('b, 'e) => result(('a, 'b), 'e);
```
`( and* )` is [`Result.product`](./Stdlib-Result.md#val-product).

```ocaml
val (let+) : ('a, 'e) result -> ('a -> 'b) -> ('b, 'e) result
```
```reasonml
let (let+): result('a, 'e) => ('a => 'b) => result('b, 'e);
```
`( let+ )` is [`Result.map`](./Stdlib-Result.md#val-map).

```ocaml
val (and+) : ('a, 'e) result -> ('b, 'e) result -> ('a * 'b, 'e) result
```
```reasonml
let (and+): result('a, 'e) => result('b, 'e) => result(('a, 'b), 'e);
```
`( and+ )` is [`Result.product`](./Stdlib-Result.md#val-product).
