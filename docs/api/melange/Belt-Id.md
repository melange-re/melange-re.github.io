# Module `Belt.Id`
[`Belt.Id`](#)
Provide utilities to create identified comparators or hashes for data structures used below.
It create a unique identifier per module of functions so that different data structures with slightly different comparison functions won't mix
[`Belt.Id`](#)
Provide utiliites to create identified comparators or hashes for data structures used below.
It create a unique identifer per module of functions so that different data structures with slightly different comparison functions won't mix.
```
type ('a, 'id) hash
```
`('a, 'id) hash`
Its runtime represenation is a `hash` function, but signed with a type parameter, so that different hash functions type mismatch
```
type ('a, 'id) eq
```
`('a, 'id) eq`
Its runtime represenation is an `eq` function, but signed with a type parameter, so that different hash functions type mismatch
```
type ('a, 'id) cmp
```
`('a,'id) cmp`
Its runtime representation is a `cmp` function, but signed with a type parameter, so that different hash functions type mismatch
```
module type Comparable = sig ... end
```
```
type ('key, 'id) comparable =
  (module Comparable
  with type identity = 'id
   and type t = 'key)
```
`('key, 'id) cmparable` is a module of functions, here it only includes `cmp`.
Unlike normal functions, when created, it comes with a unique identity (guaranteed by the type system).
It can be created using function [`comparableU`](./#val-comparableU) or [`comparable`](./#val-comparable).
The idea of a unique identity when created is that it makes sure two sets would type mismatch if they use different comparison function
```
module MakeComparableU (M : sig ... end) : Comparable with type t = M.t
```
```
module MakeComparable (M : sig ... end) : Comparable with type t = M.t
```
```
val comparableU : 
  cmp:('a -> 'a -> int) Js.Fn.arity2 ->
  (module Comparable
  with type t = 'a)
```
```
val comparable : cmp:('a -> 'a -> int) -> (module Comparable with type t = 'a)
```
```ocaml
  module C = (
    val Belt.Id.comparable ~cmp:(compare : int -> int -> int)
  )
  let m = Belt.Set.make(module C)
```
Note that the name of C can not be ignored
```
module type Hashable = sig ... end
```
```
type ('key, 'id) hashable =
  (module Hashable
  with type identity = 'id
   and type t = 'key)
```
`('key, 'id) hashable` is a module of functions, here it only includes `hash`, `eq`.
Unlike normal functions, when created, it comes with a unique identity (guaranteed by the type system).
It can be created using function [`hashableU`](./#val-hashableU) or [`hashable`](./#val-hashable).
The idea of a unique identity when created is that it makes sure two hash sets would type mismatch if they use different comparison function
```
module MakeHashableU (M : sig ... end) : Hashable with type t = M.t
```
```
module MakeHashable (M : sig ... end) : Hashable with type t = M.t
```
```
val hashableU : 
  hash:('a -> int) Js.Fn.arity1 ->
  eq:('a -> 'a -> bool) Js.Fn.arity2 ->
  (module Hashable
  with type t = 'a)
```
```
val hashable : 
  hash:('a -> int) ->
  eq:('a -> 'a -> bool) ->
  (module Hashable
  with type t = 'a)
```