
# Module `Stdlib.Option`

Option values.

Option values explicitly indicate the presence or absence of a value.

since 4\.08

## Options

```ocaml
type 'a t = 'a option = 
```
```reasonml
type t('a) = option('a) = 
```
```
| None
```
```ocaml
| Some of 'a
```
```reasonml
| Some('a)
```
```ocaml

```
```reasonml
;
```
The type for option values. Either `None` or a value `Some v`.

```ocaml
val none : 'a option
```
```reasonml
let none: option('a);
```
`none` is `None`.

```ocaml
val some : 'a -> 'a option
```
```reasonml
let some: 'a => option('a);
```
`some v` is `Some v`.

```ocaml
val value : 'a option -> default:'a -> 'a
```
```reasonml
let value: option('a) => default:'a => 'a;
```
`value o ~default` is `v` if `o` is `Some v` and `default` otherwise.

```ocaml
val get : 'a option -> 'a
```
```reasonml
let get: option('a) => 'a;
```
`get o` is `v` if `o` is `Some v` and raise otherwise.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if o is None.
```ocaml
val bind : 'a option -> ('a -> 'b option) -> 'b option
```
```reasonml
let bind: option('a) => ('a => option('b)) => option('b);
```
`bind o f` is `f v` if `o` is `Some v` and `None` if `o` is `None`.

```ocaml
val join : 'a option option -> 'a option
```
```reasonml
let join: option(option('a)) => option('a);
```
`join oo` is `Some v` if `oo` is `Some (Some v)` and `None` otherwise.

```ocaml
val map : ('a -> 'b) -> 'a option -> 'b option
```
```reasonml
let map: ('a => 'b) => option('a) => option('b);
```
`map f o` is `None` if `o` is `None` and `Some (f v)` if `o` is `Some v`.

```ocaml
val fold : none:'a -> some:('b -> 'a) -> 'b option -> 'a
```
```reasonml
let fold: none:'a => some:('b => 'a) => option('b) => 'a;
```
`fold ~none ~some o` is `none` if `o` is `None` and `some v` if `o` is `Some v`.

```ocaml
val iter : ('a -> unit) -> 'a option -> unit
```
```reasonml
let iter: ('a => unit) => option('a) => unit;
```
`iter f o` is `f v` if `o` is `Some v` and `()` otherwise.


## Predicates and comparisons

```ocaml
val is_none : 'a option -> bool
```
```reasonml
let is_none: option('a) => bool;
```
`is_none o` is `true` if and only if `o` is `None`.

```ocaml
val is_some : 'a option -> bool
```
```reasonml
let is_some: option('a) => bool;
```
`is_some o` is `true` if and only if `o` is `Some o`.

```ocaml
val equal : ('a -> 'a -> bool) -> 'a option -> 'a option -> bool
```
```reasonml
let equal: ('a => 'a => bool) => option('a) => option('a) => bool;
```
`equal eq o0 o1` is `true` if and only if `o0` and `o1` are both `None` or if they are `Some v0` and `Some v1` and `eq v0 v1` is `true`.

```ocaml
val compare : ('a -> 'a -> int) -> 'a option -> 'a option -> int
```
```reasonml
let compare: ('a => 'a => int) => option('a) => option('a) => int;
```
`compare cmp o0 o1` is a total order on options using `cmp` to compare values wrapped by `Some _`. `None` is smaller than `Some _` values.


## Converting

```ocaml
val to_result : none:'e -> 'a option -> ('a, 'e) result
```
```reasonml
let to_result: none:'e => option('a) => result('a, 'e);
```
`to_result ~none o` is `Ok v` if `o` is `Some v` and `Error none` otherwise.

```ocaml
val to_list : 'a option -> 'a list
```
```reasonml
let to_list: option('a) => list('a);
```
`to_list o` is `[]` if `o` is `None` and `[v]` if `o` is `Some v`.

```ocaml
val to_seq : 'a option -> 'a Seq.t
```
```reasonml
let to_seq: option('a) => Seq.t('a);
```
`to_seq o` is `o` as a sequence. `None` is the empty sequence and `Some v` is the singleton sequence containing `v`.
