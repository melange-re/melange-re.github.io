# Module `Hashtbl.MakeSeeded`
Functor building an implementation of the hashtable structure. The functor `Hashtbl.MakeSeeded` returns a structure containing a type `key` of keys and a type `'a t` of hash tables associating data of type `'a` to keys of type `key`. The operations perform similarly to those of the generic interface, but use the seeded hashing and equality functions specified in the functor argument `H` instead of generic equality and hashing. The `create` operation of the result structure supports the `~random` optional parameter and returns randomized hash tables if `~random:true` is passed or if randomization is globally on (see [`Hashtbl.randomize`](./Stdlib-MoreLabels-Hashtbl.md#val-randomize)).
since 4.00
## Parameters
```
module H : SeededHashedType
```
## Signature
```
type key = H.t
```
```
type 'a t = 'a Hashtbl.MakeSeeded(H).t
```
```
val create : ?random:bool -> int -> 'a t
```
```
val clear : 'a t -> unit
```
```
val reset : 'a t -> unit
```
```
val copy : 'a t -> 'a t
```
```
val add : 'a t -> key:key -> data:'a -> unit
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
val replace : 'a t -> key:key -> data:'a -> unit
```
```
val mem : 'a t -> key -> bool
```
```
val iter : f:(key:key -> data:'a -> unit) -> 'a t -> unit
```
```
val filter_map_inplace : f:(key:key -> data:'a -> 'a option) -> 'a t -> unit
```
since 4.03
```
val fold : f:(key:key -> data:'a -> 'acc -> 'acc) -> 'a t -> init:'acc -> 'acc
```
```
val length : 'a t -> int
```
```
val stats : 'a t -> statistics
```
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