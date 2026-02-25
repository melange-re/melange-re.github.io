
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
```reasonml
module IntPairs = {
  type t = (int, int);
  let compare = ((x0, y0), (x1, y1)) =>
    switch (Stdlib.compare(x0, x1)) {
    | 0 => Stdlib.compare(y0, y1)
    | c => c
    };
};

module PairsMap = Map.Make(IntPairs);

let m = PairsMap.(empty |> add((0, 1), "hello") |> add((1, 0), "world"));
```
This creates a new module `PairsMap`, with a new type <code class="text-ocaml">'a PairsMap.t</code><code class="text-reasonml">PairsMap.t('a)</code> of maps from <code class="text-ocaml">int * int</code><code class="text-reasonml">(int, int)</code> to `'a`. In this example, `m` contains `string` values so its type is `string PairsMap.t`.

```ocaml
module type OrderedType = sig ... end
```
```reasonml
module type OrderedType = { ... };
```
Input signature of the functor [`Make`](./Stdlib-Map-Make.md).

```ocaml
module type S = sig ... end
```
```reasonml
module type S = { ... };
```
Output signature of the functor [`Make`](./Stdlib-Map-Make.md).

```ocaml
module Make (Ord : OrderedType) : S with type key = Ord.t
```
```reasonml
module Make:  (Ord: OrderedType) => S with type key = Ord.t;
```
Functor building an implementation of the map structure given a totally ordered type.
