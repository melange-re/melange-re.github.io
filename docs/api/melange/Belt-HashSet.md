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
We can add elements to the collection:
```ocaml

  let () =
    add s1 0;
    add s1 1
```
Since this is an mutable data strucure, `s1` will contain two pairs.
```
module Int : sig ... end
```
Specalized when key type is `int`, more efficient than the generic type
```
module String : sig ... end
```
Specalized when key type is `string`, more efficient than the generic type
```
type ('a, 'id) t
```
The type of hash tables from type `'a` to type `'b`.
```
type ('a, 'id) id =
  (module Belt__.Belt_Id.Hashable
  with type identity = 'id
   and type t = 'a)
```
```
val make : hintSize:int -> id:('a, 'id) id -> ('a, 'id) t
```
```
val clear : ('a, 'id) t -> unit
```
```
val isEmpty : (_, _) t -> bool
```
```
val add : ('a, 'id) t -> 'a -> unit
```
```
val copy : ('a, 'id) t -> ('a, 'id) t
```
```
val has : ('a, 'id) t -> 'a -> bool
```
```
val remove : ('a, 'id) t -> 'a -> unit
```
```
val forEachU : ('a, 'id) t -> ('a -> unit) Js.Fn.arity1 -> unit
```
```
val forEach : ('a, 'id) t -> ('a -> unit) -> unit
```
Order unspecified.
```
val reduceU : ('a, 'id) t -> 'c -> ('c -> 'a -> 'c) Js.Fn.arity2 -> 'c
```
```
val reduce : ('a, 'id) t -> 'c -> ('c -> 'a -> 'c) -> 'c
```
Order unspecified.
```
val size : ('a, 'id) t -> int
```
```
val logStats : (_, _) t -> unit
```
```
val toArray : ('a, 'id) t -> 'a array
```
```
val fromArray : 'a array -> id:('a, 'id) id -> ('a, 'id) t
```
```
val mergeMany : ('a, 'id) t -> 'a array -> unit
```
```
val getBucketHistogram : (_, _) t -> int array
```