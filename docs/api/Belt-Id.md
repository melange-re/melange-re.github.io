
# Module `Belt.Id`

[`Belt.Id`](#)

Provide utilities to create identified comparators or hashes for data structures used below.

It create a unique identifier per module of functions so that different data structures with slightly different comparison functions won't mix

[`Belt.Id`](#)

Provide utiliites to create identified comparators or hashes for data structures used below.

It create a unique identifer per module of functions so that different data structures with slightly different comparison functions won't mix.

```ocaml
type ('a, 'id) hash
```
```reasonml
type hash('a, 'id);
```
<code class="text-ocaml">('a, 'id) hash</code><code class="text-reasonml">hash('a, 'id)</code>

Its runtime represenation is a `hash` function, but signed with a type parameter, so that different hash functions type mismatch

```ocaml
type ('a, 'id) eq
```
```reasonml
type eq('a, 'id);
```
<code class="text-ocaml">('a, 'id) eq</code><code class="text-reasonml">eq('a, 'id)</code>

Its runtime represenation is an `eq` function, but signed with a type parameter, so that different hash functions type mismatch

```ocaml
type ('a, 'id) cmp
```
```reasonml
type cmp('a, 'id);
```
<code class="text-ocaml">('a,'id) cmp</code><code class="text-reasonml">cmp('a, 'id)</code>

Its runtime representation is a `cmp` function, but signed with a type parameter, so that different hash functions type mismatch

```ocaml
module type Comparable = sig ... end
```
```reasonml
module type Comparable = { ... };
```
```ocaml
type ('key, 'id) comparable =
  (module Comparable
  with type identity = 'id
   and type t = 'key)
```
```reasonml
type comparable('key, 'id) =
  (module Comparable
  with type identity = 'id
   and type t = 'key);
```
<code class="text-ocaml">('key, 'id) cmparable</code><code class="text-reasonml">cmparable('key, 'id)</code> is a module of functions, here it only includes `cmp`.

Unlike normal functions, when created, it comes with a unique identity (guaranteed by the type system).

It can be created using function [`comparableU`](./#val-comparableU) or [`comparable`](./#val-comparable).

The idea of a unique identity when created is that it makes sure two sets would type mismatch if they use different comparison function

```ocaml
module MakeComparableU (M : sig ... end) : Comparable with type t = M.t
```
```reasonml
module MakeComparableU:  (M: { ... }) => Comparable with type t = M.t;
```
```ocaml
module MakeComparable (M : sig ... end) : Comparable with type t = M.t
```
```reasonml
module MakeComparable:  (M: { ... }) => Comparable with type t = M.t;
```
```ocaml
val comparableU : 
  cmp:('a -> 'a -> int) Js.Fn.arity2 ->
  (module Comparable
  with type t = 'a)
```
```reasonml
let comparableU: 
  cmp:Js.Fn.arity2(('a => 'a => int)) =>
  (module Comparable
  with type t = 'a);
```
```ocaml
val comparable : cmp:('a -> 'a -> int) -> (module Comparable with type t = 'a)
```
```reasonml
let comparable: cmp:('a => 'a => int) => (module Comparable with type t = 'a);
```
```ocaml
  module C = (
    val Belt.Id.comparable ~cmp:(compare : int -> int -> int)
  )
  let m = Belt.Set.make(module C)
```
```reasonml
module C = (val Belt.Id.comparable(~cmp=compare: (int, int) => int));
let m = Belt.Set.make((module C));
```
Note that the name of C can not be ignored

```ocaml
module type Hashable = sig ... end
```
```reasonml
module type Hashable = { ... };
```
```ocaml
type ('key, 'id) hashable =
  (module Hashable
  with type identity = 'id
   and type t = 'key)
```
```reasonml
type hashable('key, 'id) =
  (module Hashable
  with type identity = 'id
   and type t = 'key);
```
<code class="text-ocaml">('key, 'id) hashable</code><code class="text-reasonml">hashable('key, 'id)</code> is a module of functions, here it only includes `hash`, `eq`.

Unlike normal functions, when created, it comes with a unique identity (guaranteed by the type system).

It can be created using function [`hashableU`](./#val-hashableU) or [`hashable`](./#val-hashable).

The idea of a unique identity when created is that it makes sure two hash sets would type mismatch if they use different comparison function

```ocaml
module MakeHashableU (M : sig ... end) : Hashable with type t = M.t
```
```reasonml
module MakeHashableU:  (M: { ... }) => Hashable with type t = M.t;
```
```ocaml
module MakeHashable (M : sig ... end) : Hashable with type t = M.t
```
```reasonml
module MakeHashable:  (M: { ... }) => Hashable with type t = M.t;
```
```ocaml
val hashableU : 
  hash:('a -> int) Js.Fn.arity1 ->
  eq:('a -> 'a -> bool) Js.Fn.arity2 ->
  (module Hashable
  with type t = 'a)
```
```reasonml
let hashableU: 
  hash:Js.Fn.arity1(('a => int)) =>
  eq:Js.Fn.arity2(('a => 'a => bool)) =>
  (module Hashable
  with type t = 'a);
```
```ocaml
val hashable : 
  hash:('a -> int) ->
  eq:('a -> 'a -> bool) ->
  (module Hashable
  with type t = 'a)
```
```reasonml
let hashable: 
  hash:('a => int) =>
  eq:('a => 'a => bool) =>
  (module Hashable
  with type t = 'a);
```