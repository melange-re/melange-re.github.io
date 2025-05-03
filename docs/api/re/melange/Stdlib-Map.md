
# Module `Stdlib.Map`

Association tables over ordered types.

This module implements applicative association tables, also known as finite maps or dictionaries, given a total ordering function over the keys. All operations over maps are purely applicative (no side-effects). The implementation uses balanced binary trees, and therefore searching and insertion take time logarithmic in the size of the map.

For instance:

```ocaml
  module IntPairs =
    struct
      type t = int * int
      let compare (x0,y0) (x1,y1) =
        match Stdlib.compare x0 x1 with
            0 -> Stdlib.compare y0 y1
          | c -> c
    end

  module PairsMap = Map.Make(IntPairs)

  let m = PairsMap.(empty |> add (0,1) "hello" |> add (1,0) "world")
```
This creates a new module `PairsMap`, with a new type `'a PairsMap.t` of maps from `int * int` to `'a`. In this example, `m` contains `string` values so its type is `string PairsMap.t`.

```
module type OrderedType = sig ... end
```
Input signature of the functor [`Make`](./Stdlib-Map-Make.md).

```
module type S = sig ... end
```
Output signature of the functor [`Make`](./Stdlib-Map-Make.md).

```
module Make (Ord : OrderedType) : S with type key = Ord.t
```
Functor building an implementation of the map structure given a totally ordered type.
