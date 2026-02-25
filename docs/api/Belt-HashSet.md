
# Module `Belt.HashSet`

[`Belt.HashSet`](#)

The top level provides generic **mutable** hash set operations.

It also has two specialized inner modules [`Belt.HashSet.Int`](./Belt-HashSet-Int.md) and [`Belt.HashSet.String`](./Belt-HashSet-String.md)

A **mutable** Hash set which allows customized hash behavior.

All data are parameterized by not its only type but also a unique identity in the time of initialization, so that two *HashSets of ints* initialized with different *hash* functions will have different type.

For example:

```ocaml
  type t = int
  module I0 =
    (val Belt.Id.hashableU
        ~hash:(fun[\@u] (a : t)  -> a & 0xff_ff)
        ~eq:(fun[\@u] a b -> a = b)
    )
  let s0 = make ~id:(module I0) ~hintSize:40
  module I1 =
    (val Belt.Id.hashableU
        ~hash:(fun[\@u] (a : t)  -> a & 0xff)
        ~eq:(fun[\@u] a b -> a = b)
    )
  let s1 = make ~id:(module I1) ~hintSize:40
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
    add s1 0;
    add s1 1
```
```reasonml
let () = {
  add(s1, 0);
  add(s1, 1);
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
type ('a, 'id) t
```
```reasonml
type t('a, 'id);
```
The type of hash tables from type `'a` to type `'b`.

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
val make : hintSize:int -> id:('a, 'id) id -> ('a, 'id) t
```
```reasonml
let make: hintSize:int => id:id('a, 'id) => t('a, 'id);
```
```ocaml
val clear : ('a, 'id) t -> unit
```
```reasonml
let clear: t('a, 'id) => unit;
```
```ocaml
val isEmpty : (_, _) t -> bool
```
```reasonml
let isEmpty: t(_, _) => bool;
```
```ocaml
val add : ('a, 'id) t -> 'a -> unit
```
```reasonml
let add: t('a, 'id) => 'a => unit;
```
```ocaml
val copy : ('a, 'id) t -> ('a, 'id) t
```
```reasonml
let copy: t('a, 'id) => t('a, 'id);
```
```ocaml
val has : ('a, 'id) t -> 'a -> bool
```
```reasonml
let has: t('a, 'id) => 'a => bool;
```
```ocaml
val remove : ('a, 'id) t -> 'a -> unit
```
```reasonml
let remove: t('a, 'id) => 'a => unit;
```
```ocaml
val forEachU : ('a, 'id) t -> ('a -> unit) Js.Fn.arity1 -> unit
```
```reasonml
let forEachU: t('a, 'id) => Js.Fn.arity1(('a => unit)) => unit;
```
```ocaml
val forEach : ('a, 'id) t -> ('a -> unit) -> unit
```
```reasonml
let forEach: t('a, 'id) => ('a => unit) => unit;
```
Order unspecified.

```ocaml
val reduceU : ('a, 'id) t -> 'c -> ('c -> 'a -> 'c) Js.Fn.arity2 -> 'c
```
```reasonml
let reduceU: t('a, 'id) => 'c => Js.Fn.arity2(('c => 'a => 'c)) => 'c;
```
```ocaml
val reduce : ('a, 'id) t -> 'c -> ('c -> 'a -> 'c) -> 'c
```
```reasonml
let reduce: t('a, 'id) => 'c => ('c => 'a => 'c) => 'c;
```
Order unspecified.

```ocaml
val size : ('a, 'id) t -> int
```
```reasonml
let size: t('a, 'id) => int;
```
```ocaml
val logStats : (_, _) t -> unit
```
```reasonml
let logStats: t(_, _) => unit;
```
```ocaml
val toArray : ('a, 'id) t -> 'a array
```
```reasonml
let toArray: t('a, 'id) => array('a);
```
```ocaml
val fromArray : 'a array -> id:('a, 'id) id -> ('a, 'id) t
```
```reasonml
let fromArray: array('a) => id:id('a, 'id) => t('a, 'id);
```
```ocaml
val mergeMany : ('a, 'id) t -> 'a array -> unit
```
```reasonml
let mergeMany: t('a, 'id) => array('a) => unit;
```
```ocaml
val getBucketHistogram : (_, _) t -> int array
```
```reasonml
let getBucketHistogram: t(_, _) => array(int);
```