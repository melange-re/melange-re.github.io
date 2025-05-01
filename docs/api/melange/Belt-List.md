# Module `Belt.List`
[`Belt.List`](#)
Utilities for List data type
[`Belt.List`](#)
Utilities for List data type.
This module is compatible with original ocaml stdlib. In general, all functions comes with the original stdlib also applies to this collection, however, this module provides faster and stack safer utilities
```
type 'a t = 'a list
```
`'a t` is compatible with built-in `list` type
```
val length : 'a t -> int
```
`length xs`
returns the length of the list xs
```
val size : 'a t -> int
```
**See** [`length`](./#val-length)
```
val head : 'a t -> 'a option
```
`head xs` returns `None` if `xs` is the empty list, otherwise it returns `Some value` where `value` is the first element in the list.
```ocaml
  head [] = None ;;
  head [1;2;3] = Some 1 ;;
```
```
val headExn : 'a t -> 'a
```
`headExn xs`
**See** [`head`](./#val-head)
**raise** an exception if `xs` is empty
```
val tail : 'a t -> 'a t option
```
`tail xs` returns `None` if `xs` is empty; otherwise it returns `Some xs2` where `xs2` is everything except the first element of `xs`;
```ocaml
  tail [] = None;;
  tail [1;2;3;4] = Some [2;3;4];;
```
```
val tailExn : 'a t -> 'a t
```
`tailExn xs`
**See** [`tail`](./#val-tail)
**raise** an exception if `xs` is empty
```
val add : 'a t -> 'a -> 'a t
```
`add xs y` adds `y` to the beginning of list `xs`
```ocaml
  add [1] 3 = [3;1];;
```
```
val get : 'a t -> int -> 'a option
```
`get xs n`
return the nth element in `xs`, or `None` if `n` is larger than the length
```ocaml
  get [0;3;32] 2 = Some 32 ;;
  get [0;3;32] 3 = None;;
```
```
val getExn : 'a t -> int -> 'a
```
`getExn xs n`
**See** [`get`](./#val-get)
**raise** an exception if `n` is larger than the length
```
val make : int -> 'a -> 'a t
```
`make n v`
- return a list of length `n` with each element filled with value `v`
- return the empty list if `n` is negative
```ocaml
  make 3 1 =  [1;1;1]
```
```
val makeByU : int -> (int -> 'a) Js.Fn.arity1 -> 'a t
```
```
val makeBy : int -> (int -> 'a) -> 'a t
```
`makeBy n f`
- return a list of length `n` with element `i` initialized with `f i`
- return the empty list if `n` is negative
```ocaml
  makeBy 5 (fun i -> i) = [0;1;2;3;4];;
  makeBy 5 (fun i -> i * i) = [0;1;4;9;16];;
```
```
val shuffle : 'a t -> 'a t
```
`shuffle xs`
returns a new list in random order
```
val drop : 'a t -> int -> 'a t option
```
`drop xs n`
return the list obtained by dropping the first `n` elements, or `None` if `xs` has fewer than `n` elements
```ocaml
  drop [1;2;3] 2 = Some [3];;
  drop [1;2;3] 3 = Some [];;
  drop [1;2;3] 4 = None;;
```
```
val take : 'a t -> int -> 'a t option
```
`take xs n`
return a list with the first `n` elements from `xs`, or `None` if `xs` has fewer than `n` elements
```ocaml
  take [1;2;3] 1 = Some [1];;
  take [1;2;3] 2 = Some [1;2];;
  take [1;2;3] 4 = None;;
```
```
val splitAt : 'a t -> int -> ('a list * 'a list) option
```
`splitAt xs n` split the list `xs` at position `n` return None when the length of `xs` is less than `n`
```ocaml
  splitAt [0;1;2;3;4] 2 = Some ([0;1], [2;3;4])
```
```
val concat : 'a t -> 'a t -> 'a t
```
`concat xs ys`
returns the list obtained by adding ys after xs
```ocaml
  concat [1;2;3] [4;5] = [1;2;3;4;5]
```
```
val concatMany : 'a t array -> 'a t
```
`concatMany a` return the list obtained by concatenating in order all the lists in array `a`
```ocaml
  concatMany [| [1;2;3] ; []; [3]; [4] |] = [1;2;3;3;4]
```
```
val reverseConcat : 'a t -> 'a t -> 'a t
```
`reverseConcat xs ys` is equivalent to `concat (reverse xs) ys`
```ocaml
  reverseConcat [1;2] [3;4] = [2;1;3;4]
```
```
val flatten : 'a t t -> 'a t
```
`flatten ls` return the list obtained by concatenating in order all the lists in list `ls`
```ocaml
  flatten [ [1;2;3] ; []; [3]; [4] ] = [1;2;3;3;4]
```
```
val mapU : 'a t -> ('a -> 'b) Js.Fn.arity1 -> 'b t
```
```
val map : 'a t -> ('a -> 'b) -> 'b t
```
`map xs f`
return the list obtained by applying `f` to each element of `xs`
```ocaml
  map [1;2] (fun x-> x + 1) = [3;4]
```
```
val zip : 'a t -> 'b t -> ('a * 'b) t
```
`zip xs ys`
returns a list of pairs from the two lists with the length of the shorter list
```ocaml
  zip [1;2] [3;4;5] = [(1,3); (2,4)]
```
```
val zipByU : 'a t -> 'b t -> ('a -> 'b -> 'c) Js.Fn.arity2 -> 'c t
```
```
val zipBy : 'a t -> 'b t -> ('a -> 'b -> 'c) -> 'c t
```
`zipBy xs ys f`
**See** [`zip`](./#val-zip)
Equivalent to `zip xs ys |> List.map (fun (x,y) -> f x y)`
```ocaml
  zipBy [1;2;3] [4;5] (fun a b -> 2 * a + b) = [6;9];;
```
```
val mapWithIndexU : 'a t -> (int -> 'a -> 'b) Js.Fn.arity2 -> 'b t
```
```
val mapWithIndex : 'a t -> (int -> 'a -> 'b) -> 'b t
```
`mapWithIndex xs f` applies `f` to each element of `xs`. Function `f` takes two arguments: the index starting from 0 and the element from `xs`.
```ocaml
  mapWithIndex [1;2;3] (fun i x -> i + x) =
  [0 + 1; 1 + 2; 2 + 3 ]
```
```
val fromArray : 'a array -> 'a t
```
`fromArray arr` converts the given array to a list
```ocaml
    fromArray [|1;2;3|]  = [1;2;3]
```
```
val toArray : 'a t -> 'a array
```
`toArray xs` converts the given list to an array
```ocaml
    toArray [1;2;3] = [|1;2;3|]
```
```
val reverse : 'a t -> 'a t
```
`reverse xs` returns a new list whose elements are those of `xs` in reverse order.
```ocaml
    reverse [1;2;3] = [3;2;1]
```
```
val mapReverseU : 'a t -> ('a -> 'b) Js.Fn.arity1 -> 'b t
```
```
val mapReverse : 'a t -> ('a -> 'b) -> 'b t
```
`mapReverse xs f`
Equivalent to `reverse (map xs f)`
```ocaml
  mapReverse [3;4;5] (fun x -> x * x) = [25;16;9];;
```
```
val forEachU : 'a t -> ('a -> 'b) Js.Fn.arity1 -> unit
```
```
val forEach : 'a t -> ('a -> 'b) -> unit
```
`forEach xs f ` Call `f` on each element of `xs` from the beginning to end. `f` returns `unit`, so no new array is created. Use `foreach` when you are primarily concerned with repetitively creating side effects.
```ocaml
  forEach ["a";"b";"c"] (fun x -> Js.log("Item: " ^ x));;
  (*  prints:
    Item: a
    Item: b
    Item: c
  *)

  let us = ref 0;;
  forEach [1;2;3;4] (fun x -> us := !us + x);;
  !us  = 1 + 2 + 3 + 4;;
```
```
val forEachWithIndexU : 'a t -> (int -> 'a -> 'b) Js.Fn.arity2 -> unit
```
```
val forEachWithIndex : 'a t -> (int -> 'a -> 'b) -> unit
```
`forEachWithIndex xs f`
```ocaml

  forEach ["a";"b";"c"] (fun i x -> Js.log("Item " ^ (string_of_int i) ^ " is " ^ x));;
  (*  prints:
    Item 0 is a
    Item 1 is b
    Item 2 is cc
  *)

  let total = ref 0 ;;
  forEachWithIndex [10;11;12;13] (fun i x -> total := !total + x + i);;
  !total  = 0 + 10 + 1 +  11 + 2 + 12 + 3 + 13;;
```
```
val reduceU : 'a t -> 'b -> ('b -> 'a -> 'b) Js.Fn.arity2 -> 'b
```
```
val reduce : 'a t -> 'b -> ('b -> 'a -> 'b) -> 'b
```
`reduce xs f`
Applies `f` to each element of `xs` from beginning to end. Function `f` has two parameters: the item from the list and an “accumulator”, which starts with a value of `init`. `reduce` returns the final value of the accumulator.
```ocaml
  reduce [1;2;3;4] 0 (+) = 10;;
  reduce [1;2;3;4] 10 (-) = 0;;
  reduce [1;2;3;4] [] add = [4;3;2;1];
```
```
val reduceWithIndexU : 'a t -> 'b -> ('b -> 'a -> int -> 'b) Js.Fn.arity3 -> 'b
```
```
val reduceWithIndex : 'a t -> 'b -> ('b -> 'a -> int -> 'b) -> 'b
```
`reduceWithIndex xs f`
Applies `f` to each element of `xs` from beginning to end. Function `f` has three parameters: the item from the list and an “accumulator”, which starts with a value of `init` and the index of each element. `reduceWithIndex` returns the final value of the accumulator.
```ocaml
  reduceWithIndex [1;2;3;4] 0 (fun acc x i -> acc + x + i) = 16;;
```
```
val reduceReverseU : 'a t -> 'b -> ('b -> 'a -> 'b) Js.Fn.arity2 -> 'b
```
```
val reduceReverse : 'a t -> 'b -> ('b -> 'a -> 'b) -> 'b
```
`reduceReverse xs f`
Works like [`reduce`](./#val-reduce), except that function `f` is applied to each item of `xs` from the last back to the first.
```ocaml
  reduceReverse [1;2;3;4] 0 (+) = 10;;
  reduceReverse [1;2;3;4] 10 (-) = 0;;
  reduceReverse [1;2;3;4] [] add = [1;2;3;4];;
```
```
val mapReverse2U : 'a t -> 'b t -> ('a -> 'b -> 'c) Js.Fn.arity2 -> 'c t
```
```
val mapReverse2 : 'a t -> 'b t -> ('a -> 'b -> 'c) -> 'c t
```
`mapReverse2 xs ys f`
equivalent to `reverse (zipBy xs ys f)`
```ocaml
  mapReverse2 [1;2;3] [1;2] (+) = [4;2]
```
```
val forEach2U : 'a t -> 'b t -> ('a -> 'b -> 'c) Js.Fn.arity2 -> unit
```
```
val forEach2 : 'a t -> 'b t -> ('a -> 'b -> 'c) -> unit
```
`forEach2 xs ys f` stop with the shorter list
```
val reduce2U : 'b t -> 'c t -> 'a -> ('a -> 'b -> 'c -> 'a) Js.Fn.arity3 -> 'a
```
```
val reduce2 : 'b t -> 'c t -> 'a -> ('a -> 'b -> 'c -> 'a) -> 'a
```
`reduce2 xs ys init f `
Applies `f` to each element of `xs` and `ys` from beginning to end. Stops with the shorter list. Function `f` has three parameters: an “accumulator” which starts with a value of `init`, an item from `xs`, and an item from `ys`. `reduce2` returns the final value of the accumulator.
```ocaml
  reduce2 [1;2;3] [4;5] 0 (fun acc x y -> acc + x * x + y) =  0 + (1 * 1 + 4) + (2 * 2 + 5);;
  reduce2 [1;2;3] [4;5] [] (fun acc x y -> add acc (x + y) = [2 +5;1 + 4 ];; (*add appends at end *)
```
```
val reduceReverse2U : 
  'a t ->
  'b t ->
  'c ->
  ('c -> 'a -> 'b -> 'c) Js.Fn.arity3 ->
  'c
```
```
val reduceReverse2 : 'a t -> 'b t -> 'c -> ('c -> 'a -> 'b -> 'c) -> 'c
```
`reduceReverse2 xs ys init f `
Applies `f` to each element of `xs` and `ys` from end to beginning. Stops with the shorter list. Function `f` has three parameters: an “accumulator” which starts with a value of `init`, an item from `xs`, and an item from `ys`. `reduce2` returns the final value of the accumulator.
```ocaml
  reduceReverse2 [1;2;3] [4;5] 0 (fun acc x y -> acc + x * x + y) =  0 + (1 * 1 + 4) + (2 * 2 + 5);;
  reduceReverse2 [1;2;3] [4;5] [] (fun acc x y -> add acc (x + y) = [1 + 4;2 + 5];; (*add appends at end *)
```
```
val everyU : 'a t -> ('a -> bool) Js.Fn.arity1 -> bool
```
```
val every : 'a t -> ('a -> bool) -> bool
```
`every xs p`
returns true if all elements satisfy p, where p is a predicate: a function taking an element and returning a bool.
```ocaml
  every [] (fun x -> x mod 2 = 0) = true;;
  every [2;4;6] (fun x -> x mod 2 = 0 ) = true;;
  every [1;-3;5] (fun x -> x > 0) = false;;
```
```
val someU : 'a t -> ('a -> bool) Js.Fn.arity1 -> bool
```
```
val some : 'a t -> ('a -> bool) -> bool
```
`some xs p`
returns true if at least one of the elements in xs satifies p, where p is a predicate: a function taking an element and returning a bool.
```ocaml
  some [] (fun x -> x mod 2 = 0) = false ;;
  some [1;2;4] (fun x -> x mod 2 = 0) = true;;
  some [-1;-3;-5] (fun x -> x > 0) = false;;
```
```
val every2U : 'a t -> 'b t -> ('a -> 'b -> bool) Js.Fn.arity2 -> bool
```
```
val every2 : 'a t -> 'b t -> ('a -> 'b -> bool) -> bool
```
`every2 xs ys p` returns true if predicate `p xi yi` is true for all pairs of elements up to the shorter length (i.e. `min (length xs) (length ys)`)
```ocaml
  every2 [1;2;3] [0;1] (>) = true;;
  every2 [] [1] (fun  x y -> x > y) = true;;
  every2 [2;3] [1] (fun  x y -> x > y) = true;;
  every2 [0;1] [5;0] (fun x y -> x > y) = false;
```
```
val some2U : 'a t -> 'b t -> ('a -> 'b -> bool) Js.Fn.arity2 -> bool
```
```
val some2 : 'a t -> 'b t -> ('a -> 'b -> bool) -> bool
```
`some2 xs ys p` returns true if `p xi yi` is true for any pair of elements up to the shorter length (i.e. `min (length xs) (length ys)`)
```ocaml
  some2 [0;2] [1;0;3] (>) = true ;;
  some2 [] [1] (fun  x y -> x > y) =  false;;
  some2 [2;3] [1;4] (fun  x y -> x > y) = true;;
```
```
val cmpByLength : 'a t -> 'a t -> int
```
`cmpByLength l1 l2`
Compare two lists solely by length. Returns \-1 if `length l1` is less than `length l2`, 0 if `length l1` equals `length l2`, and 1 if `length l1` is greater than `length l2`.
```ocaml
cmpByLength [1;2] [3;4;5;6] = -1;;
cmpByLength [1;2;3] [4;5;6] = 0;;
cmpByLength [1;2;3;4] [5;6] = 1;;
```
```
val cmpU : 'a t -> 'a t -> ('a -> 'a -> int) Js.Fn.arity2 -> int
```
```
val cmp : 'a t -> 'a t -> ('a -> 'a -> int) -> int
```
Compare elements one by one `f x y`. `f` returns
- a negative number if `x` is “less than” `y`
- zero if `x` is “equal to” `y`
- a positive number if `x` is “greater than” `y` The comparison returns the first non-zero result of `f`, or zero if `f` returns zero for all `x` and `y`. If all items have compared equal, but `xs` is exhausted first, return \-1. (`xs` is shorter) If all items have compared equal, but `ys` is exhausted first, return 1 (`xs` is longer)
```ocaml
  cmp [3] [3;7] (fun a b -> compare a b) = -1
  cmp [5;3] [5] (fun a b -> compare a b)  = 1
  cmp [|1; 3; 5|] [|1; 4; 2|] (fun a b -> compare a b) = -1;;
  cmp [|1; 3; 5|] [|1; 2; 3|] (fun a b -> compare a b) = 1;;
  cmp [|1; 3; 5|] [|1; 3; 5|] (fun a b -> compare a b) = 0;;
```
**Attention**: The total ordering of List is different from Array, for Array, we compare the length first and, only if the lengths are equal, elements one by one. For lists, we just compare elements one by one
```
val eqU : 'a t -> 'a t -> ('a -> 'a -> bool) Js.Fn.arity2 -> bool
```
```
val eq : 'a t -> 'a t -> ('a -> 'a -> bool) -> bool
```
`eq xs ys eqElem` check equality of `xs` and `ys` using `eqElem` for equality on elements, where `eqElem` is a function that returns true if items `x` and `y` meet some criterion for equality, false otherwise. `eq` false if length of `xs` and `ys` are not the same.
```ocaml
  eq [1;2;3] [1;2] (=) = false ;;
  eq [1;2] [1;2] (=) = true;;
  eq [1; 2; 3] [-1; -2; -3] (fun a b -> abs a = abs b) = true;;
```
```
val hasU : 'a t -> 'b -> ('a -> 'b -> bool) Js.Fn.arity2 -> bool
```
```
val has : 'a t -> 'b -> ('a -> 'b -> bool) -> bool
```
`has xs eqFcn` returns true if the list contains at least one element for which `eqFcn x` returns true
```ocaml
  has [1;2;3] 2 (=) = true;;
  has [1;2;3] 4 (=) = false;;
  has [-1;-2;-3] 2 (fun a b -> abs a = abs b) = true;;
```
```
val getByU : 'a t -> ('a -> bool) Js.Fn.arity1 -> 'a option
```
```
val getBy : 'a t -> ('a -> bool) -> 'a option
```
`getBy xs p` returns `Some value` for the first value in `xs` that satisifies the predicate function `p`; returns `None` if no element satisifies the function.
```ocaml
    getBy [1;4;3;2] (fun x -> x mod 2 = 0) = Some 4
    getBy [15;13;11] (fun x -> x mod 2 = 0) = None
```
```
val keepU : 'a t -> ('a -> bool) Js.Fn.arity1 -> 'a t
```
```
val keep : 'a t -> ('a -> bool) -> 'a t
```
`keep  xs p` returns a list of all elements in `xs` which satisfy the predicate function `p`
```ocaml
  keep [1;2;3;4] (fun x -> x mod 2 = 0) =
  [2;4]
```
```
val keepWithIndexU : 'a t -> ('a -> int -> bool) Js.Fn.arity2 -> 'a t
```
```
val keepWithIndex : 'a t -> ('a -> int -> bool) -> 'a t
```
`keepWithIndex xs p` returns a list of all elements in `xs` which satisfy the predicate function `p`
```ocaml
  keepWithIndex [1;2;3;4] (fun _x i -> i mod 2 = 0)
  =
  [1;3]
```
```
val keepMapU : 'a t -> ('a -> 'b option) Js.Fn.arity1 -> 'b t
```
```
val keepMap : 'a t -> ('a -> 'b option) -> 'b t
```
`keepMap xs f` applies `f` to each element of `xs`. If `f xi` returns `Some value`, then `value` is kept in the resulting list; if `f xi` returns `None`, the element is not retained in the result.
```ocaml
  keepMap [1;2;3;4] (fun x -> if x mod 2 = 0 then Some (-x ) else None)
  =
  [-2;-4]
```
```
val partitionU : 'a t -> ('a -> bool) Js.Fn.arity1 -> 'a t * 'a t
```
```
val partition : 'a t -> ('a -> bool) -> 'a t * 'a t
```
`partition xs p` creates a pair of lists; the first list consists of all elements of `xs` that satisfy the predicate function `p`; the second list consists of all elements of `xs` that do not satisfy `p`
```ocaml
  partition [1;2;3;4] (fun x -> x mod 2 = 0) =
  ([2;4], [1;3])
```
```
val unzip : ('a * 'b) t -> 'a t * 'b t
```
`unzip xs` takes a list of pairs and creates a pair of lists. The first list contains all the first items of the pairs; the second list contains all the second items.
```ocaml
  unzip [(1,2) ; (3,4)] = ([1;3], [2;4]);;
  unzip [(1,2) ; (3,4) ; (5,6) ; (7,8)] = ([1;3;5;7], [2;4;6;8]);;
```
```
val getAssocU : 
  ('a * 'c) t ->
  'b ->
  ('a -> 'b -> bool) Js.Fn.arity2 ->
  'c option
```
```
val getAssoc : ('a * 'c) t -> 'b -> ('a -> 'b -> bool) -> 'c option
```
`getAssoc xs k eq`
return the second element of a pair in `xs` where the first element equals `x` as per the predicate function `eq`, or `None` if not found
```ocaml
  getAssoc [ 1, "a"; 2, "b"; 3, "c"] 2 (=) = Some "b"
  getAssoc [9, "morning"; 15, "afternoon"; 22, "night"] 3 (fun a b -> a mod 12 = b mod 12) = Some "afternoon"
```
```
val hasAssocU : ('a * 'c) t -> 'b -> ('a -> 'b -> bool) Js.Fn.arity2 -> bool
```
```
val hasAssoc : ('a * 'c) t -> 'b -> ('a -> 'b -> bool) -> bool
```
`hasAssoc xs k eq` return true if there is a pair in `xs` where the first element equals `k` as per the predicate funtion `eq`
```ocaml
  hasAssoc [1, "a"; 2, "b"; 3,"c"] 1 (=) = true;;
  hasAssoc [9, "morning"; 15, "afternoon"; 22, "night"] 3 (fun a b -> a mod 12 = b mod 12) = true;;
```
```
val removeAssocU : 
  ('a * 'c) t ->
  'b ->
  ('a -> 'b -> bool) Js.Fn.arity2 ->
  ('a * 'c) t
```
```
val removeAssoc : ('a * 'c) t -> 'b -> ('a -> 'b -> bool) -> ('a * 'c) t
```
`removeAssoc xs k eq` Return a list after removing the first pair whose first value is `k` per the equality predicate `eq`; if not found, return a new list identical to `xs`.
```ocaml
  removeAssoc [1,"a"; 2, "b"; 3, "c" ] 1 (=) =
    [2, "b"; 3, "c"]
  removeAssoc [1,"a"; 2, "b"; 3, "c" ] 99 (=) =
    [1, "a"; 2, "b"; 3, "c"]
```
```
val setAssocU : 
  ('a * 'c) t ->
  'a ->
  'c ->
  ('a -> 'a -> bool) Js.Fn.arity2 ->
  ('a * 'c) t
```
```
val setAssoc : ('a * 'c) t -> 'a -> 'c -> ('a -> 'a -> bool) -> ('a * 'c) t
```
`setAssoc xs k v eq` if `k` exists in `xs` by satisfying the `eq` predicate, return a new list with the key and value replaced by the new `k` and `v`; otherwise, return a new list with the pair `k, v` added to the head of `xs`.
```ocaml
  setAssoc [1,"a"; 2, "b"; 3, "c"] 2 "x" (=) =
  [1,"a"; 2, "x"; 3,"c"] ;;

  setAssoc [1,"a"; 3, "c"] 2 "b" (=) =
  [2,"b"; 1,"a"; 3, "c"]

  setAssoc [9, "morning"; 3, "morning?!"; 22, "night"] 15 "afternoon"
    (fun a b -> a mod 12 = b mod 12) = [9, "morning"; 15, "afternoon"; 22, "night"]
```
Note carefully the last example\! Since `15 mod 12` equals `3 mod 12`, *both* the key and value are replaced in the list.
```
val sortU : 'a t -> ('a -> 'a -> int) Js.Fn.arity2 -> 'a t
```
```
val sort : 'a t -> ('a -> 'a -> int) -> 'a t
```
`sort xs` Returns a sorted list.
```ocaml
  sort [5; 4; 9; 3; 7] (fun a b -> a - b) = [3; 4; 5; 7; 9]
```