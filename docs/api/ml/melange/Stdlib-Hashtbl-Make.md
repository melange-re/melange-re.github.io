
# Module `Hashtbl.Make`

Functor building an implementation of the hashtable structure. The functor `Hashtbl.Make` returns a structure containing a type `key` of keys and a type `'a t` of hash tables associating data of type `'a` to keys of type `key`. The operations perform similarly to those of the generic interface, but use the hashing and equality functions specified in the functor argument `H` instead of generic equality and hashing. Since the hash function is not seeded, the `create` operation of the result structure always returns non-randomized hash tables.


## Parameters

```
module H : HashedType
```

## Signature

```
type key = H.t
```
```
type !'a t
```
```
val create : int -> 'a t
```
```
val clear : 'a t -> unit
```
```
val reset : 'a t -> unit
```
since 4.00
```
val copy : 'a t -> 'a t
```
```
val add : 'a t -> key -> 'a -> unit
```
```
val remove : 'a t -> key -> unit
```
```
val find : 'a t -> key -> 'a
```
```
val find_opt : 'a t -> key -> 'a option
```
since 4.05
```
val find_all : 'a t -> key -> 'a list
```
```
val replace : 'a t -> key -> 'a -> unit
```
```
val mem : 'a t -> key -> bool
```
```
val iter : (key -> 'a -> unit) -> 'a t -> unit
```
```
val filter_map_inplace : (key -> 'a -> 'a option) -> 'a t -> unit
```
since 4.03
```
val fold : (key -> 'a -> 'acc -> 'acc) -> 'a t -> 'acc -> 'acc
```
```
val length : 'a t -> int
```
```
val stats : 'a t -> statistics
```
since 4.00
```
val to_seq : 'a t -> (key * 'a) Seq.t
```
since 4.07
```
val to_seq_keys : _ t -> key Seq.t
```
since 4.07
```
val to_seq_values : 'a t -> 'a Seq.t
```
since 4.07
```
val add_seq : 'a t -> (key * 'a) Seq.t -> unit
```
since 4.07
```
val replace_seq : 'a t -> (key * 'a) Seq.t -> unit
```
since 4.07
```
val of_seq : (key * 'a) Seq.t -> 'a t
```
since 4.07