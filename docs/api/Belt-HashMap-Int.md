
# Module `HashMap.Int`

Specalized when key type is `int`, more efficient than the generic type

```ocaml
type key = int
```
```reasonml
type key = int;
```
```ocaml
type 'b t
```
```reasonml
type t('b);
```
```ocaml
val make : hintSize:int -> 'b t
```
```reasonml
let make: hintSize:int => t('b);
```
```ocaml
val clear : 'b t -> unit
```
```reasonml
let clear: t('b) => unit;
```
```ocaml
val isEmpty : _ t -> bool
```
```reasonml
let isEmpty: t(_) => bool;
```
```ocaml
val set : 'a t -> key -> 'a -> unit
```
```reasonml
let set: t('a) => key => 'a => unit;
```
`setDone tbl k v` if `k` does not exist, add the binding `k,v`, otherwise, update the old value with the new `v`

```ocaml
val copy : 'a t -> 'a t
```
```reasonml
let copy: t('a) => t('a);
```
```ocaml
val get : 'a t -> key -> 'a option
```
```reasonml
let get: t('a) => key => option('a);
```
```ocaml
val has : 'b t -> key -> bool
```
```reasonml
let has: t('b) => key => bool;
```
```ocaml
val remove : 'a t -> key -> unit
```
```reasonml
let remove: t('a) => key => unit;
```
```ocaml
val forEachU : 'b t -> (key -> 'b -> unit) Js.Fn.arity2 -> unit
```
```reasonml
let forEachU: t('b) => Js.Fn.arity2((key => 'b => unit)) => unit;
```
```ocaml
val forEach : 'b t -> (key -> 'b -> unit) -> unit
```
```reasonml
let forEach: t('b) => (key => 'b => unit) => unit;
```
```ocaml
val reduceU : 'b t -> 'c -> ('c -> key -> 'b -> 'c) Js.Fn.arity3 -> 'c
```
```reasonml
let reduceU: t('b) => 'c => Js.Fn.arity3(('c => key => 'b => 'c)) => 'c;
```
```ocaml
val reduce : 'b t -> 'c -> ('c -> key -> 'b -> 'c) -> 'c
```
```reasonml
let reduce: t('b) => 'c => ('c => key => 'b => 'c) => 'c;
```
```ocaml
val keepMapInPlaceU : 'a t -> (key -> 'a -> 'a option) Js.Fn.arity2 -> unit
```
```reasonml
let keepMapInPlaceU: t('a) => Js.Fn.arity2((key => 'a => option('a))) => unit;
```
```ocaml
val keepMapInPlace : 'a t -> (key -> 'a -> 'a option) -> unit
```
```reasonml
let keepMapInPlace: t('a) => (key => 'a => option('a)) => unit;
```
```ocaml
val size : _ t -> int
```
```reasonml
let size: t(_) => int;
```
```ocaml
val toArray : 'a t -> (key * 'a) array
```
```reasonml
let toArray: t('a) => array((key, 'a));
```
```ocaml
val keysToArray : 'a t -> key array
```
```reasonml
let keysToArray: t('a) => array(key);
```
```ocaml
val valuesToArray : 'a t -> 'a array
```
```reasonml
let valuesToArray: t('a) => array('a);
```
```ocaml
val fromArray : (key * 'a) array -> 'a t
```
```reasonml
let fromArray: array((key, 'a)) => t('a);
```
```ocaml
val mergeMany : 'a t -> (key * 'a) array -> unit
```
```reasonml
let mergeMany: t('a) => array((key, 'a)) => unit;
```
```ocaml
val getBucketHistogram : _ t -> int array
```
```reasonml
let getBucketHistogram: t(_) => array(int);
```
```ocaml
val logStats : _ t -> unit
```
```reasonml
let logStats: t(_) => unit;
```