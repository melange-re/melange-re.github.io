
# Module `Stdlib.Set`

Sets over ordered types.

This module implements the set data structure, given a total ordering function over the set elements. All operations over sets are purely applicative (no side-effects). The implementation uses balanced binary trees, and is therefore reasonably efficient: insertion and membership take time logarithmic in the size of the set, for instance.

The [`Make`](./Stdlib-Set-Make.md) functor constructs implementations for any type, given a `compare` function. For instance:

```ocaml
  module IntPairs =
    struct
      type t = int * int
      let compare (x0,y0) (x1,y1) =
        match Stdlib.compare x0 x1 with
            0 -> Stdlib.compare y0 y1
          | c -> c
    end

  module PairsSet = Set.Make(IntPairs)

  let m = PairsSet.(empty |> add (2,3) |> add (5,7) |> add (11,13))
```
This creates a new module `PairsSet`, with a new type `PairsSet.t` of sets of `int * int`.

```
module type OrderedType = sig ... end
```
Input signature of the functor [`Make`](./Stdlib-Set-Make.md).

```
module type S = sig ... end
```
Output signature of the functor [`Make`](./Stdlib-Set-Make.md).

```
module Make (Ord : OrderedType) : S with type elt = Ord.t
```
Functor building an implementation of the set structure given a totally ordered type.
