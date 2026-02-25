
# Module type `Map.S`

Output signature of the functor [`Make`](./Stdlib-MoreLabels-Map-Make.md).


## Maps

```ocaml
type key
```
```reasonml
type key;
```
The type of the map keys.

```ocaml
type !+'a t
```
```reasonml
type t(!+'a);
```
The type of maps from type `key` to type `'a`.

```ocaml
val empty : 'a t
```
```reasonml
let empty: t('a);
```
The empty map.

```ocaml
val add : key:key -> data:'a -> 'a t -> 'a t
```
```reasonml
let add: key:key => data:'a => t('a) => t('a);
```
`add ~key ~data m` returns a map containing the same bindings as `m`, plus a binding of `key` to `data`. If `key` was already bound in `m` to a value that is physically equal to `data`, `m` is returned unchanged (the result of the function is then physically equal to `m`). Otherwise, the previous binding of `key` in `m` disappears.

before 4\.03 Physical equality was not ensured.
```ocaml
val add_to_list : key:key -> data:'a -> 'a list t -> 'a list t
```
```reasonml
let add_to_list: key:key => data:'a => t(list('a)) => t(list('a));
```
`add_to_list ~key ~data m` is `m` with `key` mapped to `l` such that `l` is `data :: Map.find key m` if `key` was bound in `m` and `[data]` otherwise.

since 5\.1
```ocaml
val update : key:key -> f:('a option -> 'a option) -> 'a t -> 'a t
```
```reasonml
let update: key:key => f:(option('a) => option('a)) => t('a) => t('a);
```
`update ~key ~f m` returns a map containing the same bindings as `m`, except for the binding of `key`. Depending on the value of `y` where `y` is `f (find_opt key m)`, the binding of `key` is added, removed or updated. If `y` is `None`, the binding is removed if it exists; otherwise, if `y` is `Some z` then `key` is associated to `z` in the resulting map. If `key` was already bound in `m` to a value that is physically equal to `z`, `m` is returned unchanged (the result of the function is then physically equal to `m`).

since 4\.06
```ocaml
val singleton : key -> 'a -> 'a t
```
```reasonml
let singleton: key => 'a => t('a);
```
`singleton x y` returns the one-element map that contains a binding `y` for `x`.

since 3\.12
```ocaml
val remove : key -> 'a t -> 'a t
```
```reasonml
let remove: key => t('a) => t('a);
```
`remove x m` returns a map containing the same bindings as `m`, except for `x` which is unbound in the returned map. If `x` was not in `m`, `m` is returned unchanged (the result of the function is then physically equal to `m`).

before 4\.03 Physical equality was not ensured.
```ocaml
val merge : 
  f:(key -> 'a option -> 'b option -> 'c option) ->
  'a t ->
  'b t ->
  'c t
```
```reasonml
let merge: 
  f:(key => option('a) => option('b) => option('c)) =>
  t('a) =>
  t('b) =>
  t('c);
```
`merge ~f m1 m2` computes a map whose keys are a subset of the keys of `m1` and of `m2`. The presence of each such binding, and the corresponding value, is determined with the function `f`. In terms of the `find_opt` operation, we have `find_opt x (merge f m1 m2) = f x (find_opt x m1) (find_opt x m2)` for any key `x`, provided that `f x None None = None`.

since 3\.12
```ocaml
val union : f:(key -> 'a -> 'a -> 'a option) -> 'a t -> 'a t -> 'a t
```
```reasonml
let union: f:(key => 'a => 'a => option('a)) => t('a) => t('a) => t('a);
```
`union ~f m1 m2` computes a map whose keys are a subset of the keys of `m1` and of `m2`. When the same binding is defined in both arguments, the function `f` is used to combine them. This is a special case of `merge`: `union f m1 m2` is equivalent to `merge f' m1 m2`, where

