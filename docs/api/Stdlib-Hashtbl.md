
# Module `Stdlib.Hashtbl`

Hash tables and hash functions.

Hash tables are hashed association tables, with in-place modification. Because most operations on a hash table modify their input, they're more commonly used in imperative code. The lookup of the value associated with a key (see [`find`](./#val-find), [`find_opt`](./#val-find_opt)) is normally very fast, often faster than the equivalent lookup in [`Map`](./Stdlib-Map.md).

The functors [`Make`](./Stdlib-Hashtbl-Make.md) and [`MakeSeeded`](./Stdlib-Hashtbl-MakeSeeded.md) can be used when performance or flexibility are key. The user provides custom equality and hash functions for the key type, and obtains a custom hash table type for this particular type of key.

**Warning** a hash table is only as good as the hash function. A bad hash function will turn the table into a degenerate association list, with linear time lookup instead of constant time lookup.

The polymorphic [`t`](./#type-t) hash table is useful in simpler cases or in interactive environments. It uses the polymorphic [`hash`](./#val-hash) function defined in the OCaml runtime (at the time of writing, it's SipHash), as well as the polymorphic equality `(=)`.

See [the examples section](./#examples).

**Unsynchronized accesses**

Unsynchronized accesses to a hash table may lead to an invalid hash table state. Thus, concurrent accesses to a hash tables must be synchronized (for instance with a [`Mutex.t`](./Stdlib-Mutex.md#type-t)).


## Generic interface

```ocaml
type (!'a, !'b) t
```
```reasonml
type t(!'a, !'b);
```
The type of hash tables from type `'a` to type `'b`.

```ocaml
val create : ?random:bool -> int -> ('a, 'b) t
```
```reasonml
let create: ?random:bool => int => t('a, 'b);
```
`Hashtbl.create n` creates a new, empty hash table, with initial size greater or equal to the suggested size `n`. For best results, `n` should be on the order of the expected number of elements that will be in the table. The table grows as needed, so `n` is just an initial guess. If `n` is very small or negative then it is disregarded and a small default size is used.

The optional `~random` parameter (a boolean) controls whether the internal organization of the hash table is randomized at each execution of `Hashtbl.create` or deterministic over all executions.

A hash table that is created with `~random` set to `false` uses a fixed hash function ([`hash`](./#val-hash)) to distribute keys among buckets. As a consequence, collisions between keys happen deterministically. In Web-facing applications or other security-sensitive applications, the deterministic collision patterns can be exploited by a malicious user to create a denial-of-service attack: the attacker sends input crafted to create many collisions in the table, slowing the application down.

A hash table that is created with `~random` set to `true` uses the seeded hash function [`seeded_hash`](./#val-seeded_hash) with a seed that is randomly chosen at hash table creation time. In effect, the hash function used is randomly selected among `2^{30}` different hash functions. All these hash functions have different collision patterns, rendering ineffective the denial-of-service attack described above. However, because of randomization, enumerating all elements of the hash table using [`fold`](./#val-fold) or [`iter`](./#val-iter) is no longer deterministic: elements are enumerated in different orders at different runs of the program.

If no `~random` parameter is given, hash tables are created in non-random mode by default. This default can be changed either programmatically by calling [`randomize`](./#val-randomize) or by setting the `R` flag in the `OCAMLRUNPARAM` environment variable.

before 4\.00 the ~random parameter was not present and all hash tables were created in non-randomized mode.
```ocaml
val clear : ('a, 'b) t -> unit
```
```reasonml
let clear: t('a, 'b) => unit;
```
Empty a hash table. Use `reset` instead of `clear` to shrink the size of the bucket table to its initial size.

```ocaml
val reset : ('a, 'b) t -> unit
```
```reasonml
let reset: t('a, 'b) => unit;
```
Empty a hash table and shrink the size of the bucket table to its initial size.

since 4\.00
```ocaml
val copy : ('a, 'b) t -> ('a, 'b) t
```
```reasonml
let copy: t('a, 'b) => t('a, 'b);
```
Return a copy of the given hashtable.

```ocaml
val add : ('a, 'b) t -> 'a -> 'b -> unit
```
```reasonml
let add: t('a, 'b) => 'a => 'b => unit;
```
`Hashtbl.add tbl key data` adds a binding of `key` to `data` in table `tbl`.

**Warning**: Previous bindings for `key` are not removed, but simply hidden. That is, after performing [`remove`](./#val-remove)` tbl key`, the previous binding for `key`, if any, is restored. (Same behavior as with association lists.)

If you desire the classic behavior of replacing elements, see [`replace`](./#val-replace).

```ocaml
val find : ('a, 'b) t -> 'a -> 'b
```
```reasonml
let find: t('a, 'b) => 'a => 'b;
```
`Hashtbl.find tbl x` returns the current binding of `x` in `tbl`, or raises `Not_found` if no such binding exists.

```ocaml
val find_opt : ('a, 'b) t -> 'a -> 'b option
```
```reasonml
let find_opt: t('a, 'b) => 'a => option('b);
```
`Hashtbl.find_opt tbl x` returns the current binding of `x` in `tbl`, or `None` if no such binding exists.

since 4\.05
```ocaml
val find_all : ('a, 'b) t -> 'a -> 'b list
```
```reasonml
let find_all: t('a, 'b) => 'a => list('b);
```
`Hashtbl.find_all tbl x` returns the list of all data associated with `x` in `tbl`. The current binding is returned first, then the previous bindings, in reverse order of introduction in the table.

```ocaml
val mem : ('a, 'b) t -> 'a -> bool
```
```reasonml
let mem: t('a, 'b) => 'a => bool;
```
`Hashtbl.mem tbl x` checks if `x` is bound in `tbl`.

```ocaml
val remove : ('a, 'b) t -> 'a -> unit
```
```reasonml
let remove: t('a, 'b) => 'a => unit;
```
`Hashtbl.remove tbl x` removes the current binding of `x` in `tbl`, restoring the previous binding if it exists. It does nothing if `x` is not bound in `tbl`.

```ocaml
val replace : ('a, 'b) t -> 'a -> 'b -> unit
```
```reasonml
let replace: t('a, 'b) => 'a => 'b => unit;
```
`Hashtbl.replace tbl key data` replaces the current binding of `key` in `tbl` by a binding of `key` to `data`. If `key` is unbound in `tbl`, a binding of `key` to `data` is added to `tbl`. This is functionally equivalent to [`remove`](./#val-remove)` tbl key` followed by [`add`](./#val-add)` tbl key data`.

```ocaml
val iter : ('a -> 'b -> unit) -> ('a, 'b) t -> unit
```
```reasonml
let iter: ('a => 'b => unit) => t('a, 'b) => unit;
```
`Hashtbl.iter f tbl` applies `f` to all bindings in table `tbl`. `f` receives the key as first argument, and the associated value as second argument. Each binding is presented exactly once to `f`.

The order in which the bindings are passed to `f` is unspecified. However, if the table contains several bindings for the same key, they are passed to `f` in reverse order of introduction, that is, the most recent binding is passed first.

If the hash table was created in non-randomized mode, the order in which the bindings are enumerated is reproducible between successive runs of the program, and even between minor versions of OCaml. For randomized hash tables, the order of enumeration is entirely random.

The behavior is not specified if the hash table is modified by `f` during the iteration.

```ocaml
val filter_map_inplace : ('a -> 'b -> 'b option) -> ('a, 'b) t -> unit
```
```reasonml
let filter_map_inplace: ('a => 'b => option('b)) => t('a, 'b) => unit;
```
`Hashtbl.filter_map_inplace f tbl` applies `f` to all bindings in table `tbl` and update each binding depending on the result of `f`. If `f` returns `None`, the binding is discarded. If it returns `Some new_val`, the binding is update to associate the key to `new_val`.

Other comments for [`iter`](./#val-iter) apply as well.

since 4\.03
```ocaml
val fold : ('a -> 'b -> 'acc -> 'acc) -> ('a, 'b) t -> 'acc -> 'acc
```
```reasonml
let fold: ('a => 'b => 'acc => 'acc) => t('a, 'b) => 'acc => 'acc;
```
`Hashtbl.fold f tbl init` computes `(f kN dN ... (f k1 d1 init)...)`, where `k1 ... kN` are the keys of all bindings in `tbl`, and `d1 ... dN` are the associated values. Each binding is presented exactly once to `f`.

The order in which the bindings are passed to `f` is unspecified. However, if the table contains several bindings for the same key, they are passed to `f` in reverse order of introduction, that is, the most recent binding is passed first.

If the hash table was created in non-randomized mode, the order in which the bindings are enumerated is reproducible between successive runs of the program, and even between minor versions of OCaml. For randomized hash tables, the order of enumeration is entirely random.

The behavior is not specified if the hash table is modified by `f` during the iteration.

```ocaml
val length : ('a, 'b) t -> int
```
```reasonml
let length: t('a, 'b) => int;
```
`Hashtbl.length tbl` returns the number of bindings in `tbl`. It takes constant time. Multiple bindings are counted once each, so `Hashtbl.length` gives the number of times `Hashtbl.iter` calls its first argument.

```ocaml
val randomize : unit -> unit
```
```reasonml
let randomize: unit => unit;
```
After a call to `Hashtbl.randomize()`, hash tables are created in randomized mode by default: [`create`](./#val-create) returns randomized hash tables, unless the `~random:false` optional parameter is given. The same effect can be achieved by setting the `R` parameter in the `OCAMLRUNPARAM` environment variable.

It is recommended that applications or Web frameworks that need to protect themselves against the denial-of-service attack described in [`create`](./#val-create) call `Hashtbl.randomize()` at initialization time before any domains are created.

Note that once `Hashtbl.randomize()` was called, there is no way to revert to the non-randomized default behavior of [`create`](./#val-create). This is intentional. Non-randomized hash tables can still be created using `Hashtbl.create ~random:false`.

since 4\.00
```ocaml
val is_randomized : unit -> bool
```
```reasonml
let is_randomized: unit => bool;
```
Return `true` if the tables are currently created in randomized mode by default, `false` otherwise.

since 4\.03
```ocaml
val rebuild : ?random:bool -> ('a, 'b) t -> ('a, 'b) t
```
```reasonml
let rebuild: ?random:bool => t('a, 'b) => t('a, 'b);
```
Return a copy of the given hashtable. Unlike [`copy`](./#val-copy), [`rebuild`](./#val-rebuild)` h` re-hashes all the (key, value) entries of the original table `h`. The returned hash table is randomized if `h` was randomized, or the optional `random` parameter is true, or if the default is to create randomized hash tables; see [`create`](./#val-create) for more information.

[`rebuild`](./#val-rebuild) can safely be used to import a hash table built by an old version of the [`Hashtbl`](#) module, then marshaled to persistent storage. After unmarshaling, apply [`rebuild`](./#val-rebuild) to produce a hash table for the current version of the [`Hashtbl`](#) module.

since 4\.12
```
type statistics = {
```
`num_bindings : int;`
Number of bindings present in the table. Same value as returned by [`length`](./#val-length).

`num_buckets : int;`
Number of buckets in the table.

`max_bucket_length : int;`
Maximal number of bindings per bucket.

`bucket_histogram : int array;`
Histogram of bucket sizes. This array `histo` has length `max_bucket_length + 1`. The value of `histo.(i)` is the number of buckets whose size is `i`.

```ocaml
}
```
```reasonml
};
```
since 4\.00
```ocaml
val stats : ('a, 'b) t -> statistics
```
```reasonml
let stats: t('a, 'b) => statistics;
```
`Hashtbl.stats tbl` returns statistics about the table `tbl`: number of buckets, size of the biggest bucket, distribution of buckets by size.

since 4\.00

## Hash tables and Sequences

```ocaml
val to_seq : ('a, 'b) t -> ('a * 'b) Seq.t
```
```reasonml
let to_seq: t('a, 'b) => Seq.t(('a, 'b));
```
Iterate on the whole table. The order in which the bindings appear in the sequence is unspecified. However, if the table contains several bindings for the same key, they appear in reversed order of introduction, that is, the most recent binding appears first.

The behavior is not specified if the hash table is modified during the iteration.

since 4\.07
```ocaml
val to_seq_keys : ('a, _) t -> 'a Seq.t
```
```reasonml
let to_seq_keys: t('a, _) => Seq.t('a);
```
Same as `Seq.map fst (to_seq m)`

since 4\.07
```ocaml
val to_seq_values : (_, 'b) t -> 'b Seq.t
```
```reasonml
let to_seq_values: t(_, 'b) => Seq.t('b);
```
Same as `Seq.map snd (to_seq m)`

since 4\.07
```ocaml
val add_seq : ('a, 'b) t -> ('a * 'b) Seq.t -> unit
```
```reasonml
let add_seq: t('a, 'b) => Seq.t(('a, 'b)) => unit;
```
Add the given bindings to the table, using [`add`](./#val-add)

since 4\.07
```ocaml
val replace_seq : ('a, 'b) t -> ('a * 'b) Seq.t -> unit
```
```reasonml
let replace_seq: t('a, 'b) => Seq.t(('a, 'b)) => unit;
```
Add the given bindings to the table, using [`replace`](./#val-replace)

since 4\.07
```ocaml
val of_seq : ('a * 'b) Seq.t -> ('a, 'b) t
```
```reasonml
let of_seq: Seq.t(('a, 'b)) => t('a, 'b);
```
Build a table from the given bindings. The bindings are added in the same order they appear in the sequence, using [`replace_seq`](./#val-replace_seq), which means that if two pairs have the same key, only the latest one will appear in the table.

since 4\.07

## Functorial interface

The functorial interface allows the use of specific comparison and hash functions, either for performance/security concerns, or because keys are not hashable/comparable with the polymorphic builtins.

For instance, one might want to specialize a table for integer keys:

```ocaml
  module IntHash =
    struct
      type t = int
      let equal i j = i=j
      let hash i = i land max_int
    end

  module IntHashtbl = Hashtbl.Make(IntHash)

  let h = IntHashtbl.create 17 in
  IntHashtbl.add h 12 "hello"
```
This creates a new module `IntHashtbl`, with a new type <code class="text-ocaml">'a IntHashtbl.t</code><code class="text-reasonml">IntHashtbl.t('a)</code> of tables from `int` to `'a`. In this example, `h` contains `string` values so its type is `string IntHashtbl.t`.

Note that the new type <code class="text-ocaml">'a IntHashtbl.t</code><code class="text-reasonml">IntHashtbl.t('a)</code> is not compatible with the type <code class="text-ocaml">('a,'b) Hashtbl.t</code><code class="text-reasonml">Hashtbl.t('a, 'b)</code> of the generic interface. For example, `Hashtbl.length h` would not type-check, you must use `IntHashtbl.length`.

```ocaml
module type HashedType = sig ... end
```
```reasonml
module type HashedType = { ... };
```
The input signature of the functor [`Make`](./Stdlib-Hashtbl-Make.md).

```ocaml
module type S = sig ... end
```
```reasonml
module type S = { ... };
```
The output signature of the functor [`Make`](./Stdlib-Hashtbl-Make.md).

```ocaml
module Make (H : HashedType) : S with type key = H.t
```
```reasonml
module Make:  (H: HashedType) => S with type key = H.t;
```
Functor building an implementation of the hashtable structure. The functor `Hashtbl.Make` returns a structure containing a type `key` of keys and a type <code class="text-ocaml">'a t</code><code class="text-reasonml">t('a)</code> of hash tables associating data of type `'a` to keys of type `key`. The operations perform similarly to those of the generic interface, but use the hashing and equality functions specified in the functor argument `H` instead of generic equality and hashing. Since the hash function is not seeded, the `create` operation of the result structure always returns non-randomized hash tables.

```ocaml
module type SeededHashedType = sig ... end
```
```reasonml
module type SeededHashedType = { ... };
```
The input signature of the functor [`MakeSeeded`](./Stdlib-Hashtbl-MakeSeeded.md).

```ocaml
module type SeededS = sig ... end
```
```reasonml
module type SeededS = { ... };
```
The output signature of the functor [`MakeSeeded`](./Stdlib-Hashtbl-MakeSeeded.md).

```ocaml
module MakeSeeded (H : SeededHashedType) : SeededS with type key = H.t
```
```reasonml
module MakeSeeded:  (H: SeededHashedType) => SeededS with type key = H.t;
```
Functor building an implementation of the hashtable structure. The functor `Hashtbl.MakeSeeded` returns a structure containing a type `key` of keys and a type <code class="text-ocaml">'a t</code><code class="text-reasonml">t('a)</code> of hash tables associating data of type `'a` to keys of type `key`. The operations perform similarly to those of the generic interface, but use the seeded hashing and equality functions specified in the functor argument `H` instead of generic equality and hashing. The `create` operation of the result structure supports the `~random` optional parameter and returns randomized hash tables if `~random:true` is passed or if randomization is globally on (see [`Hashtbl.randomize`](./#val-randomize)).


## The polymorphic hash functions

```ocaml
val hash : 'a -> int
```
```reasonml
let hash: 'a => int;
```
`Hashtbl.hash x` associates a nonnegative integer to any value of any type. It is guaranteed that if `x = y` or `Stdlib.compare x y = 0`, then `hash x = hash y`. Moreover, `hash` always terminates, even on cyclic structures.

```ocaml
val seeded_hash : int -> 'a -> int
```
```reasonml
let seeded_hash: int => 'a => int;
```
A variant of [`hash`](./#val-hash) that is further parameterized by an integer seed.

since 4\.00
```ocaml
val hash_param : int -> int -> 'a -> int
```
```reasonml
let hash_param: int => int => 'a => int;
```
`Hashtbl.hash_param meaningful total x` computes a hash value for `x`, with the same properties as for `hash`. The two extra integer parameters `meaningful` and `total` give more precise control over hashing. Hashing performs a breadth-first, left-to-right traversal of the structure `x`, stopping after `meaningful` meaningful nodes were encountered, or `total` nodes (meaningful or not) were encountered. If `total` as specified by the user exceeds a certain value, currently 256, then it is capped to that value. Meaningful nodes are: integers; floating-point numbers; strings; characters; booleans; and constant constructors. Larger values of `meaningful` and `total` means that more nodes are taken into account to compute the final hash value, and therefore collisions are less likely to happen. However, hashing takes longer. The parameters `meaningful` and `total` govern the tradeoff between accuracy and speed. As default choices, [`hash`](./#val-hash) and [`seeded_hash`](./#val-seeded_hash) take `meaningful = 10` and `total = 100`.

```ocaml
val seeded_hash_param : int -> int -> int -> 'a -> int
```
```reasonml
let seeded_hash_param: int => int => int => 'a => int;
```
A variant of [`hash_param`](./#val-hash_param) that is further parameterized by an integer seed. Usage: `Hashtbl.seeded_hash_param meaningful total seed x`.

since 4\.00

## Examples


### Basic Example

```ocaml
  (* 0...99 *)
  let seq = Seq.ints 0 |> Seq.take 100

  (* build from Seq.t *)
  # let tbl =
      seq
      |> Seq.map (fun x -> x, string_of_int x)
      |> Hashtbl.of_seq
  val tbl : (int, string) Hashtbl.t = <abstr>

  # Hashtbl.length tbl
  - : int = 100

  # Hashtbl.find_opt tbl 32
  - : string option = Some "32"

  # Hashtbl.find_opt tbl 166
  - : string option = None

  # Hashtbl.replace tbl 166 "one six six"
  - : unit = ()

  # Hashtbl.find_opt tbl 166
  - : string option = Some "one six six"

  # Hashtbl.length tbl
  - : int = 101
```

### Counting Elements

Given a sequence of elements (here, a [`Seq.t`](./Stdlib-Seq.md#type-t)), we want to count how many times each distinct element occurs in the sequence. A simple way to do this, assuming the elements are comparable and hashable, is to use a hash table that maps elements to their number of occurrences.

Here we illustrate that principle using a sequence of (ascii) characters (type `char`). We use a custom `Char_tbl` specialized for `char`.

```ocaml
  # module Char_tbl = Hashtbl.Make(struct
      type t = char
      let equal = Char.equal
      let hash = Hashtbl.hash
    end)

  (*  count distinct occurrences of chars in [seq] *)
  # let count_chars (seq : char Seq.t) : _ list =
      let counts = Char_tbl.create 16 in
      Seq.iter
        (fun c ->
          let count_c =
            Char_tbl.find_opt counts c
            |> Option.value ~default:0
          in
          Char_tbl.replace counts c (count_c + 1))
        seq;
      (* turn into a list *)
      Char_tbl.fold (fun c n l -> (c,n) :: l) counts []
        |> List.sort (fun (c1,_)(c2,_) -> Char.compare c1 c2)
  val count_chars : Char_tbl.key Seq.t -> (Char.t * int) list = <fun>

  (* basic seq from a string *)
  # let seq = String.to_seq "hello world, and all the camels in it!"
  val seq : char Seq.t = <fun>

  # count_chars seq
  - : (Char.t * int) list =
  [(' ', 7); ('!', 1); (',', 1); ('a', 3); ('c', 1); ('d', 2); ('e', 3);
   ('h', 2); ('i', 2); ('l', 6); ('m', 1); ('n', 2); ('o', 2); ('r', 1);
   ('s', 1); ('t', 2); ('w', 1)]

  (* "abcabcabc..." *)
  # let seq2 =
      Seq.cycle (String.to_seq "abc") |> Seq.take 31
  val seq2 : char Seq.t = <fun>

  # String.of_seq seq2
  - : String.t = "abcabcabcabcabcabcabcabcabcabca"

  # count_chars seq2
  - : (Char.t * int) list = [('a', 11); ('b', 10); ('c', 10)]

```