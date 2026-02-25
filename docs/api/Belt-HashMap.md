
# Module `Belt.HashMap`

[`Belt.HashMap`](#)

The top level provides generic **mutable** hash map operations.

It also has two specialized inner modules [`Belt.HashMap.Int`](./Belt-HashMap-Int.md) and [`Belt.HashMap.String`](./Belt-HashMap-String.md)

A **mutable** Hash map which allows customized hash behavior.

All data are parameterized by not its only type but also a unique identity in the time of initialization, so that two *HashMaps of ints* initialized with different *hash* functions will have different type.

For example:

```ocaml
  type t = int
  module I0 =
    (val Belt.Id.hashableU
        ~hash:(fun[\@u] (a : t)  -> a & 0xff_ff)
        ~eq:(fun[\@u] a b -> a = b)
    )
  let s0 : (_, string,_) t = make ~hintSize:40 ~id:(module I0)
  module I1 =
    (val Belt.Id.hashableU
        ~hash:(fun[\@u] (a : t)  -> a & 0xff)
        ~eq:(fun[\@u] a b -> a = b)
    )
  let s1 : (_, string,_) t  = make ~hintSize:40 ~id:(module I1)
```
The invariant must be held: for two elements who are *equal*, their hashed value should be the same

Here the compiler would infer `s0` and `s1` having different type so that it would not mix.

```ocaml
  val s0 :  (int, I0.identity) t
  val s1 :  (int, I1.identity) t
```
```reasonml
external s0: t(int, I0.identity) = ;
external s1: t(int, I1.identity) = ;
```
We can add elements to the collection:

```ocaml

  let () =
    add s1 0 "3";
    add s1 1 "3"
```
```reasonml
let () = {
  add(s1, 0, "3");
  add(s1, 1, "3");
};
```
Since this is an mutable data strucure, `s1` will contain two pairs.

```ocaml
module Int : sig ... end
```
```reasonml
module Int: { ... };
```
Specalized when key type is `int`, more efficient than the generic type

```ocaml
module String : sig ... end
```
```reasonml
module String: { ... };
```
Specalized when key type is `string`, more efficient than the generic type

```ocaml
type ('key, 'value, 'id) t
```
```reasonml
type t('key, 'value, 'id);
```
The type of hash tables from type `'key` to type `'value`.

```ocaml
type ('a, 'id) id =
  (module Belt__.Belt_Id.Hashable
  with type identity = 'id
   and type t = 'a)
```
```reasonml
type id('a, 'id) =
  (module Belt__.Belt_Id.Hashable
  with type identity = 'id
   and type t = 'a);
```
```ocaml
val make : hintSize:int -> id:('key, 'id) id -> ('key, 'value, 'id) t
```
```reasonml
let make: hintSize:int => id:id('key, 'id) => t('key, 'value, 'id);
```
```ocaml
val clear : ('key, 'value, 'id) t -> unit
```
```reasonml
let clear: t('key, 'value, 'id) => unit;
```
Empty a hash table.

```ocaml
val isEmpty : (_, _, _) t -> bool
```
```reasonml
let isEmpty: t(_, _, _) => bool;
```
```ocaml
val set : ('key, 'value, 'id) t -> 'key -> 'value -> unit
```
```reasonml
let set: t('key, 'value, 'id) => 'key => 'value => unit;
```
`set tbl k v` if `k` does not exist, add the binding `k,v`, otherwise, update the old value with the new `v`

```ocaml
val copy : ('key, 'value, 'id) t -> ('key, 'value, 'id) t
```
```reasonml
let copy: t('key, 'value, 'id) => t('key, 'value, 'id);
```
```ocaml
val get : ('key, 'value, 'id) t -> 'key -> 'value option
```
```reasonml
let get: t('key, 'value, 'id) => 'key => option('value);
```
```ocaml
val has : ('key, 'value, 'id) t -> 'key -> bool
```
```reasonml
let has: t('key, 'value, 'id) => 'key => bool;
```
`has tbl x` checks if `x` is bound in `tbl`.

```ocaml
val remove : ('key, 'value, 'id) t -> 'key -> unit
```
```reasonml
let remove: t('key, 'value, 'id) => 'key => unit;
```
```ocaml
val forEachU : 
  ('key, 'value, 'id) t ->
  ('key -> 'value -> unit) Js.Fn.arity2 ->
  unit
```
```reasonml
let forEachU: 
  t('key, 'value, 'id) =>
  Js.Fn.arity2(('key => 'value => unit)) =>
  unit;
```
```ocaml
val forEach : ('key, 'value, 'id) t -> ('key -> 'value -> unit) -> unit
```
```reasonml
let forEach: t('key, 'value, 'id) => ('key => 'value => unit) => unit;
```
`forEach tbl f` applies `f` to all bindings in table `tbl`. `f` receives the key as first argument, and the associated value as second argument. Each binding is presented exactly once to `f`.

```ocaml
val reduceU : 
  ('key, 'value, 'id) t ->
  'c ->
  ('c -> 'key -> 'value -> 'c) Js.Fn.arity3 ->
  'c
```
```reasonml
let reduceU: 
  t('key, 'value, 'id) =>
  'c =>
  Js.Fn.arity3(('c => 'key => 'value => 'c)) =>
  'c;
```
```ocaml
val reduce : ('key, 'value, 'id) t -> 'c -> ('c -> 'key -> 'value -> 'c) -> 'c
```
```reasonml
let reduce: t('key, 'value, 'id) => 'c => ('c => 'key => 'value => 'c) => 'c;
```
`reduce  tbl init f` computes `(f kN dN ... (f k1 d1 init)...)`, where `k1 ... kN` are the keys of all bindings in `tbl`, and `d1 ... dN` are the associated values. Each binding is presented exactly once to `f`.

The order in which the bindings are passed to `f` is unspecified. However, if the table contains several bindings for the same key, they are passed to `f` in reverse order of introduction, that is, the most recent binding is passed first.

```ocaml
val keepMapInPlaceU : 
  ('key, 'value, 'id) t ->
  ('key -> 'value -> 'value option) Js.Fn.arity2 ->
  unit
```
```reasonml
let keepMapInPlaceU: 
  t('key, 'value, 'id) =>
  Js.Fn.arity2(('key => 'value => option('value))) =>
  unit;
```
```ocaml
val keepMapInPlace : 
  ('key, 'value, 'id) t ->
  ('key -> 'value -> 'value option) ->
  unit
```
```reasonml
let keepMapInPlace: 
  t('key, 'value, 'id) =>
  ('key => 'value => option('value)) =>
  unit;
```
```ocaml
val size : (_, _, _) t -> int
```
```reasonml
let size: t(_, _, _) => int;
```
`size tbl` returns the number of bindings in `tbl`. It takes constant time.

```ocaml
val toArray : ('key, 'value, 'id) t -> ('key * 'value) array
```
```reasonml
let toArray: t('key, 'value, 'id) => array(('key, 'value));
```
```ocaml
val keysToArray : ('key, _, _) t -> 'key array
```
```reasonml
let keysToArray: t('key, _, _) => array('key);
```
```ocaml
val valuesToArray : (_, 'value, _) t -> 'value array
```
```reasonml
let valuesToArray: t(_, 'value, _) => array('value);
```
```ocaml
val fromArray : 
  ('key * 'value) array ->
  id:('key, 'id) id ->
  ('key, 'value, 'id) t
```
```reasonml
let fromArray: 
  array(('key, 'value)) =>
  id:id('key, 'id) =>
  t('key, 'value, 'id);
```
```ocaml
val mergeMany : ('key, 'value, 'id) t -> ('key * 'value) array -> unit
```
```reasonml
let mergeMany: t('key, 'value, 'id) => array(('key, 'value)) => unit;
```
```ocaml
val getBucketHistogram : (_, _, _) t -> int array
```
```reasonml
let getBucketHistogram: t(_, _, _) => array(int);
```
```ocaml
val logStats : (_, _, _) t -> unit
```
```reasonml
let logStats: t(_, _, _) => unit;
```