- `f' _key None None = None`
- `f' _key (Some v) None = Some v`
- `f' _key None (Some v) = Some v`
- `f' key (Some v1) (Some v2) = f key v1 v2`
since 4\.03
```ocaml
val cardinal : 'a t -> int
```
```reasonml
let cardinal: t('a) => int;
```
Return the number of bindings of a map.

since 3\.12

## Bindings

```ocaml
val bindings : 'a t -> (key * 'a) list
```
```reasonml
let bindings: t('a) => list((key, 'a));
```
Return the list of all bindings of the given map. The returned list is sorted in increasing order of keys with respect to the ordering `Ord.compare`, where `Ord` is the argument given to [`Map.Make`](./Stdlib-MoreLabels-Map-Make.md).

since 3\.12
```ocaml
val min_binding : 'a t -> key * 'a
```
```reasonml
let min_binding: t('a) => (key, 'a);
```
Return the binding with the smallest key in a given map (with respect to the `Ord.compare` ordering), or raise `Not_found` if the map is empty.

since 3\.12
```ocaml
val min_binding_opt : 'a t -> (key * 'a) option
```
```reasonml
let min_binding_opt: t('a) => option((key, 'a));
```
Return the binding with the smallest key in the given map (with respect to the `Ord.compare` ordering), or `None` if the map is empty.

