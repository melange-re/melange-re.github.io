# Module `Type.Id`
Type identifiers.
A type identifier is a value that denotes a type. Given two type identifiers, they can be tested for [equality](./#val-provably_equal) to prove they denote the same type. Note that:
- Unequal identifiers do not imply unequal types: a given type can be denoted by more than one identifier.
- Type identifiers can be marshalled, but they get a new, distinct, identity on unmarshalling, so the equalities are lost.
See an [example](./#example) of use.
## Type identifiers
```
type !'a t
```
The type for identifiers for type `'a`.
```
val make : unit -> 'a t
```
`make ()` is a new type identifier.
```
val uid : 'a t -> int
```
`uid id` is a runtime unique identifier for `id`.
```
val provably_equal : 'a t -> 'b t -> ('a, 'b) eq option
```
`provably_equal i0 i1` is `Some Equal` if identifier `i0` is equal to `i1` and `None` otherwise.
## Example
The following shows how type identifiers can be used to implement a simple heterogeneous key-value dictionary. In contrast to [`Stdlib.Map`](./Stdlib-Map.md) values whose keys map to a single, homogeneous type of values, this dictionary can associate a different type of value to each key.
```ocaml
(** Heterogeneous dictionaries. *)
module Dict : sig
  type t
  (** The type for dictionaries. *)

  type 'a key
  (** The type for keys binding values of type ['a]. *)

  val key : unit -> 'a key
  (** [key ()] is a new dictionary key. *)

  val empty : t
  (** [empty] is the empty dictionary. *)

  val add : 'a key -> 'a -> t -> t
  (** [add k v d] is [d] with [k] bound to [v]. *)

  val remove : 'a key -> t -> t
  (** [remove k d] is [d] with the last binding of [k] removed. *)

  val find : 'a key -> t -> 'a option
  (** [find k d] is the binding of [k] in [d], if any. *)
end = struct
  type 'a key = 'a Type.Id.t
  type binding = B : 'a key * 'a -> binding
  type t = (int * binding) list

  let key () = Type.Id.make ()
  let empty = []
  let add k v d = (Type.Id.uid k, B (k, v)) :: d
  let remove k d = List.remove_assoc (Type.Id.uid k) d
  let find : type a. a key -> t -> a option = fun k d ->
    match List.assoc_opt (Type.Id.uid k) d with
    | None -> None
    | Some (B (k', v)) ->
        match Type.Id.provably_equal k k' with
        | Some Type.Equal -> Some v
        | None -> assert false
end
```