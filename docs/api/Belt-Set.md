
# Module `Belt.Set`

[`Belt.Set`](#)

The top level provides generic **immutable** set operations.

It also has three specialized inner modules [`Belt.Set.Int`](./Belt-Set-Int.md), [`Belt.Set.String`](./Belt-Set-String.md) and

[`Belt.Set.Dict`](./Belt-Set-Dict.md): This module separates data from function which is more verbose but slightly more efficient

A *immutable* sorted set module which allows customize *compare* behavior.

The implementation uses balanced binary trees, and therefore searching and insertion take time logarithmic in the size of the map.

For more info on this module's usage of identity, \`make\` and others, please see the top level documentation of Belt, **A special encoding for collection safety**.

Example usage:

```ocaml
 module PairComparator = Belt.Id.MakeComparable(struct
   type t = int * int
   let cmp (a0, a1) (b0, b1) =
     match Pervasives.compare a0 b0 with
     | 0 -> Pervasives.compare a1 b1
     | c -> c
 end)

 let mySet = Belt.Set.make ~id:(module PairComparator)
 let mySet2 = Belt.Set.add mySet (1, 2)
```
```reasonml
module PairComparator =
  Belt.Id.MakeComparable({
    type t = (int, int);
    let cmp = ((a0, a1), (b0, b1)) =>
      switch (Pervasives.compare(a0, b0)) {
      | 0 => Pervasives.compare(a1, b1)
      | c => c
      };
  });

let mySet = Belt.Set.make(~id=(module PairComparator));
let mySet2 = Belt.Set.add(mySet, (1, 2));
```
The API documentation below will assume a predeclared comparator module for integers, IntCmp

```ocaml
module Int : sig ... end
```
```reasonml
module Int: { ... };
```
Specalized when value type is `int`, more efficient than the generic type, its compare behavior is fixed using the built-in comparison

```ocaml
module String : sig ... end
```
```reasonml
module String: { ... };
```
Specalized when value type is `string`, more efficient than the generic type, its compare behavior is fixed using the built-in comparison

```ocaml
module Dict : sig ... end
```
```reasonml
module Dict: { ... };
```
This module seprate identity from data, it is a bit more verboe but slightly more efficient due to the fact that there is no need to pack identity and data back after each operation

```ocaml
type ('value, 'identity) t
```
```reasonml
type t('value, 'identity);
```
<code class="text-ocaml">('value, 'identity) t</code><code class="text-reasonml">t('value, 'identity)</code>

`'value` is the element type

`'identity` the identity of the collection

```ocaml
type ('value, 'id) id =
  (module Belt__.Belt_Id.Comparable
  with type identity = 'id
   and type t = 'value)
```
```reasonml
type id('value, 'id) =
  (module Belt__.Belt_Id.Comparable
  with type identity = 'id
   and type t = 'value);
```
The identity needed for making a set from scratch

```ocaml
val make : id:('value, 'id) id -> ('value, 'id) t
```
```reasonml
let make: id:id('value, 'id) => t('value, 'id);
```
`make ~id` creates a new set by taking in the comparator

```ocaml
  let s = make ~id:(module IntCmp)
```
```reasonml
let s = make(~id=(module IntCmp));
```
```ocaml
val fromArray : 'value array -> id:('value, 'id) id -> ('value, 'id) t
```
```reasonml
let fromArray: array('value) => id:id('value, 'id) => t('value, 'id);
```
`fromArray xs ~id`

```ocaml
 toArray (fromArray [1;3;2;4] (module IntCmp)) = [1;2;3;4]
```
```reasonml
toArray(fromArray([1, 3, 2, 4], (module IntCmp))) == [1, 2, 3, 4];
```
```ocaml
val fromSortedArrayUnsafe : 
  'value array ->
  id:('value, 'id) id ->
  ('value, 'id) t
```
```reasonml
let fromSortedArrayUnsafe: 
  array('value) =>
  id:id('value, 'id) =>
  t('value, 'id);
```
`fromSortedArrayUnsafe xs ~id`

The same as [`fromArray`](./#val-fromArray) except it is after assuming the input array `x` is already sorted

**Unsafe**

```ocaml
val isEmpty : (_, _) t -> bool
```
```reasonml
let isEmpty: t(_, _) => bool;
```
```ocaml
  isEmpty (fromArray [||] ~id:(module IntCmp)) = true;;
  isEmpty (fromArray [|1|] ~id:(module IntCmp)) = true;;
```
```reasonml
isEmpty(fromArray([||], ~id=(module IntCmp))) == true;
isEmpty(fromArray([|1|], ~id=(module IntCmp))) == true;
```
```ocaml
val has : ('value, 'id) t -> 'value -> bool
```
```reasonml
let has: t('value, 'id) => 'value => bool;
```
```ocaml
  let v = fromArray [|1;4;2;5|] ~id:(module IntCmp);;
  has v 3 = false;;
  has v 1 = true;;
```
```reasonml
let v = fromArray([|1, 4, 2, 5|], ~id=(module IntCmp));
has(v, 3) == false;
has(v, 1) == true;
```
```ocaml
val add : ('value, 'id) t -> 'value -> ('value, 'id) t
```
```reasonml
let add: t('value, 'id) => 'value => t('value, 'id);
```
`add s x` If `x` was already in `s`, `s` is returned unchanged.

```ocaml
 let s0 = make ~id:(module IntCmp);;
 let s1 = add s0 1 ;;
 let s2 = add s1 2;;
 let s3 = add s2 2;;
 toArray s0 = [||];;
 toArray s1 = [|1|];;
 toArray s2 = [|1;2|];;
 toArray s3 = [|1;2|];;
 s2 == s3;;
```
```reasonml
let s0 = make(~id=(module IntCmp));
let s1 = add(s0, 1);
let s2 = add(s1, 2);
let s3 = add(s2, 2);
toArray(s0) == [||];
toArray(s1) == [|1|];
toArray(s2) == [|1, 2|];
toArray(s3) == [|1, 2|];
s2 === s3;
```
```ocaml
val mergeMany : ('value, 'id) t -> 'value array -> ('value, 'id) t
```
```reasonml
let mergeMany: t('value, 'id) => array('value) => t('value, 'id);
```
`mergeMany s xs`

Adding each of `xs` to `s`, note unlike [`add`](./#val-add), the reference of return value might be changed even if all values in `xs` exist `s`

```ocaml
val remove : ('value, 'id) t -> 'value -> ('value, 'id) t
```
```reasonml
let remove: t('value, 'id) => 'value => t('value, 'id);
```
`remove m x` If `x` was not in `m`, `m` is returned reference unchanged.

```ocaml
  let s0 = fromArray ~id:(module IntCmp) [|2;3;1;4;5|];;
  let s1 = remove s0 1 ;;
  let s2 = remove s1 3 ;;
  let s3 = remove s2 3 ;;

  toArray s1 = [|2;3;4;5|];;
  toArray s2 = [|2;4;5|];;
  s2 == s3;;
```
```reasonml
let s0 = fromArray(~id=(module IntCmp), [|2, 3, 1, 4, 5|]);
let s1 = remove(s0, 1);
let s2 = remove(s1, 3);
let s3 = remove(s2, 3);

toArray(s1) == [|2, 3, 4, 5|];
toArray(s2) == [|2, 4, 5|];
s2 === s3;
```
```ocaml
val removeMany : ('value, 'id) t -> 'value array -> ('value, 'id) t
```
```reasonml
let removeMany: t('value, 'id) => array('value) => t('value, 'id);
```
`removeMany s xs`

Removing each of `xs` to `s`, note unlike [`remove`](./#val-remove), the reference of return value might be changed even if none in `xs` exists `s`

```ocaml
val union : ('value, 'id) t -> ('value, 'id) t -> ('value, 'id) t
```
```reasonml
let union: t('value, 'id) => t('value, 'id) => t('value, 'id);
```
`union s0 s1`

```ocaml
  let s0 = fromArray ~id:(module IntCmp) [|5;2;3;5;6|]];;
  let s1 = fromArray ~id:(module IntCmp) [|5;2;3;1;5;4;|];;
  toArray (union s0 s1) =  [|1;2;3;4;5;6|]
```
```ocaml
val intersect : ('value, 'id) t -> ('value, 'id) t -> ('value, 'id) t
```
```reasonml
let intersect: t('value, 'id) => t('value, 'id) => t('value, 'id);
```
`intersect s0 s1`

```ocaml
  let s0 = fromArray ~id:(module IntCmp) [|5;2;3;5;6|]];;
  let s1 = fromArray ~id:(module IntCmp) [|5;2;3;1;5;4;|];;
  toArray (intersect s0 s1) =  [|2;3;5|]
```
```ocaml
val diff : ('value, 'id) t -> ('value, 'id) t -> ('value, 'id) t
```
```reasonml
let diff: t('value, 'id) => t('value, 'id) => t('value, 'id);
```
`diff s0 s1`

```ocaml
  let s0 = fromArray ~id:(module IntCmp) [|5;2;3;5;6|]];;
  let s1 = fromArray ~id:(module IntCmp) [|5;2;3;1;5;4;|];;
  toArray (diff s0 s1) = [|6|];;
  toArray (diff s1 s0) = [|1;4|];;
```
```ocaml
val subset : ('value, 'id) t -> ('value, 'id) t -> bool
```
```reasonml
let subset: t('value, 'id) => t('value, 'id) => bool;
```
`subset s0 s1`

```ocaml
  let s0 = fromArray ~id:(module IntCmp) [|5;2;3;5;6|]];;
  let s1 = fromArray ~id:(module IntCmp) [|5;2;3;1;5;4;|];;
  let s2 = intersect s0 s1;;
  subset s2 s0 = true;;
  subset s2 s1 = true;;
  subset s1 s0 = false;;
```
```ocaml
val cmp : ('value, 'id) t -> ('value, 'id) t -> int
```
```reasonml
let cmp: t('value, 'id) => t('value, 'id) => int;
```
Total ordering between sets. Can be used as the ordering function for doing sets of sets. It compare `size` first and then iterate over each element following the order of elements

```ocaml
val eq : ('value, 'id) t -> ('value, 'id) t -> bool
```
```reasonml
let eq: t('value, 'id) => t('value, 'id) => bool;
```
`eq s0 s1`

returns true if toArray s0 = toArray s1
```ocaml
val forEachU : ('value, 'id) t -> ('value -> unit) Js.Fn.arity1 -> unit
```
```reasonml
let forEachU: t('value, 'id) => Js.Fn.arity1(('value => unit)) => unit;
```
```ocaml
val forEach : ('value, 'id) t -> ('value -> unit) -> unit
```
```reasonml
let forEach: t('value, 'id) => ('value => unit) => unit;
```
`forEach s f` applies `f` in turn to all elements of `s`. In increasing order

```ocaml
  let s0 = fromArray ~id:(module IntCmp) [|5;2;3;5;6|]];;
  let acc = ref [] ;;
  forEach s0 (fun x -> acc := x !acc);;
  !acc = [6;5;3;2];;
```
```ocaml
val reduceU : ('value, 'id) t -> 'a -> ('a -> 'value -> 'a) Js.Fn.arity2 -> 'a
```
```reasonml
let reduceU: t('value, 'id) => 'a => Js.Fn.arity2(('a => 'value => 'a)) => 'a;
```
```ocaml
val reduce : ('value, 'id) t -> 'a -> ('a -> 'value -> 'a) -> 'a
```
```reasonml
let reduce: t('value, 'id) => 'a => ('a => 'value => 'a) => 'a;
```
In increasing order.

```ocaml
  let s0 = fromArray ~id:(module IntCmp) [|5;2;3;5;6|]];;
  reduce s0 [] Belt.List.add = [6;5;3;2];;
```
```ocaml
val everyU : ('value, 'id) t -> ('value -> bool) Js.Fn.arity1 -> bool
```
```reasonml
let everyU: t('value, 'id) => Js.Fn.arity1(('value => bool)) => bool;
```
```ocaml
val every : ('value, 'id) t -> ('value -> bool) -> bool
```
```reasonml
let every: t('value, 'id) => ('value => bool) => bool;
```
`every p s` checks if all elements of the set satisfy the predicate `p`. Order unspecified.

```ocaml
val someU : ('value, 'id) t -> ('value -> bool) Js.Fn.arity1 -> bool
```
```reasonml
let someU: t('value, 'id) => Js.Fn.arity1(('value => bool)) => bool;
```
```ocaml
val some : ('value, 'id) t -> ('value -> bool) -> bool
```
```reasonml
let some: t('value, 'id) => ('value => bool) => bool;
```
`some p s` checks if at least one element of the set satisfies the predicate `p`.

```ocaml
val keepU : ('value, 'id) t -> ('value -> bool) Js.Fn.arity1 -> ('value, 'id) t
```
```reasonml
let keepU: t('value, 'id) => Js.Fn.arity1(('value => bool)) => t('value, 'id);
```
```ocaml
val keep : ('value, 'id) t -> ('value -> bool) -> ('value, 'id) t
```
```reasonml
let keep: t('value, 'id) => ('value => bool) => t('value, 'id);
```
`keep m p` returns the set of all elements in `s` that satisfy predicate `p`.

```ocaml
val partitionU : 
  ('value, 'id) t ->
  ('value -> bool) Js.Fn.arity1 ->
  ('value, 'id) t * ('value, 'id) t
```
```reasonml
let partitionU: 
  t('value, 'id) =>
  Js.Fn.arity1(('value => bool)) =>
  (t('value, 'id), t('value, 'id));
```
```ocaml
val partition : 
  ('value, 'id) t ->
  ('value -> bool) ->
  ('value, 'id) t * ('value, 'id) t
```
```reasonml
let partition: 
  t('value, 'id) =>
  ('value => bool) =>
  (t('value, 'id), t('value, 'id));
```
`partition m p` returns a pair of sets `(s1, s2)`, where `s1` is the set of all the elements of `s` that satisfy the predicate `p`, and `s2` is the set of all the elements of `s` that do not satisfy `p`.

```ocaml
val size : ('value, 'id) t -> int
```
```reasonml
let size: t('value, 'id) => int;
```
`size s`

```ocaml
  let s0 = fromArray ~id:(module IntCmp) [|5;2;3;5;6|]];;
  size s0 = 4;;
```
```ocaml
val toArray : ('value, 'id) t -> 'value array
```
```reasonml
let toArray: t('value, 'id) => array('value);
```
`toArray s0`

```ocaml
   let s0 = fromArray ~id:(module IntCmp) [|5;2;3;5;6|]];;
   toArray s0 = [|2;3;5;6|];;
```
```ocaml
val toList : ('value, 'id) t -> 'value list
```
```reasonml
let toList: t('value, 'id) => list('value);
```
In increasing order

**See** [`toArray`](./#val-toArray)

```ocaml
val minimum : ('value, 'id) t -> 'value option
```
```reasonml
let minimum: t('value, 'id) => option('value);
```
`minimum s0`

returns the minimum element of the collection, None if it is empty
```ocaml
val minUndefined : ('value, 'id) t -> 'value Js.undefined
```
```reasonml
let minUndefined: t('value, 'id) => Js.undefined('value);
```
`minUndefined s0`

returns the minimum element of the collection, undefined if it is empty
```ocaml
val maximum : ('value, 'id) t -> 'value option
```
```reasonml
let maximum: t('value, 'id) => option('value);
```
`maximum s0`

returns the maximum element of the collection, None if it is empty
```ocaml
val maxUndefined : ('value, 'id) t -> 'value Js.undefined
```
```reasonml
let maxUndefined: t('value, 'id) => Js.undefined('value);
```
`maxUndefined s0`

returns the maximum element of the collection, undefined if it is empty
```ocaml
val get : ('value, 'id) t -> 'value -> 'value option
```
```reasonml
let get: t('value, 'id) => 'value => option('value);
```
`get s0 k`

returns the reference of the value k' which is equivalent to k using the comparator specifiecd by this collection, None if it does not exist
```ocaml
val getUndefined : ('value, 'id) t -> 'value -> 'value Js.undefined
```
```reasonml
let getUndefined: t('value, 'id) => 'value => Js.undefined('value);
```
**See** [`get`](./#val-get)

```ocaml
val getExn : ('value, 'id) t -> 'value -> 'value
```
```reasonml
let getExn: t('value, 'id) => 'value => 'value;
```
**See** [`get`](./#val-get)

**raise** if not exist

```ocaml
val split : 
  ('value, 'id) t ->
  'value ->
  (('value, 'id) t * ('value, 'id) t) * bool
```
```reasonml
let split: 
  t('value, 'id) =>
  'value =>
  ((t('value, 'id), t('value, 'id)), bool);
```
`split set ele`

returns a tuple ((smaller, larger), present), present is true when ele exist in set
Below are operations only when better performance needed, it is still safe API but more verbose. More API will be exposed by needs

```ocaml
val getData : ('value, 'id) t -> ('value, 'id) Belt__.Belt_SetDict.t
```
```reasonml
let getData: t('value, 'id) => Belt__.Belt_SetDict.t('value, 'id);
```
`getData s0`

**Advanced usage only**

returns the raw data (detached from comparator), but its type is still manifested, so that user can pass identity directly without boxing
```ocaml
val getId : ('value, 'id) t -> ('value, 'id) id
```
```reasonml
let getId: t('value, 'id) => id('value, 'id);
```
`getId s0`

**Advanced usage only**

returns the identity of s0
```ocaml
val packIdData : 
  id:('value, 'id) id ->
  data:('value, 'id) Belt__.Belt_SetDict.t ->
  ('value, 'id) t
```
```reasonml
let packIdData: 
  id:id('value, 'id) =>
  data:Belt__.Belt_SetDict.t('value, 'id) =>
  t('value, 'id);
```
`packIdData ~id ~data`

**Advanced usage only**

returns the packed collection