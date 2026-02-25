
# Module `Stdlib.Result`

Result values.

Result values handle computation results and errors in an explicit and declarative manner without resorting to exceptions.

since 4\.08

## Results

```ocaml
type ('a, 'e) t = ('a, 'e) result = 
```
```reasonml
type t('a, 'e) = result('a, 'e) = 
```
```ocaml
| Ok of 'a
```
```reasonml
| Ok('a)
```
```ocaml
| Error of 'e
```
```reasonml
| Error('e)
```
```ocaml

```
```reasonml
;
```
The type for result values. Either a value `Ok v` or an error `Error e`.

```ocaml
val ok : 'a -> ('a, 'e) result
```
```reasonml
let ok: 'a => result('a, 'e);
```
`ok v` is `Ok v`.

```ocaml
val error : 'e -> ('a, 'e) result
```
```reasonml
let error: 'e => result('a, 'e);
```
`error e` is `Error e`.

```ocaml
val value : ('a, 'e) result -> default:'a -> 'a
```
```reasonml
let value: result('a, 'e) => default:'a => 'a;
```
`value r ~default` is `v` if `r` is `Ok v` and `default` otherwise.

```ocaml
val get_ok : ('a, 'e) result -> 'a
```
```reasonml
let get_ok: result('a, 'e) => 'a;
```
`get_ok r` is `v` if `r` is `Ok v` and raise otherwise.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if r is Error \_.
```ocaml
val get_ok' : ('a, string) result -> 'a
```
```reasonml
let get_ok': result('a, string) => 'a;
```
`get_ok'` is like [`get_ok`](./#val-get_ok) but in case of error uses the error message for raising `Invalid_argument`.

since 5\.4
```ocaml
val get_error : ('a, 'e) result -> 'e
```
```reasonml
let get_error: result('a, 'e) => 'e;
```
`get_error r` is `e` if `r` is `Error e` and raise otherwise.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if r is Ok \_.
```ocaml
val error_to_failure : ('a, string) result -> 'a
```
```reasonml
let error_to_failure: result('a, string) => 'a;
```
`error_to_failure r` is `v` if `r` is `Ok v` and raises `Failure e` if `r` is `Error e`.

since 5\.4
```ocaml
val bind : ('a, 'e) result -> ('a -> ('b, 'e) result) -> ('b, 'e) result
```
```reasonml
let bind: result('a, 'e) => ('a => result('b, 'e)) => result('b, 'e);
```
`bind r f` is `f v` if `r` is `Ok v` and `r` if `r` is `Error _`.

```ocaml
val join : (('a, 'e) result, 'e) result -> ('a, 'e) result
```
```reasonml
let join: result(result('a, 'e), 'e) => result('a, 'e);
```
`join rr` is `r` if `rr` is `Ok r` and `rr` if `rr` is `Error _`.

```ocaml
val map : ('a -> 'b) -> ('a, 'e) result -> ('b, 'e) result
```
```reasonml
let map: ('a => 'b) => result('a, 'e) => result('b, 'e);
```
`map f r` is `Ok (f v)` if `r` is `Ok v` and `r` if `r` is `Error _`.

```ocaml
val product : ('a, 'e) result -> ('b, 'e) result -> ('a * 'b, 'e) result
```
```reasonml
let product: result('a, 'e) => result('b, 'e) => result(('a, 'b), 'e);
```
`product r0 r1` is `Ok (v0, v1)` if `r0` is `Ok v0` and `r1` is `Ok v2` and otherwise returns the error of `r0`, if any, or the error of `r1`.

since 5\.4
```ocaml
val map_error : ('e -> 'f) -> ('a, 'e) result -> ('a, 'f) result
```
```reasonml
let map_error: ('e => 'f) => result('a, 'e) => result('a, 'f);
```
`map_error f r` is `Error (f e)` if `r` is `Error e` and `r` if `r` is `Ok _`.

```ocaml
val fold : ok:('a -> 'c) -> error:('e -> 'c) -> ('a, 'e) result -> 'c
```
```reasonml
let fold: ok:('a => 'c) => error:('e => 'c) => result('a, 'e) => 'c;
```
`fold ~ok ~error r` is `ok v` if `r` is `Ok v` and `error e` if `r` is `Error e`.

```ocaml
val retract : ('a, 'a) result -> 'a
```
```reasonml
let retract: result('a, 'a) => 'a;
```
`retract r` is `v` if `r` is `Ok v` or `Error v`.

since 5\.4
```ocaml
val iter : ('a -> unit) -> ('a, 'e) result -> unit
```
```reasonml
let iter: ('a => unit) => result('a, 'e) => unit;
```
`iter f r` is `f v` if `r` is `Ok v` and `()` otherwise.

```ocaml
val iter_error : ('e -> unit) -> ('a, 'e) result -> unit
```
```reasonml
let iter_error: ('e => unit) => result('a, 'e) => unit;
```
`iter_error f r` is `f e` if `r` is `Error e` and `()` otherwise.


## Predicates and comparisons

```ocaml
val is_ok : ('a, 'e) result -> bool
```
```reasonml
let is_ok: result('a, 'e) => bool;
```
`is_ok r` is `true` if and only if `r` is `Ok _`.

```ocaml
val is_error : ('a, 'e) result -> bool
```
```reasonml
let is_error: result('a, 'e) => bool;
```
`is_error r` is `true` if and only if `r` is `Error _`.

```ocaml
val equal : 
  ok:('a -> 'a -> bool) ->
  error:('e -> 'e -> bool) ->
  ('a, 'e) result ->
  ('a, 'e) result ->
  bool
```
```reasonml
let equal: 
  ok:('a => 'a => bool) =>
  error:('e => 'e => bool) =>
  result('a, 'e) =>
  result('a, 'e) =>
  bool;
```
`equal ~ok ~error r0 r1` tests equality of `r0` and `r1` using `ok` and `error` to respectively compare values wrapped by `Ok _` and `Error _`.

```ocaml
val compare : 
  ok:('a -> 'a -> int) ->
  error:('e -> 'e -> int) ->
  ('a, 'e) result ->
  ('a, 'e) result ->
  int
```
```reasonml
let compare: 
  ok:('a => 'a => int) =>
  error:('e => 'e => int) =>
  result('a, 'e) =>
  result('a, 'e) =>
  int;
```
`compare ~ok ~error r0 r1` totally orders `r0` and `r1` using `ok` and `error` to respectively compare values wrapped by `Ok _ ` and `Error _`. `Ok _` values are smaller than `Error _` values.


## Converting

```ocaml
val to_option : ('a, 'e) result -> 'a option
```
```reasonml
let to_option: result('a, 'e) => option('a);
```
`to_option r` is `r` as an option, mapping `Ok v` to `Some v` and `Error _` to `None`.

```ocaml
val to_list : ('a, 'e) result -> 'a list
```
```reasonml
let to_list: result('a, 'e) => list('a);
```
`to_list r` is `[v]` if `r` is `Ok v` and `[]` otherwise.

```ocaml
val to_seq : ('a, 'e) result -> 'a Seq.t
```
```reasonml
let to_seq: result('a, 'e) => Seq.t('a);
```
`to_seq r` is `r` as a sequence. `Ok v` is the singleton sequence containing `v` and `Error _` is the empty sequence.


## Syntax

```ocaml
module Syntax : sig ... end
```
```reasonml
module Syntax: { ... };
```
Binding operators.
