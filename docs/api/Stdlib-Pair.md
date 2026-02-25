
# Module `Stdlib.Pair`

Operations on pairs.

since 5\.4

## Pairs

```ocaml
type ('a, 'b) t = 'a * 'b
```
```reasonml
type t('a, 'b) = ('a, 'b);
```
The type for pairs.

```ocaml
val make : 'a -> 'b -> 'a * 'b
```
```reasonml
let make: 'a => 'b => ('a, 'b);
```
`make a b` is the pair `(a, b)`.

```ocaml
val fst : ('a * 'b) -> 'a
```
```reasonml
let fst: ('a, 'b) => 'a;
```
`fst (a, b)` is `a`.

```ocaml
val snd : ('a * 'b) -> 'b
```
```reasonml
let snd: ('a, 'b) => 'b;
```
`snd (a, b)` is `b`.

```ocaml
val swap : ('a * 'b) -> 'b * 'a
```
```reasonml
let swap: ('a, 'b) => ('b, 'a);
```
`swap (a, b)` is `(b, a)`.


## Iterators

```ocaml
val fold : ('a -> 'b -> 'c) -> ('a * 'b) -> 'c
```
```reasonml
let fold: ('a => 'b => 'c) => ('a, 'b) => 'c;
```
`fold f (a, b)` applies `f` to `a` and `b`.

```ocaml
val map : ('a -> 'c) -> ('b -> 'd) -> ('a * 'b) -> 'c * 'd
```
```reasonml
let map: ('a => 'c) => ('b => 'd) => ('a, 'b) => ('c, 'd);
```
`map f g (a, b)` applies `f` to `a` and `g` to `b`.

```ocaml
val iter : ('a -> unit) -> ('b -> unit) -> ('a * 'b) -> unit
```
```reasonml
let iter: ('a => unit) => ('b => unit) => ('a, 'b) => unit;
```
`iter f g (a, b)` first applies `f` to `a`, and then `g` to `b`.

```ocaml
val map_fst : ('a -> 'c) -> ('a * 'b) -> 'c * 'b
```
```reasonml
let map_fst: ('a => 'c) => ('a, 'b) => ('c, 'b);
```
`map_fst f p` applies `f` to `p`'s first component.

```ocaml
val map_snd : ('b -> 'c) -> ('a * 'b) -> 'a * 'c
```
```reasonml
let map_snd: ('b => 'c) => ('a, 'b) => ('a, 'c);
```
`map_snd f p` applies `f` to `p`'s second component.


## Predicates and comparisons

```ocaml
val equal : 
  ('a -> 'a -> bool) ->
  ('b -> 'b -> bool) ->
  ('a * 'b) ->
  ('a * 'b) ->
  bool
```
```reasonml
let equal: 
  ('a => 'a => bool) =>
  ('b => 'b => bool) =>
  ('a, 'b) =>
  ('a, 'b) =>
  bool;
```
`equal eqa eqb (a1, b1) (a2, b2)` is `true` if and only if `eqa a1 a2` and `eqb b1 b2` are both `true`.

```ocaml
val compare : 
  ('a -> 'a -> int) ->
  ('b -> 'b -> int) ->
  ('a * 'b) ->
  ('a * 'b) ->
  int
```
```reasonml
let compare: 
  ('a => 'a => int) =>
  ('b => 'b => int) =>
  ('a, 'b) =>
  ('a, 'b) =>
  int;
```
`compare cmpa cmpb` is a total order on pairs using `cmpa` to compare the first component, and `cmpb` to compare the second component. It is implemented by a lexicographic order.