since 4\.05
```ocaml
val max_binding : 'a t -> key * 'a
```
```reasonml
let max_binding: t('a) => (key, 'a);
```
Same as [`min_binding`](./#val-min_binding), but returns the binding with the largest key in the given map.

since 3\.12
```ocaml
val max_binding_opt : 'a t -> (key * 'a) option
```
```reasonml
let max_binding_opt: t('a) => option((key, 'a));
```
Same as [`min_binding_opt`](./#val-min_binding_opt), but returns the binding with the largest key in the given map.

since 4\.05
```ocaml
val choose : 'a t -> key * 'a
```
```reasonml
let choose: t('a) => (key, 'a);
```
Return one binding of the given map, or raise `Not_found` if the map is empty. Which binding is chosen is unspecified, but equal bindings will be chosen for equal maps.

since 3\.12
```ocaml
val choose_opt : 'a t -> (key * 'a) option
```
```reasonml
let choose_opt: t('a) => option((key, 'a));
```
Return one binding of the given map, or `None` if the map is empty. Which binding is chosen is unspecified, but equal bindings will be chosen for equal maps.

since 4\.05

## Searching

```ocaml
val find : key -> 'a t -> 'a
```
```reasonml
let find: key => t('a) => 'a;
```
`find x m` returns the current value of `x` in `m`, or raises `Not_found` if no binding for `x` exists.

```ocaml
val find_opt : key -> 'a t -> 'a option
```
```reasonml
let find_opt: key => t('a) => option('a);
```
`find_opt x m` returns `Some v` if the current value of `x` in `m` is `v`, or `None` if no binding for `x` exists.

since 4\.05
```ocaml
val find_first : f:(key -> bool) -> 'a t -> key * 'a
```
```reasonml
let find_first: f:(key => bool) => t('a) => (key, 'a);
```
`find_first ~f m`, where `f` is a monotonically increasing function, returns the binding of `m` with the lowest key `k` such that `f k`, or raises `Not_found` if no such key exists.

For example, `find_first (fun k -> Ord.compare k x >= 0) m` will return the first binding `k, v` of `m` where `Ord.compare k x >= 0` (intuitively: `k >= x`), or raise `Not_found` if `x` is greater than any element of `m`.

since 4\.05
```ocaml
val find_first_opt : f:(key -> bool) -> 'a t -> (key * 'a) option
```
```reasonml
let find_first_opt: f:(key => bool) => t('a) => option((key, 'a));
```
`find_first_opt ~f m`, where `f` is a monotonically increasing function, returns an option containing the binding of `m` with the lowest key `k` such that `f k`, or `None` if no such key exists.

since 4\.05
```ocaml
val find_last : f:(key -> bool) -> 'a t -> key * 'a
```
```reasonml
let find_last: f:(key => bool) => t('a) => (key, 'a);
```
`find_last ~f m`, where `f` is a monotonically decreasing function, returns the binding of `m` with the highest key `k` such that `f k`, or raises `Not_found` if no such key exists.

since 4\.05
```ocaml
val find_last_opt : f:(key -> bool) -> 'a t -> (key * 'a) option
```
```reasonml
let find_last_opt: f:(key => bool) => t('a) => option((key, 'a));
```
`find_last_opt ~f m`, where `f` is a monotonically decreasing function, returns an option containing the binding of `m` with the highest key `k` such that `f k`, or `None` if no such key exists.

since 4\.05

## Traversing

```ocaml
val iter : f:(key:key -> data:'a -> unit) -> 'a t -> unit
```
```reasonml
let iter: f:(key:key => data:'a => unit) => t('a) => unit;
```
`iter ~f m` applies `f` to all bindings in map `m`. `f` receives the key as first argument, and the associated value as second argument. The bindings are passed to `f` in increasing order with respect to the ordering over the type of the keys.

```ocaml
val fold : f:(key:key -> data:'a -> 'acc -> 'acc) -> 'a t -> init:'acc -> 'acc
```
```reasonml
let fold: f:(key:key => data:'a => 'acc => 'acc) => t('a) => init:'acc => 'acc;
```
`fold ~f m ~init` computes `(f kN dN ... (f k1 d1 init)...)`, where `k1 ... kN` are the keys of all bindings in `m` (in increasing order), and `d1 ... dN` are the associated data.


## Transforming

```ocaml
val map : f:('a -> 'b) -> 'a t -> 'b t
```
```reasonml
let map: f:('a => 'b) => t('a) => t('b);
```
`map ~f m` returns a map with same domain as `m`, where the associated value `a` of all bindings of `m` has been replaced by the result of the application of `f` to `a`. The bindings are passed to `f` in increasing order with respect to the ordering over the type of the keys.

```ocaml
val mapi : f:(key -> 'a -> 'b) -> 'a t -> 'b t
```
```reasonml
let mapi: f:(key => 'a => 'b) => t('a) => t('b);
```
Same as [`map`](./#val-map), but the function receives as arguments both the key and the associated value for each binding of the map.

```ocaml
val filter : f:(key -> 'a -> bool) -> 'a t -> 'a t
```
```reasonml
let filter: f:(key => 'a => bool) => t('a) => t('a);
```
`filter ~f m` returns the map with all the bindings in `m` that satisfy predicate `p`. If every binding in `m` satisfies `f`, `m` is returned unchanged (the result of the function is then physically equal to `m`)

since 3\.12
before 4\.03 Physical equality was not ensured.
```ocaml
val filter_map : f:(key -> 'a -> 'b option) -> 'a t -> 'b t
```
```reasonml
let filter_map: f:(key => 'a => option('b)) => t('a) => t('b);
```
`filter_map ~f m` applies the function `f` to every binding of `m`, and builds a map from the results. For each binding `(k, v)` in the input map:

- if `f k v` is `None` then `k` is not in the result,
- if `f k v` is `Some v'` then the binding `(k, v')` is in the output map.
For example, the following function on maps whose values are lists

```ocaml
filter_map
  (fun _k li -> match li with [] -> None | _::tl -> Some tl)
  m
```
```reasonml
filter_map(
  (_k, li) =>
    switch (li) {
    | [] => None
    | [_, ...tl] => Some(tl)
    },
  m,
);
```
drops all bindings of `m` whose value is an empty list, and pops the first element of each value that is non-empty.

since 4\.11
```ocaml
val partition : f:(key -> 'a -> bool) -> 'a t -> 'a t * 'a t
```
```reasonml
let partition: f:(key => 'a => bool) => t('a) => (t('a), t('a));
```
`partition ~f m` returns a pair of maps `(m1, m2)`, where `m1` contains all the bindings of `m` that satisfy the predicate `f`, and `m2` is the map with all the bindings of `m` that do not satisfy `f`.

since 3\.12
```ocaml
val split : key -> 'a t -> 'a t * 'a option * 'a t
```
```reasonml
let split: key => t('a) => (t('a), option('a), t('a));
```
`split x m` returns a triple `(l, data, r)`, where `l` is the map with all the bindings of `m` whose key is strictly less than `x`; `r` is the map with all the bindings of `m` whose key is strictly greater than `x`; `data` is `None` if `m` contains no binding for `x`, or `Some v` if `m` binds `v` to `x`.

since 3\.12

## Predicates and comparisons

```ocaml
val is_empty : 'a t -> bool
```
```reasonml
let is_empty: t('a) => bool;
```
Test whether a map is empty or not.

```ocaml
val mem : key -> 'a t -> bool
```
```reasonml
let mem: key => t('a) => bool;
```
`mem x m` returns `true` if `m` contains a binding for `x`, and `false` otherwise.

```ocaml
val equal : cmp:('a -> 'a -> bool) -> 'a t -> 'a t -> bool
```
```reasonml
let equal: cmp:('a => 'a => bool) => t('a) => t('a) => bool;
```
`equal ~cmp m1 m2` tests whether the maps `m1` and `m2` are equal, that is, contain equal keys and associate them with equal data. `cmp` is the equality predicate used to compare the data associated with the keys.

```ocaml
val compare : cmp:('a -> 'a -> int) -> 'a t -> 'a t -> int
```
```reasonml
let compare: cmp:('a => 'a => int) => t('a) => t('a) => int;
```
Total ordering between maps. The first argument is a total ordering used to compare data associated with equal keys in the two maps.

```ocaml
val for_all : f:(key -> 'a -> bool) -> 'a t -> bool
```
```reasonml
let for_all: f:(key => 'a => bool) => t('a) => bool;
```
`for_all ~f m` checks if all the bindings of the map satisfy the predicate `f`.

since 3\.12
```ocaml
val exists : f:(key -> 'a -> bool) -> 'a t -> bool
```
```reasonml
let exists: f:(key => 'a => bool) => t('a) => bool;
```
`exists ~f m` checks if at least one binding of the map satisfies the predicate `f`.

since 3\.12

## Converting

```ocaml
val to_list : 'a t -> (key * 'a) list
```
```reasonml
let to_list: t('a) => list((key, 'a));
```
`to_list m` is [`bindings`](./#val-bindings)` m`.

since 5\.1
```ocaml
val of_list : (key * 'a) list -> 'a t
```
```reasonml
let of_list: list((key, 'a)) => t('a);
```
`of_list bs` adds the bindings of `bs` to the empty map, in list order (if a key is bound twice in `bs` the last one takes over).

since 5\.1
```ocaml
val to_seq : 'a t -> (key * 'a) Seq.t
```
```reasonml
let to_seq: t('a) => Seq.t((key, 'a));
```
Iterate on the whole map, in ascending order of keys

since 4\.07
```ocaml
val to_rev_seq : 'a t -> (key * 'a) Seq.t
```
```reasonml
let to_rev_seq: t('a) => Seq.t((key, 'a));
```
Iterate on the whole map, in descending order of keys

since 4\.12
```ocaml
val to_seq_from : key -> 'a t -> (key * 'a) Seq.t
```
```reasonml
let to_seq_from: key => t('a) => Seq.t((key, 'a));
```
`to_seq_from k m` iterates on a subset of the bindings of `m`, in ascending order of keys, from key `k` or above.

since 4\.07
```ocaml
val add_seq : (key * 'a) Seq.t -> 'a t -> 'a t
```
```reasonml
let add_seq: Seq.t((key, 'a)) => t('a) => t('a);
```
Add the given bindings to the map, in order.

since 4\.07
```ocaml
val of_seq : (key * 'a) Seq.t -> 'a t
```
```reasonml
let of_seq: Seq.t((key, 'a)) => t('a);
```
Build a map from the given bindings

since 4\.07