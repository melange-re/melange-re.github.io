
# Module `Belt`

A stdlib shipped with Melange

This stdlib is still in *beta* but we encourage you to try it out and give us feedback.

**Motivation**

The motivation for creating such library is to provide Melange users a better end-to-end user experience, since the original OCaml stdlib was not written with JS in mind. Below is a list of areas this lib aims to improve:

1. Consistency in name convention: camlCase, and arguments order
2. Exception thrown functions are all suffixed with *Exn*, e.g, *getExn*
3. Better performance and smaller code size running on JS platform
**Name Convention**

For higher order functions, it will be suffixed **U** if it takes uncurried callback.

```ocaml
  val forEach  : 'a t -> ('a -> unit) -> unit
  val forEachU : 'a t -> ('a -> unit [\@u]) -> unit
```
In general, uncurried version will be faster, but it may be less familiar to people who have a background in functional programming.

**A special encoding for collection safety**

When we create a collection library for a custom data type we need a way to provide a comparator function. Take *Set* for example, suppose its element type is a pair of ints, it needs a custom *compare* function that takes two tuples and returns their order. The *Set* could not just be typed as <code class="text-ocaml"> Set.t (int * int) </code><code class="text-reasonml">Set.t((int, int))</code>, its customized *compare* function needs to manifest itself in the signature, otherwise, if the user creates another customized *compare* function, the two collection could mix which would result in runtime error.

The original OCaml stdlib solved the problem using *functor* which creates a big closure at runtime and makes dead code elimination much harder. We use a phantom type to solve the problem:

```ocaml
  module Comparable1 = Belt.Id.MakeComparable(struct
    type t = int * int
    let cmp (a0, a1) (b0, b1) =
      match Pervasives.compare a0 b0 with
      | 0 -> Pervasives.compare a1 b1
      | c -> c
  end)

let mySet1 = Belt.Set.make ~id:(module Comparable1)

module Comparable2 = Belt.Id.MakeComparable(struct
  type t = int * int
  let cmp (a0, a1) (b0, b1) =
    match Pervasives.compare a0 b0 with
    | 0 -> Pervasives.compare a1 b1
    | c -> c
end)

let mySet2 = Belt.Set.make ~id:(module Comparable2)
```
```reasonml
module Comparable1 =
  Belt.Id.MakeComparable({
    type t = (int, int);
    let cmp = ((a0, a1), (b0, b1)) =>
      switch (Pervasives.compare(a0, b0)) {
      | 0 => Pervasives.compare(a1, b1)
      | c => c
      };
  });

let mySet1 = Belt.Set.make(~id=(module Comparable1));

module Comparable2 =
  Belt.Id.MakeComparable({
    type t = (int, int);
    let cmp = ((a0, a1), (b0, b1)) =>
      switch (Pervasives.compare(a0, b0)) {
      | 0 => Pervasives.compare(a1, b1)
      | c => c
      };
  });

let mySet2 = Belt.Set.make(~id=(module Comparable2));
```
Here, the compiler would infer `mySet1` and `mySet2` having different type, so e.g. a \`merge\` operation that tries to merge these two sets will correctly fail.

```ocaml
  val mySet1 : ((int * int), Comparable1.identity) t
  val mySet2 : ((int * int), Comparable2.identity) t
```
```reasonml
external mySet1: t((int, int), Comparable1.identity) = ;
external mySet2: t((int, int), Comparable2.identity) = ;
```
`Comparable1.identity` and `Comparable2.identity` are not the same using our encoding scheme.

**Collection Hierarchy**

In general, we provide a generic collection module, but also create specialized modules for commonly used data type. Take *Belt.Set* for example, we provide:

```ocaml
    Belt.Set
    Belt.Set.Int
    Belt.Set.String
```
The specialized modules *Belt.Set.Int*, *Belt.Set.String* are in general more efficient.

Currently, both *Belt\_Set* and *Belt.Set* are accessible to users for some technical reasons, we **strongly recommend** users stick to qualified import, *Belt.Set*, we may hide the internal, *i.e*, *Belt\_Set* in the future

```ocaml
module Id : sig ... end
```
```reasonml
module Id: { ... };
```
[`Belt.Id`](./Belt-Id.md)

```ocaml
module Array : sig ... end
```
```reasonml
module Array: { ... };
```
[`Belt.Array`](./Belt-Array.md)

```ocaml
module SortArray : sig ... end
```
```reasonml
module SortArray: { ... };
```
[`Belt.SortArray`](./Belt-SortArray.md)

```ocaml
module MutableQueue : sig ... end
```
```reasonml
module MutableQueue: { ... };
```
[`Belt.MutableQueue`](./Belt-MutableQueue.md)

```ocaml
module MutableStack : sig ... end
```
```reasonml
module MutableStack: { ... };
```
[`Belt.MutableStack`](./Belt-MutableStack.md)

```ocaml
module List : sig ... end
```
```reasonml
module List: { ... };
```
[`Belt.List`](./Belt-List.md)

```ocaml
module Range : sig ... end
```
```reasonml
module Range: { ... };
```
[`Belt.Range`](./Belt-Range.md)

```ocaml
module Set : sig ... end
```
```reasonml
module Set: { ... };
```
[`Belt.Set`](./Belt-Set.md)

```ocaml
module Map : sig ... end
```
```reasonml
module Map: { ... };
```
[`Belt.Map`](./Belt-Map.md),

```ocaml
module MutableSet : sig ... end
```
```reasonml
module MutableSet: { ... };
```
[`Belt.MutableSet`](./Belt-MutableSet.md)

```ocaml
module MutableMap : sig ... end
```
```reasonml
module MutableMap: { ... };
```
[`Belt.MutableMap`](./Belt-MutableMap.md)

```ocaml
module HashSet : sig ... end
```
```reasonml
module HashSet: { ... };
```
[`Belt.HashSet`](./Belt-HashSet.md)

```ocaml
module HashMap : sig ... end
```
```reasonml
module HashMap: { ... };
```
[`Belt.HashMap`](./Belt-HashMap.md)

```ocaml
module Option : sig ... end
```
```reasonml
module Option: { ... };
```
[`Belt.Option`](./Belt-Option.md)

[`Belt.Result`](./Belt-Result.md)

Utilities for result data type.

```ocaml
module Result : sig ... end
```
```reasonml
module Result: { ... };
```
[`Belt.Result`](./Belt-Result.md)

[`Belt.Int`](./Belt-Int.md)

Utilities for Int.

```ocaml
module Int : sig ... end
```
```reasonml
module Int: { ... };
```
[`Belt.Int`](./Belt-Int.md) Utililites for Int

[`Belt.Float`](./Belt-Float.md)

Utilities for Float.

```ocaml
module Float : sig ... end
```
```reasonml
module Float: { ... };
```
[`Belt.Float`](./Belt-Float.md) Utililites for Float
