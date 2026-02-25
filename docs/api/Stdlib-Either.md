
# Module `Stdlib.Either`

Either type.

Either is the simplest and most generic sum/variant type: a value of <code class="text-ocaml">('a, 'b) Either.t</code><code class="text-reasonml">Either.t('a, 'b)</code> is either a `Left (v : 'a)` or a `Right (v : 'b)`.

It is a natural choice in the API of generic functions where values could fall in two different cases, possibly at different types, without assigning a specific meaning to what each case should be.

For example:

```ocaml
List.partition_map:
    ('a -> ('b, 'c) Either.t) -> 'a list -> 'b list * 'c list
```
If you are looking for a parametrized type where one alternative means success and the other means failure, you should use the more specific type [`Result.t`](./Stdlib-Result.md#type-t).

since 4\.12
```ocaml
type ('a, 'b) t = 
```
```reasonml
type t('a, 'b) = 
```
```ocaml
| Left of 'a
```
```reasonml
| Left('a)
```
```ocaml
| Right of 'b
```
```reasonml
| Right('b)
```
```ocaml

```
```reasonml
;
```
A value of <code class="text-ocaml">('a, 'b) Either.t</code><code class="text-reasonml">Either.t('a, 'b)</code> contains either a value of `'a` or a value of `'b`

```ocaml
val left : 'a -> ('a, 'b) t
```
```reasonml
let left: 'a => t('a, 'b);
```
`left v` is `Left v`.

```ocaml
val right : 'b -> ('a, 'b) t
```
```reasonml
let right: 'b => t('a, 'b);
```
`right v` is `Right v`.

```ocaml
val is_left : ('a, 'b) t -> bool
```
```reasonml
let is_left: t('a, 'b) => bool;
```
`is_left (Left v)` is `true`, `is_left (Right v)` is `false`.

```ocaml
val is_right : ('a, 'b) t -> bool
```
```reasonml
let is_right: t('a, 'b) => bool;
```
`is_right (Left v)` is `false`, `is_right (Right v)` is `true`.

```ocaml
val get_left : ('a, 'b) t -> 'a
```
```reasonml
let get_left: t('a, 'b) => 'a;
```
`get_left e` is `v` if `e` is `Left v` and raise otherwise.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if e is Right \_.
since 5\.4
```ocaml
val get_right : ('a, 'b) t -> 'b
```
```reasonml
let get_right: t('a, 'b) => 'b;
```
`get_right e` is `v` if `e` is `Right v` and raise otherwise.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if e is Left \_.
since 5\.4
```ocaml
val find_left : ('a, 'b) t -> 'a option
```
```reasonml
let find_left: t('a, 'b) => option('a);
```
`find_left (Left v)` is `Some v`, `find_left (Right _)` is `None`

```ocaml
val find_right : ('a, 'b) t -> 'b option
```
```reasonml
let find_right: t('a, 'b) => option('b);
```
`find_right (Right v)` is `Some v`, `find_right (Left _)` is `None`

```ocaml
val map_left : ('a1 -> 'a2) -> ('a1, 'b) t -> ('a2, 'b) t
```
```reasonml
let map_left: ('a1 => 'a2) => t('a1, 'b) => t('a2, 'b);
```
`map_left f e` is `Left (f v)` if `e` is `Left v` and `e` if `e` is `Right _`.

```ocaml
val map_right : ('b1 -> 'b2) -> ('a, 'b1) t -> ('a, 'b2) t
```
```reasonml
let map_right: ('b1 => 'b2) => t('a, 'b1) => t('a, 'b2);
```
`map_right f e` is `Right (f v)` if `e` is `Right v` and `e` if `e` is `Left _`.

```ocaml
val map : 
  left:('a1 -> 'a2) ->
  right:('b1 -> 'b2) ->
  ('a1, 'b1) t ->
  ('a2, 'b2) t
```
```reasonml
let map: left:('a1 => 'a2) => right:('b1 => 'b2) => t('a1, 'b1) => t('a2, 'b2);
```
`map ~left ~right (Left v)` is `Left (left v)`, `map ~left ~right (Right v)` is `Right (right v)`.

```ocaml
val fold : left:('a -> 'c) -> right:('b -> 'c) -> ('a, 'b) t -> 'c
```
```reasonml
let fold: left:('a => 'c) => right:('b => 'c) => t('a, 'b) => 'c;
```
`fold ~left ~right (Left v)` is `left v`, and `fold ~left ~right (Right v)` is `right v`.

```ocaml
val retract : ('a, 'a) t -> 'a
```
```reasonml
let retract: t('a, 'a) => 'a;
```
`retract (Left v)` is `v`, and `retract (Right v)` is `v`.

since 5\.4
```ocaml
val iter : left:('a -> unit) -> right:('b -> unit) -> ('a, 'b) t -> unit
```
```reasonml
let iter: left:('a => unit) => right:('b => unit) => t('a, 'b) => unit;
```
`iter ~left ~right (Left v)` is `left v`, and `iter ~left ~right (Right v)` is `right v`.

```ocaml
val for_all : left:('a -> bool) -> right:('b -> bool) -> ('a, 'b) t -> bool
```
```reasonml
let for_all: left:('a => bool) => right:('b => bool) => t('a, 'b) => bool;
```
`for_all ~left ~right (Left v)` is `left v`, and `for_all ~left ~right (Right v)` is `right v`.

```ocaml
val equal : 
  left:('a -> 'a -> bool) ->
  right:('b -> 'b -> bool) ->
  ('a, 'b) t ->
  ('a, 'b) t ->
  bool
```
```reasonml
let equal: 
  left:('a => 'a => bool) =>
  right:('b => 'b => bool) =>
  t('a, 'b) =>
  t('a, 'b) =>
  bool;
```
`equal ~left ~right e0 e1` tests equality of `e0` and `e1` using `left` and `right` to respectively compare values wrapped by `Left _` and `Right _`.

```ocaml
val compare : 
  left:('a -> 'a -> int) ->
  right:('b -> 'b -> int) ->
  ('a, 'b) t ->
  ('a, 'b) t ->
  int
```
```reasonml
let compare: 
  left:('a => 'a => int) =>
  right:('b => 'b => int) =>
  t('a, 'b) =>
  t('a, 'b) =>
  int;
```
`compare ~left ~right e0 e1` totally orders `e0` and `e1` using `left` and `right` to respectively compare values wrapped by `Left _ ` and `Right _`. `Left _` values are smaller than `Right _` values.
